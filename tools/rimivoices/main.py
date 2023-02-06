"""The main script. Generates the voices before handing them off to audacity."""

import requests
import urllib.parse
import os.path
import audacity_pipeline
import json
import sys

# Before someone comments about using "/" instead of os.path, it *really* doesn't matter. Python and audacity are quite happy with either, as well as mixed \ and /s.

# This script is untested on linux and macos, but it should work just fine.

print("This tool requires OpenTTS tag zh-2.1. Other versions may work, but it was made with this version in mind. Source and docs: https://github.com/synesthesiam/opentts Docker Image: https://hub.docker.com/r/synesthesiam/opentts")
print("If on windows, docker desktop is an unstable piece of shite, and you might have to download snapshot builds for the fucking thing to work at all. Hope your github crawling skills are up to scratch.")

voices = {
    "larynx:cmu_bdl-glow_tts": "male",
    "coqui-tts:en_vctk": "female",
    "larynx:mary_ann-glow_tts": "female"
}  # The voices as seen in the OpenTTS UI and documentation. Attach a gender as a fallback option.

file = open("lines", "r")
line = file.readline()

json_for_effects = dict()

while line:
    line = line.replace("\n", "").replace("\r", "")
    if line.startswith("#") or len(line) < 4:  # 4 is the absolute minimum (a::a)
        line = file.readline()
        continue
    line = line.split("::")
    print("Generating " + line[0])  # Print the filename so you know something's happening.
    if len(line) > 2:
        filename, text, read_json = line
    else:
        filename, text = line
        read_json = None

    if read_json:
        json_for_effects[filename] = json.loads(read_json)

    if not sys.argv.__contains__("skip"):
        for voice in voices:
            response = requests.request("get", "http://127.0.0.1:5500/api/tts?voice=" + urllib.parse.quote(voice) + "&text=" + urllib.parse.quote(text) + "&vocoder=high&cache=false")  # Cache is disabled cause the TTS can rarely dump out garbage. Vocoder set to high manually, cause some voices support varying qualities.

            base_path = "sounds/" + voice.replace(":", "_") + "/"
            os.makedirs(base_path, exist_ok=True)
            with open(base_path + filename + ".wav", "wb") as output:
                output.write(response.content)

    print("Saved " + line[0])
    line = file.readline()

commands = open("voice_config.json", "r")
commands_string = commands.read()  # Done like this to avoid holding a write lock when we really don't need it.
commands.close()
commands = json.loads(commands_string)

for voice in voices:
    if commands.__contains__(voice):
        commands_to_use = commands[voice]
    elif voices[voice] is not "male":
        commands_to_use = commands["<default_" + voices[voice] + ">"]
    else:
        continue

    audacity_pipeline.process_audio(voice.replace(":", "_"), commands_to_use, json_for_effects)
