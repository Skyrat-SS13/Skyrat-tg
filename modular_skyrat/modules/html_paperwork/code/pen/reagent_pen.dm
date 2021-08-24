/obj/item/pen/sleepy
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE  // Skyrat edit
	special_desc = "A Armour piercing syringe concealed in a pen , used by the Syndicate in covert operations."  // Skyrat edit

/obj/item/pen/sleepy/attack(mob/living/M, mob/user, params)
	. = ..()
	if(!.)
		return
	if(!reagents.total_volume)
		return
	if(!M.reagents)
		return
	reagents.trans_to(M, reagents.total_volume, transfered_by = user, methods = INJECT)


/obj/item/pen/sleepy/Initialize()
	. = ..()
	create_reagents(45, OPENCONTAINER)
	reagents.add_reagent(/datum/reagent/toxin/chloralhydrate, 20)
	reagents.add_reagent(/datum/reagent/toxin/mutetoxin, 15)
	reagents.add_reagent(/datum/reagent/toxin/staminatoxin, 10)
