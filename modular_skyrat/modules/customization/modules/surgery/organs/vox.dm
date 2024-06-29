/obj/item/organ/internal/lungs/nitrogen
	name = "nitrogen lungs"
	desc = "A set of lungs for breathing nitrogen."
	safe_oxygen_min = 0	//Dont need oxygen
	safe_oxygen_max = 2 //But it is quite toxic
	safe_nitro_min = 10 // Atleast 10 nitrogen
	oxy_damage_type = TOX
	oxy_breath_dam_min = 6
	oxy_breath_dam_max = 20

/obj/item/organ/internal/lungs/nitrogen/vox
	name = "vox lungs"
	desc = "They're filled with dust... wow."
	icon_state = "lungs-c"

	cold_level_1_threshold = 0 // Vox should be able to breathe in cold gas without issues?
	cold_level_2_threshold = 0
	cold_level_3_threshold = 0
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/internal/brain/vox
	name = "vox brain"
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/internal/brain/vox/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(owner.stat == DEAD)
		return
	switch(severity)
		if(1)
			to_chat(owner, span_boldwarning("You feel [pick("like your brain is being fried", "a sharp pain in your head")]!"))
			owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 20, 150)
			owner.set_jitter_if_lower(30 SECONDS)
			owner.adjust_stutter(30 SECONDS)
			owner.adjust_confusion(10 SECONDS)
		if(2)
			to_chat(owner, span_warning("You feel [pick("disoriented", "confused", "dizzy")]."))
			owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10, 150)
			owner.set_jitter_if_lower(30 SECONDS)
			owner.adjust_stutter(30 SECONDS)
			owner.adjust_confusion(3 SECONDS)
