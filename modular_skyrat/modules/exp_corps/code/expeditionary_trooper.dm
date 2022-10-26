/obj/item/modular_computer/tablet/pda/expeditionary_corps
	greyscale_colors = "#891417#000099"
	name = "Military PDA"

/obj/item/storage/box/expeditionary_survival
	name = "expedition survival pack"
	desc = "A box filled with useful items for your expedition!"
	icon_state = "survival_pack"
	icon = 'modular_skyrat/modules/exp_corps/icons/survival_pack.dmi'
	illustration = null

/obj/item/storage/box/expeditionary_survival/PopulateContents()
	new /obj/item/storage/box/donkpockets(src)
	new /obj/item/flashlight/glowstick(src)
	new /obj/item/tank/internals/emergency_oxygen/double(src)
	new /obj/item/reagent_containers/cup/glass/waterbottle(src)
	new /obj/item/reagent_containers/blood/universal(src)
	new /obj/item/reagent_containers/syringe(src)
	new /obj/item/storage/pill_bottle/multiver(src)

//edgy loner with knives AND A FUKKEN gun
/obj/structure/closet/crate/secure/exp_corps/marksman/PopulateContents()
	new /obj/item/storage/medkit/regular(src)
	new /obj/item/storage/box/expeditionary_survival(src)
	new /obj/item/radio(src)
	new /obj/item/storage/bag/ammo/marksman(src)
	new /obj/item/clothing/gloves/color/black/expeditionary_corps(src)
	new /obj/item/clothing/head/helmet/expeditionary_corps(src)
	new /obj/item/clothing/suit/armor/vest/expeditionary_corps(src)
	new /obj/item/storage/belt/military/expeditionary_corps/marksman(src)
	new /obj/item/storage/backpack/duffelbag/expeditionary_corps(src)
	new /obj/item/storage/box/gunset/ladon(src)

/datum/supply_pack/misc/vanguard_surplus
	name = "Expeditionary Corps Surplus"
	desc = "Contains an assortment of surplus equipment from the now-defunct Vanguard Expeditionary Corps."
	cost = CARGO_CRATE_VALUE * 18
	contains = list(
		/obj/item/storage/box/expeditionary_survival,
		/obj/item/melee/tomahawk,
		/obj/item/storage/backpack/duffelbag/expeditionary_corps,
		/obj/item/clothing/gloves/color/black/expeditionary_corps,
		/obj/item/clothing/head/helmet/expeditionary_corps,
		/obj/item/clothing/suit/armor/vest/expeditionary_corps,
		/obj/item/storage/belt/military/expeditionary_corps,
		/obj/item/clothing/under/rank/expeditionary_corps,
		/obj/item/clothing/shoes/combat/expeditionary_corps,
		/obj/item/modular_computer/tablet/pda/expeditionary_corps,
	)
	/// How many of the contains to put in the crate
	var/num_contained = 3

/datum/supply_pack/misc/vanguard_surplus/fill(obj/structure/closet/crate/filled_crate)
	var/list/contain_copy = contains.Copy()
	for(var/i in 1 to num_contained)
		var/item = pick_n_take(contain_copy)
		new item(filled_crate)
