/datum/component/mindless_killer
	///how much force is added to items before hitting a mindless mob
	var/mindless_force = 10
	///how much force is multiplied to items before hitting a mindless mob (applied after mindless force)
	var/mindless_multiplier = 1
	///the obj parent this component is attached to
	var/obj/obj_parent

/datum/component/mindless_killer/Initialize(mindless_force_override = 10, mindless_multiplier_override = 1)
	if(!isobj(parent))
		return COMPONENT_INCOMPATIBLE

	obj_parent = parent

	mindless_force = mindless_force_override
	mindless_multiplier = mindless_multiplier_override

	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(examine))
	RegisterSignal(parent, COMSIG_ITEM_AFTERATTACK, PROC_REF(deal_smite))

/datum/component/mindless_killer/proc/examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += span_danger("It has an awful gleam against those who cannot think.")

/datum/component/mindless_killer/proc/deal_smite(datum/source, mob/living/target_mob, mob/user, params)
	SIGNAL_HANDLER
	if(!istype(target_mob))
		return
	if(target_mob.mind)
		return
	var/extra_damage = (obj_parent.force + mindless_force) * mindless_multiplier
	target_mob.apply_damage(extra_damage, forced = TRUE, spread_damage = TRUE)
	return
