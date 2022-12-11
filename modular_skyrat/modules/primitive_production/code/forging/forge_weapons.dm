// Weapons

/obj/item/melee/forging_weapon
	icon = 'modular_skyrat/modules/primitive_production/icons/forge_items.dmi'
	lefthand_file = 'modular_skyrat/modules/primitive_production/icons/inhands/forge_weapon_l.dmi'
	righthand_file = 'modular_skyrat/modules/primitive_production/icons/inhands/forge_weapon_r.dmi'
	worn_icon = 'modular_skyrat/modules/primitive_production/icons/clothing/forge_weapon_worn.dmi'
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR
	resistance_flags = FIRE_PROOF

/obj/item/melee/forging_weapon/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text, final_block_chance, damage, attack_type)
	if(prob(final_block_chance))
		if(attack_type == PROJECTILE_ATTACK)
			return FALSE
		playsound(src, 'sound/weapons/parry.ogg', 75, TRUE)
		owner.visible_message(span_danger("[owner] parries [attack_text] with [src]!"))
		return TRUE
	return FALSE

/obj/item/melee/forging_weapon/sword
	name = "sword"
	desc = "A sharp, one-handed sword that you could definitely block incoming melee strikes with."
	force = 15
	armour_penetration = 10
	icon_state = "sword"
	inhand_icon_state = "sword"
	worn_icon_state = "sword_back"
	belt_icon_state = "sword_belt"
	hitsound = 'sound/weapons/bladeslice.ogg'
	throwforce = 10
	block_chance = 30
	demolition_mod = 0.75
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED

/obj/item/melee/forging_weapon/dagger
	name = "dagger"
	desc = "An easily concealable dagger."
	force = 8
	icon_state = "dagger"
	inhand_icon_state = "dagger"
	worn_icon_state = "dagger_back"
	belt_icon_state = "dagger_belt"
	hitsound = 'sound/weapons/bladeslice.ogg'
	throwforce = 10
	demolition_mod = 0.5
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_SMALL
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED

/obj/item/melee/forging_weapon/staff
	name = "staff"
	desc = "A two-handed staff with a blunt, heavy end, perfect for bashing someone over the head with."
	force = 10
	icon_state = "staff"
	inhand_icon_state = "staff"
	worn_icon_state = "staff_back"
	throwforce = 10
	demolition_mod = 1.25
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("bonks", "bashes", "whacks", "pokes", "prods")
	attack_verb_simple = list("bonk", "bash", "whack", "poke", "prod")

/obj/item/melee/forging_weapon/staff/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 10, force_wielded = 18)

/obj/item/melee/forging_weapon/spear
	name = "spear"
	desc = "A long, two-handed spear. Also makes an effective throwing weapon."
	force = 10
	armour_penetration = 10
	icon_state = "spear"
	inhand_icon_state = "spear"
	worn_icon_state = "spear_back"
	throwforce = 20
	throw_speed = 4
	demolition_mod = 0.75
	embedding = list("impact_pain_mult" = 2, "remove_pain_mult" = 4, "jostle_chance" = 2.5)
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "pokes", "jabs", "tears", "lacerates", "gores")
	attack_verb_simple = list("attack", "poke", "jab", "tear", "lacerate", "gore")
	wound_bonus = -15
	bare_wound_bonus = 15
	sharpness = SHARP_POINTY

/obj/item/melee/forging_weapon/spear/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 10, force_wielded = 17) //better than the bone spear

/obj/item/melee/forging_weapon/axe
	name = "axe"
	desc = "A simple axe that works well when thrown, or when simply used to hack into your enemies."
	force = 12
	bare_wound_bonus = 15
	icon_state = "axe"
	inhand_icon_state = "axe"
	worn_icon_state = "axe_back"
	throwforce = 18
	throw_speed = 4
	demolition_mod = 1.1
	embedding = list("impact_pain_mult" = 2, "remove_pain_mult" = 4, "jostle_chance" = 2.5)
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("slashes", "bashes")
	attack_verb_simple = list("slash", "bash")
	sharpness = SHARP_EDGED

/obj/item/melee/forging_weapon/hammer
	name = "hammer"
	desc = "A heavy hammer capable of crushing through armor and person alike. Coincidentally, not that bad at crushing objects either."
	force = 14
	armour_penetration = 10
	wound_bonus = 10
	bare_wound_bonus = 25
	demolition_mod = 1.25
	icon_state = "crush_hammer"
	inhand_icon_state = "crush_hammer"
	worn_icon_state = "hammer_back"
	throwforce = 10
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("bashes", "whacks")
	attack_verb_simple = list("bash", "whack")
	tool_behaviour = TOOL_HAMMER

/obj/item/melee/forging_weapon/hammer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/kneejerk)

/obj/item/pickaxe/forging

/obj/item/shovel/forging

// Shields

/obj/item/shield/buckler/forging_shield
	name = "buckler"
	desc = "A small, round shield best used in tandem with a melee weapon in close-quarters combat."
	icon = 'modular_skyrat/modules/primitive_production/icons/forge_items.dmi'
	worn_icon = 'modular_skyrat/modules/primitive_production/icons/clothing/forge_weapon_worn.dmi'
	icon_state = "buckler"
	inhand_icon_state = "buckler"
	worn_icon_state = "buckler_back"
	lefthand_file = 'modular_skyrat/modules/primitive_production/icons/inhands/forge_weapon_l.dmi'
	righthand_file = 'modular_skyrat/modules/primitive_production/icons/inhands/forge_weapon_r.dmi'
	custom_materials = list(/datum/material/iron=1000)
	resistance_flags = FIRE_PROOF
	block_chance = 30
	max_integrity = 100
	w_class = WEIGHT_CLASS_NORMAL
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_AFFECT_STATISTICS

/obj/item/shield/buckler/forging_shield/pavise
	name = "tower shield"
	desc = "A towering shield (hence the name) that, while needing the use of both hands, is capable of blocking just about any incoming attack."
	icon_state = "pavise"
	inhand_icon_state = "pavise"
	worn_icon_state = "pavise_back"
	block_chance = 80
	item_flags = SLOWS_WHILE_IN_HAND
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = ITEM_SLOT_BACK
	max_integrity = 300

/obj/item/shield/riot/buckler/forging_shield/pavise/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands = TRUE, force_wielded = 15)

// Arrows

/obj/item/ammo_casing/caseless/arrow/wood/forged
	desc = "An arrow made of wood, typically fired from a bow. It can be reinforced with sinew."
	projectile_type = /obj/projectile/bullet/reusable/arrow/wood/forged

/obj/item/ammo_casing/caseless/arrow/wood/forged/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/stack/sheet/sinew))
		var/obj/item/stack/stack_item = attacking_item
		if(!stack_item.use(1))
			return
		new /obj/item/ammo_casing/caseless/arrow/ash(get_turf(src))
		qdel(src)
		return
	return ..()

/obj/projectile/bullet/reusable/arrow/wood/forged
	name = "wooden arrow"
	desc = "Woosh!"
	damage = 25
	icon_state = "arrow"
	ammo_type = /obj/item/ammo_casing/caseless/arrow/wood/forged
