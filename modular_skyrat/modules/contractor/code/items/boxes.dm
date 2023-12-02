#define SMALL_ITEM_AMOUNT 3

/obj/item/storage/box/syndicate/contract_kit
	name = "contract kit"
	special_desc = "Supplied to Syndicate contractors."
	special_desc_requirement = EXAMINE_CHECK_CONTRACTOR
	icon_state = "syndiebox"
	illustration = "writing_syndie"
	var/list/item_list = list(
		/obj/item/storage/backpack/duffelbag/syndie/x4,
		/obj/item/storage/box/syndie_kit/throwing_weapons,
		/obj/item/gun/syringe/syndicate,
		/obj/item/pen/edagger,
		/obj/item/pen/sleepy,
		/obj/item/flashlight/emp,
		/obj/item/reagent_containers/syringe/mulligan,
		/obj/item/clothing/shoes/chameleon/noslip,
		/obj/item/storage/medkit/tactical,
		/obj/item/encryptionkey/syndicate,
		/obj/item/clothing/glasses/thermal/syndi,
		/obj/item/slimepotion/slime/sentience/nuclear,
		/obj/item/storage/box/syndie_kit/imp_radio,
		/obj/item/gun/ballistic/automatic/c20r/toy/unrestricted/riot,
		/obj/item/reagent_containers/hypospray/medipen/stimulants,
		/obj/item/storage/box/syndie_kit/imp_freedom,
		/obj/item/crowbar/power/syndicate,
		/obj/item/clothing/gloves/tackler/combat/insulated,
		/obj/item/storage/box/syndie_kit/emp,
		/obj/item/radio/headset/chameleon/advanced,
		/obj/item/shield/energy,
		/obj/item/healthanalyzer/rad_laser
	)

/obj/item/storage/box/syndicate/contract_kit/PopulateContents()
	new /obj/item/modular_computer/pda/contractor(src)
	new /obj/item/storage/box/syndicate/contractor_loadout(src)
	new /obj/item/melee/baton/telescopic/contractor_baton(src)

	// All about 4 TC or less - some nukeops only items, but fit nicely to the theme.
	for(var/iteration in 1 to SMALL_ITEM_AMOUNT)
		var/obj/item/small_item = pick_n_take(item_list)
		new small_item(src)

	// Paper guide
	new /obj/item/paper/contractor_guide(src)

/obj/item/storage/box/syndicate/contractor_loadout
	name = "standard loadout"
	special_desc_requirement = EXAMINE_CHECK_CONTRACTOR
	special_desc = "Supplied to Syndicate contractors, providing their specialised MODSuit and chameleon uniform."
	icon_state = "syndiebox"
	illustration = "writing_syndie"

/obj/item/storage/box/syndicate/contractor_loadout/PopulateContents()
	new /obj/item/mod/control/pre_equipped/contractor(src)
	new /obj/item/clothing/under/chameleon(src)
	new /obj/item/clothing/mask/chameleon(src)
	new /obj/item/storage/fancy/cigarettes/cigpack_syndicate(src)
	new /obj/item/card/id/advanced/chameleon(src)
	new /obj/item/lighter(src)
	new /obj/item/uplink/old_radio(src)
	new /obj/item/jammer(src)

/obj/item/storage/box/contractor/fulton_extraction
	name = "fulton extraction kit"
	icon_state = "syndiebox"
	illustration = "writing_syndie"

/obj/item/storage/box/contractor/fulton_extraction/PopulateContents()
	new /obj/item/extraction_pack/contractor(src)
	new /obj/item/fulton_core(src)

// trimmed down specifically for midrounds
/obj/item/storage/box/syndicate/contract_kit/midround
	name = "contract kit"
	special_desc = "Supplied to Syndicate contractors."
	special_desc_requirement = EXAMINE_CHECK_CONTRACTOR
	icon_state = "syndiebox"
	illustration = "writing_syndie"
	item_list = list(
		/obj/item/storage/backpack/duffelbag/syndie/x4,
		/obj/item/storage/box/syndie_kit/throwing_weapons,
		/obj/item/pen/sleepy,
		/obj/item/flashlight/emp,
		/obj/item/storage/medkit/tactical,
		/obj/item/storage/box/random_nades,
		/obj/item/clothing/glasses/hud/health/night/meson,
		/obj/item/mod/module/visor/thermal,
		/obj/item/mod/module/power_kick/removable,
		/obj/item/gun/ballistic/automatic/c20r/toy/unrestricted/riot,
		/obj/item/reagent_containers/hypospray/medipen/stimulants,
		/obj/item/storage/box/syndie_kit/imp_freedom,
		/obj/item/crowbar/power/syndicate,
		/obj/item/storage/box/syndie_kit/emp,
		/obj/item/shield/energy,
		/obj/item/card/emag/doorjack,
	)

/obj/item/storage/box/syndicate/contract_kit/midround/PopulateContents()
	// All about 4 TC or less - some nukeops only items, but fit nicely to the theme.
	for(var/iteration in 1 to SMALL_ITEM_AMOUNT)
		var/obj/item/small_item = pick_n_take(item_list)
		new small_item(src)

	// Paper guide
	new /obj/item/paper/contractor_guide/midround(src)
	new /obj/item/reagent_containers/hypospray/medipen/atropine(src)
	new /obj/item/jammer(src)
	new /obj/item/storage/fancy/cigarettes/cigpack_syndicate(src)
	new /obj/item/lighter(src)

/obj/item/storage/box/random_nades
	name = "box of grenades"
	desc = "Contains a random assortment of grenades. Caveat emptor."
	icon_state = "syndiebox"
	illustration = "flashbang"
	/// A weighted list of random, probably less-lethal, grenades. At time of writing, weights total to 20.
	var/list/weighted_nades_list = list(
		/obj/item/grenade/smokebomb = 10,
		/obj/item/grenade/mirage = 6,
		/obj/item/grenade/chem_grenade/teargas = 4,
	)

/obj/item/storage/box/random_nades/PopulateContents()
	for(var/items in 1 to 5)
		var/item = pick_weight(weighted_nades_list)
		new item(src)

#undef SMALL_ITEM_AMOUNT
