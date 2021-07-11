/mob/living/simple_animal/pet/dog/cheems
	name = "\proper Cheems"
	real_name = "Cheems"
	gender = MALE
	desc = "It's the Cargo's overfed, yet still beloved dog."
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "cheems"
	icon_dead = "cheems_dead"
	icon_living = "cheems"
	speak = list("Borf!", "Boof!", "Bork!", "Bowwow!", "Burbger...", "Pizza cramte.", "No horny.")
	butcher_results = list(/obj/item/food/burger/cheese = 1, /obj/item/food/meat/slab = 2, /obj/item/trash/syndi_cakes = 1)
	animal_species = /mob/living/simple_animal/pet/dog
	can_be_held = FALSE
	gold_core_spawnable = FRIENDLY_SPAWN

/mob/living/simple_animal/pet/dog/cheems/treat_message(message)
	if(client) //cheems only thinks of necessities
		message = pick("Borf!", "Boof!", "Bork!", "Bowwow!", "Burbger...", "Pizza cramte.", "No horny.")

	return message

/datum/chemical_reaction/cheem_reaction
	results = list(/datum/reagent/ash = 1)
	required_reagents = list(/datum/reagent/medicine/insulin = 20, /datum/reagent/medicine/omnizine = 20, /datum/reagent/blood = 20, /datum/reagent/medicine/c2/synthflesh = 20, /datum/reagent/colorful_reagent/powder/yellow/crayon = 10, /datum/reagent/consumable/nutriment/protein = 10)
	required_temp = 420

/datum/chemical_reaction/cheem_reaction/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	. = ..()
	var/location = get_turf(holder.my_atom)
	new /mob/living/simple_animal/pet/dog/cheems(location)
	playsound(location, 'modular_skyrat/master_files/sound/effects/dorime.ogg', 100, 0, 7)
