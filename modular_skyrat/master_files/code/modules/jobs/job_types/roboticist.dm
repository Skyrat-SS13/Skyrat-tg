/datum/outfit/job/roboticist
	backpack = /obj/item/storage/backpack/science/robo
	satchel = /obj/item/storage/backpack/satchel/science/robo
	duffelbag = /obj/item/storage/backpack/duffelbag/science/robo
	messenger = /obj/item/storage/backpack/messenger/science/robo

/datum/job/roboticist
	description = "Build cyborgs, mechs, AIs, and maintain them all. Create MODsuits for those that wish. Try to remind medical that you're \
	actually a lot better at treating synthetic crew members than them."

/datum/job/roboticist/New()
	. = ..()

	mail_goodies += list(
		/obj/item/healthanalyzer/advanced = 15,
		/obj/item/screwdriver/power/science = 6,
		/obj/item/crowbar/power/science = 6,
		/obj/item/weldingtool/experimental = 2, // a lot rarer since its relatively powerful
		/obj/item/scalpel/advanced = 6,
		/obj/item/retractor/advanced = 6,
		/obj/item/cautery/advanced = 6,
		/obj/item/storage/pill_bottle/liquid_solder = 6,
		/obj/item/storage/pill_bottle/system_cleaner = 6,
		/obj/item/storage/pill_bottle/nanite_slurry = 6,
		/obj/item/reagent_containers/spray/hercuri/chilled = 8,
		/obj/item/reagent_containers/spray/dinitrogen_plasmide = 8,
	)
