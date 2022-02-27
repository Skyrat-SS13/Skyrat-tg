
/// Check: Is src's (the generated jumpsuit) icon_state equal to a icon within any of the dedicated taur uniform DMI files? If yes, add the relevant bitflag and check other files.
/obj/item/clothing/under/Initialize(mapload)
	. = ..()
	if (!(mutant_variants & STYLE_TAUR_SNAKE))
		if (icon_state in GLOB.naga_taur_uniform_sprites)
			mutant_variants |= STYLE_TAUR_SNAKE
/*	if (icon_state in GLOB.horse_taur_uniform_sprites) //Commented out for future use when we get these sprites
		mutant_variants |= STYLE_TAUR_SNAKE
	if (icon_state in GLOB.pawed_taur_uniform_sprites)
		mutant_variants |= STYLE_TAUR_SNAKE */

//TODO: Cache the results so the for loop doesnt need to be ran after the first init of each item

// Convert this to obj/item if you need to make a item sprite. It'll become more intensive due to it, but yeah
