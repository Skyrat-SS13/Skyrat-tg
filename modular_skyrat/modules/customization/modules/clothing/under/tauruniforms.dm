/// Possible values: 2: Has an alternate sprite. 1: Has no alternate sprite.
/obj/item/var/static/has_snake_alt = list()

/// Check: Is src's (the generated jumpsuit) icon_state equal to a icon within any of the dedicated taur uniform DMI files? If yes, add the relevant bitflag and check other files.
/obj/item/clothing/Initialize(mapload)
	. = ..()
	if (mutant_variants & STYLE_TAUR_SNAKE)
		return
	if (has_snake_alt[icon_state] == 2)
		if (!(mutant_variants & STYLE_TAUR_SNAKE))
			mutant_variants |= STYLE_TAUR_SNAKE
	else if (has_snake_alt[icon_state] == 1)
		return
	else if (icon_state in GLOB.naga_taur_uniform_sprites)
		mutant_variants |= STYLE_TAUR_SNAKE
		has_snake_alt[icon_state] = 2
	else
		has_snake_alt[icon_state] = 1

// Convert this to obj/item if you need to make a item sprite. It'll become more intensive due to it, but yeah
