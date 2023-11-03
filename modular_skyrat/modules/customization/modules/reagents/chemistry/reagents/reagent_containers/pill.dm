// Used by Diabetic quirk
/obj/item/reagent_containers/pill/insulin/diabetic
	desc = "Handles hyperglycemia symptoms caused by excessive blood sugar."
	list_reagents = list(/datum/reagent/medicine/insulin = 10)

/obj/item/reagent_containers/pill/sugar
	name = "sugar pill"
	desc = "Handles hypoglycemia symptoms caused by low blood sugar."
	icon_state = "pill18"
	list_reagents = list(/datum/reagent/consumable/sugar = 10)
	rename_with_volume = TRUE
