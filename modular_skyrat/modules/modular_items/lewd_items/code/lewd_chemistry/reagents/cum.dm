/datum/reagent/consumable/femcum
	name = "femcum"
	description = "Uhh... Someone had fun."
	taste_description = "astringent and sweetish"
	color = "#ffffffb0"
	reagent_state = LIQUID

/datum/glass_style/drinking_glass/femcum
	required_drink_type = /datum/reagent/consumable/femcum
	icon_state = "glass_white"
	name = "glass of girlcum"
	desc = "A strange white liquid... Ew!"

/datum/glass_style/shot_glass/femcum
	required_drink_type = /datum/reagent/consumable/femcum
	icon_state ="shotglasscream"
	name = "glass of girlcum"
	desc = "A strange white liquid... Ew!"

/datum/reagent/consumable/cum
	name = "cum"
	description = "A fluid secreted by the sexual organs of many species."
	taste_description = "musky and salty"
	color = "#ffffffff"
	reagent_state = LIQUID

/datum/glass_style/drinking_glass/cum
	required_drink_type = /datum/reagent/consumable/cum
	icon_state = "glass_white"
	name = "glass of cum"
	desc = "O-oh, my...~"

/datum/glass_style/shot_glass/cum
	required_drink_type = /datum/reagent/consumable/cum
	icon_state ="shotglasscream"
	name = "glass of cum"
	desc = "O-oh, my...~"

/datum/chemical_reaction/cum
	results = list(/datum/reagent/consumable/cum = 5)
	required_reagents = list(/datum/reagent/blood = 2, /datum/reagent/consumable/milk = 2, /datum/reagent/consumable/salt = 1) // Iiiinteresting...
	mix_message = "The mixture turns into a gooey, musky white liquid..."
	erp_reaction = TRUE
