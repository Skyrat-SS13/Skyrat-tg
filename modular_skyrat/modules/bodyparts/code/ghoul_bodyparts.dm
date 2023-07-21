#define GHOUL_BRUTE_MODIFIER 2
#define GHOUL_BURN_MODIFIER 2

// Ghouls!
/obj/item/bodypart/head/mutant/ghoul
	icon_greyscale = BODYPART_ICON_GHOUL
	is_dimorphic = FALSE
	limb_id = SPECIES_GHOUL
	brute_modifier = GHOUL_BRUTE_MODIFIER
	burn_modifier = GHOUL_BURN_MODIFIER
	head_flags = HEAD_HAIR|HEAD_FACIAL_HAIR|HEAD_DEBRAIN

/obj/item/bodypart/head/mutant/ghoul/Initialize(mapload)
	worn_ears_offset = new(
		attached_part = src,
		feature_key = OFFSET_EARS,
		offset_y = list("north" = 1, "south" = 1, "east" = 1, "west" = 1),
	)
	worn_head_offset = new(
		attached_part = src,
		feature_key = OFFSET_HEAD,
		offset_x = list("north" = 1, "south" = 1, "east" = 1, "west" = 1),
	)
	worn_mask_offset = new(
		attached_part = src,
		feature_key = OFFSET_FACEMASK,
		offset_y = list("north" = 1, "south" = 1, "east" = 1, "west" = 1),
	)
	worn_glasses_offset = new(
		attached_part = src,
		feature_key = OFFSET_GLASSES,
		offset_y = list("north" = 1, "south" = 1, "east" = 1, "west" = 1),
	)
	worn_face_offset = new(
		attached_part = src,
		feature_key = OFFSET_FACE,
		offset_y = list("north" = 1, "south" = 1, "east" = 1, "west" = 1),
	)
	return ..()

/obj/item/bodypart/chest/mutant/ghoul
	icon_greyscale = BODYPART_ICON_GHOUL
	limb_id = SPECIES_GHOUL
	is_dimorphic = FALSE
	brute_modifier = GHOUL_BRUTE_MODIFIER
	burn_modifier = GHOUL_BURN_MODIFIER


/obj/item/bodypart/chest/mutant/ghoul/Initialize(mapload)
	worn_neck_offset = new(
		attached_part = src,
		feature_key = OFFSET_NECK,
		offset_y = list("north" = 1, "south" = 1, "east" = 1, "west" = 1),
	)
	return ..()

/obj/item/bodypart/arm/left/mutant/ghoul
	icon_greyscale = BODYPART_ICON_GHOUL
	limb_id = SPECIES_GHOUL
	unarmed_damage_low = 1 //lowest possible punch damage. if this is set to 0, punches will always miss
	unarmed_damage_high = 5 //highest possible punch damage
	unarmed_attack_verb = "punch"
	unarmed_attack_effect = ATTACK_EFFECT_PUNCH
	unarmed_attack_sound = 'sound/weapons/punch1.ogg'
	unarmed_miss_sound = 'sound/weapons/punchmiss.ogg'
	brute_modifier = GHOUL_BRUTE_MODIFIER
	burn_modifier = GHOUL_BURN_MODIFIER


/obj/item/bodypart/arm/right/mutant/ghoul
	icon_greyscale = BODYPART_ICON_GHOUL
	limb_id = SPECIES_GHOUL
	unarmed_damage_low = 1 //lowest possible punch damage. if this is set to 0, punches will always miss
	unarmed_damage_high = 5 //highest possible punch damage
	unarmed_attack_verb = "punch"
	unarmed_attack_effect = ATTACK_EFFECT_PUNCH
	unarmed_attack_sound = 'sound/weapons/punch1.ogg'
	unarmed_miss_sound = 'sound/weapons/punchmiss.ogg'
	brute_modifier = GHOUL_BRUTE_MODIFIER
	burn_modifier = GHOUL_BURN_MODIFIER


/obj/item/bodypart/leg/left/mutant/ghoul
	icon_greyscale = BODYPART_ICON_GHOUL
	limb_id = SPECIES_GHOUL
	brute_modifier = GHOUL_BRUTE_MODIFIER
	burn_modifier = GHOUL_BURN_MODIFIER


/obj/item/bodypart/leg/right/mutant/ghoul
	icon_greyscale = BODYPART_ICON_GHOUL
	limb_id = SPECIES_GHOUL
	brute_modifier = GHOUL_BRUTE_MODIFIER
	burn_modifier = GHOUL_BURN_MODIFIER


// LIMBS

/obj/item/bodypart/arm/right/mutant/ghoul/drop_limb(special)
	..() // Create Meat, Remove Limb
	var/percentHealth = 1 - (brute_dam + burn_dam) / max_damage
	if (percentHealth > 0)
		// Create Meat
		var/obj/item/food/meat/slab/newMeat = new /obj/item/food/meat/slab(src.loc)

		. = newMeat // Return MEAT

	qdel(src)

/obj/item/bodypart/arm/left/mutant/ghoul/drop_limb(special)
	..() // Create Meat, Remove Limb
	var/percentHealth = 1 - (brute_dam + burn_dam) / max_damage
	if (percentHealth > 0)
		// Create Meat
		var/obj/item/food/meat/slab/newMeat = new /obj/item/food/meat/slab(src.loc)

		. = newMeat // Return MEAT

	qdel(src)

/obj/item/bodypart/leg/right/mutant/ghoul/drop_limb(special)
	..() // Create Meat, Remove Limb
	var/percentHealth = 1 - (brute_dam + burn_dam) / max_damage
	if (percentHealth > 0)
		// Create Meat
		var/obj/item/food/meat/slab/newMeat = new /obj/item/food/meat/slab(src.loc)

		. = newMeat // Return MEAT

	qdel(src)

/obj/item/bodypart/leg/left/mutant/ghoul/drop_limb(special)
	..() // Create Meat, Remove Limb
	var/percentHealth = 1 - (brute_dam + burn_dam) / max_damage
	if (percentHealth > 0)
		// Create Meat
		var/obj/item/food/meat/slab/newMeat = new /obj/item/food/meat/slab(src.loc)

		. = newMeat // Return MEAT

	qdel(src)

#undef GHOUL_BRUTE_MODIFIER
#undef GHOUL_BURN_MODIFIER
