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

	/// has_taur_sprite[icon_state]: Does this icon_state have ANY taur sprite?
	var/static/list/has_taur_sprite = list()

	/// has_taur_sprite_suit[icon_state]: has_taur_sprite but for /obj/item/clothng/suit
	var/static/list/has_taur_sprite_suit = list()

/obj/item/clothing/Initialize(mapload)
	. = ..()
	handle_taur_sprites()

/* NOTE FOR handle_taur_sprites(): This can be converted to handle things like digi sprites, vox, etc. I just didn't do it because I don't want to refactor the entire
system for this one pr. ~niko */

/**
 * Called in /obj/item/clothing/Initialize().
 *
 * Quits instantly if mutant_variants has all taur styles (STYLE_TAUR), then checks to see if the clothing's icon state has an alt sprite for taurs. If no, it then checks to see if
 * the icon state EXPLICITELY has no taur sprites. If no, it then checks 3 DMI files for the icon_state, and if it appears in any of them, has_taur_sprite is set to
 * true for that icon state, then it sets the more specific list to true for that state, and finally the specific mutant_variants bitflag for the clothing.
 *
 * Finally, if all of the conditions are false, has_taur_sprite for that icon state will be set to false.
 *
 * Has seperate logic for suits, as they use a different set of DMIs as of now.
 */
/obj/item/clothing/proc/handle_taur_sprites()

	if (!(istype(src, /obj/item/clothing/under))) //remove this if we ever make a taur sprite for anything else, this is for performance
		return

	if (mutant_variants & STYLE_TAUR)
		return

	if (has_taur_sprite[icon_state])
		if (GLOB.naga_taur_uniform_sprites[icon_state])
			mutant_variants |= STYLE_TAUR_SNAKE
		if (GLOB.horse_taur_uniform_sprites[icon_state])
			mutant_variants |= STYLE_TAUR_HOOF
		if (GLOB.pawed_taur_uniform_sprites[icon_state])
			mutant_variants |= STYLE_TAUR_PAW
		return

	else if (!has_taur_sprite)
		return
	// Code only goes here if has_taur_sprite[] == nothing, AKA if init has never been ran
	var/taur_sprite = FALSE

	if (GLOB.naga_taur_uniform_sprites[icon_state]) // The purpose of these 4 if statements is to cache the results, so if the icon_state has no alt sprites, we can skip all the logic
		has_taur_sprite[icon_state] = TRUE // on any successive inits.
		taur_sprite = TRUE
		mutant_variants |= STYLE_TAUR_SNAKE

	if (GLOB.horse_taur_uniform_sprites[icon_state])
		has_taur_sprite[icon_state] = TRUE //This block of code is checking the 3 DMI files for the icon state and setting flags/vars dynamically based on that
		taur_sprite = TRUE
		mutant_variants |= STYLE_TAUR_HOOF

	if (GLOB.pawed_taur_uniform_sprites[icon_state])
		has_taur_sprite[icon_state] = TRUE
		taur_sprite = TRUE
		mutant_variants |= STYLE_TAUR_PAW

	if (!taur_sprite) // If none of the 3 above if statements are true, it has no alt sprite
		has_taur_sprite[icon_state] = FALSE

/obj/item/clothing/suit/handle_taur_sprites()

	if (mutant_variants & STYLE_TAUR)
		return

	if (has_taur_sprite_suit[icon_state])
		if (GLOB.naga_taur_suit_sprites[icon_state])
			mutant_variants |= STYLE_TAUR_SNAKE
		if (GLOB.horse_taur_suit_sprites[icon_state])
			mutant_variants |= STYLE_TAUR_HOOF
		if (GLOB.pawed_taur_suit_sprites[icon_state])
			mutant_variants |= STYLE_TAUR_PAW
		return

	else if (has_taur_sprite_suit[icon_state] == FALSE)
		return
	// Code only goes here if has_taur_sprite_suit[] == nothing, AKA if init has never been ran
	var/taur_sprite_suit = FALSE

	if (GLOB.naga_taur_suit_sprites[icon_state]) // The purpose of these 4 if statements is to cache the results, so if the icon_state has no alt sprites, we can skip all the logic
		has_taur_sprite_suit[icon_state] = TRUE // on any successive inits.
		taur_sprite_suit = TRUE
		mutant_variants |= STYLE_TAUR_SNAKE

	if (GLOB.horse_taur_suit_sprites[icon_state])
		has_taur_sprite_suit[icon_state] = TRUE //This block of code is checking the 3 DMI files for the icon state and setting flags/vars dynamically based on that
		taur_sprite_suit = TRUE
		mutant_variants |= STYLE_TAUR_HOOF

	if (GLOB.pawed_taur_suit_sprites[icon_state])
		has_taur_sprite_suit[icon_state] = TRUE
		taur_sprite_suit = TRUE
		mutant_variants |= STYLE_TAUR_PAW

	if (!taur_sprite_suit) // If none of the 3 above if statements are true, it has no alt sprite
		has_taur_sprite_suit[icon_state] = FALSE
		return
	return

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
