/obj/item/storage/backpack/satchel/flat/PopulateContents()
	var/contraband_list = list(
		/obj/item/storage/belt/utility/syndicate = 1,
		/obj/item/storage/toolbox/syndicate = 7,
		/obj/item/card/id/advanced/chameleon = 6,
		/obj/item/stack/spacecash/c5000 = 3,
		/obj/item/stack/telecrystal = 2,
		/obj/item/storage/belt/military = 12,
		/obj/item/storage/fancy/cigarettes/cigpack_syndicate = 8,
		/obj/item/storage/box/fireworks/dangerous = 11,
		/obj/item/clothing/mask/gas/syndicate = 10,
		/obj/item/vending_refill/donksoft = 13,
		/obj/item/ammo_box/foambox/riot = 11,
		/obj/item/soap/syndie = 7,
		/obj/item/reagent_containers/crackbrick = 5,
		/obj/item/reagent_containers/crack = 10,
		/obj/item/reagent_containers/cocaine = 9,
		/obj/item/reagent_containers/cocainebrick = 4,
		/obj/item/reagent_containers/hashbrick = 13, //not contraband, but it'll be good padding, and there'll still be a black market for bulk goods
		/obj/item/reagent_containers/heroin = 8,
		/obj/item/reagent_containers/heroinbrick = 3,
		/obj/item/reagent_containers/blacktar = 12,
		/obj/item/storage/pill_bottle/stimulant = 9, //ephedrine and coffee. Can actually change whether someone gets out of a runaway situation
		/obj/item/clothing/cigarette/pipe/crackpipe = 15,
		/obj/item/toy/cards/deck/syndicate = 10, //1tc, not balance breaking, small but premium commodity
		/obj/item/reagent_containers/cup/bottle/morphine = 8,
		/obj/item/reagent_containers/syringe/contraband/methamphetamine = 12,
		/obj/item/clothing/glasses/sunglasses = 5, //can already be achieved in an arguably better form with just some hacking
	)

	for(var/i in 1 to 3)
		var/contraband_type = pick_weight(contraband_list)
		contraband_list -= contraband_type
		new contraband_type(src)

/obj/item/storage/backpack/satchel/flat/with_tools/PopulateContents()
	new /obj/item/stack/tile/iron/base(src)
	new /obj/item/crowbar(src)

/*
 * Messenger Bag Types
 */

/obj/item/storage/backpack/messenger
	name = "messenger bag"
	desc = "A trendy looking messenger bag; sometimes known as a courier bag. Fashionable and portable."
	icon_state = "messenger"
	inhand_icon_state = "messenger"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_righthand.dmi'

/obj/item/storage/backpack/messenger/eng
	name = "industrial messenger bag"
	desc = "A tough messenger bag made of advanced treated leather for fireproofing. It also has more pockets than usual."
	icon_state = "messenger_engineering"
	inhand_icon_state = "messenger_engineering"
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/messenger/med
	name = "medical messenger bag"
	desc = "A sterile messenger bag well loved by medics for its portability and sleek profile."
	icon_state = "messenger_medical"
	inhand_icon_state = "messenger_medical"

/obj/item/storage/backpack/messenger/vir
	name = "virologist messenger bag"
	desc = "A sterile messenger bag with virologist colours, useful for deploying biohazards in record times."
	icon_state = "messenger_virology"
	inhand_icon_state = "messenger_virology"

/obj/item/storage/backpack/messenger/chem
	name = "chemist messenger bag"
	desc = "A sterile messenger bag with chemist colours, good for getting to your alleyway deals on time."
	icon_state = "messenger_chemistry"
	inhand_icon_state = "messenger_chemistry"

/obj/item/storage/backpack/messenger/coroner
	name = "coroner messenger bag"
	desc = "A messenger bag used to sneak your way out of graveyards at a good pace."
	icon_state = "messenger_coroner"
	inhand_icon_state = "messenger_coroner"

/obj/item/storage/backpack/messenger/gen
	name = "geneticist messenger bag"
	desc = "A sterile messenger bag with geneticist colours, making a remarkably cute accessory for hulks."
	icon_state = "messenger_genetics"
	inhand_icon_state = "messenger_genetics"

/obj/item/storage/backpack/messenger/science
	name = "scientist messenger bag"
	desc = "Useful for holding research materials, and for speeding your way to different scan objectives."
	icon_state = "messenger_science"
	inhand_icon_state = "messenger_science"

/obj/item/storage/backpack/messenger/hyd
	name = "botanist messenger bag"
	desc = "A messenger bag made of all natural fibers, great for getting to the sesh in time."
	icon_state = "messenger_hydroponics"
	inhand_icon_state = "messenger_hydroponics"

/obj/item/storage/backpack/messenger/sec
	name = "security messenger bag"
	desc = "A robust messenger bag for security related needs."
	icon_state = "messenger_security_black"
	inhand_icon_state = "messenger_security_black"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "messenger_security_black",
			RESKIN_WORN_ICON_STATE = "messenger_security_black",
			RESKIN_INHAND_STATE = "messenger_security_black",
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "messenger_security_white",
			RESKIN_WORN_ICON_STATE = "messenger_security_white",
			RESKIN_INHAND_STATE = "messenger_security_white",
		),
	)

/obj/item/storage/backpack/messenger/explorer
	name = "explorer messenger bag"
	desc = "A robust messenger bag for stashing your loot, as well as making a remarkably cute accessory for your drakebone armor."
	icon_state = "messenger_explorer"
	inhand_icon_state = "messenger_explorer"

/obj/item/storage/backpack/messenger/cap
	name = "captain's messenger bag"
	desc = "An exclusive messenger bag for NanoTrasen officers, made of real whaleleather."
	icon_state = "messenger_captain"
	inhand_icon_state = "messenger_captain"

/obj/item/storage/backpack/messenger/head_of_personnel
	name = "head of personnel's messenger bag"
	desc = "A exclusive messenger bag issued to Nanotrasen's finest second, with great storage space for all that paperwork you have planned."
	icon_state = "messenger_hop"
	inhand_icon_state = "messenger_hop"

/obj/item/storage/backpack/messenger/blueshield
	name = "blueshield's messenger bag'"
	desc = "A robust messenger bag issued to Nanotrasen's finest guard dogs, with extra TACTICAL POCKETS. Whatever that even means."
	icon_state = "messenger_blueshield"
	inhand_icon_state = "messenger_blueshield"

/obj/item/storage/backpack/messenger/science/robo
	name = "robotics messenger bag"
	desc = "A sleek, industrial-strength messenger bag issued to robotics personnel. Smells faintly of oil; a fashionably mobile choice for fashionably sedentary mechanics."
	icon_state = "messenger_robo"
	inhand_icon_state = "messenger_robo"

/obj/item/storage/backpack/messenger/clown
	name = "Giggles von Honkerton Jr."
	desc = "The latest in storage 'technology' from Honk Co. Hey, how does this fit so much with such a small profile anyway? The wearer will definitely never tell you."
	icon_state = "messenger_clown"
	inhand_icon_state = "messenger_clown"
