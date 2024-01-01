/obj/item/crowbar/freeman
	name = "blood soaked crowbar"
	desc = "A heavy handed crowbar, it drips with blood."
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/freeman.dmi'
	icon_state = "crowbar"
	force = 35
	throwforce = 45
	toolspeed = 0.1
	wound_bonus = 10
	hitsound = 'modular_skyrat/master_files/sound/weapons/crowbar2.ogg'
	mob_throw_hit_sound = 'modular_skyrat/master_files/sound/weapons/crowbar2.ogg'
	force_opens = TRUE

/obj/item/crowbar/freeman/ultimate
	name = "\improper Freeman's crowbar"
	desc = "A weapon wielded by an ancient physicist, the blood of hundreds seeps through this rod of iron and malice."
	force = 45

/obj/item/crowbar/freeman/ultimate/Initialize(mapload)
	. = ..()
	add_filter("rad_glow", 2, list("type" = "outline", "color" = "#fbff1479", "size" = 2))

/obj/item/shield/riot/pointman/hecu
	name = "ballistic shield"
	desc = "A shield fit for those that want to sprint headfirst into the unknown! Cumbersome as hell. Repair with iron."
	icon_state = "ballistic"
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/ballistic.dmi'
	worn_icon_state = "ballistic_worn"
	worn_icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/ballistic.dmi'
	inhand_icon_state = "ballistic"
	lefthand_file = 'modular_skyrat/modules/awaymissions_skyrat/icons/ballistic_l.dmi'
	righthand_file = 'modular_skyrat/modules/awaymissions_skyrat/icons/ballistic_r.dmi'
	force = 14
	throwforce = 5
	throw_speed = 1
	throw_range = 1
	block_chance = 45
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("shoves", "bashes")
	attack_verb_simple = list("shove", "bash")
	transparent = TRUE
	max_integrity = 150
	repairable_by = /obj/item/stack/sheet/iron //what to repair the shield with


/obj/item/shield/riot/pointman/hecu/shatter(mob/living/carbon/human/owner)
	playsound(owner, 'sound/effects/glassbr3.ogg', 100)
	new /obj/item/ballistic_broken((get_turf(src)))

/obj/item/ballistic_broken
	name = "broken ballistic shield"
	desc = "An unsalvageable, unrecoverable mess of armor steel and kevlar. Should've maintained it, huh?"
	icon_state = "ballistic_broken"
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/ballistic.dmi'
	w_class = WEIGHT_CLASS_BULKY
