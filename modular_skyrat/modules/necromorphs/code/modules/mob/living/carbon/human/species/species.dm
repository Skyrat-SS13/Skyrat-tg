/datum/species
	//Audio vars
	var/step_volume = 30	//Base volume of ALL footstep sounds for this mob
	var/step_range = -1		//Base volume of ALL footstep sounds for this mob. Each point of range adds or subtracts two tiles from the actual audio distance
	var/step_priority = 0	//Base priority of species-specific footstep sounds. Zero disables them
	var/pain_audio_threshold = 0	//If a mob takes damage equal to this portion of its total health, (and audio files exist), it will scream in pain
	var/list/species_audio = list()	//An associative list of lists, in the format SOUND_TYPE = list(sound_1, sound_2)
		//In addition, the list of sounds supports weighted picking (default weight 1 if unspecified).
		//For example: (sound_1, sound_2 = 0.5) will result in sound_2 being played half as often as sound_1
	var/list/speech_chance                    // The likelihood of a speech sound playing.
	var/list/species_audio_volume = list()		//An associative list, in the format SOUND_TYPE = VOLUME_XXX. Values set here will override the volume of species audio files

/datum/species/proc/setup_defense(var/mob/living/carbon/human/H)

//Species level audio wrappers
//--------------------------------
/datum/species/proc/get_species_audio(var/audio_type)
	var/list/L = species_audio[audio_type]
	return null

/datum/species/proc/play_species_audio(var/atom/source, audio_type, vol as num, vary, extrarange as num, falloff, var/is_global, var/frequency, var/is_ambiance = 0)
	var/soundin = get_species_audio(audio_type)
	if (soundin)
		playsound(source, soundin, vol, vary, extrarange, falloff, is_global, frequency, is_ambiance)
		return TRUE
	return FALSE


/mob/proc/play_species_audio()
	return

// /mob/living/carbon/human/play_species_audio(var/atom/source, audio_type, var/volume = VOLUME_MID, var/vary = TRUE, extrarange as num, falloff, var/is_global, var/frequency, var/is_ambiance = 0)

// 	if (species.species_audio_volume[audio_type])
// 		volume = species.species_audio_volume[audio_type]
// 	return species.play_species_audio(arglist(args.Copy()))

// /mob/proc/get_species_audio()
// 	return

// /mob/living/carbon/human/get_species_audio(var/audio_type)
// 	return species.get_species_audio(arglist(args.Copy()))
