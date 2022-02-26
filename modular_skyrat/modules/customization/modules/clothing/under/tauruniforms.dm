
/// For loop check: Is src's (the generated jumpsuit) icon_state equal to a icon within any of the dedicated taur uniform DMI files? If yes, add the relevant bitflag and check other files.
/obj/item/clothing/under/Initialize(mapload)
	. = ..()
	if (icon_state in GLOB.naga_taur_uniform_sprites)
		mutant_variants |= STYLE_TAUR_SNAKE


	/* for (var/icon in GLOB.naga_taur_uniform_sprites)
		if ((src.icon_state == icon))
			src.mutant_variants |= STYLE_TAUR_SNAKE
			break*/
