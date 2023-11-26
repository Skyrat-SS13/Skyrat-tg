/datum/techweb_node/base/New()
	. = ..()
	design_ids += "blanksynth"

/datum/design/synthclone
	name = "Blank synthetic shell"
	id = "blanksynth"
	build_type = MECHFAB
	construction_time = 60 SECONDS
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 20,
					/datum/material/glass = SHEET_MATERIAL_AMOUNT * 10,
					/datum/material/silver = SHEET_MATERIAL_AMOUNT * 0.5,
					/datum/material/gold = SHEET_MATERIAL_AMOUNT * 0.25)
	category = list(RND_CATEGORY_MECHFAB_SYNTH + RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS)

	build_path = /mob/living/carbon/human/species/synth/empty
