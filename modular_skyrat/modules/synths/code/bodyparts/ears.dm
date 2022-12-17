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
