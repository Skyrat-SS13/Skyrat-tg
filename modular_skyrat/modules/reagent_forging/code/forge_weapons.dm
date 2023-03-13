/obj/item/melee/forged_weapon
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_items.dmi'
	lefthand_file = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_weapon_l.dmi'
	righthand_file = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_weapon_r.dmi'
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_weapon_worn.dmi'
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR
	resistance_flags = FIRE_PROOF

	throwforce = 10
	sharpness = SHARP_EDGED

// The sword has a block chance and more damage than the katana, but lacks armour penetration
/obj/item/melee/forged_weapon/sword
	name = "sword"
	desc = "A one-handed sword that is capable of blocking attacks, but can struggle against armor."

	force = 18
	block_chance = 25
	bare_wound_bonus = 10

	icon_state = "sword"
	inhand_icon_state = "sword"
	worn_icon_state = "sword_back"
	belt_icon_state = "sword_belt"
	hitsound = 'sound/weapons/bladeslice.ogg'
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")

// The katana can't block attacks and has a bit less damage than the sword, but it gets a free 25 armour penetration
/obj/item/melee/forged_weapon/katana
	name = "katana"
	desc = "A katana sharp enough to penetrate body armor, but not quite million-times-folded sharp."

	force = 15
	armour_penetration = 25
	wound_bonus = 5
	bare_wound_bonus = 15

	icon_state = "katana"
	inhand_icon_state = "katana"
	worn_icon_state = "katana_back"
	belt_icon_state = "katana_belt"
	hitsound = 'sound/weapons/bladeslice.ogg'
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")

// The dagger is equivalent in force to a hunting knife, these can be concealed in a boot pocket or just a normal pocket so what it do
/obj/item/melee/forged_weapon/dagger
	name = "dagger"
	desc = "A lightweight dagger that is easy to conceal."

	force = 10
	bare_wound_bonus = 10

	icon_state = "dagger"
	inhand_icon_state = "dagger"
	worn_icon_state = "dagger_back"
	belt_icon_state = "dagger_belt"
	hitsound = 'sound/weapons/bladeslice.ogg'
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")

// The spear and the staff will be hand in hand for melee functionality, able to be two handed for more damage, the difference is what type of wounds they deal
/obj/item/melee/forged_weapon/staff
	name = "staff"
	desc = "A staff most notably capable of breaking someone's shins and being held with two hands."

	force = 10
	sharpness = NONE
	wound_bonus = 10
	bare_wound_bonus = 15

	icon_state = "staff"
	inhand_icon_state = "staff"
	worn_icon_state = "staff_back"
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("bonks", "bashes", "whacks")
	attack_verb_simple = list("bonk", "bash", "whack")

/obj/item/melee/forged_weapon/staff/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/two_handed, force_unwielded = 10, force_wielded = 18)

// Like the staff, but you can also throw spears really hard, also pokey
/obj/item/melee/forged_weapon/spear
	name = "spear"
	desc = "A long spear that can be wielded in two hands to boost damage at the cost of single-handed versatility."

	force = 10
	throwforce = 20
	armour_penetration = 10
	wound_bonus = -15
	bare_wound_bonus = 15
	throw_speed = 4
	embedding = list("impact_pain_mult" = 2, "remove_pain_mult" = 4, "jostle_chance" = 2.5)
	sharpness = SHARP_POINTY

	icon_state = "spear"
	inhand_icon_state = "spear"
	worn_icon_state = "spear_back"
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "pokes", "jabs", "tears", "lacerates", "gores")
	attack_verb_simple = list("attack", "poke", "jab", "tear", "lacerate", "gore")

/obj/item/melee/forged_weapon/spear/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/two_handed, force_unwielded = 10, force_wielded = 18)
	AddComponent(/datum/component/jousting)

/obj/item/melee/forged_weapon/axe
	name = "axe"
	desc = "An axe especially balanced for throwing and embedding into fleshy targets. Nonetheless useful as a traditional melee tool."

	force = 15
	wound_bonus = 10
	bare_wound_bonus = 25
	throwforce = 18
	throw_speed = 4
	embedding = list("impact_pain_mult" = 2, "remove_pain_mult" = 4, "jostle_chance" = 2.5)

	icon_state = "axe"
	inhand_icon_state = "axe"
	worn_icon_state = "axe_back"
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("slashes", "bashes")
	attack_verb_simple = list("slash", "bash")

// The hammer operates much like a katana, but you crush bones rather than cutting people
/obj/item/melee/forged_weapon/hammer
	name = "reagent hammer"
	desc = "A heavy, weighted hammer that packs an incredible punch but can prove to be unwieldy. Useful for forging!"

	force = 15
	armour_penetration = 25
	wound_bonus = 5
	bare_wound_bonus = 15
	sharpness = NONE

	icon_state = "crush_hammer"
	inhand_icon_state = "crush_hammer"
	worn_icon_state = "hammer_back"
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("bashes", "whacks")
	attack_verb_simple = list("bash", "whack")
	tool_behaviour = TOOL_HAMMER

	///the list of things that, if attacked, will set the attack speed to rapid
	var/static/list/fast_attacks = list(
		/obj/structure/reagent_anvil,
		/obj/structure/reagent_crafting_bench
	)

/obj/item/melee/forged_weapon/hammer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/kneejerk)

/obj/item/melee/forged_weapon/hammer/attack_atom(atom/attacked_atom, mob/living/user, params)
	. = ..()
	if(!is_type_in_list(attacked_atom, fast_attacks))
		return
	user.changeNext_move(CLICK_CD_RAPID)

/obj/item/shield/buckler/forged
	name = "plated buckler shield"
	desc = "A small, round shield best used in tandem with a melee weapon in close-quarters combat."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_items.dmi'
	worn_icon = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_weapon_worn.dmi'
	icon_state = "buckler"
	inhand_icon_state = "buckler"
	worn_icon_state = "buckler_back"
	lefthand_file = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_weapon_l.dmi'
	righthand_file = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_weapon_r.dmi'
	resistance_flags = FIRE_PROOF

	block_chance = 30
	transparent = FALSE
	max_integrity = 150

	w_class = WEIGHT_CLASS_NORMAL
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_AFFECT_STATISTICS
	shield_break_sound = 'sound/effects/bang.ogg'
	shield_break_leftover = /obj/item/forging/complete/plate

/obj/item/shield/buckler/forged/pavise //similar to the adamantine shield. Huge, slow, lets you soak damage and packs a wallop.
	name = "plated pavise shield"
	desc = "An oblong shield used by ancient crossbowmen as cover while reloading. Probably just as useful with an actual gun."
	icon_state = "pavise"
	inhand_icon_state = "pavise"
	worn_icon_state = "pavise_back"
	block_chance = 75
	item_flags = SLOWS_WHILE_IN_HAND
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = ITEM_SLOT_BACK
	max_integrity = 300

/obj/item/shield/buckler/reagent_weapon/pavise/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands = TRUE, force_wielded = 15)

/obj/item/pickaxe/reagent_weapon
	name = "reagent pickaxe"

/obj/item/pickaxe/reagent_weapon/Initialize(mapload)
	. = ..()

/obj/item/shovel/reagent_weapon
	name = "reagent shovel"

/obj/item/shovel/reagent_weapon/Initialize(mapload)
	. = ..()

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
