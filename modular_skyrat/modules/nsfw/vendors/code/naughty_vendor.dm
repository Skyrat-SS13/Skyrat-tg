/obj/machinery/vending/dorms
	name = "\improper Dorms-Time Vending Machine"
	desc = "A rebranded vending machine, the words \"Kink-Mate\" are sprayed on the side. Recently illegalized following a controversy regarding Nanotrasen policy."
	product_ads = "Hey you, yeah you... wanna take a look at my collection?;Come on, take a look!;Remember, always adhere to Nanotrasen corporate policy!"
	icon = 'modular_skyrat/modules/nsfw/vendors/icons/vending.dmi'
	icon_state = "kink"
	icon_deny = "kink-deny"
	light_mask = "kink-light-mask"

	products = list( //Relatively normal to have, I GUESS
		/obj/item/clothing/under/costume/maid = 8,
		/obj/item/clothing/under/rank/civilian/janitor/maid = 8,
		/obj/item/clothing/under/misc/gear_harness = 6,
		/obj/item/clothing/under/costume/loincloth = 4,
		/obj/item/clothing/under/misc/stripper = 4,
		/obj/item/clothing/under/misc/stripper/green = 4,
		/obj/item/clothing/under/misc/stripper/mankini = 4,
		/obj/item/clothing/under/misc/stripper/bunnysuit = 4,
		/obj/item/clothing/under/misc/stripper/bunnysuit/white = 4,
		/obj/item/clothing/under/shorts/polychromic/pantsu = 4,
		/obj/item/clothing/under/misc/poly_bottomless = 4,
		/obj/item/clothing/under/misc/poly_tanktop = 4,
		/obj/item/clothing/under/misc/poly_tanktop/female = 4,
		/obj/item/clothing/mask/muzzle/ring = 4,
		/obj/item/clothing/mask/muzzle/ball = 4,
		/obj/item/clothing/neck/human_petcollar = 8,
		/obj/item/clothing/neck/human_petcollar/locked/cowcollar = 3,
		/obj/item/clothing/neck/human_petcollar/locked/bellcollar = 5,
		/obj/item/clothing/neck/human_petcollar/locked/spikecollar = 3,
		/obj/item/clothing/neck/human_petcollar/locked/cross = 3,
		/obj/item/clothing/neck/human_petcollar/choker = 4,
		/obj/item/restraints/handcuffs/fake = 8,
		/obj/item/clothing/glasses/blindfold = 8,
		/obj/item/clothing/mask/muzzle = 8,
		/obj/item/clothing/head/kitty = 4,
		/obj/item/clothing/head/rabbitears = 4,
		/obj/item/reagent_containers/pill/crocin = 20
	)

	contraband = list( //Actually dangerous or exploitable shit.
		/obj/item/clothing/under/costume/jabroni = 4,
		/obj/item/clothing/neck/human_petcollar/locked = 2,
		/obj/item/key/collar = 2,
		/obj/item/electropack/shockcollar = 4,
		/obj/item/assembly/signaler = 4,
		/obj/item/reagent_containers/pill/hexacrocin = 10
	)

	premium = list(
		/obj/item/clothing/under/dress/corset = 4,
		/obj/item/clothing/under/pants/chaps = 4,
		/obj/item/clothing/accessory/skullcodpiece/fake = 4,
		/obj/item/clothing/neck/human_petcollar/locked/holocollar = 3
	)

	refill_canister = /obj/item/vending_refill/kink

/obj/item/vending_refill/kink
	machine_name 	= "KinkMate"
	icon_state 		= "refill_snack"
