/datum/job/expeditionary_trooper
	title = "Vanguard Operative"
	department_head = list("Captain")
	faction = "Station"
	total_positions = 4
	spawn_positions = 4
	supervisors = "the captain"
	selection_color = "#ffeeff"
	minimal_player_age = 40
	exp_requirements = 400
	exp_type = EXP_TYPE_SCIENCE

	outfit = /datum/outfit/job/expeditionary_trooper

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SCI

	display_order = JOB_DISPLAY_ORDER_EXP_CORPS
	bounty_types = CIV_JOB_SCI

	family_heirlooms = list(/obj/item/binoculars)

	veteran_only = TRUE

/datum/job/expeditionary_trooper/after_spawn(mob/living/carbon/human/H, mob/M)
	. = ..()
	to_chat(M, "<span class='redtext'>As a Vanguard Operative you are not part of security! You must not perform security duties unless absolutely nessecary. \
	Do not valid hunt using your equipment. Use common sense. Failure to follow these simple rules will result in a job ban.")

/datum/outfit/job/expeditionary_trooper
	name = "Vanguard Operative"
	jobtype = /datum/job/expeditionary_trooper

	shoes = /obj/item/clothing/shoes/combat/expeditionary_corps
	ears = /obj/item/radio/headset/headset_sci
	uniform = /obj/item/clothing/under/rank/expeditionary_corps
	glasses = /obj/item/clothing/glasses/sunglasses/big

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	box = /obj/item/storage/box/survival/expeditionary_corps

	backpack_contents = list(/obj/item/choice_beacon/exp_corps_equip)

	id = /obj/item/card/id/advanced/silver/exp_corps
	id_trim = /datum/id_trim/job/expeditionary_trooper

	belt = /obj/item/pda/expeditionary_corps

/obj/effect/landmark/start/expeditionary_corps
	name = "Vanguard Operative"
	icon_state = "Security Officer"

/obj/item/pda/expeditionary_corps
	greyscale_colors = "#891417#000099"
	name = "Military PDA"

/obj/item/storage/box/survival/expeditionary_corps
	mask_type = /obj/item/clothing/mask/gas/alt

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
	new /obj/item/reagent_containers/food/drinks/waterbottle(src)
	new /obj/item/reagent_containers/blood/universal(src)
	new /obj/item/reagent_containers/syringe(src)
	new /obj/item/storage/pill_bottle/multiver(src)

/obj/item/choice_beacon/exp_corps_equip
	name = "Vanguard Operatives Supply Beacon"
	desc = "Used to request your job supplies, use in hand to do so!"
	icon = 'icons/obj/device.dmi'
	icon_state = "gangtool-red"
	inhand_icon_state = "radio"

/obj/item/choice_beacon/exp_corps_equip/generate_display_names()
	var/static/list/exp_crates
	if(!exp_crates)
		exp_crates = list()
		var/list/templist = typesof(/obj/structure/closet/crate/secure/exp_corps)
		for(var/iterating_crate in templist)
			var/obj/structure/closet/crate/secure/exp_corps/our_crate = iterating_crate
			exp_crates[initial(our_crate.name)] = our_crate
	return exp_crates

/obj/item/card/id/advanced/silver/exp_corps
	wildcard_slots = WILDCARD_LIMIT_CENTCOM

/obj/structure/closet/crate/secure/exp_corps
	name = "expeditionary gear crate"
	desc = "A secure crate, for Expeditionary Corps only!"
	icon_state = "expcrate"
	icon = 'modular_skyrat/modules/exp_corps/icons/exp_crate.dmi'
	req_access = list(ACCESS_GATEWAY, ACCESS_CENT_GENERAL)
	max_integrity = 5000
	var/loadout_name = "Standard"


/obj/structure/closet/crate/secure/exp_corps/testa
	name = "Test1"
	loadout_name = "Standard 1"

/obj/structure/closet/crate/secure/exp_corps/testb
	name = "Test2"
	loadout_name = "Standard 2"

/obj/structure/closet/crate/secure/exp_corps/PopulateContents()
	new /obj/item/storage/firstaid/tactical(src)
	new /obj/item/storage/box/expeditionary_survival(src)
	new /obj/item/clothing/suit/space/hardsuit/expeditionary_corps(src)
	new /obj/item/radio(src)
	new /obj/item/melee/tomahawk(src)
	new /obj/item/clothing/gloves/combat/expeditionary_corps(src)
	new /obj/item/clothing/head/helmet/expeditionary_corps(src)
	new /obj/item/clothing/suit/armor/vest/expeditionary_corps(src)
	new /obj/item/storage/belt/military/expeditionary_corps(src)
	new /obj/item/storage/backpack/duffelbag/expeditionary_corps(src)
