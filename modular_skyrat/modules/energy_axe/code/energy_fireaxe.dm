// Energy fire axes, for DS-2

/obj/item/fireaxe/energy
	icon = 'modular_skyrat/master_files/icons/obj/energy_axe.dmi'
	icon_state = "energy_axe0"
	base_icon_state = "energy_axe"
	lefthand_file = 'modular_skyrat/master_files/icons/mob/energyaxe_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/energyaxe_righthand.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	name = "energy fire axe"
	desc = "You aren't quite sure if this counts as a fire axe anymore, but it sure is fancy! A tag hangs off of it reading: \"property of the Gorlex Marauders\""
	force = 5
	throwforce = 15
	light_system = MOVABLE_LIGHT
	light_range = 6
	light_color = COLOR_SOFT_RED
	light_on = FALSE
	armour_penetration = 35
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "An energized fire axe used in Syndicate bases for breaking glass, and people."

/obj/item/fireaxe/energy/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 10, force_wielded = 33, icon_wielded = "[base_icon_state]1", wieldsound = 'sound/weapons/saberon.ogg', unwieldsound = 'sound/weapons/saberoff.ogg')

/obj/item/fireaxe/energy/proc/energy_wield(obj/item/source, mob/living/carbon/user)
	SIGNAL_HANDLER

	hitsound = 'sound/weapons/blade1.ogg'
	START_PROCESSING(SSobj, src)
	set_light_on(TRUE)

//Swap hitsounds from energy slash to basic smack sound when unwielded

/obj/item/fireaxe/energy/proc/energy_unwield(obj/item/source, mob/living/carbon/user)
	SIGNAL_HANDLER

	hitsound = SFX_SWING_HIT
	STOP_PROCESSING(SSobj, src)
	set_light_on(FALSE)

/obj/item/fireaxe/energy/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, .proc/energy_wield, override = TRUE)
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/energy_unwield, override = TRUE)
