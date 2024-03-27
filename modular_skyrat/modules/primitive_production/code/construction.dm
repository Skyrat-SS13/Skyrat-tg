/datum/skill/construction
	name = "Construction"
	title = "Builder"
	desc = "To be a builder is to enjoy the start and construction of civilization."
	modifiers = list(
		SKILL_SPEED_MODIFIER = list(1, 0.95, 0.9, 0.85, 0.75, 0.6, 0.5),
		SKILL_PROBS_MODIFIER = list(0, 5, 10, 20, 40, 80, 100)
	)
	skill_item_path = /obj/item/clothing/neck/cloak/skill_reward/construction

/obj/item/clothing/neck/cloak/skill_reward/construction
	name = "legendary builder's cloak"
	desc = "Those who wear this cloak have the knowledge and understanding to start the foundation of a civilization. \
	It is within folklore that there exists people who can create and destroy villages, towns, and cities within minutes."
	icon = 'modular_skyrat/modules/primitive_production/icons/cloaks.dmi'
	worn_icon = 'modular_skyrat/modules/primitive_production/icons/neck.dmi'
	icon_state = "buildercloak"
	associated_skill_path = /datum/skill/construction
