/datum/skill/fishing
	name = "Fishing"
	title = "Fisher"
	desc = "The person who enjoys the solitute to enjoy the catch."
	modifiers = list(
		SKILL_SPEED_MODIFIER = list(1, 0.95, 0.9, 0.85, 0.75, 0.6, 0.5),
		SKILL_PROBS_MODIFIER = list(0, 5, 10, 20, 40, 80, 100),
		SKILL_RANDS_MODIFIER = list(0, 0, 0, 0, 0, 1, 1)
	)
	skill_cape_path = /obj/item/clothing/neck/cloak/skill_reward/fishing

/obj/item/clothing/neck/cloak/skill_reward/fishing
	name = "legendary fisher's cloak"
	desc = "Worn by the most skilled fishers, this legendary cloak is only attainable by having the patience and experience to fish. \
	This status symbol represents a being who has fished some of the fiercest fishes and survived the weathering storms."
	icon = 'modular_skyrat/modules/fishing/icons/cloaks.dmi'
	worn_icon = 'modular_skyrat/modules/fishing/icons/neck.dmi'
	icon_state = "fishingcloak"
	associated_skill_path = /datum/skill/fishing
