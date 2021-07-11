/mob/living/simple_animal/pet/dog/markus
	name = "\proper Markus"
	real_name = "Markus"
	gender = MALE
	desc = "It's the Cargo's overfed, yet still beloved dog."
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "markus"
	icon_dead = "markus_dead"
	icon_living = "markus"
	speak = list("Borf!", "Boof!", "Bork!", "Bowwow!", "Burg?")
	butcher_results = list(/obj/item/food/burger/cheese = 1, /obj/item/food/meat/slab = 2, /obj/item/trash/syndi_cakes = 1)
	animal_species = /mob/living/simple_animal/pet/dog
	can_be_held = FALSE
	gold_core_spawnable = FRIENDLY_SPAWN

/mob/living/simple_animal/pet/dog/markus/treat_message(message)
	return client ? pick(speak) : message //markus only talks business

/datum/chemical_reaction/mark_reaction
	results = list(/datum/reagent/liquidgibs = 15)
	required_reagents = list(/datum/reagent/medicine/omnizine = 20,
	/datum/reagent/blood = 20,
	/datum/reagent/medicine/c2/synthflesh = 20,
	/datum/reagent/consumable/nutriment/protein = 10,
	/datum/reagent/consumable/nutriment = 10,
	/datum/reagent/colorful_reagent/powder/yellow/crayon = 5,
	/datum/reagent/consumable/ketchup = 5,
	/datum/reagent/consumable/mayonnaise = 5)
	required_catalysts = list(/datum/reagent/consumable/enzyme = 5)
	required_temp = 480

/datum/chemical_reaction/mark_reaction/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	. = ..()
	var/location = get_turf(holder.my_atom)
	new /mob/living/simple_animal/pet/dog/markus(location)
	playsound(location, 'modular_skyrat/master_files/sound/effects/dorime.ogg', 100, 0, 7)
