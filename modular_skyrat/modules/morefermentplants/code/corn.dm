//Not actually changing the fermentation, but I was given permission to change corn here
/obj/item/food/grown/corn/make_dryable()
	AddElement(/datum/element/dryable, /obj/item/food/grown/corn/dried)

/obj/item/food/grown/corn/dried //Same as normal corn but gives cornmeal when ground up
	grind_results = list(/datum/reagent/consumable/cornmeal = 0)
	color = "#ad7257"
