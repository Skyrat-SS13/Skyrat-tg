/obj/item/organ/internal/lungs/synth
	name = "heatsink"
	desc = "A device that transfers generated heat to a fluid medium to cool it down. Required to keep your synthetics cool-headed. It's shape resembles lungs." //Purposefully left the 'fluid medium' ambigious for interpretation of the character, whether it be air or fluid cooling
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "lungs-ipc"
	safe_nitro_min = 0
	safe_co2_max = 0
	safe_plasma_min = 0
	safe_plasma_max = 0
	safe_oxygen_min = 0	//What are you doing man, dont breathe with those!
	safe_oxygen_max = 0
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_LUNGS
	maxHealth = 1.5 * STANDARD_ORGAN_THRESHOLD
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/internal/lungs/synth/emp_act(severity)
	. = ..()

	if(!owner || . & EMP_PROTECT_SELF)
		return

	if(!COOLDOWN_FINISHED(src, severe_cooldown)) //So we cant just spam emp to kill people.
		COOLDOWN_START(src, severe_cooldown, 10 SECONDS)

	switch(severity)
		if(EMP_HEAVY)
			to_chat(owner, span_warning("Alert: Critical cooling system failure! Seek maintenance immediately. Error Code: 5H-17"))
			apply_organ_damage(SYNTH_ORGAN_HEAVY_EMP_DAMAGE, maxHealth, required_organ_flag = ORGAN_ROBOTIC)
			owner.adjust_bodytemperature(SYNTH_HEAVY_EMP_TEMPERATURE_POWER * TEMPERATURE_DAMAGE_COEFFICIENT)

		if(EMP_LIGHT)
			to_chat(owner, span_warning("Alert: Major cooling system failure!"))
			apply_organ_damage(SYNTH_ORGAN_LIGHT_EMP_DAMAGE, maxHealth, required_organ_flag = ORGAN_ROBOTIC)
			owner.adjust_bodytemperature(SYNTH_LIGHT_EMP_TEMPERATURE_POWER * TEMPERATURE_DAMAGE_COEFFICIENT)

/datum/design/synth_heatsink
	name = "Heatsink"
	desc = "A device that transfers generated heat to a fluid medium to cool it down. Required to keep your synthetics cool-headed. It's shape resembles lungs."
	id = "synth_lungs"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/organ/internal/lungs/synth
	category = list(
		RND_SUBCATEGORY_MECHFAB_ANDROID + RND_SUBCATEGORY_MECHFAB_ANDROID_ORGANS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE
