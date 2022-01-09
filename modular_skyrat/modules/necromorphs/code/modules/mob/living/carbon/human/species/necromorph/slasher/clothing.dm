/*
	Outfits for slashers
	All items generated for their outfits are oldified. See oldificator.dm
*/
/decl/hierarchy/outfit/necromorph
	hierarchy_type = /decl/hierarchy/outfit/necromorph
	id_slot = slot_wear_id

/decl/hierarchy/outfit/necromorph/create_item(var/path, var/location, var/dummy = FALSE)
	.=..()
	if (isatom(.))
		var/atom/A = .
		A.make_old()
		A.color = initial(A.color)	//Revert any color changes from being old

		//If an item of clothing has been added to a necromorph outfit, then strip out species restrictions.
		if (istype(A, /obj/item/clothing))
			var/obj/item/clothing/C = A
			C.species_restricted = null	//This must be null, not an empty list


//Mining overalls
/decl/hierarchy/outfit/necromorph/planet_cracker
	name ="Planet Slasher"
	uniform = /obj/item/clothing/under/deadspace/planet_cracker
	id_type = /obj/item/weapon/card/id/holo/mining

/obj/item/clothing/under/deadspace/planet_cracker
	sprite_sheets = list(
		SPECIES_NECROMORPH_SLASHER = 'icons/mob/necromorph/slasher/clothing.dmi'
		)



//Security Uniform
/decl/hierarchy/outfit/necromorph/security
	name = "Slashity Officer"
	uniform = /obj/item/clothing/under/deadspace/security
	id_type = /obj/item/weapon/card/id/holo/security


//Science biosuits Uniform
/decl/hierarchy/outfit/necromorph/biosuit
	name = "Bioslashard"
	uniform = /obj/item/clothing/under/deadspace/doctor
	suit = /obj/item/clothing/suit/bio_suit/ds
	id_type = /obj/item/weapon/card/id/holo/science


/decl/hierarchy/outfit/necromorph/biosuit/earthgov
	name = "G-Man"
	uniform = /obj/item/clothing/under/deadspace/doctor
	suit = /obj/item/clothing/suit/bio_suit/ds/black
	id_type = /obj/item/weapon/card/id/holo/science


//Medical
/decl/hierarchy/outfit/necromorph/doctor
	name = "Doctor Slick"
	uniform = /obj/item/clothing/under/deadspace/doctor
	id_type = /obj/item/weapon/card/id/holo/medical

/decl/hierarchy/outfit/necromorph/command
	name = "Commander Slasher"
	uniform = /obj/item/clothing/under/deadspace/captain
	id_type = /obj/item/weapon/card/id/holo/command

/decl/hierarchy/outfit/necromorph/mining
	name = "mining Slasher"
	suit = /obj/item/clothing/suit/space/void/mining/slasher

/decl/hierarchy/outfit/necromorph/engi
	name = "engi Slasher"
	suit = /obj/item/clothing/suit/space/void/engineering
