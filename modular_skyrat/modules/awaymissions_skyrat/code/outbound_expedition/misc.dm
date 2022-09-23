/obj/effect/mob_spawn/corpse/human/prisoner
	name = "Prisoner"
	outfit = /datum/outfit/job/prisoner
	icon_state = "corpseminer"

/obj/effect/mob_spawn/corpse/human/clock_cultist
	name = "Clock Cultist"
	outfit = /datum/outfit/clock_cultist/corpse
	icon_state = "corpseminer"

/datum/outfit/clock_cultist/corpse/post_equip(mob/living/carbon/human/equipped, visualsOnly)
	. = ..()
	equipped.faction |= "clock"

/obj/effect/mob_spawn/corpse/human/blood_cultist
	name = "Blood Cultist"
	outfit = /datum/outfit/cultist/corpse
	icon_state = "corpseminer"

/datum/outfit/cultist/corpse
	name = "Cultist (Corpse)"
	r_hand = null

/obj/item/storage/box/stockparts/advanced
	name = "box of stock parts"
	desc = "Contains a variety of advanced stock parts."

/obj/item/storage/box/stockparts/advanced/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stock_parts/capacitor/adv = 3,
		/obj/item/stock_parts/scanning_module/adv = 3,
		/obj/item/stock_parts/manipulator/nano = 3,
		/obj/item/stock_parts/micro_laser/high = 3,
		/obj/item/stock_parts/matter_bin/adv = 3)
	generate_items_inside(items_inside, src)

/obj/machinery/suit_storage_unit/standard_unit/with_jetpack
	storage_type = /obj/item/tank/jetpack/oxygen
