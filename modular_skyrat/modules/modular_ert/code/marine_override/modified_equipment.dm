/datum/outfit/centcom/ert/marine //commander
	suit_store = /obj/item/gun/ballistic/automatic/ar/modular/m44a/gl
	belt = /obj/item/storage/belt/military/assault/full/m44a
	back = /obj/item/mod/control/pre_equipped/marine
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer/marine = 1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/ammo_box/a40mm = 2, //gods must be strong
	)
	l_hand = null
	r_hand = null
	
/datum/outfit/centcom/ert/marine/security //generic and/or heavy
	suit_store = /obj/item/gun/ballistic/automatic/ar/modular/m44a/sg
	belt = /obj/item/storage/belt/military/assault/full/m44a
	back = /obj/item/mod/control/pre_equipped/marine
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer/marine = 1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/ammo_box/advanced/s12gauge/marine = 2,
	)
	l_hand = null
	r_hand = null
	
/datum/outfit/centcom/ert/marine/medic //medic
	suit_store = /obj/item/gun/ballistic/automatic/ar/modular/m44a/s
	belt = /obj/item/storage/belt/military/assault/full/m44a
	back = /obj/item/mod/control/pre_equipped/marine
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer/marine = 1,
		/obj/item/reagent_containers/hypospray/combat = 1,
		/obj/item/storage/medkit/regular = 1,
		/obj/item/storage/medkit/advanced = 1,
		/obj/item/sensor_device,
		/obj/item/pinpointer/crew/prox,
		/obj/item/stack/medical/gauze/twelve,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/glass/bottle/formaldehyde,
		/obj/item/stack/sticky_tape/surgical,
	)
	l_hand = /obj/item/gun/medbeam
	r_hand = null
	
/datum/outfit/centcom/ert/marine/engineer //engineer
	suit_store = null //doesn't need a rifle
	back = /obj/item/mod/control/pre_equipped/marine
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer/marine = 1,
	)
	l_hand = /obj/item/deployable_turret_folded
	r_hand = null
