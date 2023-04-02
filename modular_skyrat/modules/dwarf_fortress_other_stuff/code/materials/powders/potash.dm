/datum/material/dwarf_certified/powder/potash
	name = "potash"
	desc = "Often just ash out of a pot (as the name might imply)."

	color = "#ffabab"
	greyscale_colors = "#ffabab"

	sheet_type = /obj/item/stack/dwarf_certified/powder/potash

/obj/item/stack/dwarf_certified/powder/potash
	name = "potash pile"
	singular_name = "potash pile"

	desc = "A pile of reddish tinted powder known as 'potash', its origin being from a pot or not has nothing to do with the fact this is basically just potassium powder."

	merge_type = /obj/item/stack/dwarf_certified/powder/potash

	mats_per_unit = list(/datum/material/dwarf_certified/powder/potash = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified/powder/potash
