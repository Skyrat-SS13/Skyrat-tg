/obj/item/modular_computer/pda/centcom
	name = "\improper Centcom PDA"
	starting_programs = list(
		/datum/computer_file/program/crew_manifest,
		/datum/computer_file/program/status,
		/datum/computer_file/program/science,
		/datum/computer_file/program/robocontrol,
		/datum/computer_file/program/budgetorders,
	)
	inserted_item = /obj/item/pen/fountain/captain
	greyscale_colors = "#017941#0060b8"

/obj/item/storage/box/syndie_kit/rnd_server
	name = "R&D server extraction kit"
	desc = "A box containing the equipment and instructions for extracting the hard drive of a Nanotrasen R&D server."

/obj/item/storage/box/syndie_kit/rnd_server/PopulateContents()
	new /obj/item/screwdriver/nuke(src)
	new /obj/item/crowbar/power/syndicate(src) // Let's be a bit generous
	new /obj/item/paper/guides/antag/hdd_extraction(src)


/obj/item/storage/box/red_clothing/PopulateContents()
	new /obj/item/clothing/under/color/red(src)
	new /obj/item/clothing/mask/bandana/red(src)
	new /obj/item/gun/ballistic/automatic/mini_uzi(src)
	new /obj/item/switchblade(src)

/obj/item/storage/box/red_clothing/boss/PopulateContents()
	. = ..()
	new /obj/item/clothing/head/beanie/red(src)
	new /obj/item/storage/briefcase/red_gang(src)


/obj/item/storage/box/blue_clothing/PopulateContents()
	new /obj/item/clothing/under/color/blue(src)
	new /obj/item/clothing/mask/bandana/blue(src)
	new /obj/item/gun/ballistic/automatic/mini_uzi(src)
	new /obj/item/switchblade(src)

/obj/item/storage/box/blue_clothing/boss/PopulateContents()
	. = ..()
	new /obj/item/clothing/head/beanie/darkblue(src)
	new /obj/item/storage/briefcase/blue_gang(src)


/obj/item/storage/briefcase/red_gang
	name = "lockbox of cash"
	desc = "Just by looking at this, you feel like it is absolutely LOADED with money."
	icon_state = "lockbox"
	inhand_icon_state = "lockbox"

/obj/item/storage/briefcase/red_gang/PopulateContents()
	. = ..()
	for(var/i in 1 to 5)
		new /obj/item/stack/spacecash/c1000(src)

/obj/item/storage/briefcase/blue_gang
	name = "lockbox of the goods"
	desc = "Just by looking at this, you feel like it is stuffed with something only known as \"The Goods\"."
	icon_state = "lockbox"
	inhand_icon_state = "lockbox"

/obj/item/storage/briefcase/red_gang/PopulateContents()
	. = ..()
	var/static/list/possible_items = list(
		/obj/item/reagent_containers/cocainebrick,
		/obj/item/reagent_containers/hashbrick,
		/obj/item/reagent_containers/crackbrick,
		/obj/item/reagent_containers/heroinbrick,
		/obj/item/storage/pill_bottle/stimulant,
		/obj/item/storage/box/fireworks/dangerous,
		/obj/item/food/grown/cannabis/ultimate,
	)
	for(var/i in 1 to 7)
		var/obj/picked_item = pick(possible_items)
		new picked_item(src)
