/*
	Outfits for slashers
	All items generated for their outfits are oldified. See oldificator.dm
*/
/decl/hierarchy/outfit/necromorph
	hierarchy_type = /decl/hierarchy/outfit/necromorph
	id_slot = slot_wear_id

/decl/hierarchy/outfit/necromorph/create_item(var/path, var/location)
	.=..()
	if (isatom(.))
		var/atom/A = .
		A.make_old()

		//If an item of clothing has been added to a necromorph outfit, then strip out species restrictions.
		if (istype(A, /obj/item/clothing))
			var/obj/item/clothing/C = A
			C.species_restricted = null	//This must be null, not an empty list


//Mining overalls
/decl/hierarchy/outfit/necromorph/planet_cracker
	name = OUTFIT_JOB_NAME("Planet Slasher")
	uniform = /obj/item/clothing/under/deadspace/planet_cracker
	id_type = /obj/item/weapon/card/id/holo/mining

/obj/item/clothing/under/deadspace/planet_cracker
	sprite_sheets = list(
		SPECIES_NECROMORPH_SLASHER = 'icons/mob/necromorph/slasher/clothing.dmi'
		)



//Security Uniform
/decl/hierarchy/outfit/necromorph/security
	name = OUTFIT_JOB_NAME("Slashity Officer")
	uniform = /obj/item/clothing/under/deadspace/security
	id_type = /obj/item/weapon/card/id/holo/security

/obj/item/clothing/under/deadspace/security
	sprite_sheets = list(
		SPECIES_NECROMORPH_SLASHER = 'icons/mob/necromorph/slasher/clothing.dmi'
		)