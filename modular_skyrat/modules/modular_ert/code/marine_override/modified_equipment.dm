/datum/outfit/centcom/ert/marine //commander
	suit_store = /obj/item/gun/ballistic/automatic/ar/modular/model75
	belt = /obj/item/storage/belt/military/assault/full/arg
	back = /obj/item/mod/control/pre_equipped/marine
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer = 1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/storage/box/handcuffs = 1,
	)
	
/datum/outfit/centcom/ert/marine/security //generic and/or heavy
	suit_store = /obj/item/gun/ballistic/automatic/c20r/unrestricted/cmg1
	belt = /obj/item/storage/belt/military/assault/full/cmg
	back = /obj/item/mod/control/pre_equipped/marine
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer = 1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/storage/box/handcuffs = 1,
	)
	l_hand = /obj/item/shield/riot/pointman/hecu //weaker than exp corps shield, also looks the part
	
/datum/outfit/centcom/ert/marine/medic //medic
	suit_store = /obj/item/gun/ballistic/shotgun/automatic/as2
	back = /obj/item/mod/control/pre_equipped/marine
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/combat = 1,
		/obj/item/storage/medkit/regular = 1,
		/obj/item/storage/medkit/advanced = 1,
		/obj/item/ammo_box/advanced/s12gauge/marine = 2,
	)
	l_hand = /obj/item/gun/medbeam
	
/datum/outfit/centcom/ert/marine/engineer //engineer
	suit_store = /obj/item/gun/ballistic/shotgun/automatic/as2
	back = /obj/item/mod/control/pre_equipped/marine
	backpack_contents = list(
		/obj/item/storage/box/survival/engineer = 1,
		/obj/item/ammo_box/advanced/s12gauge/marine = 2,
	)
	l_hand = /obj/item/deployable_turret_folded
