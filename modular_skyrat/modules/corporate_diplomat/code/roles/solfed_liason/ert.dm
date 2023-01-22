/datum/outfit/solfed_marshal
	name = "SolFed Response Marshal"
	back = /obj/item/storage/backpack/duffelbag/cops
	uniform = /obj/item/clothing/under/rank/security/detective/cowboy
	shoes = /obj/item/clothing/shoes/cowboy
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/solfed/marshal
	head = /obj/item/clothing/head/cowboy
	belt = /obj/item/gun/energy/disabler
	r_pocket = /obj/item/lighter
	l_pocket = /obj/item/restraints/handcuffs
	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/melee/baton/security/loaded = 1,
	)

	id = /obj/item/card/id/advanced/solfed
	id_trim = /datum/id_trim/solfed


/datum/outfit/solfed_marshal/leader
	name = "SolFed Response Marshal Leader"
	suit = /obj/item/clothing/suit/armor/bulletproof
	suit_store = /obj/item/gun/ballistic/shotgun/m23

	backpack_contents = list(
		/obj/item/storage/box/survival = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/ammo_box/advanced/s12gauge/buckshot = 1,
	)


/datum/ert/solfed_marshal
	roles = list(/datum/antagonist/ert/solfed_marshal)
	leader_role = /datum/antagonist/ert/solfed_marshal/leader
	rename_team = "SolFed Response Marshal"
	polldesc = "a group of SolFed Response Marshals"
	ert_template = /datum/map_template/shuttle/ert/solfed


/datum/antagonist/ert/solfed_marshal
	name = "SolFed Response Marshal"
	outfit = /datum/outfit/solfed_marshal
	role = "Marshal"


/datum/antagonist/ert/solfed_marshal/leader
	name = "SolFed Response Marshal Leader"
	outfit = /datum/outfit/solfed_marshal/leader
	role = "Commander"
