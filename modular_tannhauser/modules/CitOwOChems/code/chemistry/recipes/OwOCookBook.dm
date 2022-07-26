/datum/chemical_reaction/OwO
	var/name = null
	var/id = null

//FURRANIUM

/datum/chemical_reaction/OwO/furranium
	name = "Furranium"
	id = /datum/reagent/OwO/furranium
	results = list(/datum/reagent/OwO/furranium = 5)
	required_reagents = list(/datum/reagent/drug/aphrodisiac/crocin = 1, /datum/reagent/pax/catnip = 1, /datum/reagent/silver = 2, /datum/reagent/medicine/salglu_solution = 1) // /datum/reagent/moonsugar = 1
	mix_message = "You think you can hear a howl come from the beaker."
	//OwOChem vars:
	required_temp 	 = 350
	optimal_temp 	 = 600
	overheat_temp 	 = 700
	optimal_ph_min 	 = 8
	optimal_ph_max 	 = 10
	thermic_constant = -10
	H_ion_release 	 = -0.1
	rate_up_lim 	 = 2
	purity_min		 = 0.3
	reaction_tags	 = REACTION_TAG_MODERATE | REACTION_TAG_ORGAN

//PLUSHY

/datum/chemical_reaction/OwO/plushmium
	name = "Plushification serum"
	id = /datum/reagent/OwO/plushmium
	results = list(/datum/reagent/OwO/plushmium = 5)
	required_reagents = list(/datum/reagent/medicine/strange_reagent = 5, /datum/reagent/drug/happiness = 3, /datum/reagent/blood = 10, /datum/reagent/consumable/laughter = 5, /datum/reagent/toxin/bad_food = 6)
	mix_message = "From within the vessel you here the echoing laughter of small children"
	//OwOChem vars:
	required_temp 	 = 400
	optimal_temp 	 = 666
	overheat_temp 	 = 800
	optimal_ph_min 	 = 2
	optimal_ph_max 	 = 5
	thermic_constant = -2
	H_ion_release 	 = -0.1
	rate_up_lim 	 = 2
	purity_min		 = 0.6
	reaction_tags	 = REACTION_TAG_HARD | REACTION_TAG_OTHER


/datum/chemical_reaction/OwO/plushmium/reaction_finish(datum/reagents/holder, datum/equilibrium/reaction, react_vol)
	..()
	var/datum/reagent/plushmium = holder.get_reagent(/datum/reagent/OwO/plushmium)
	if(plushmium.purity > 0.9) // High purity leaves the reagent behind, so you can make plushie shells
		return
	if(react_vol < 20) // It creates a normal plush at low volume.. at higher amounts, things get slightly more interesting.
		var/obj/item/toy/plush/P = pick(GLOB.valid_plushie_paths)
		new P(get_turf(holder.my_atom))
	else
		new /obj/item/toy/plush/plushling(get_turf(holder.my_atom))
	holder.my_atom.audible_message("<span class='warning'>The reaction suddenly zaps, creating a plushie!</b></span>")
	clear_products(holder)

