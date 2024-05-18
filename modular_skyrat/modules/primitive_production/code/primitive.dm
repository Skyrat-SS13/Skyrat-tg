/datum/skill/primitive
	name = "Primitive"
	title = "Survivalist"
	desc = "Even after society has collapsed and they are by themselves, they can survive till the bitter end."
	modifiers = list(
		SKILL_SPEED_MODIFIER = list(1, 0.85, 0.75, 0.60, 0.45, 0.35, 0.25),
		SKILL_PROBS_MODIFIER = list(0, 5, 10, 20, 40, 80, 100)
	)
	skill_item_path = /obj/item/clothing/neck/cloak/skill_reward/primitive

/obj/item/clothing/neck/cloak/skill_reward/primitive
	name = "legendary survivalist's cloak"
	desc = "Those who wear this cloak take the responsibility that comes with it: that they may be last survivor of their race. \
	Society may change or crumble, yet those who wear this cloak will observe that destruction and carry their task."
	icon = 'modular_skyrat/modules/primitive_production/icons/cloaks.dmi'
	worn_icon = 'modular_skyrat/modules/primitive_production/icons/neck.dmi'
	icon_state = "primitivecloak"
	associated_skill_path = /datum/skill/primitive
