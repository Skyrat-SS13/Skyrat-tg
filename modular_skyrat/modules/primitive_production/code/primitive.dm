/datum/skill/primitive
	name = "Primitive"
	title = "Survivalist"
	desc = "Even after society has collapsed and they are by themselves, they can survive till the bitter end."
	modifiers = list(
		SKILL_SPEED_MODIFIER = list(1, 0.85, 0.75, 0.60, 0.45, 0.35, 0.25),
		SKILL_PROBS_MODIFIER = list(0, 5, 10, 20, 40, 80, 100)
	)
	skill_item_path = /obj/item/clothing/neck/cloak/skill_reward/primitive

/datum/skill/primitive/level_gained(datum/mind/mind, new_level, old_level, silent)
	. = ..()
	mind.current.apply_status_effect(/datum/status_effect/primitive_skill, new_level)


/datum/status_effect/primitive_skill
	status_type = STATUS_EFFECT_REFRESH
	tick_interval = 0.2 SECONDS
	alert_type = null
	var/stored_level = SKILL_LEVEL_NOVICE

/datum/status_effect/primitive_skill/refresh(effect, new_level)
	. = ..()
	stored_level = new_level


/datum/status_effect/primitive_skill/tick(seconds_between_ticks)
	for(var/atom/potential_farm in view(3, owner))
		var/datum/component/simple_farm/farm_component = potential_farm.GetComponent(/datum/component/simple_farm)
		if(!farm_component)
			continue

		var/obj/structure/simple_farm/farm = locate() in get_turf(farm_component.atom_parent)
		farm?.increase_level(stored_level)




/obj/item/clothing/neck/cloak/skill_reward/primitive
	name = "legendary survivalist's cloak"
	desc = "Those who wear this cloak take the responsibility that comes with it: that they may be last survivor of their race. \
	Society may change or crumble, yet those who wear this cloak will observe that destruction and carry their task."
	icon = 'modular_skyrat/modules/primitive_production/icons/cloaks.dmi'
	worn_icon = 'modular_skyrat/modules/primitive_production/icons/neck.dmi'
	icon_state = "primitivecloak"
	associated_skill_path = /datum/skill/primitive
