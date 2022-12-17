/obj/item/organ/internal/stomach/synth
	name = "synth power cell"
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "stomach-ipc"
	w_class = WEIGHT_CLASS_NORMAL
	zone = "chest"
	slot = "stomach"
	desc = "A specialised cell, for synthetic use only. Has a low-power mode. Without this, synthetics are unable to stay powered."
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/internal/stomach/synth/emp_act(severity)
	. = ..()
	if(!owner || . & EMP_PROTECT_SELF)
		return
	switch(severity)
		if(1)
			owner.nutrition = 50
			to_chat(owner, span_warning("Alert: Detected severe battery discharge!"))
		if(2)
			owner.nutrition = 250
			to_chat(owner, span_warning("Alert: Minor battery discharge!"))

/obj/item/organ/internal/ears/synth
	name = "auditory sensors"
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "ears-ipc"
	desc = "A pair of microphones intended to be installed in an IPC head, that grant the ability to hear."
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EARS
	gender = PLURAL
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/internal/ears/synth/emp_act(severity)
	. = ..()
	if(!owner || . & EMP_PROTECT_SELF)
		return
	switch(severity)
		if(1)
			owner.set_jitter_if_lower(60 SECONDS)
			owner.set_dizzy_if_lower(60 SECONDS)
			owner.Knockdown(80)
			deaf = 30
			to_chat(owner, span_warning("Your system reports a complete lack of input from your auditory sensors."))
		if(2)
			owner.set_jitter_if_lower(30 SECONDS)
			owner.set_dizzy_if_lower(30 SECONDS)
			owner.Knockdown(40)
			to_chat(owner, span_warning("Your system reports anomalous feedback from your auditory sensors."))

/obj/item/organ/internal/tongue/synth
	name = "synthetic voicebox"
	desc = "A voice synthesizer that allows synths to communicate with lifeforms. Tuned to sound less agressive than robotic voiceboxes."
	status = ORGAN_ROBOTIC
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "tongue-ipc"
	say_mod = "beeps"
	modifies_speech = TRUE
	taste_sensitivity = 25 // not as good as an organic tongue
	maxHealth = 100 //RoboTongue!
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/internal/tongue/synth/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_SPANS] |= SPAN_ROBOT

/obj/item/organ/internal/eyes/synth
	name = "optical sensors"
	icon_state = "cybernetic_eyeballs"
	desc = "A very basic set of optical sensors with no extra vision modes or functions."
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/internal/eyes/synth/emp_act(severity)
	. = ..()
	if(!owner || . & EMP_PROTECT_SELF)
		return
	to_chat(owner, span_warning("Electromagnetic interference clouds your optics with static."))
	owner.flash_act(visual = 1)
	if(severity == EMP_HEAVY)
		owner.adjustOrganLoss(ORGAN_SLOT_EYES, 20)

/obj/item/organ/internal/lungs/synth
	name = "heat sink"
	desc = "A device that transfers generated heat to a fluid medium to cool it down. Required to keep your synthetics cool-headed. It's shape resembles lungs." //Purposefully left the 'fluid medium' ambigious for interpretation of the character, whether it be air or fluid cooling
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "lungs-ipc"
	safe_nitro_min = 0
	safe_nitro_max = 0
	safe_co2_min = 0
	safe_co2_max = 0
	safe_plasma_min = 0
	safe_plasma_max = 0
	safe_oxygen_min = 0	//What are you doing man, dont breathe with those!
	safe_oxygen_max = 0
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/internal/lungs/synth/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	switch(severity)
		if(1)
			to_chat(owner, span_warning("Alert: Critical cooling system failure!"))
			owner.adjust_bodytemperature(100*TEMPERATURE_DAMAGE_COEFFICIENT)
		if(2)
			owner.adjust_bodytemperature(30*TEMPERATURE_DAMAGE_COEFFICIENT)

/obj/item/organ/internal/heart/synth
	name = "hydraulic pump engine"
	desc = "An electronic device that handles the hydraulic pumps, powering one's robotic limbs. Without this, synthetics are unable to move."
	organ_flags = ORGAN_SYNTHETIC
	status = ORGAN_ROBOTIC
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "heart-ipc"

/obj/item/organ/internal/liver/synth
	name = "reagent processing unit"
	desc = "An electronic device that processes the beneficial chemicals for the synthetic user."
	organ_flags = ORGAN_SYNTHETIC
	status = ORGAN_ROBOTIC
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "liver-c"
	filterToxins = FALSE //We dont filter them, we're immune to them


