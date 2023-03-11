#define TESHARI_PUNCH_LOW 2 // Lower bound punch damage
#define TESHARI_PUNCH_HIGH 6

// teshari!
/obj/item/bodypart/head/mutant/teshari
	icon_greyscale = BODYPART_ICON_TESHARI
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	limb_id = SPECIES_TESHARI

/obj/item/bodypart/chest/mutant/teshari
	icon_greyscale = BODYPART_ICON_TESHARI
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_CUSTOM
	limb_id = SPECIES_TESHARI

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
