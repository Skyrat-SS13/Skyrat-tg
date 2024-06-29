// voxs!
/obj/item/bodypart/head/mutant/vox
	icon_greyscale = BODYPART_ICON_VOX
	bodyshape = parent_type::bodyshape | BODYSHAPE_SNOUTED | BODYSHAPE_CUSTOM
	limb_id = SPECIES_VOX
	teeth_count = 0

/obj/item/bodypart/chest/mutant/vox
	icon_greyscale = BODYPART_ICON_VOX
	bodyshape = parent_type::bodyshape | BODYSHAPE_SNOUTED | BODYSHAPE_CUSTOM
	limb_id = SPECIES_VOX

/obj/item/bodypart/chest/mutant/vox/get_butt_sprite()
	return icon('modular_skyrat/master_files/icons/mob/butts.dmi', BUTT_SPRITE_VOX)

/obj/item/bodypart/arm/left/mutant/vox
	icon_greyscale = BODYPART_ICON_VOX
	bodyshape = parent_type::bodyshape | BODYSHAPE_SNOUTED | BODYSHAPE_CUSTOM
	limb_id = SPECIES_VOX

/obj/item/bodypart/arm/right/mutant/vox
	icon_greyscale = BODYPART_ICON_VOX
	bodyshape = parent_type::bodyshape | BODYSHAPE_SNOUTED | BODYSHAPE_CUSTOM
	limb_id = SPECIES_VOX

/obj/item/bodypart/leg/left/mutant/vox
	icon_greyscale = BODYPART_ICON_VOX
	bodyshape = parent_type::bodyshape | BODYSHAPE_SNOUTED | BODYSHAPE_CUSTOM
	limb_id = SPECIES_VOX
	digitigrade_type = /obj/item/bodypart/leg/left/digitigrade/vox

/obj/item/bodypart/leg/right/mutant/vox
	icon_greyscale = BODYPART_ICON_VOX
	bodyshape = parent_type::bodyshape | BODYSHAPE_SNOUTED | BODYSHAPE_CUSTOM
	limb_id = SPECIES_VOX
	digitigrade_type = /obj/item/bodypart/leg/right/digitigrade/vox

/obj/item/bodypart/leg/left/digitigrade/vox
	icon_greyscale = BODYPART_ICON_VOX
	bodyshape = parent_type::bodyshape | BODYSHAPE_SNOUTED | BODYSHAPE_CUSTOM
	base_limb_id = SPECIES_VOX

/obj/item/bodypart/leg/right/digitigrade/vox
	icon_greyscale = BODYPART_ICON_VOX
	bodyshape = parent_type::bodyshape | BODYSHAPE_SNOUTED | BODYSHAPE_CUSTOM
	base_limb_id = SPECIES_VOX
