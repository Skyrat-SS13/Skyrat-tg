/datum/chemical_reaction/system_cleaner
	results = list(/datum/reagent/medicine/system_cleaner = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol = 1, /datum/reagent/chlorine = 1, /datum/reagent/phenol = 2, /datum/reagent/potassium = 1)

/datum/chemical_reaction/liquid_solder
	results = list(/datum/reagent/medicine/liquid_solder = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol = 1, /datum/reagent/copper = 1, /datum/reagent/silver = 1)
	required_temp = 370
	mix_message = "The mixture becomes a metallic slurry."

/datum/chemical_reaction/nanite_slurry
	results = list(/datum/reagent/medicine/nanite_slurry = 3)
	required_reagents = list(/datum/reagent/foaming_agent = 1, /datum/reagent/gold = 1, /datum/reagent/iron = 1)
	mix_message = "The mixture becomes a metallic slurry."


/datum/chemical_reaction/medicine/taste_suppressor
	results = list(/datum/reagent/medicine/taste_suppressor = 3)
	required_reagents = list(/datum/reagent/sodium = 1, /datum/reagent/sulfur = 1, /datum/reagent/water = 1)
	mix_message = "The mixture becomes clear like water."


/datum/chemical_reaction/medicine/taste_suppressor/maint
	results = list(/datum/reagent/medicine/taste_suppressor = 3, /datum/reagent/chlorine = 1) // The chlorine dissociated from the sodium to allow for the synthesis of the taste suppressor
	required_reagents = list(/datum/reagent/consumable/salt = 2, /datum/reagent/sulfur = 1, /datum/reagent/water = 1)
	required_temp = 300

/datum/chemical_reaction/medicine/dermagen
	results = list(/datum/reagent/medicine/dermagen = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol = 4, /datum/reagent/medicine/c2/synthflesh = 3, /datum/reagent/medicine/mine_salve = 3)
	mix_message = "The slurry congeals into a thick cream."
