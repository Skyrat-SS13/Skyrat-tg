/obj/item/organ/internal/stomach/synth
	name = "synthetic bio-reactor"
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "stomach-ipc"
	w_class = WEIGHT_CLASS_NORMAL
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_STOMACH
	maxHealth = 1 * STANDARD_ORGAN_THRESHOLD
	zone = "chest"
	slot = "stomach"
	desc = "A specialised mini reactor, for synthetic use only. Has a low-power mode to ensure baseline functions. Without this, synthetics are unable to stay powered."
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/internal/stomach/synth/emp_act(severity)
	. = ..()

	if(!owner || . & EMP_PROTECT_SELF)
		return

	if(!COOLDOWN_FINISHED(src, severe_cooldown)) //So we cant just spam emp to kill people.
		COOLDOWN_START(src, severe_cooldown, 10 SECONDS)

	switch(severity)
		if(EMP_HEAVY)
			owner.nutrition = max(0, owner.nutrition - SYNTH_STOMACH_HEAVY_EMP_CHARGE_LOSS)
			apply_organ_damage(SYNTH_ORGAN_HEAVY_EMP_DAMAGE, maxHealth, required_organ_flag = ORGAN_ROBOTIC)
			to_chat(owner, span_warning("Alert: Severe battery discharge!"))

		if(EMP_LIGHT)
			owner.nutrition = max(0, owner.nutrition - SYNTH_STOMACH_LIGHT_EMP_CHARGE_LOSS)
			apply_organ_damage(SYNTH_ORGAN_LIGHT_EMP_DAMAGE, maxHealth, required_organ_flag = ORGAN_ROBOTIC)
			to_chat(owner, span_warning("Alert: Minor battery discharge!"))

/datum/design/synth_stomach
	name = "Synthetic Bio-Reactor"
	desc = "A specialised mini reactor, for synthetic use only. Has a low-power mode to ensure baseline functions. Without this, synthetics are unable to stay powered."
	id = "synth_stomach"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	construction_time = 4 SECONDS
	materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/organ/internal/stomach/synth
	category = list(
		RND_SUBCATEGORY_MECHFAB_ANDROID + RND_SUBCATEGORY_MECHFAB_ANDROID_ORGANS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SCIENCE

/obj/item/organ/internal/stomach/synth/Insert(mob/living/carbon/receiver, special, movement_flags)
	. = ..()
	RegisterSignal(receiver, COMSIG_PROCESS_BORGCHARGER_OCCUPANT, PROC_REF(on_borg_charge))

/obj/item/organ/internal/stomach/synth/Remove(mob/living/carbon/stomach_owner, special)
	. = ..()
	UnregisterSignal(stomach_owner, COMSIG_PROCESS_BORGCHARGER_OCCUPANT)

///Handles charging the synth from borg chargers
/obj/item/organ/internal/stomach/synth/proc/on_borg_charge(datum/source, datum/callback/charge_cell, seconds_per_tick)
	SIGNAL_HANDLER

	if(owner.nutrition >= NUTRITION_LEVEL_ALMOST_FULL)
		return

	// I am NOT rewriting this to fit with TG's standard. I have like 70 bugfixes waiting. Feel free to give synths actual cells if I don't i the future
	// ~Waterpig

	owner.nutrition = min(owner.nutrition + (40 / seconds_per_tick), NUTRITION_LEVEL_ALMOST_FULL) // Makes sure we don't make the synth too full, which would apply the overweight slowdown
