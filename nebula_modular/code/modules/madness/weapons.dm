/obj/item/staff/roadsign
	name = "road sign"
	desc = "It obviously isn't supposed to be used like that, huh?"
	force = 15
	throwforce = 18
	sharpness = SHARP_EDGED
	icon = 'nebula_modular/icons/obj/weapons/roadsign.dmi'
	lefthand_file = 'nebula_modular/icons/mob/inhands/weapons/roadsign_lefthand.dmi'
	righthand_file = 'nebula_modular/icons/mob/inhands/weapons/roadsign_righthand.dmi'
	icon_state = "roadsign"
	inhand_icon_state = "roadsign"
	armour_penetration = 20
	block_chance = 20
	attack_verb_continuous = list("bludgeons", "whacks", "slices", "impales")
	attack_verb_simple = list("bludgeon", "whack", "slice", "impale")
	w_class = WEIGHT_CLASS_BULKY
	var/attack_speed_mod = 0.4

/obj/item/katana/binarykatana
	name = "binary sword"
	desc = "A mysterious sword forged by a human that wanted revenge against the synths, It seems that this sword is a key to something."
	force = 40
	throwforce = 18
	sharpness = SHARP_EDGED
	icon = 'nebula_modular/icons/obj/weapons/binarysword.dmi'
	worn_icon = 'nebula_modular/icons/mob/clothing/binarysword_back.dmi'
	belt_icon_state = "binary_sword"
	icon_state = "binary_sword"
	worn_icon_state = "binary_sword"
	inhand_icon_state = "binary_sword"
	lefthand_file = 'nebula_modular/icons/mob/inhands/weapons/binarysword_lefthand.dmi'
	righthand_file = 'nebula_modular/icons/mob/inhands/weapons/binarysword_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_HUGE
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	block_chance = 50
	max_integrity = 200
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 50)
	resistance_flags = FIRE_PROOF
