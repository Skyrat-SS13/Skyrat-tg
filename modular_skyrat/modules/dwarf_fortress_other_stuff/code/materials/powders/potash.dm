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

// potash + sand (clear glass mix)

/datum/material/dwarf_certified/powder/clear_glass_mix
	name = "sandash"
	desc = "A mixture of potash and sand."

	color = "#bb9c9c"
	greyscale_colors = "#bb9c9c"

	sheet_type = /obj/item/stack/dwarf_certified/powder/clear_glass_mix

/obj/item/stack/dwarf_certified/powder/clear_glass_mix
	name = "sandash pile"
	singular_name = "sandash pile"

	desc = "A pile of reddish-grey powder known as 'sandash', which isn't good for much other than making clear glass out of."

	merge_type = /obj/item/stack/dwarf_certified/powder/clear_glass_mix

	mats_per_unit = list(/datum/material/dwarf_certified/powder/clear_glass_mix = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified/powder/clear_glass_mix

/obj/item/stack/dwarf_certified/powder/clear_glass_mix/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/bakeable, /obj/item/stack/dwarf_certified/glass/clear, rand(30 SECONDS, 45 SECONDS), TRUE, TRUE)

/obj/item/stack/dwarf_certified/powder/clear_glass_mix/examine(mob/user)
	. = ..()

	. += span_notice("You could probably <b>bake</b> this into glass.")

/datum/crafting_recipe/clear_glass_mix
	name = "Clear Glass Powder Mix"
	result = /obj/item/stack/dwarf_certified/powder/clear_glass_mix
	reqs = list(
		/obj/item/stack/dwarf_certified/powder/potash = 1,
		/obj/item/stack/dwarf_certified/powder/sand = 1,
	)
	category = CAT_GLASSMAKING
