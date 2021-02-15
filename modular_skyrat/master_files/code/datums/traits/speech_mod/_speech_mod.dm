/mob/living/carbon/human/var/list/speech_mods = list()

/mob/living/carbon/human/proc/toggle_speech_mod(datumtype)
	var/checkbool = TRUE
	for(var/datum/speech_mod/S in speech_mods)
		if(istype(S,datumtype))
			S.remove_speech_mod()
			qdel(S)
			checkbool = FALSE
			break
	if(checkbool)
		var/datum/speech_mod/speech = new datumtype
		speech.add_speech_mod(src)

/mob/living/carbon/human/proc/enable_speech_mod(datumtype)
	for(var/datum/speech_mod/S in speech_mods)
		if(istype(S,datumtype))
			return
	var/datum/speech_mod/speech = new datumtype
	speech.add_speech_mod(src)

/mob/living/carbon/human/proc/disable_speech_mod(datumtype)
	for(var/datum/speech_mod/S in speech_mods)
		if(istype(S,datumtype))
			S.remove_speech_mod()
			qdel(S)

/datum/speech_mod
	var/soundtext = ""
	var/mob/living/carbon/human/affected_mob = null

/datum/speech_mod/proc/handle_speech(datum/source, list/speech_args)
	return

/datum/speech_mod/proc/after_add()
	RegisterSignal(affected_mob, COMSIG_MOB_SAY, .proc/handle_speech)
	if(soundtext)
		to_chat(affected_mob, "You start [soundtext].")
	return

/datum/speech_mod/proc/add_speech_mod(mob/living/carbon/human/M)
	affected_mob = M
	affected_mob.speech_mods += src
	after_add()

/datum/speech_mod/proc/remove_speech_mod()
	if(soundtext)
		to_chat(affected_mob, "You stop [soundtext].")
	UnregisterSignal(affected_mob, COMSIG_MOB_SAY)
	affected_mob.speech_mods -= src
	affected_mob = null
