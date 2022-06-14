// Ghouls!
/obj/item/bodypart/head/mutant/ghoul
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/ghoul_bodyparts.dmi'
	is_dimorphic = FALSE
	limb_id = SPECIES_GHOUL

/obj/item/bodypart/chest/mutant/ghoul
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/ghoul_bodyparts.dmi'
	limb_id = SPECIES_GHOUL
	is_dimorphic = FALSE

/obj/item/bodypart/l_arm/mutant/ghoul
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/ghoul_bodyparts.dmi'
	limb_id = SPECIES_GHOUL

/obj/item/bodypart/r_arm/mutant/ghoul
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/ghoul_bodyparts.dmi'
	limb_id = SPECIES_GHOUL

/obj/item/bodypart/l_leg/mutant/ghoul
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/ghoul_bodyparts.dmi'
	limb_id = SPECIES_GHOUL

/obj/item/bodypart/r_leg/mutant/ghoul
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/ghoul_bodyparts.dmi'
	limb_id = SPECIES_GHOUL

// LIMBS

/obj/item/bodypart/r_arm/mutant/ghoul/drop_limb(special)
	..() // Create Meat, Remove Limb
	var/percentHealth = 1 - (brute_dam + burn_dam) / max_damage
	if (percentHealth > 0)
		// Create Meat
		var/obj/item/food/meat/slab/newMeat = new /obj/item/food/meat/slab(src.loc)

		. = newMeat // Return MEAT

	qdel(src)

/obj/item/bodypart/l_arm/mutant/ghoul/drop_limb(special)
	..() // Create Meat, Remove Limb
	var/percentHealth = 1 - (brute_dam + burn_dam) / max_damage
	if (percentHealth > 0)
		// Create Meat
		var/obj/item/food/meat/slab/newMeat = new /obj/item/food/meat/slab(src.loc)

		. = newMeat // Return MEAT

	qdel(src)

/obj/item/bodypart/r_leg/mutant/ghoul/drop_limb(special)
	..() // Create Meat, Remove Limb
	var/percentHealth = 1 - (brute_dam + burn_dam) / max_damage
	if (percentHealth > 0)
		// Create Meat
		var/obj/item/food/meat/slab/newMeat = new /obj/item/food/meat/slab(src.loc)

		. = newMeat // Return MEAT

	qdel(src)

/obj/item/bodypart/l_leg/mutant/ghoul/drop_limb(special)
	..() // Create Meat, Remove Limb
	var/percentHealth = 1 - (brute_dam + burn_dam) / max_damage
	if (percentHealth > 0)
		// Create Meat
		var/obj/item/food/meat/slab/newMeat = new /obj/item/food/meat/slab(src.loc)

		. = newMeat // Return MEAT

	qdel(src)
