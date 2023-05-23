/obj/machinery/vending/access/command
	name = "\improper Command Outfitting Station"
	desc = "A vending machine for specialised clothing for members of Command."
	product_ads = "File paperwork in style!;It's red so you can't see the blood!;You have the right to be fashionable!;Now you can be the fashion police you always wanted to be!"
	icon = 'modular_skyrat/modules/command_vendor/icons/vending.dmi'
	icon_state = "commdrobe"
	light_mask = "wardrobe-light-mask"
	vend_reply = "Thank you for using the CommDrobe!"
	auto_build_products = TRUE
	payment_department = ACCOUNT_CMD

	refill_canister = /obj/item/vending_refill/wardrobe/comm_wardrobe
	payment_department = ACCOUNT_CMD
	light_color = COLOR_COMMAND_BLUE

/obj/item/vending_refill/wardrobe/comm_wardrobe
	machine_name = "CommDrobe"

/obj/machinery/vending/access/command/build_access_list(list/access_lists)
	access_lists["[ACCESS_CAPTAIN]"] = list(
		// CAPTAIN
		/obj/item/clothing/head/hats/caphat = 1,
		/obj/item/clothing/head/caphat/beret = 1,
		/obj/item/clothing/head/caphat/beret/alt = 1,
		/obj/item/clothing/head/hats/imperial/cap = 1,
		/obj/item/clothing/under/rank/captain = 1,
		/obj/item/clothing/under/rank/captain/skirt = 1,
		/obj/item/clothing/under/rank/captain/dress = 1,
		/obj/item/clothing/under/rank/captain/skyrat/kilt = 1,
		/obj/item/clothing/under/rank/captain/skyrat/imperial = 1,
		/obj/item/clothing/head/hats/caphat/parade = 1,
		/obj/item/clothing/under/rank/captain/parade = 1,
		/obj/item/clothing/suit/armor/vest/capcarapace/captains_formal = 1,
		/obj/item/clothing/suit/armor/vest/capcarapace/jacket = 1,
		/obj/item/clothing/suit/jacket/capjacket = 1,
		/obj/item/clothing/neck/cloak/cap = 1,
		/obj/item/clothing/neck/mantle/capmantle = 1,
		/obj/item/storage/backpack/captain = 1,
		/obj/item/storage/backpack/satchel/cap = 1,
		/obj/item/storage/backpack/duffelbag/captain = 1,
		/obj/item/clothing/shoes/sneakers/brown = 1,

		// BLUESHIELD
		/obj/item/clothing/head/beret/blueshield = 1,
		/obj/item/clothing/head/beret/blueshield/navy = 1,
		/obj/item/clothing/under/rank/blueshield = 1,
		/obj/item/clothing/under/rank/blueshield/skirt = 1,
		/obj/item/clothing/under/rank/blueshield/turtleneck = 1,
		/obj/item/clothing/under/rank/blueshield/turtleneck/skirt = 1,
		/obj/item/clothing/suit/armor/vest/blueshield = 1,
		/obj/item/clothing/suit/armor/vest/blueshieldarmor = 1,
		/obj/item/clothing/neck/mantle/bsmantle = 1,
		/obj/item/storage/backpack/blueshield = 1,
		/obj/item/storage/backpack/satchel/blueshield = 1,
		/obj/item/storage/backpack/duffelbag/blueshield = 1,
		/obj/item/clothing/shoes/laceup = 1,
	)
	access_lists["[ACCESS_HOP]"] = list( // Best head btw
		/obj/item/clothing/head/hats/hopcap = 1,
		/obj/item/clothing/head/hopcap/beret = 1,
		/obj/item/clothing/head/hopcap/beret/alt = 1,
		/obj/item/clothing/head/hats/imperial/hop = 1,
		/obj/item/clothing/under/rank/civilian/head_of_personnel = 1,
		/obj/item/clothing/under/rank/civilian/head_of_personnel/skirt = 1,
		/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/turtleneck = 1,
		/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/turtleneck/skirt = 1,
		/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/parade = 1,
		/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/parade/female = 1,
		/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/imperial = 1,
		/obj/item/clothing/suit/toggle/hop_parade = 1,
		/obj/item/clothing/neck/cloak/hop = 1,
		/obj/item/clothing/neck/mantle/hopmantle = 1,
		/obj/item/storage/backpack/head_of_personnel = 1,
		/obj/item/storage/backpack/satchel/head_of_personnel = 1,
		/obj/item/storage/backpack/duffelbag/head_of_personnel = 1,
		/obj/item/clothing/shoes/sneakers/brown = 1,
	)
	access_lists["[ACCESS_CMO]"] = list(
		/obj/item/clothing/head/beret/medical/cmo = 1,
		/obj/item/clothing/head/beret/medical/cmo/alt = 1,
		/obj/item/clothing/head/hats/imperial/cmo = 1,
		/obj/item/clothing/under/rank/medical/chief_medical_officer = 1,
		/obj/item/clothing/under/rank/medical/chief_medical_officer/skirt = 1,
		/obj/item/clothing/under/rank/medical/chief_medical_officer/turtleneck = 1,
		/obj/item/clothing/under/rank/medical/chief_medical_officer/skyrat/imperial = 1,
		/obj/item/clothing/neck/cloak/cmo = 1,
		/obj/item/clothing/neck/mantle/cmomantle = 1,
		/obj/item/clothing/shoes/sneakers/brown = 1,
	)
	access_lists["[ACCESS_RD]"] = list(
		/obj/item/clothing/head/beret/science/rd = 1,
		/obj/item/clothing/head/beret/science/rd/alt = 1,
		/obj/item/clothing/under/rank/rnd/research_director = 1,
		/obj/item/clothing/under/rank/rnd/research_director/skirt = 1,
		/obj/item/clothing/under/rank/rnd/research_director/alt = 1,
		/obj/item/clothing/under/rank/rnd/research_director/alt/skirt = 1,
		/obj/item/clothing/under/rank/rnd/research_director/turtleneck = 1,
		/obj/item/clothing/under/rank/rnd/research_director/turtleneck/skirt = 1,
		/obj/item/clothing/under/rank/rnd/research_director/skyrat/jumpsuit = 1,
		/obj/item/clothing/under/rank/rnd/research_director/skyrat/jumpsuit/skirt = 1,
		/obj/item/clothing/under/rank/rnd/research_director/skyrat/imperial = 1,
		/obj/item/clothing/neck/cloak/rd = 1,
		/obj/item/clothing/neck/mantle/rdmantle = 1,
		/obj/item/clothing/suit/toggle/labcoat = 1,
		/obj/item/clothing/shoes/sneakers/brown = 1,
	)
	access_lists["[ACCESS_CE]"] = list(
		/obj/item/clothing/head/beret/engi/ce = 1,
		/obj/item/clothing/head/hats/imperial/ce = 1,
		/obj/item/clothing/under/rank/engineering/chief_engineer = 1,
		/obj/item/clothing/under/rank/engineering/chief_engineer/skirt = 1,
		/obj/item/clothing/under/rank/engineering/chief_engineer/skyrat/imperial = 1,
		/obj/item/clothing/neck/cloak/ce = 1,
		/obj/item/clothing/neck/mantle/cemantle = 1,
		/obj/item/clothing/shoes/sneakers/brown = 1,
	)
	access_lists["[ACCESS_HOS]"] = list(
		/obj/item/clothing/head/hats/hos/cap = 1,
		/obj/item/clothing/head/hats/hos/beret/navyhos = 1,
		/obj/item/clothing/head/hats/hos/cap/peacekeeper/sol = 1,
		/obj/item/clothing/head/hats/imperial/hos = 1,
		/obj/item/clothing/under/rank/security/head_of_security/peacekeeper = 1,
		/obj/item/clothing/under/rank/security/head_of_security/peacekeeper/sol = 1,
		/obj/item/clothing/under/rank/security/head_of_security/alt = 1,
		/obj/item/clothing/under/rank/security/head_of_security/alt/skirt = 1,
		/obj/item/clothing/under/rank/security/head_of_security/skyrat/imperial = 1,
		/obj/item/clothing/suit/armor/hos/navyblue = 1,
		/obj/item/clothing/under/rank/security/head_of_security/parade = 1,
		/obj/item/clothing/suit/armor/hos/hos_formal = 1,
		/obj/item/clothing/neck/cloak/hos = 1,
		/obj/item/clothing/neck/cloak/hos/redsec = 1,
		/obj/item/clothing/neck/mantle/hosmantle = 1,
		/obj/item/clothing/shoes/sneakers/brown = 1,
	)
	access_lists["[ACCESS_QM]"] = list(
		/obj/item/clothing/head/beret/cargo/qm = 1,
		/obj/item/clothing/head/beret/cargo/qm/alt = 1,
		/obj/item/clothing/neck/cloak/qm = 1,
		/obj/item/clothing/neck/mantle/qm = 1,
		/obj/item/clothing/under/rank/cargo/qm = 1,
		/obj/item/clothing/under/rank/cargo/qm/skirt = 1,
		/obj/item/clothing/under/rank/cargo/qm/skyrat/gorka = 1,
		/obj/item/clothing/under/rank/cargo/qm/skyrat/turtleneck = 1,
		/obj/item/clothing/under/rank/cargo/qm/skyrat/turtleneck/skirt = 1,
		/obj/item/clothing/suit/brownfurrich = 1,
		/obj/item/clothing/under/rank/cargo/qm/skyrat/casual = 1,
		/obj/item/clothing/suit/toggle/jacket/supply/head = 1,
		/obj/item/clothing/under/rank/cargo/qm/skyrat/formal = 1,
		/obj/item/clothing/under/rank/cargo/qm/skyrat/formal/skirt = 1,
		/obj/item/clothing/shoes/sneakers/brown = 1,
	)

	access_lists["[ACCESS_CENT_GENERAL]"] = list( // CC Rep Shiz
		/obj/item/clothing/head/nanotrasen_consultant = 1,
		/obj/item/clothing/head/nanotrasen_consultant/beret = 1,
		/obj/item/clothing/head/beret/centcom_formal/nt_consultant = 1,
		/obj/item/clothing/under/rank/nanotrasen_consultant = 1,
		/obj/item/clothing/under/rank/nanotrasen_consultant/skirt = 1,
		/obj/item/clothing/head/hats/centhat = 1,
		/obj/item/clothing/suit/armor/centcom_formal/nt_consultant = 1,
		/obj/item/clothing/gloves/combat/naval/nanotrasen_consultant = 1,
	)

	access_lists["[ACCESS_COMMAND]"] = list(
		/obj/item/clothing/head/hats/imperial = 5,
		/obj/item/clothing/head/hats/imperial/grey = 5,
		/obj/item/clothing/head/hats/imperial/white = 2,
		/obj/item/clothing/head/hats/imperial/red = 5,
		/obj/item/clothing/head/hats/imperial/helmet = 5,
		/obj/item/clothing/under/rank/captain/skyrat/imperial/generic = 5,
		/obj/item/clothing/under/rank/captain/skyrat/imperial/generic/grey = 5,
		/obj/item/clothing/under/rank/captain/skyrat/imperial/generic/pants = 5,
		/obj/item/clothing/under/rank/captain/skyrat/imperial/generic/red = 5,
	)

