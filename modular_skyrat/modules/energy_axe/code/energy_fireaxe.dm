// Energy fire axes, for DS-2

/obj/item/fireaxe/energy
	icon = 'modular_skyrat/master_files/icons/obj/energy_axe.dmi'
	icon_state = "energy_axe0"
	base_icon_state = "energy_axe"
	lefthand_file = 'modular_skyrat/master_files/icons/mob/energyaxe_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/energyaxe_righthand.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	name = "energy fire axe"
	desc = "You aren't quite sure if this counts as a fire axe anymore, but it sure is fancy! A tag hangs off of it reading: 'properly of the Gorlex Marauders'"
	force = 5
	throwforce = 15
	w_class = WEIGHT_CLASS_BULKY
	light_system = MOVABLE_LIGHT
	light_range = 6
	light_color = COLOR_SOFT_RED
	light_on = FALSE
	attack_verb_continuous = list("attacks", "chops", "cleaves", "tears", "lacerates", "cuts")
	attack_verb_simple = list("attack", "chop", "cleave", "tear", "lacerate", "cut")
	armour_penetration = 35
	sharpness = SHARP_EDGED
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "An energized fireaxe of Syndicate descent."
	max_integrity = 200
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 100, ACID = 30)
	resistance_flags = FIRE_PROOF
	wound_bonus = -15
	bare_wound_bonus = 20

/obj/item/fireaxe/energy/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=10, force_wielded=30, icon_wielded="[base_icon_state]1", wieldsound='sound/weapons/saberon.ogg', unwieldsound='sound/weapons/saberoff.ogg')

/obj/item/fireaxe/energy/proc/energy_wield(obj/item/source, mob/living/carbon/user)
	SIGNAL_HANDLER

	wielded = TRUE
	hitsound = 'sound/weapons/blade1.ogg'
	START_PROCESSING(SSobj, src)
	set_light_on(TRUE)

//Swap hitsounds into the smack sound

/obj/item/fireaxe/energy/proc/energy_unwield(obj/item/source, mob/living/carbon/user)
	SIGNAL_HANDLER

	wielded = FALSE
	hitsound = "swing_hit"
	STOP_PROCESSING(SSobj, src)
	set_light_on(FALSE)

/obj/item/fireaxe/energy/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, .proc/energy_wield, override = TRUE)
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/energy_unwield, override = TRUE)
