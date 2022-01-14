//useless relics
/obj/item/xenoarch/useless_relic
	name = "useless relic"
	desc = "A useless relic that can be redeemed for cargo or research points."

/obj/item/xenoarch/useless_relic/Initialize()
	. = ..()
	icon_state = "useless[rand(1,8)]"

/datum/export/xenoarch/useless_relic
	cost = CARGO_CRATE_VALUE*2
	unit_name = "xenoarch item"
	export_types = list(/obj/item/xenoarch/useless_relic)

/datum/export/xenoarch/useless_relic/sell_object(obj/O, datum/export_report/report, dry_run, apply_elastic = FALSE) //I really dont want them to feel gimped
	. = ..()

//broken items
/obj/item/xenoarch/broken_item
	name = "broken item"
	desc = "An item that has been damaged, destroyed for quite some time. It is possible to recover it."

/obj/item/xenoarch/broken_item/tech
	name = "broken tech"
	icon_state = "recover_tech"

/obj/item/xenoarch/broken_item/weapon
	name = "broken weapon"
	icon_state = "recover_weapon"

/obj/item/xenoarch/broken_item/illegal
	name = "broken unknown object"
	icon_state = "recover_illegal"

/obj/item/xenoarch/broken_item/alien
	name = "broken unknown object"
	icon_state = "recover_illegal"

/obj/item/xenoarch/broken_item/plant
	name = "withered plant"
	desc = "A plant that is long past its prime. It is possible to recover it."
	icon_state = "recover_plant"

/obj/item/xenoarch/broken_item/animal
	name = "preserved animal carcass"
	desc = "An animal that is long past its prime. It is possible to recover it. Can be swabbed to recover its original animal's remnant DNA."
	icon_state = "recover_animal"

/obj/item/xenoarch/broken_item/animal/Initialize()
	. = ..()
	var/pick_celltype = pick(CELL_LINE_TABLE_BEAR,
							CELL_LINE_TABLE_BLOBBERNAUT,
							CELL_LINE_TABLE_BLOBSPORE,
							CELL_LINE_TABLE_CARP,
							CELL_LINE_TABLE_CAT,
							CELL_LINE_TABLE_CHICKEN,
							CELL_LINE_TABLE_COCKROACH,
							CELL_LINE_TABLE_CORGI,
							CELL_LINE_TABLE_COW,
							CELL_LINE_TABLE_MOONICORN,
							CELL_LINE_TABLE_GELATINOUS,
							CELL_LINE_TABLE_GRAPE,
							CELL_LINE_TABLE_MEGACARP,
							CELL_LINE_TABLE_MOUSE,
							CELL_LINE_TABLE_PINE,
							CELL_LINE_TABLE_PUG,
							CELL_LINE_TABLE_SLIME,
							CELL_LINE_TABLE_SNAKE,
							CELL_LINE_TABLE_VATBEAST,
							CELL_LINE_TABLE_NETHER,
							CELL_LINE_TABLE_GLUTTON,
							CELL_LINE_TABLE_FROG,
							CELL_LINE_TABLE_WALKING_MUSHROOM,
							CELL_LINE_TABLE_QUEEN_BEE,
							CELL_LINE_TABLE_LEAPER,
							CELL_LINE_TABLE_MEGA_ARACHNID)
	AddElement(/datum/element/swabable, pick_celltype, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)

/obj/item/xenoarch/broken_item/clothing
	name = "petrified clothing"
	desc = "A piece of clothing that has long since lost its beauty."
	icon_state = "recover_clothing"

/datum/export/xenoarch/broken_item
	cost = CARGO_CRATE_VALUE*5
	unit_name = "broken object"
	export_types = list(/obj/item/xenoarch/broken_item)
	include_subtypes = TRUE

//circuit boards
/obj/item/circuitboard/machine/xenoarch_researcher
	name = "Xenoarch Researcher (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/xenoarch/researcher
	req_components = list(
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stack/cable_coil = 2,
		/obj/item/stack/sheet/glass = 2)
	needs_anchored = TRUE

/obj/item/circuitboard/machine/xenoarch_scanner
	name = "Xenoarch Scanner (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/xenoarch/scanner
	req_components = list(
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stack/cable_coil = 2,
		/obj/item/stack/sheet/glass = 2)
	needs_anchored = TRUE

/obj/item/circuitboard/machine/xenoarch_recoverer
	name = "Xenoarch Recoverer (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/xenoarch/recoverer
	req_components = list(
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stack/cable_coil = 2,
		/obj/item/stack/sheet/glass = 2)
	needs_anchored = TRUE

/obj/item/paper/fluff/xenoarch_guide
	name = "xenoarchaeology guide - MUST READ"
	info = {"<b><center>Xenoarchaeology Guide</center></b><br> \
			Let's start right from the beginning: what is Xenoarchaeology?<br> \
			Great question! Xenoarchaeology is the study of ancient foreign bodies that are trapped within strange rocks.<br> \
			Your goal as a xenoarchaeologist is to find these strange rocks and unearth the secrets that are held within.<br> \
			You will find that these rocks are plentiful throughout the astronomical bodies that we typically orbit.<br> \
			<br> \
			<b>Tools of the Trade</b><br> \
			<br> \
			There are plenty of tools that are required (and some just for the quality of life for the xenoarchaeologist).<br> \
			There are the hammers, the brushes, the tape, the belt, the bag, the handheld machines, and the machines.<br> \
			In this line of work, the brushes and hammers will be the bread and butter.<br> \
			They will allow you to unearth the foreign bodies held within the strange rocks.<br> \
			The hammers (with varying depths) allow you to reach the depths in a faster manner than the brushes.<br> \
			The brushes allow you to uncover the items within the proper depths without damaging it.<br> \
			The tape will allow you to tag the strange rock with the current depth. Continue to examine the rock for updates.<br> \
			The belt will allow you to store your mobile/handheld tools for easy access.<br> \
			The bag will allow you to store and automatically pickup strange rocks that you find lying on the floor.<br> \
			The handheld machines allow you to not have to be stuck at the machines. There are only handheld scanners and recoverers.<br> \
			The Scanner is a machine which allows you to tag the strange rock with its max and safe depth.<br> \
			The Researcher is a machine that allows you to compile/condense relics and items into larger strange artifacts.<br> \
			The Recoverer is a machine that allows you to recover long lost objects from broken items.<br> \
			<br> \
			<b>The Process</b><br> \
			<br> \
			1) Find yourself a strange rock out in the wilderness.<br> \
			2) Go back (or stay) to the xenoarchaeology labratory.<br> \
			3) Process the rock in the scanner (or use the handheld scanner).<br> \
			4) Use the measuring tape on the rock.<br> \
			5) Subtract the safe depth (SD) from the max depth (MD).<br> \
				5a) QUESTION: What is the depth you dig <i>to</i> when the MD is 50 and the SD is 16?<br> \
					ANSWER: 34. Just make sure to not dig 34 as there will be previous depth involved.<br> \
			6) Subtract the current depth (CD) from the answer to step 5.<br> \
			7) Use the hammers to dig the answer to step 6.<br> \
			8) Once you've reached the answer to step 5, use the brush until you reveal the item.<br> \
			9) Enjoy the use of your unearthed secret!<br> \
				9a) If it is a useless relic, sell it or use it in the Researcher for a surprise.<br> \
				9b) If it is a broken item, sell it or use it in the Recoverer for a surprise.<br> \
			<br> \
			I hope this has been helpful and I wish you great success!<br> \
			<br> \
			<i>- KB</i><br> \
			Director of Xenoarchaeological Studies"}
