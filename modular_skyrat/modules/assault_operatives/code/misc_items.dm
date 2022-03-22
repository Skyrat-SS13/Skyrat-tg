/obj/item/storage/bag/medpens
	name = "medpen pouch"
	desc = "A pouch containing several different types of lifesaving medipens."

/obj/item/storage/bag/medpens/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_combined_w_class = 30
	STR.max_items = 4
	STR.display_numerical_stacking = FALSE
	STR.can_hold = typecacheof(list(/obj/item/reagent_containers/hypospray))


/obj/item/storage/bag/medpens/PopulateContents()
	new /obj/item/reagent_containers/hypospray/medipen/oxandrolone(src)
	new /obj/item/reagent_containers/hypospray/medipen/salacid(src)
	new /obj/item/reagent_containers/hypospray/medipen/salbutamol(src)
	new /obj/item/reagent_containers/hypospray/medipen/stimulants(src)
