/**
 * Weaponry
 */

/obj/item/gun/energy/alien/zeta
	name = "Zeta Blaster"
	desc = "Having this too close to your face makes you start to taste blood, is this safe?"
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/alienblaster.dmi'
	lefthand_file = 'modular_skyrat/modules/awaymissions_skyrat/icons/alienhand.dmi'
	righthand_file = 'modular_skyrat/modules/awaymissions_skyrat/icons/alienhand2.dmi'
	icon_state = "alienblaster"
	inhand_icon_state = "alienblaster"
	pin = /obj/item/firing_pin
	selfcharge = TRUE

/obj/item/gun/energy/alien/astrum
	name = "alien energy pistol"
	desc = "A seemingly complicated gun, that isn't so complicated after all."
	ammo_type = list(/obj/item/ammo_casing/energy/laser)
	pin = /obj/item/firing_pin
	icon_state = "alienpistol"
	inhand_icon_state = "alienpistol"
	cell_type = /obj/item/stock_parts/power_store/cell/pulse/pistol


/**
 * Armour
 */

/obj/item/clothing/suit/armor/abductor/astrum
	name = "agent vest"
	desc = "You feel like you're wearing the suit wrong, and you have no idea how to operate its systems."
	icon = 'icons/obj/antags/abductor.dmi'
	icon_state = "vest_combat"
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	armor_type = /datum/armor/abductor_astrum
	resistance_flags = FIRE_PROOF | ACID_PROOF
	allowed = null // populated on init with armour vest defaults

/datum/armor/abductor_astrum
	melee = 40
	bullet = 50
	laser = 50
	energy = 50
	bomb = 20
	bio = 50
	fire = 90
	acid = 90

/obj/item/clothing/head/helmet/astrum
	name = "agent headgear"
	desc = "An exceptionally robust helmet. For alien standards, that is."
	icon_state = "alienhelmet"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	armor_type = /datum/armor/helmet_astrum
	resistance_flags = FIRE_PROOF | ACID_PROOF

/datum/armor/helmet_astrum
	melee = 40
	bullet = 30
	laser = 30
	energy = 40
	bomb = 50
	bio = 90
	fire = 100
	acid = 100
	wound = 15
