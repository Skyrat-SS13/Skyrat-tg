/datum/reagent/consumable/breast_milk
	name = "breast milk"
	description = "This looks familiar... Wait, it's milk!"
	taste_description = "warm and creamy"
	color = "#ffffffff"
	reagent_state = LIQUID

/datum/reagent/consumable/breast_milk/moth_milk
	name = "moth milk"
	description = "This looks familiar... Wait, what the fuck?!"
	taste_description = "warm and silky"
	color = "#ffffddff"

/datum/glass_style/drinking_glass/breast_milk
	required_drink_type = /datum/reagent/consumable/breast_milk
	icon_state = "glass_white"
	name = "glass of breast milk"
	desc = "almost like normal milk."
