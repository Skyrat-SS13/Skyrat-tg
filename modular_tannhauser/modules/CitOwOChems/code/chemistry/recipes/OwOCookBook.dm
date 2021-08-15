/datum/chemical_reaction/OwO
	var/name = null
	var/id = null


//Called when temperature is above a certain threshold, or if purity is too low.
/datum/chemical_reaction/proc/OwOExplode(datum/reagents/R0, atom/my_atom, volume, temp, ph, Exploding = FALSE)
	if (Exploding == TRUE)
		return

	if(!ph)//Dunno how things got here without a ph, but just in case
		ph = 7
	var/ImpureTot = 0
	var/turf/T = get_turf(my_atom)

	if(temp>500)//if hot, start a fire
		switch(temp)
			if (500 to 750)
				for(var/turf/turf in range(1,T))
					new /obj/effect/hotspot(turf)
				volume*=1.1

			if (751 to 1100)
				for(var/turf/turf in range(2,T))
					new /obj/effect/hotspot(turf)
				volume*=1.2

			if (1101 to 1500) //If you're crafty
				for(var/turf/turf in range(3,T))
					new /obj/effect/hotspot(turf)
				volume*=1.3

			if (1501 to 2500) //requested
				for(var/turf/turf in range(4,T))
					new /obj/effect/hotspot(turf)
				volume*=1.4

			if (2501 to 5000)
				for(var/turf/turf in range(5,T))
					new /obj/effect/hotspot(turf)
				volume*=1.5

			if (5001 to INFINITY)
				for(var/turf/turf in range(6,T))
					new /obj/effect/hotspot(turf)
				volume*=1.6


	message_admins("OwO explosion at [T], with a temperature of [temp], ph of [ph], Impurity tot of [ImpureTot].")
	log_game("OwO explosion at [T], with a temperature of [temp], ph of [ph], Impurity tot of [ImpureTot].")
	var/datum/reagents/R = new/datum/reagents(3000)//Hey, just in case.
	var/datum/effect_system/smoke_spread/chem/s = new()
	R.my_atom = my_atom //Give the gas a fingerprint

	for (var/A in R0.reagent_list) //make gas for reagents, has to be done this way, otherwise it never stops Exploding
		var/datum/reagent/R2 = A
		R.add_reagent(R2.type, R2.volume/3) //Seems fine? I think I fixed the infinite explosion bug.

		if (R2.purity < 0.6)
			ImpureTot = (ImpureTot + (1-R2.purity)) / 2

	if(ph < 4) //if acidic, make acid spray
		R.add_reagent(/datum/reagent/inverse, (volume/3))
	if(R.reagent_list)
		s.set_up(R, (volume/5), my_atom)
		s.start()

	if (ph > 10) //if alkaline, small explosion.
		var/datum/effect_system/reagents_explosion/e = new()
		e.set_up(round((volume/28)*(ph-9)), T, 0, 0)
		e.start()

	if(ImpureTot) //If impure, v.small emp (0.6 or less)
		empulse(T, ImpureTot, 1)

	my_atom.reagents.clear_reagents() //just in case
	return


//FURRANIUM

/datum/chemical_reaction/OwO/furranium
	name = "Furranium"
	id = /datum/reagent/OwO/furranium
	results = list(/datum/reagent/OwO/furranium = 5)
	required_reagents = list(/datum/reagent/drug/dopamine = 1, /datum/reagent/pax/catnip = 1, /datum/reagent/silver = 2, /datum/reagent/medicine/salglu_solution = 1) // /datum/reagent/moonsugar = 1,
	mix_message = "You think you can hear a howl come from the beaker."
	//OwOChem vars:
	required_temp 	= 350
	optimal_temp 	= 600
	overheat_temp 	= 700
	optimal_ph_min 	= 8
	optimal_ph_max 	= 10
	//CatalystFact 	= 0 //To do 1
	thermic_constant = -10
	H_ion_release 	= -0.1
	rate_up_lim 		= 2
	purity_min		= 0.3

//PLUSHY

/datum/chemical_reaction/OwO/plushmium
	name = "Plushification serum"
	id = /datum/reagent/OwO/plushmium
	results = list(/datum/reagent/OwO/plushmium = 5)
	required_reagents = list(/datum/reagent/medicine/strange_reagent = 5, /datum/reagent/drug/happiness = 3, /datum/reagent/blood = 10, /datum/reagent/consumable/laughter = 5, /datum/reagent/toxin/bad_food = 6)
	mix_message = "From within the vessel you here the echoing laughter of small children"
	//OwOChem vars:
	required_temp 	= 400
	optimal_temp 	= 666
	overheat_temp 	= 800
	optimal_ph_min 	= 2
	optimal_ph_max 	= 5
	//CatalystFact 	= 0 //To do 1
	thermic_constant = -2
	H_ion_release 	= -0.1
	rate_up_lim 		= 2
	purity_min		= 0.6

/datum/chemical_reaction/OwO/plushmium/OwOExplode(datum/reagents, var/atom/my_atom, volume, temp, ph)
	if(volume < 20) //It creates a normal plush at low volume.. at higher amounts, things get slightly more interesting.
		new /obj/item/toy/plush/random(get_turf(my_atom))
	else
		new /obj/item/toy/plush/plushling(get_turf(my_atom))
	my_atom.visible_message("<span class='warning'>The reaction suddenly zaps, creating a plushie!</b></span>")
	my_atom.reagents.clear_reagents()
