/datum/language/vox
	name = "Vox Standard"
	desc = "A form of hybrid encoded language employed by the biomechanical Vox species, characterized by sounding extremely annoying and irritating to those who don't recognize it. It usually requires an implant to be spoken in its entirety."
	key = "V"
	flags = TONGUELESS_SPEECH
	space_chance = 40
	syllables = list("ti","ti","ti","hi","hi","ki","ki","ki","ki","ya","ta","ha","ka","ya", "yi", "chi","cha","kah","SKRE","AHK","EHK","RAWK","KRA","AAA","EEE","KI","II","KRI","KA")
	icon_state = "vox-pidgin"
	icon = 'modular_skyrat/master_files/icons/misc/language.dmi'
	default_priority = 99

/datum/language/vox/get_random_name(
	gender = NEUTER,
	name_count = default_name_count,
	syllable_min = default_name_syllable_min,
	syllable_max = default_name_syllable_max,
	force_use_syllables = FALSE,
)
	if(force_use_syllables)
		return ..()

	var/newname = ""
	for(var/i in 1 to rand(2, 8))
		newname += pick(list("ti","hi","ki","ya","ta","ha","ka","ya","chi","cha","kah","ri","ra"))
	return capitalize(newname)
