/obj/item/organ/internal/eyes/synth
	name = "optical sensors"
	icon_state = "cybernetic_eyeballs"
	desc = "A very basic set of optical sensors with no extra vision modes or functions."
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC | ORGAN_SYNTHETIC_FROM_SPECIES

/obj/item/organ/internal/eyes/synth/emp_act(severity)
	. = ..()

	if(!owner || . & EMP_PROTECT_SELF)
		return

	to_chat(owner, span_warning("Electromagnetic interference clouds your optics with static."))
	owner.flash_act(visual = TRUE)

	switch(severity)
		if(EMP_LIGHT)
			owner.adjustOrganLoss(ORGAN_SLOT_EYES, SYNTH_ORGAN_LIGHT_EMP_DAMAGE)
		if(EMP_HEAVY)
			owner.adjustOrganLoss(ORGAN_SLOT_EYES, SYNTH_ORGAN_HEAVY_EMP_DAMAGE)
