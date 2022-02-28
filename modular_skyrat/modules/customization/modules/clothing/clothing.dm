//Mutant variants needs to be a property of all items, because all items can be equipped, despite the mob code only expecting clothing items (ugh)
/obj/item
	var/mutant_variants = NONE
	///Icon file for mob worn overlays, if the user is digi.
	var/icon/worn_icon_digi
	///The config type to use for greyscaled worn sprites for digitigrade characters. Both this and greyscale_colors must be assigned to work.
	var/greyscale_config_worn_digi
	/// Icon file for mob worn overlays, if the user is a vox.
	var/icon/worn_icon_vox
	/// The config type to use for greyscaled worn sprites for vox characters. Both this and greyscale_colors must be assigned to work.
	var/greyscale_config_worn_vox

	var/worn_icon_taur_snake
	var/worn_icon_taur_paw
	var/worn_icon_taur_hoof
	var/worn_icon_muzzled

	var/greyscale_config_worn_taur_snake
	var/greyscale_config_worn_taur_paw
	var/greyscale_config_worn_taur_hoof

	var/static/has_alt_sprite = list()
	var/static/has_alt_snake_sprite = list()
	var/static/has_alt_paw_sprite = list()
	var/static/has_alt_horse_sprite = list()

	var/static/has_alt_sprite_suit = list()
	var/static/has_alt_snake_sprite_suit = list()
	var/static/has_alt_paw_sprite_suit = list()
	var/static/has_alt_horse_sprite_suit = list()

/obj/item/clothing/Initialize(mapload)
	. = ..()
	handle_taur_sprites()

// Convert this to obj/item if you need to make a item sprite. It'll become more intensive due to it, but yeah

/**
 * Called in /obj/item/clothing/Initialize().
 *
 * Quits instantly if mutant_variants has STYLE_TAUR_ALL, then checks to see if the clothing's icon state has an alt sprite for taurs. If no, it then checks to see if
 * the icon state EXPLICITELY has no taur sprites. If no, it then checks 3 DMI files for the icon_state, and if it appears in any of them, has_alt_sprite is set to
 * true for that icon state, then it sets the more specific list to true for that state, and finally the specific mutant_variants bitflag for the clothing if the
 * clothing doesnt already have it.
 *
 * Finally, if all of the conditions are false, has_alt_sprite for that icon state will be set to false.
 *
 * DO NOT RELY ON THIS PROC TO DO YOUR WORK FOR YOU. If you are adding a new item, or a sprite, you SHOULD be manually setting your mutant_variants flags, otherwise this proc
 * will be called and cause slight performance loss.
 */
/obj/item/clothing/proc/handle_taur_sprites() //niko-if i do not come back in a week and entirely refactor how this works gitban me
	if (istype(src, /obj/item/clothing/suit))
		handle_taur_sprites_for_suits()
		return
	if (!(istype(src, /obj/item/clothing/under)))
		return
	if (mutant_variants & STYLE_TAUR_ALL)
		return
	if (has_alt_sprite[icon_state] == HAS_ALT_SPRITE)
		if ((has_alt_snake_sprite[icon_state] == HAS_ALT_SPRITE) && (!(mutant_variants & STYLE_TAUR_SNAKE)))
			mutant_variants |= STYLE_TAUR_SNAKE
		if ((has_alt_horse_sprite[icon_state] == HAS_ALT_SPRITE) && (!(mutant_variants & STYLE_TAUR_HOOF)))
			mutant_variants |= STYLE_TAUR_HOOF
		if ((has_alt_paw_sprite[icon_state] == HAS_ALT_SPRITE) && (!(mutant_variants & STYLE_TAUR_PAW)))
			mutant_variants |= STYLE_TAUR_PAW
		return
	else if (has_alt_sprite[icon_state] == HAS_NO_ALT_SPRITE)
		return
	// Code only goes here if has_alt_sprite[] == nothing, AKA if init has never been ran
	var/has_alt = FALSE
	if (icon_state in GLOB.naga_taur_uniform_sprites)
		has_alt_sprite[icon_state] = HAS_ALT_SPRITE
		has_alt_snake_sprite[icon_state] = HAS_ALT_SPRITE
		has_alt = TRUE
		if (!(mutant_variants & STYLE_TAUR_SNAKE))
			mutant_variants |= STYLE_TAUR_SNAKE
	if (icon_state in GLOB.horse_taur_uniform_sprites)
		has_alt_sprite[icon_state] = HAS_ALT_SPRITE
		has_alt_horse_sprite[icon_state] = HAS_ALT_SPRITE
		has_alt = TRUE
		if (!(mutant_variants & STYLE_TAUR_HOOF))
			mutant_variants |= STYLE_TAUR_HOOF
	if (icon_state in GLOB.pawed_taur_uniform_sprites)
		has_alt_sprite[icon_state] = HAS_ALT_SPRITE
		has_alt_paw_sprite[icon_state] = HAS_ALT_SPRITE
		has_alt = TRUE
		if (!(mutant_variants & STYLE_TAUR_PAW))
			mutant_variants |= STYLE_TAUR_PAW
	if (!(has_alt)) // If none of the 3 above if statements are true, it has no alt sprite
		has_alt_sprite[icon_state] = HAS_NO_ALT_SPRITE


/**
 * Called in handle_taur_sprites().
 *
 * Suit variation of handle_taur_sprites().
 *
 * Quits instantly if mutant_variants has STYLE_TAUR_ALL, then checks to see if the clothing's icon state has an alt sprite for taurs. If no, it then checks to see if
 * the icon state EXPLICITELY has no taur sprites. If no, it then checks 3 DMI files for the icon_state, and if it appears in any of them, has_alt_sprite is set to
 * true for that icon state, then it sets the more specific list to true for that state, and finally the specific mutant_variants bitflag for the clothing if the
 * clothing doesnt already have it.
 *
 * Finally, if all of the conditions are false, has_alt_sprite for that icon state will be set to false.
 *
 * DO NOT RELY ON THIS PROC TO DO YOUR WORK FOR YOU. If you are adding a new item, or a sprite, you SHOULD be manually setting your mutant_variants flags, otherwise this proc
 * will be called and cause slight performance loss.
 */
/obj/item/clothing/proc/handle_taur_sprites_for_suits()
	if (mutant_variants & STYLE_TAUR_ALL)
		return
	if (has_alt_sprite_suit[icon_state] == HAS_ALT_SPRITE)
		if ((has_alt_snake_sprite_suit[icon_state] == HAS_ALT_SPRITE) && (!(mutant_variants & STYLE_TAUR_SNAKE)))
			mutant_variants |= STYLE_TAUR_SNAKE
		if ((has_alt_horse_sprite_suit[icon_state] == HAS_ALT_SPRITE) && (!(mutant_variants & STYLE_TAUR_HOOF)))
			mutant_variants |= STYLE_TAUR_HOOF
		if ((has_alt_paw_sprite_suit[icon_state] == HAS_ALT_SPRITE) && (!(mutant_variants & STYLE_TAUR_PAW)))
			mutant_variants |= STYLE_TAUR_PAW
		return
	else if (has_alt_sprite_suit[icon_state] == HAS_NO_ALT_SPRITE)
		return
	// Code only goes here if has_alt_sprite[] == nothing, AKA if init has never been ran
	var/has_alt_suit = FALSE
	if (icon_state in GLOB.naga_taur_suit_sprites)
		has_alt_sprite_suit[icon_state] = HAS_ALT_SPRITE
		has_alt_snake_sprite_suit[icon_state] = HAS_ALT_SPRITE
		has_alt_suit = TRUE
		if (!(mutant_variants & STYLE_TAUR_SNAKE))
			mutant_variants |= STYLE_TAUR_SNAKE
	if (icon_state in GLOB.horse_taur_suit_sprites)
		has_alt_sprite_suit[icon_state] = HAS_ALT_SPRITE
		has_alt_horse_sprite_suit[icon_state] = HAS_ALT_SPRITE
		has_alt_suit = TRUE
		if (!(mutant_variants & STYLE_TAUR_HOOF))
			mutant_variants |= STYLE_TAUR_HOOF
	if (icon_state in GLOB.pawed_taur_suit_sprites)
		has_alt_sprite_suit[icon_state] = HAS_ALT_SPRITE
		has_alt_paw_sprite_suit[icon_state] = HAS_ALT_SPRITE
		has_alt_suit = TRUE
		if (!(mutant_variants & STYLE_TAUR_PAW))
			mutant_variants |= STYLE_TAUR_PAW
	if (!(has_alt_suit)) // If none of the 3 above if statements are true, it has no alt sprite
		has_alt_sprite_suit[icon_state] = HAS_NO_ALT_SPRITE


/obj/item/clothing/head
	mutant_variants = STYLE_MUZZLE | STYLE_VOX

/obj/item/clothing/mask
	mutant_variants = STYLE_MUZZLE | STYLE_VOX

/obj/item/clothing/glasses
	mutant_variants = STYLE_VOX

/obj/item/clothing/under
	mutant_variants = STYLE_DIGITIGRADE|STYLE_VOX

/obj/item/clothing/suit
	mutant_variants = STYLE_DIGITIGRADE|STYLE_VOX

/obj/item/clothing/gloves
	mutant_variants = STYLE_VOX

/obj/item/clothing/shoes
	mutant_variants = STYLE_DIGITIGRADE|STYLE_VOX

/obj/item/clothing/suit/armor
	mutant_variants = STYLE_VOX

/obj/item/clothing/under/color/jumpskirt
	mutant_variants = STYLE_VOX

/obj/item/clothing/under/rank/engineering/chief_engineer/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/medical/chief_medical_officer/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/civilian/chaplain/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/cargo/qm/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/captain/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/civilian/chaplain/skirt
	mutant_variants = NONE

/obj/item/clothing/under/dress
	mutant_variants = STYLE_VOX

/obj/item/clothing/under/rank/security/officer/skirt
	mutant_variants = NONE

/obj/item/clothing/under/suit/black/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/rnd/research_director/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/rnd/research_director/alt
	mutant_variants = NONE

/obj/item/clothing/under/rank/rnd/research_director/turtleneck/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/civilian/head_of_personnel/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/security/head_of_security/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/security/head_of_security/alt/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/security/warden/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/prisoner/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/security/officer/skirt
	mutant_variants = NONE

/obj/item/clothing/under/syndicate/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/cargo/tech/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/civilian/bartender/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/civilian/chef/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/civilian/head_of_personnel/suit/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/civilian/hydroponics/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/civilian/janitor/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/civilian/lawyer/black/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/civilian/lawyer/female/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/civilian/lawyer/red/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/civilian/lawyer/blue/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/civilian/lawyer/bluesuit/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/civilian/lawyer/purpsuit/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/civilian/mime/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/civilian/curator/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/engineering/atmospheric_technician/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/engineering/engineer/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/medical/virologist/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/medical/doctor/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/medical/chemist
	mutant_variants = NONE

/obj/item/clothing/under/rank/medical/paramedic/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/rnd/scientist/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/rnd/roboticist/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/rnd/geneticist/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/security/detective/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/security/detective/grey/skirt
	mutant_variants = NONE

/obj/item/clothing/under/suit/white/skirt
	mutant_variants = NONE

/obj/item/clothing/under/suit/black/skirt
	mutant_variants = NONE

/obj/item/clothing/under/suit/black_really/skirt
	mutant_variants = NONE

/obj/item/clothing/under/syndicate/tacticool/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/civilian/head_of_personnel/suit/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/civilian/head_of_personnel/suit/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/civilian/head_of_personnel/suit/skirt
	mutant_variants = NONE

/obj/item/clothing/under/rank/civilian/head_of_personnel/suit/skirt
	mutant_variants = NONE

/obj/item/clothing/under/costume/draculass
	mutant_variants = NONE
