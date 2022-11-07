/*
*	IMPROVISED SHOTGUN
*	We're using the rifle because we want the bolt action so we can pretend it's a break action gun.
*	On Skyrat/Cit there was a need to tone improvised weapons down due to their incredible ease of access.
*	This is the same nerf, but drastically more fun. We now need two hands to fire and we have a slightly slower action.
*/

/obj/item/gun/ballistic/rifle/ishotgun
	name = "improvised shotgun"
	desc = "A break-action 12 gauge shotgun. You need both hands to fire this."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile40x32.dmi'
	icon_state = "ishotgun"
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/weapons/64x_guns_right.dmi'
	pixel_x = -8
	inhand_icon_state = "ishotgun"
	w_class = WEIGHT_CLASS_BULKY
	force = 10
	slot_flags = null
	mag_type = /obj/item/ammo_box/magazine/internal/shot/improvised
	sawn_desc = "A break-action 12 gauge shotgun, but with most of the stock and some of the barrel removed. You still need both hands to fire this."
	unique_reskin = null
	var/slung = FALSE
	weapon_weight = WEAPON_HEAVY	// It's big.
	recoil = 4	// We're firing 12 gauge.
	can_be_sawn_off = TRUE
	bolt_wording = "barrel"

/obj/item/ammo_box/magazine/internal/shot/improvised
	name = "improvised shotgun internal magazine"
	ammo_type = /obj/item/ammo_casing/shotgun/improvised
	max_ammo = 1

/obj/item/gun/ballistic/rifle/ishotgun/examine(mob/user)
	. = ..()
	. += "The barrel is [bolt_locked ? "broke open" : "closed"]."

/obj/item/gun/ballistic/rifle/ishotgun/attackby(obj/item/A, mob/user, params)
	..()
	if(istype(A, /obj/item/stack/cable_coil) && !sawn_off)
		var/obj/item/stack/cable_coil/C = A
		if(C.use(10))
			slot_flags = ITEM_SLOT_BACK
			to_chat(user, span_notice("You tie the lengths of cable to the shotgun, making a sling."))
			slung = TRUE
			update_icon()
		else
			to_chat(user, span_warning("You need at least ten lengths of cable if you want to make a sling!"))

/obj/item/gun/ballistic/rifle/ishotgun/update_icon_state()
	. = ..()
	if(slung)
		inhand_icon_state = "ishotgunsling"
	if(sawn_off)
		inhand_icon_state = "ishotgun_sawn"

/obj/item/gun/ballistic/rifle/ishotgun/update_overlays()
	. = ..()
	if(slung)
		. += "ishotgunsling"
	if(sawn_off)
		. += "ishotgun_sawn"

/obj/item/gun/ballistic/rifle/ishotgun/sawoff(mob/user)
	. = ..()
	if(. && slung) //sawing off the gun removes the sling
		new /obj/item/stack/cable_coil(get_turf(src), 10)
		slung = 0
		update_icon()
		lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/weapons/64x_guns_left.dmi'
		righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/weapons/64x_guns_right.dmi'

/obj/item/gun/ballistic/rifle/ishotgun/sawn
	name = "sawn-off improvised shotgun"
	desc = "A break-action 12 gauge shotgun, but with most of the stock and some of the barrel removed. You still need both hands to fire this."
	icon_state = "ishotgun_sawn"
	inhand_icon_state = "ishotgun_sawn"
	worn_icon_state = "gun"
	worn_icon = null
	w_class = WEIGHT_CLASS_NORMAL
	sawn_off = TRUE
	slot_flags = ITEM_SLOT_BELT
