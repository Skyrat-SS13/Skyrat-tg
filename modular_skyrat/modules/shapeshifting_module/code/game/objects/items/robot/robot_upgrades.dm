/obj/item/borg/upgrade/borg_shapeshifter
	name = "Cyborg Shapeshifter Module"
	desc = "An experimental device which allows a cyborg to disguise themself into another type of cyborg."
	icon_state = "cyborg_upgrade3"

/obj/item/borg/upgrade/borg_shapeshifter/action(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if(.)
		var/obj/item/borg_shapeshifter/BS = new /obj/item/borg_shapeshifter(R.model)
		R.model.basic_modules += BS
		R.model.add_module(BS, FALSE, TRUE)

/obj/item/borg/upgrade/borg_shapeshifter/deactivate(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if (.)
		for(var/obj/item/borg_shapeshifter/BS in R.model)
			R.model.remove_module(BS, TRUE)
