/obj/item/advanced_choice_beacon/nri
	name = "\improper NRI Defense Colleague supply beacon"
	desc = "Used to request your job supplies, use in hand to do so!"

	possible_choices = list(
		/obj/structure/closet/crate/secure/weapon/nri/marksman,
		/obj/structure/closet/crate/secure/weapon/nri/pointman,
		/obj/structure/closet/crate/secure/weapon/nri/field_medic,
		/obj/structure/closet/crate/secure/weapon/nri/combat_tech
	)

/obj/item/advanced_choice_beacon/nri/get_available_options()
	var/list/options = list()
	for(var/iterating_choice in possible_choices)
		var/obj/structure/closet/crate/secure/exp_corps/our_crate = iterating_choice
		var/datum/radial_menu_choice/option = new
		option.image = image(icon = initial(our_crate.icon), icon_state = initial(our_crate.icon_state))
		option.info = span_boldnotice("[initial(our_crate.loadout_desc)]")

		options[our_crate] = option

	sort_list(options)

	return options

/obj/structure/closet/crate/secure/weapon/nri
	name = "military supplies crate"
	desc = "A secure military-grade crate. According to the markings, -as well as mixed Cyrillics-, it was shipped and provided by the NRI Defense Colleague."
	req_access = list(ACCESS_CENT_GENERAL)

//base, don't use this, but leaving it for admin spawns is probably a good call?
/obj/structure/closet/crate/secure/weapon/nri/PopulateContents()
	new /obj/item/storage/medkit/tactical(src)
	new /obj/item/storage/box/expeditionary_survival(src)
	new /obj/item/radio(src)
	new /obj/item/melee/tomahawk(src)
	new /obj/item/clothing/gloves/color/black/expeditionary_corps(src)
	new /obj/item/clothing/head/helmet/expeditionary_corps(src)
	new /obj/item/clothing/suit/armor/vest/expeditionary_corps(src)
	new /obj/item/storage/belt/military/expeditionary_corps(src)
	new /obj/item/storage/backpack/duffelbag/expeditionary_corps(src)

//shield guy
/obj/structure/closet/crate/secure/weapon/nri/PopulateContents()
	new /obj/item/storage/medkit/regular(src)
	new /obj/item/storage/box/expeditionary_survival(src)
	new /obj/item/radio(src)
	new /obj/item/melee/tomahawk(src)
	new /obj/item/clothing/gloves/color/black/expeditionary_corps(src)
	new /obj/item/clothing/head/helmet/expeditionary_corps(src)
	new /obj/item/clothing/suit/armor/vest/expeditionary_corps(src)
	new /obj/item/storage/belt/military/expeditionary_corps/pointman(src)
	new /obj/item/storage/backpack/duffelbag/expeditionary_corps(src)
	new /obj/item/shield/riot/pointman(src)

//medic
/obj/structure/closet/crate/secure/weapon/nri/PopulateContents()
	new /obj/item/storage/medkit/expeditionary(src)
	new /obj/item/storage/box/expeditionary_survival(src)
	new /obj/item/radio(src)
	new /obj/item/clothing/gloves/color/latex/nitrile/expeditionary_corps(src)
	new /obj/item/clothing/head/helmet/expeditionary_corps(src)
	new /obj/item/clothing/suit/armor/vest/expeditionary_corps(src)
	new /obj/item/storage/belt/military/expeditionary_corps/field_medic(src)
	new /obj/item/storage/backpack/duffelbag/expeditionary_corps(src)
	new /obj/item/healthanalyzer(src)

//engineer gaming
/obj/structure/closet/crate/secure/weapon/nri/PopulateContents()
	new /obj/item/storage/medkit/emergency(src)
	new /obj/item/storage/box/expeditionary_survival(src)
	new /obj/item/radio(src)
	new /obj/item/melee/tomahawk(src)
	new /obj/item/clothing/gloves/color/chief_engineer/expeditionary_corps(src)
	new /obj/item/clothing/head/helmet/expeditionary_corps(src)
	new /obj/item/clothing/suit/armor/vest/expeditionary_corps(src)
	new /obj/item/storage/belt/military/expeditionary_corps/combat_tech(src)
	new /obj/item/storage/backpack/duffelbag/expeditionary_corps(src)
	new /obj/item/skillchip/job/engineer(src)
	new /obj/item/storage/bag/material(src)

//edgy loner with knives AND A FUKKEN gun
/obj/structure/closet/crate/secure/weapon/nri/PopulateContents()
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
