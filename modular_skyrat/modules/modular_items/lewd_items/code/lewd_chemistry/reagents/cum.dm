/datum/reagent/consumable/femcum
	name = "femcum"
	description = "Uhh... Someone had fun."
	taste_description = "astringent and sweetish"
	color = "#ffffffb0"
	glass_name = "glass of girlcum"
	glass_desc = "A strange white liquid... Ew!"
	reagent_state = LIQUID
	shot_glass_icon_state = "shotglasswhite"

/datum/reagent/consumable/cum
	name = "cum"
	description = "A fluid secreted by the sexual organs of many species."
	taste_description = "musky and salty"
	color = "#ffffffff"
	glass_name = "glass of cum"
	glass_desc = "O-oh, my...~"
	reagent_state = LIQUID
	shot_glass_icon_state = "shotglasswhite"

/datum/chemical_reaction/cum
	results = list(/datum/reagent/consumable/cum = 5)
	required_reagents = list(/datum/reagent/blood = 2, /datum/reagent/consumable/milk = 2, /datum/reagent/consumable/salt = 1) // Iiiinteresting...
	mix_message = "The mixture turns into a gooey, musky white liquid..."
