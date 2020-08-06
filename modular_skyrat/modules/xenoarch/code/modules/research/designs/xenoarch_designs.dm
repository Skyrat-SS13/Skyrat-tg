//Research DESIGNS
//Tool Designs

/datum/design/xenoarch
	name = "parent design"
	desc = "You shouldn't be able to see this."
	id = "parentxenoarch"
	build_type = PROTOLATHE
	materials = list(/datum/material/plastic = 500)
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/xenoarch/hammercm1
	name = "Hammer cm1"
	desc = "A hammer that destroys 1 cm of debris."
	id = "hammercm1"
	build_path = /obj/item/xenoarch/clean/hammer/cm1

/datum/design/xenoarch/hammercm2
	name = "Hammer cm2"
	desc = "A hammer that destroys 2 cm of debris."
	id = "hammercm2"
	build_path = /obj/item/xenoarch/clean/hammer/cm2

/datum/design/xenoarch/hammercm3
	name = "Hammer cm3"
	desc = "A hammer that destroys 3 cm of debris."
	id = "hammercm3"
	build_path = /obj/item/xenoarch/clean/hammer/cm3

/datum/design/xenoarch/hammercm4
	name = "Hammer cm4"
	desc = "A hammer that destroys 4 cm of debris."
	id = "hammercm4"
	build_path = /obj/item/xenoarch/clean/hammer/cm4

/datum/design/xenoarch/hammercm5
	name = "Hammer cm5"
	desc = "A hammer that destroys 5 cm of debris."
	id = "hammercm5"
	build_path = /obj/item/xenoarch/clean/hammer/cm5

/datum/design/xenoarch/hammercm6
	name = "Hammer cm6"
	desc = "A hammer that destroys 6 cm of debris."
	id = "hammercm6"
	build_path = /obj/item/xenoarch/clean/hammer/cm6

/datum/design/xenoarch/hammercm15
	name = "Hammer cm15"
	desc = "A hammer that destroys 15 cm of debris."
	id = "hammercm15"
	build_path = /obj/item/xenoarch/clean/hammer/cm15

/datum/design/xenoarch/hammercmadv
	name = "Advanced Hammer"
	desc = "A hammer that destroys up to 30 cm of debris."
	id = "hammercmadv"
	materials = list(/datum/material/plastic = 1500)
	build_path = /obj/item/xenoarch/clean/hammer/advanced

/datum/design/xenoarch/cleanbrush
	name = "Brush"
	desc = "A brush that cleans debris."
	id = "hammerbrush"
	build_path = /obj/item/xenoarch/clean/brush/basic

/datum/design/xenoarch/cleanbrushadv
	name = "Advanced Brush"
	desc = "A brush that cleans debris."
	id = "hammerbrushadv"
	materials = list(/datum/material/plastic = 1500)
	build_path = /obj/item/xenoarch/clean/brush/adv

/datum/design/xenoarch/xenomeasure
	name = "Measuring Tape"
	desc = "A tool to measure the dug depth of rocks."
	id = "xenomeasure"
	build_path = /obj/item/xenoarch/help/measuring

/datum/design/xenoarch/xenominingscanner
	name = "Xenoarchaeology Mining Scanner"
	desc = "A tool to measure the dug depth of rocks."
	id = "xenominingscanner"
	build_path = /obj/item/t_scanner/adv_mining_scanner/xenoarch

//Storage Designs

/datum/design/xenoarch/xenobelt
	name = "Xenoarchaeology Belt"
	desc = "A belt used to store some xenoarch tools."
	id = "xenobelt"
	materials = list(/datum/material/plastic = 2000)
	build_path = /obj/item/storage/belt/xenoarch

/datum/design/xenoarch/xenorockback
	name = "Xenoarchaeology Strange Rock Bag"
	desc = "A bag used to store 10 strange rocks."
	id = "xenorockback"
	materials = list(/datum/material/plastic = 2000)
	build_path = /obj/item/storage/bag/strangerock

/datum/design/xenoarch/xenorockbackadv
	name = "Xenoarchaeology Bluespace Strange Rock Bag"
	desc = "A bluespace bag used to store 50 strange rocks."
	id = "xenorockbackadv"
	materials = list(/datum/material/plastic = 2000, /datum/material/bluespace = 1000)
	build_path = /obj/item/storage/bag/strangerock/adv

//Machine Designs

/datum/design/board/xenoarch
	name = "Machine Design (Strange Rock)"
	desc = "The circuit board for an Strange Rock."
	id = "strangerock"
	build_path = /obj/item/circuitboard/machine/experimentor
	category = list("Research Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/xenoarch/scanner
	name = "Machine Design (Strange Rock Scanner)"
	desc = "The circuit board for an Strange Rock Scanner."
	id = "xenoarchscanner"
	build_path = /obj/item/circuitboard/machine/xenoarch/scanner

/datum/design/board/xenoarch/openner
	name = "Machine Design (Strange Rock Openner)"
	desc = "The circuit board for an Strange Rock Openner."
	id = "xenoarchopenner"
	build_path = /obj/item/circuitboard/machine/xenoarch/openner

/datum/design/board/xenoarch/recycler
	name = "Machine Design (Strange Rock Recycler)"
	desc = "The circuit board for an Strange Rock Recycler."
	id = "xenoarchrecycler"
	build_path = /obj/item/circuitboard/machine/xenoarch/recycler
