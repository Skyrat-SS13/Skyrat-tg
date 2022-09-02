/datum/outfit/centcom/ert/marine //commander
	suit_store = /obj/item/gun/ballistic/automatic/ar/modular/m44a/grenadelauncher
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
	suit_store = /obj/item/gun/ballistic/automatic/ar/modular/m44a/shotgun
	belt = /obj/item/storage/belt/military/assault/full/m44a
	back = /obj/item/mod/control/pre_equipped/marine
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer/marine = 1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/ammo_box/advanced/s12gauge/buckshot/marine = 2,
	)
	l_hand = null
	r_hand = null

/datum/outfit/centcom/ert/marine/medic //medic
	suit_store = /obj/item/gun/ballistic/automatic/ar/modular/m44a/scoped
	belt = /obj/item/storage/belt/military/assault/full/m44a
	back = /obj/item/mod/control/pre_equipped/marine
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer/marine = 1,
		/obj/item/reagent_containers/hypospray/combat = 1,
		/obj/item/storage/medkit/regular = 1,
		/obj/item/storage/medkit/advanced = 1,
		/obj/item/sensor_device = 1,
		/obj/item/stack/medical/gauze/twelve = 1,
		/obj/item/reagent_containers/syringe = 1,
		/obj/item/reagent_containers/cup/bottle/formaldehyde = 1,
		/obj/item/stack/sticky_tape/surgical = 1,
	)
	l_hand = /obj/item/gun/medbeam
	r_hand = null

/datum/outfit/centcom/ert/marine/engineer //engineer
	suit_store = /obj/item/melee/hammer //doesn't need a rifle
	back = /obj/item/mod/control/pre_equipped/marine/engineer
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer/marine = 1,
		/obj/item/ammo_box/magazine/smartgun_drum = 4, //AND WE'LL ALL STAY FREE
	)
	l_hand = null
	r_hand = null
