"""Based off of audacity's pipeline example. Made for python 3.6+."""

import os
import sys
import librosa
import shutil

"""Helper constants for process_audio."""
IMPORT = "Import"
TEMPO = "Tempo"
PITCH = "Pitch"
DISTORTION = "Distortion"
REVERB = "Reverb"

print("This tool requires Audacity 2.4, other versions may work, but this script was made with this specific version in mind. https://www.audacityteam.org")

if sys.platform == 'win32':
    print("pipe-test.py, running on windows")
    TONAME = '\\\\.\\pipe\\ToSrvPipe'
    FROMNAME = '\\\\.\\pipe\\FromSrvPipe'
    EOL = '\r\n\0'
else:
    print("pipe-test.py, running on linux or mac")
    TONAME = '/tmp/audacity_script_pipe.to.' + str(os.getuid())
    FROMNAME = '/tmp/audacity_script_pipe.from.' + str(os.getuid())
    EOL = '\n'

print("If you get a file not found error before the two audacity pipe files have been opened, please go into Edit > Preferences > Modules, and set mod-script-pipe to enabled, and restart audacity!")

"""You can totally direct write into here at your own risk."""
TOFILE = open(TONAME, 'w')
print("Audacity pipe file to write to has been opened")
FROMFILE = open(FROMNAME, 'rt')
print("Audacity pipe file to read from has now been opened too\r\n")


def send_command(command):
    """Send a single command."""
    print("Send: >>> " + command)
    TOFILE.write(command + EOL)
    TOFILE.flush()


def get_response():
    """Return the command response."""
    result = ''
    line = ''
    while True:
        result += line
        line = FROMFILE.readline()
        if line == '\n' and len(result) > 0:
            break
    return result


def do_command(command):
    """Send one command, and return the response."""
    send_command(command)
    response = get_response()
    print("Rcvd: <<< " + response)
    return response


def check_dict(key, dct: dict):
    if dct and key and dct.keys().__contains__(key):
        return dct[key]

    return None


def check_effects(key, extra_effects, track_index):
    extra_effects = check_dict(key, extra_effects)
    if extra_effects is None:
        return track_index

    for effect in extra_effects:
        do_command('Import2: Filename="' + os.path.abspath("effects/" + effect[1]) + '"')
        if effect[0] != 0 and effect[0] != "0":
            if isinstance(effect[0], str):
                effect[0] = int(effect[0])
            do_command('SelectTracks: Track="' + str(track_index) + '" TrackCount="1" Mode="Set"')
            do_command('SelectTime: Start="0" End="' + str(librosa.get_duration(filename="effects/" + effect[1])) + '" RelativeTo="ProjectStart"')
            do_command('Cut:')
            do_command('SelectTime: Start="' + str(effect[0]) + '" End="' + str(librosa.get_duration(filename="effects/" + effect[1]) + effect[0]) + '" RelativeTo="ProjectStart"')
            do_command('Paste:')
            do_command('SelectTracks: Track="1" TrackCount="1" Mode="Set"')
            do_command('SelectTime: Start="0" End="0" RelativeTo="ProjectStart"')
            track_index += 1

    return track_index


def process_audio(extra_content: dict = None):
    """
    Processes everything in the sounds folder. Takes an optional dict for passing extra sounds in at various steps.
    Dict format:
        "filename" = { "step to run *after*" = ["Timestamp in seconds (floats supported)", "sound file path to insert relative to cwd"] }
    Valid steps:
        Import
        Tempo
        Pitch
        Distortion
        Reverb

    e.g: {"meteors" = {IMPORT = [["0", "explosion.ogg"], ["3.87", "kaboom.ogg"]]}}
    """
    output_dir = os.getcwd() + "/output/"
    if os.path.exists(output_dir):
        shutil.rmtree(output_dir)
    os.makedirs(output_dir)

    do_command('SelectAll:')
    do_command('RemoveTracks:')
    do_command('SelectTime: End="0.8" Start="0"')
    do_command('Silence: Use_Preset="<Current Settings>"')
    do_command('Copy:')
    do_command('RemoveTracks:')

    folder_path = os.getcwd() + "/sounds/"
    for file in os.listdir(folder_path):
        track_index = 2
        filename = file[:-4]
        extra_effects = check_dict(filename, extra_content)
        in_file = folder_path + "/" + filename
        os.makedirs(output_dir, exist_ok=True)
        do_command('SelectAll:')
        do_command('RemoveTracks:')
        do_command('Import2: Filename="' + in_file + '.wav"')
        track_index += check_effects(IMPORT, extra_effects, track_index)
        do_command('SelectAll:')
        # do_command('ChangeTempo: Percentage="15" SBSMS="0"')
        do_command('ChangeTempo: Percentage="10" SBSMS="0"')
        track_index += check_effects(TEMPO, extra_effects, track_index)
        # do_command('ChangePitch: Percentage="-20" SBSMS="1"')
        track_index += check_effects(PITCH, extra_effects, track_index)
        # do_command('Distortion: DC_Block="0" Noise_Floor="-70" Parameter_1="20" Parameter_2="56" Repeats="1" Threshold_dB="-6" Type="Rectifier Distortion"')  # This masks some AI voice roughness. Also makes it sound less 'human'. Also makes it sound like it's coming from a cheap speaker system.
        do_command('Distortion: DC_Block="0" Noise_Floor="-70" Parameter_1="30" Parameter_2="56" Repeats="1" Threshold_dB="-6" Type="Rectifier Distortion"')  # This masks some AI voice roughness. Also makes it sound less 'human'. Also makes it sound like it's coming from a cheap speaker system.
        track_index += check_effects(DISTORTION, extra_effects, track_index)
        do_command('SelectTime: Start="0" End="0" RelativeTo="ProjectEnd"')
        do_command('Paste:')
        do_command('SelectNone:')
        do_command('Reverb: Delay="12" DryGain="-1" HfDamping="41" Reverberance="70" RoomSize="100" StereoWidth="100" ToneHigh="100" ToneLow="60" WetGain="-8" WetOnly="0"')
        track_index += check_effects(REVERB, extra_effects, track_index)
        do_command('Export2: Filename="' + output_dir + filename + '.ogg"')
