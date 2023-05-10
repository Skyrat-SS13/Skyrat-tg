/obj/item/storage/toolbox/ammo
	desc = "It contains a few clips."
	icon_state = "ammobox"
	inhand_icon_state = "ammobox"
	lefthand_file = 'icons/mob/inhands/equipment/toolbox_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/toolbox_righthand.dmi'
	has_latches = FALSE
	drop_sound = 'sound/items/handling/ammobox_drop.ogg'
	pickup_sound = 'sound/items/handling/ammobox_pickup.ogg'

/obj/item/storage/toolbox/ammo/PopulateContents()
	return

/obj/item/storage/toolbox/ammo/full
	var/ammo_type = null ///Type of mags/casings/clips we spawn in.
	var/amount = 0 ///Amount of mags/casings/clips we spawn in.

/obj/item/storage/toolbox/ammo/full/PopulateContents()
	for(var/i in 1 to amount)
		new ammo_type(src)

/obj/item/storage/toolbox/ammo/full/mosin
	name = "ammo box (Sportiv)"
	ammo_type = /obj/item/ammo_box/a762
	amount = 7

/obj/item/storage/toolbox/ammo/full/krinkov
	name = "ammo box (Krinkov)"
	desc = "It contains a few magazines."
	ammo_type = /obj/item/ammo_box/magazine/akm
	amount = 7

/obj/item/storage/toolbox/ammo/full/krinkov/emp
	name = "ammo box (Krinkov, EMP)"
	desc = "It contains a few magazines."
	ammo_type = /obj/item/ammo_box/magazine/akm/emp

/obj/item/storage/toolbox/ammo/full/krinkov/fire
	name = "ammo box (Krinkov, incendiary)"
	desc = "It contains a few magazines."
	ammo_type = /obj/item/ammo_box/magazine/akm/fire

/obj/item/storage/toolbox/ammo/full/krinkov/ricochet
	name = "ammo box (Krinkov, match)"
	desc = "It contains a few magazines."
	ammo_type = /obj/item/ammo_box/magazine/akm/ricochet

/obj/item/storage/toolbox/ammo/full/krinkov/ap
	name = "ammo box (Krinkov, armor piercing)"
	desc = "It contains a few magazines."
	ammo_type = /obj/item/ammo_box/magazine/akm/ap

/obj/item/storage/toolbox/ammo/full/bison
	name = "ammo box (PP-95)"
	desc = "It contains a few magazines."
	ammo_type = /obj/item/ammo_box/magazine/multi_sprite/cfa_lynx
	amount = 4

/obj/item/storage/toolbox/ammo/full/nri_smg
	name = "ammo box (QLP/04)"
	ammo_type = /obj/item/ammo_box/magazine/multi_sprite/cfa_lynx
	amount = 7

/obj/item/storage/toolbox/ammo/full/l6_saw
	name = "ammo box (L6 SAW)"
	desc = "It contains a few magazines."
	ammo_type = /obj/item/ammo_box/magazine/mm712x82
	amount = 7

/obj/item/storage/toolbox/ammo/full/makarov
	name = "ammo box (R-C Makarov)"
	desc = "It contains a few magazines."
	ammo_type = /obj/item/ammo_box/magazine/multi_sprite/makarov
	amount = 7

/obj/item/storage/toolbox/ammo/full/aps
	name = "ammo box (Szabo-Ivanek/APS)"
	desc = "It contains a few magazines."
	ammo_type = /obj/item/ammo_box/magazine/m9mm_aps
	amount = 7
