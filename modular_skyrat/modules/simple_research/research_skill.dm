/datum/skill/research
	name = "Researching"
	title = "Researcher"
	desc = "Those who desire to discover the mysteries of the universe-- or taste rocks."
	modifiers = list(
		SKILL_SPEED_MODIFIER = list(1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.25),
		SKILL_PROBS_MODIFIER = list(0, 5, 10, 20, 40, 80, 100)
	)
	skill_item_path = /obj/item/clothing/neck/cloak/skill_reward/researching

/obj/item/clothing/neck/cloak/skill_reward/researching
	name = "legendary researcher's cloak"
	desc = "This legendary cloak is awarded only to those who have created a large stir within the scientific community with their contributions. \
	Those who wear this cloak create the scientific foundations, and have the ability to discern the truth of the universe even from the most mundane things."
	icon = 'modular_skyrat/modules/simple_research/cloaks.dmi'
	worn_icon = 'modular_skyrat/modules/simple_research/neck.dmi'
	icon_state = "researchcloak"
	associated_skill_path = /datum/skill/research
