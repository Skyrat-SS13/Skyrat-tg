/datum/sprite_accessory/taur
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/taur.dmi'
	key = "taur"
	generic = "Taur Type"
	color_src = USE_MATRIXED_COLORS
	dimension_x = 64
	center = TRUE
	relevent_layers = list(BODY_ADJ_LAYER, BODY_FRONT_UNDER_CLOTHES)
	genetic = TRUE
	organ_type = /obj/item/organ/external/taur_body
	flags_for_organ = SPRITE_ACCESSORY_HIDE_SHOES
	/// Must be a single specific tauric suit variation bitflag. Don't do FLAG_1|FLAG_2
	var/taur_mode = NONE
	/// Must be a single specific tauric suit variation bitflag. Don't do FLAG_1|FLAG_2
	var/alt_taur_mode = NONE

/datum/sprite_accessory/taur/is_hidden(mob/living/carbon/human/target, obj/item/bodypart/limb)
	var/obj/item/clothing/suit/worn_suit = target.wear_suit
	if(istype(worn_suit) && (worn_suit.flags_inv & HIDEJUMPSUIT) && !worn_suit.gets_cropped_on_taurs)
		return TRUE
	if(target.owned_turf)
		var/list/used_in_turf = list("tail")
		if(target.owned_turf.name in used_in_turf)
			return TRUE
	return FALSE


/obj/item/organ/external/taur_body
	name = "taur body"
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_EXTERNAL_TAUR
	layers = ALL_EXTERNAL_OVERLAYS
	external_bodytypes = BODYTYPE_TAUR
	color_source = ORGAN_COLOR_OVERRIDE
	use_mob_sprite_as_obj_sprite = TRUE

	feature_key = "taur"
	preference = "feature_taur"
	mutantpart_key = "taur"
	mutantpart_info = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"))


/obj/item/organ/external/taur_body/override_color(rgb_value)
	if(mutantpart_key)
		return mutantpart_info[MUTANT_INDEX_COLOR_LIST][1]

	return rgb_value


/obj/item/organ/external/taur_body/get_global_feature_list()
	return GLOB.sprite_accessories["taur"]


/obj/item/organ/external/taur_body/Insert(mob/living/carbon/reciever, special, drop_if_replaced)
	if(sprite_accessory_flags & SPRITE_ACCESSORY_HIDE_SHOES)
		external_bodytypes |= BODYTYPE_HIDE_SHOES

	var/obj/item/bodypart/l_leg/taur/new_left_leg = new /obj/item/bodypart/l_leg/taur()
	var/obj/item/bodypart/l_leg/old_left_leg = reciever.get_bodypart(BODY_ZONE_L_LEG)
	var/obj/item/bodypart/r_leg/taur/new_right_leg = new /obj/item/bodypart/r_leg/taur()
	var/obj/item/bodypart/r_leg/old_right_leg = reciever.get_bodypart(BODY_ZONE_R_LEG)

	new_left_leg.bodytype |= external_bodytypes
	new_left_leg.replace_limb(reciever, TRUE)
	if(old_left_leg)
		qdel(old_left_leg)

	new_right_leg.bodytype |= external_bodytypes
	new_right_leg.replace_limb(reciever, TRUE)
	if(old_right_leg)
		qdel(old_right_leg)

	return ..()


/obj/item/organ/external/taur_body/Remove(mob/living/carbon/organ_owner, special, moving)
	var/obj/item/bodypart/l_leg/left_leg = organ_owner.get_bodypart(BODY_ZONE_L_LEG)
	var/obj/item/bodypart/r_leg/right_leg = organ_owner.get_bodypart(BODY_ZONE_R_LEG)

	if(left_leg)
		left_leg.drop_limb()

		if(left_leg)
			qdel(left_leg)

	if(right_leg)
		right_leg.drop_limb()

		if(right_leg)
			qdel(right_leg)

	// We don't call `synchronize_bodytypes()` here, because it's already going to get called in the parent because `external_bodytypes` has a value.

	return ..()

/datum/sprite_accessory/taur/none
	name = "None"
	dimension_x = 32
	center = FALSE
	factual = FALSE
	color_src = null
	flags_for_organ = NONE

/datum/sprite_accessory/taur/cow
	name = "Cow"
	icon_state = "cow"
	taur_mode = STYLE_TAUR_HOOF
	alt_taur_mode = STYLE_TAUR_PAW
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/taur/cow/spotted
	name = "Cow (Spotted)"
	icon_state = "cow_spotted"
	color_src = USE_MATRIXED_COLORS

/datum/sprite_accessory/taur/deer
	name = "Deer"
	icon_state = "deer"
	taur_mode = STYLE_TAUR_HOOF
	alt_taur_mode = STYLE_TAUR_PAW
	color_src = USE_ONE_COLOR
	extra = TRUE
	extra_color_src = MUTCOLORS2

/datum/sprite_accessory/taur/drake
	name = "Drake"
	icon_state = "drake"
	taur_mode = STYLE_TAUR_PAW
	color_src = USE_ONE_COLOR
	extra = TRUE
	extra_color_src = MUTCOLORS2

/datum/sprite_accessory/taur/drake/old
	name = "Drake (Old)"
	icon_state = "drake_old"
	color_src = USE_MATRIXED_COLORS
	extra = FALSE

/datum/sprite_accessory/taur/drider
	name = "Drider"
	icon_state = "drider"
	color_src = USE_ONE_COLOR
	extra = TRUE
	extra_color_src = MUTCOLORS2

/datum/sprite_accessory/taur/eevee
	name = "Eevee"
	icon_state = "eevee"
	taur_mode = STYLE_TAUR_PAW
	color_src = USE_ONE_COLOR
	extra = TRUE
	extra_color_src = MUTCOLORS2

/datum/sprite_accessory/taur/horse
	name = "Horse"
	icon_state = "horse"
	taur_mode = STYLE_TAUR_HOOF
	alt_taur_mode = STYLE_TAUR_PAW

/datum/sprite_accessory/taur/naga
	name = "Naga"
	icon_state = "naga"
	taur_mode = STYLE_TAUR_SNAKE

/datum/sprite_accessory/taur/otie
	name = "Otie"
	icon_state = "otie"
	taur_mode = STYLE_TAUR_PAW

/datum/sprite_accessory/taur/pede
	name = "Scolipede"
	icon_state = "pede"
	taur_mode = STYLE_TAUR_PAW
	color_src = USE_ONE_COLOR
	extra = TRUE
	extra2 = TRUE
	extra_color_src = MUTCOLORS2
	extra2_color_src = MUTCOLORS3

/datum/sprite_accessory/taur/tentacle
	name = "Tentacle"
	icon_state = "tentacle"
	taur_mode = STYLE_TAUR_SNAKE
	color_src = USE_ONE_COLOR

/datum/sprite_accessory/taur/canine
	name = "Canine"
	icon_state = "canine"
	taur_mode = STYLE_TAUR_PAW
	color_src = USE_ONE_COLOR
	extra = TRUE
	extra_color_src = MUTCOLORS2

/datum/sprite_accessory/taur/feline
	name = "Feline"
	icon_state = "feline"
	taur_mode = STYLE_TAUR_PAW
	color_src = USE_ONE_COLOR
	extra = TRUE
	extra_color_src = MUTCOLORS2
