// Insulin bottles used by Diabetic quirk.
/obj/item/storage/pill_bottle/insulin
	desc = "Contains pills used to treat hyperglycemic shock."

/obj/item/storage/pill_bottle/insulin/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/pill/insulin(src)

// Contains 4 insulin pills instead of 7, and 10u pills instead of 50u.
/obj/item/storage/pill_bottle/insulin/diabetic
	desc = "Contains diluted pills used to treat hyperglycemia. Take one to reduce excessive blood sugar."

/obj/item/storage/pill_bottle/insulin/diabetic/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/pill/insulin/diabetic(src)

/obj/item/storage/pill_bottle/sugar
	desc = "Contains diluted pills used to treat hypoglycemia. Take one to treat low blood sugar."

/obj/item/storage/pill_bottle/sugar/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/pill/sugar(src)
