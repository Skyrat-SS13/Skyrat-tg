#define TESHARI_PUNCH_LOW 2 // Lower bound punch damage
#define TESHARI_PUNCH_HIGH 6

// teshari!
/obj/item/bodypart/head/mutant/teshari
	icon_greyscale = BODYPART_ICON_TESHARI
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	limb_id = SPECIES_TESHARI

/obj/item/bodypart/head/mutant/teshari/Initialize(mapload)
	worn_ears_offset = new(
		attached_part = src,
		feature_key = OFFSET_EARS,
		offset_y = list("north" = -4, "south" = -4, "east" = -4, "west" = -4),
	)
	worn_head_offset = new(
		attached_part = src,
		feature_key = OFFSET_HEAD,
		offset_x = list("north" = 1, "south" = 1, "east" = 1, "west" = -1, "northwest" = -1, "southwest" = -1),
		offset_y = list("north" = -4, "south" = -4, "east" = -4, "west" = -4),
	)
	worn_mask_offset = new(
		attached_part = src,
		feature_key = OFFSET_FACEMASK,
		offset_y = list("north" = -5, "south" = -5, "east" = -5, "west" = -5),
	)
	return ..()


/obj/item/bodypart/chest/mutant/teshari
	icon_greyscale = BODYPART_ICON_TESHARI
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	limb_id = SPECIES_TESHARI

/obj/item/bodypart/chest/mutant/teshari/Initialize(mapload)
	worn_back_offset = new(
		attached_part = src,
		feature_key = OFFSET_BACK,
		offset_y = list("north" = -4, "south" = -4, "east" = -4, "west" = -4),
	)
	worn_accessory_offset = new(
		attached_part = src,
		feature_key = OFFSET_ACCESSORY,
		offset_y = list("north" = -4, "south" = -4, "east" = -4, "west" = -4),
	)
	return ..()


/obj/item/bodypart/arm/left/mutant/teshari
	icon_greyscale = BODYPART_ICON_TESHARI
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	limb_id = SPECIES_TESHARI
	unarmed_damage_low = TESHARI_PUNCH_LOW
	unarmed_damage_high = TESHARI_PUNCH_HIGH


/obj/item/bodypart/arm/right/mutant/teshari
	icon_greyscale = BODYPART_ICON_TESHARI
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	limb_id = SPECIES_TESHARI
	unarmed_damage_low = TESHARI_PUNCH_LOW
	unarmed_damage_high = TESHARI_PUNCH_HIGH


/obj/item/bodypart/leg/left/mutant/teshari
	icon_greyscale = BODYPART_ICON_TESHARI
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	limb_id = SPECIES_TESHARI
	digitigrade_type = /obj/item/bodypart/leg/left/digitigrade/teshari

/obj/item/bodypart/leg/right/mutant/teshari
	icon_greyscale = BODYPART_ICON_TESHARI
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	limb_id = SPECIES_TESHARI
	digitigrade_type = /obj/item/bodypart/leg/right/digitigrade/teshari

/obj/item/bodypart/leg/left/digitigrade/teshari
	icon_greyscale = BODYPART_ICON_TESHARI
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	base_limb_id = SPECIES_TESHARI

/obj/item/bodypart/leg/right/digitigrade/teshari
	icon_greyscale = BODYPART_ICON_TESHARI
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	base_limb_id = SPECIES_TESHARI

#undef TESHARI_PUNCH_LOW
#undef TESHARI_PUNCH_HIGH
