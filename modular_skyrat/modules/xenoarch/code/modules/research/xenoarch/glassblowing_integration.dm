/obj/item/glassblowing/magnifying_glass
	name = "magnifying glass"
	desc = "A tool that, with the assistance of a magnifying lens, allows you to view what is small."
	icon_state = "magnifying_glass"

/datum/crafting_recipe/magnifying_glass
	name = "Magnifying Glass"
	result = /obj/item/glassblowing/magnifying_glass
	reqs = list(
		/obj/item/stack/sheet/mineral/wood = 1,
		/obj/item/glassblowing/glass_lens = 1,
	)
	category = CAT_PRIMAL
