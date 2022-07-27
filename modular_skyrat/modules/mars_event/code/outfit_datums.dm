/datum/outfit/event_colonizer
	name = "Planetary Colonizer"

	id = /obj/item/card/id/advanced/black
	id_trim = /datum/id_trim/centcom/ert/engineer

	uniform = /obj/item/clothing/under/rank/engineering/engineer/skyrat/utility/syndicate
	suit = /obj/item/clothing/suit/hazardvest
	suit_store = /obj/item/tank/internals/oxygen/yellow
	back = /obj/item/mod/control/pre_equipped/event
	backpack_contents = list(
		/obj/item/storage/box/nri_rations = 1,
		/obj/item/construction/rcd/loaded = 1,
		/obj/item/pipe_dispenser = 1,
	)
	belt = /obj/item/storage/belt/utility/full/redtools
	ears = /obj/item/radio/headset/headset_cargo/mining
	glasses = null
	gloves = /obj/item/clothing/gloves/color/chief_engineer
	head = null
	mask = /obj/item/clothing/mask/gas/alt
	neck = null
	shoes = /obj/item/clothing/shoes/combat/expeditionary_corps
	l_pocket = /obj/item/knife/combat/survival
	r_pocket = /obj/item/trench_tool
	l_hand = null
	r_hand = null
	accessory = null
	box = /obj/item/storage/box/expeditionary_survival/event
	internals_slot = ITEM_SLOT_SUITSTORE
	skillchips = list(/obj/item/skillchip/job/engineer)

/datum/outfit/event_colonizer/post_equip(mob/living/carbon/human/human_target, visualsOnly = FALSE)
	var/obj/item/card/id/target_id = human_target.wear_id
	target_id.registered_name = human_target.real_name
	target_id.update_label()
	target_id.update_icon()
	return ..()

/datum/outfit/event_colonizer/leader
	id_trim = /datum/id_trim/centcom/ert/commander
	uniform = /obj/item/clothing/under/rank/centcom/officer
	suit = /obj/item/clothing/suit/armor/vest/marine
	back = /obj/item/mod/control/pre_equipped/event/leader
	backpack_contents = list(
		/obj/item/storage/box/nri_rations = 1,
		/obj/item/construction/rcd/loaded = 1,
		/obj/item/pipe_dispenser = 1,
		/obj/item/megaphone/command = 1,
	)
	ears = /obj/item/radio/headset/headset_cent/alt/with_key

/obj/item/storage/box/expeditionary_survival/event/PopulateContents()
	new /obj/item/clothing/mask/gas/sechailer (src)
	new /obj/item/tank/internals/emergency_oxygen/engi(src)
	new /obj/item/stack/medical/suture(src)
	new /obj/item/stack/medical/ointment(src)
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/flashlight/flare(src)
	new /obj/item/reagent_containers/food/drinks/flask/event(src)

/obj/item/reagent_containers/food/drinks/flask/event
	name = "emergency flask"
	desc = "Contains a sizeable amount of some popular vitamin water brand to give you that little extra boost when the going gets tough."
	list_reagents = list(
		/datum/reagent/consumable/sugar = 10,
		/datum/reagent/drug/methamphetamine = 2,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/water = 40
	)

/obj/item/storage/belt/utility/full/redtools
	icon_state = "explorer2"
	inhand_icon_state = "explorer2"
	worn_icon_state = "explorer2"

/obj/item/storage/belt/utility/full/redtools/PopulateContents()
	SSwardrobe.provide_type(/obj/item/screwdriver/caravan, src)
	SSwardrobe.provide_type(/obj/item/wrench/caravan, src)
	SSwardrobe.provide_type(/obj/item/weldingtool/advanced, src)
	SSwardrobe.provide_type(/obj/item/crowbar/red/caravan, src)
	SSwardrobe.provide_type(/obj/item/wirecutters/caravan, src)
	SSwardrobe.provide_type(/obj/item/multitool, src)
	SSwardrobe.provide_type(/obj/item/stack/cable_coil, src)

/obj/item/storage/belt/utility/full/redtools/get_types_to_preload()
	var/list/to_preload = list() //Yes this is a pain. Yes this is the point
	to_preload += /obj/item/screwdriver/caravan
	to_preload += /obj/item/wrench/caravan
	to_preload += /obj/item/weldingtool/advanced
	to_preload += /obj/item/crowbar/red/caravan
	to_preload += /obj/item/wirecutters/caravan
	to_preload += /obj/item/multitool
	to_preload += /obj/item/stack/cable_coil
	return to_preload
