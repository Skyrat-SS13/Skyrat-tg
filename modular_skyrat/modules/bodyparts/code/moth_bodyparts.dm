/obj/item/bodypart/head/moth
	icon = BODYPART_ICON_MOTH
	icon_greyscale = BODYPART_ICON_MOTH
	icon_state = "moth_head_m"
	limb_id = SPECIES_MOTH
	is_dimorphic = TRUE
	head_flags = HEAD_HAIR|HEAD_FACIAL_HAIR|HEAD_LIPS|HEAD_EYESPRITES|HEAD_EYEHOLES|HEAD_DEBRAIN //what the fuck, moths have lips?
	teeth_count = 0

/obj/item/bodypart/chest/moth
	icon = BODYPART_ICON_MOTH
	icon_greyscale = BODYPART_ICON_MOTH
	icon_state = "moth_chest_m"
	limb_id = SPECIES_MOTH
	is_dimorphic = TRUE
	wing_types = list(/obj/item/organ/external/wings/functional/moth/megamoth, /obj/item/organ/external/wings/functional/moth/mothra)

/obj/item/bodypart/chest/moth/get_butt_sprite()
	return icon('icons/mob/butts.dmi', BUTT_SPRITE_FUZZY)

/obj/item/bodypart/arm/left/moth
	icon = BODYPART_ICON_MOTH
	icon_greyscale = BODYPART_ICON_MOTH
	icon_state = "moth_l_arm"
	limb_id = SPECIES_MOTH

/obj/item/bodypart/arm/right/moth
	icon = BODYPART_ICON_MOTH
	icon_greyscale = BODYPART_ICON_MOTH
	icon_state = "moth_r_arm"
	limb_id = SPECIES_MOTH

/obj/item/bodypart/leg/left/moth
	icon = BODYPART_ICON_MOTH
	icon_greyscale = BODYPART_ICON_MOTH
	icon_state = "moth_l_leg"
	limb_id = SPECIES_MOTH

/obj/item/bodypart/leg/right/moth
	icon = BODYPART_ICON_MOTH
	icon_greyscale = BODYPART_ICON_MOTH
	icon_state = "moth_r_leg"
	limb_id = SPECIES_MOTH
