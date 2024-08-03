/obj/item/organ/internal/heart/synth
	name = "hydraulic pump engine"
	desc = "An electronic device that handles the hydraulic pumps, powering one's robotic limbs. Without this, synthetics are unable to move."
	organ_flags = ORGAN_ROBOTIC
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "heart-ipc-on"
	base_icon_state = "heart-ipc"
	maxHealth = 1.5 * STANDARD_ORGAN_THRESHOLD // 1.5x due to synthcode.tm being weird
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_HEART
	var/last_message_time = 0

/obj/item/organ/internal/heart/synth/emp_act(severity)
	. = ..()

	if(!owner || . & EMP_PROTECT_SELF)
		return

	if(!COOLDOWN_FINISHED(src, severe_cooldown)) //So we cant just spam emp to kill people.
		COOLDOWN_START(src, severe_cooldown, 10 SECONDS)

	switch(severity)
		if(EMP_HEAVY)
			to_chat(owner, span_warning("Alert: Main hydraulic pump control has taken severe damage, seek maintenance immediately. Error code: HP300-10."))
			apply_organ_damage(SYNTH_ORGAN_HEAVY_EMP_DAMAGE, maxHealth, required_organ_flag = ORGAN_ROBOTIC)
		if(EMP_LIGHT)
			to_chat(owner, span_warning("Alert: Main hydraulic pump control has taken light damage, seek maintenance immediately. Error code: HP300-05."))
			apply_organ_damage(SYNTH_ORGAN_LIGHT_EMP_DAMAGE, maxHealth, required_organ_flag = ORGAN_ROBOTIC)

/datum/design/synth_heart
	name = "Hydraulic Pump Engine"
	desc = "An electronic device that handles the hydraulic pumps, powering one's robotic limbs. Without this, synthetics are unable to move."
	id = "synth_heart"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/organ/internal/heart/synth
	category = list(
		RND_SUBCATEGORY_MECHFAB_ANDROID + RND_SUBCATEGORY_MECHFAB_ANDROID_ORGANS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE
