/datum/design/borg_snack_dispensor
	name = "Cyborg Upgrade (Snack Dispensor)"
	id = "borg_upgrade_snacks"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/snack_dispensor
	materials = list(/datum/material/iron = 700, /datum/material/glass = 500)
	construction_time = 10
	category = list("Cyborg Upgrade Modules")

/obj/item/borg/upgrade/snack_dispensor
	name = "Borg Snack Dispensor"
	desc = "Gives any borg the ability to dispense speciality snacks."

/obj/item/borg/upgrade/snack_dispensor/action(mob/living/silicon/robot/R, user)
	. = ..()
	if(.)
		var/obj/item/borg_snack_dispensor/snack_dispensor = new /obj/item/borg_snack_dispensor(R.model)
		R.model.basic_modules += snack_dispensor
		R.model.add_module(snack_dispensor, FALSE, TRUE)

/obj/item/borg/upgrade/snack_dispensor/deactivate(mob/living/silicon/robot/R, user)
	. = ..()
	if(!.)
		return
	for(var/obj/item/borg_snack_dispensor/dispensor in R.model)
		R.model.remove_module(dispensor, TRUE)

/obj/item/borg_snack_dispensor
	name = "\improper Automated Snack Dispensor"
	desc = "Has the ability to automatically print many differnt forms of snacks. Now Lizard approved!"
	icon = 'icons/obj/tools.dmi'
	icon_state = "rsf"
	/// Contains the PATH of the selected snack
	var/atom/selected_snack
	var/list/valid_snacks = list(
		/obj/item/food/cookie/bacon,
		/obj/item/food/cookie/cloth,
		/obj/item/food/cookie/sugar,
		/obj/item/food/lollipop/cyborg
	)
	var/borg_charge_cutoff = 200
	var/borg_charge_usage = 50

/obj/item/borg_snack_dispensor/Initialize(mapload)
	. = ..()
	selected_snack = selected_snack ||  LAZYACCESS(valid_snacks, 1)

/obj/item/borg_snack_dispensor/attack_self(mob/user, modifiers)
	var/list/choices = list()
	for(var/atom/snack as anything in valid_snacks)
		choices[initial(snack.name)] = snack
	if(!length(choices))
		to_chat(user, span_warning("No valid snacks in database."))
	if(length(choices) == 1)
		selected_snack = choices[1]
	else
		var/selected = tgui_input_list(user, "Select Snack", "Snack Selection", choices)
		selected_snack = choices[selected]
	var/snack_name = initial(selected_snack.name)
	to_chat(user, span_notice("[src] is now dispensing [snack_name]"))

/obj/item/borg_snack_dispensor/attack(mob/living/patron, mob/living/user, params)
	var/empty_hand = LAZYACCESS(patron.get_empty_held_indexes(), 1)
	if(!empty_hand)
		to_chat(user, span_warning("[patron] has no free hands!"))
		return
	if(!selected_snack)
		to_chat(user, span_warning("No snack selected."))
		return
	var/mob/living/silicon/robot/borg = user
	if(borg.cell.charge < borg_charge_cutoff)
		to_chat(user, span_danger("Automated Safety Measures restrict the operation of [src] while under [borg_charge_cutoff]!"))
		return
	if(!borg.cell.use(borg_charge_usage))
		to_chat(user, span_danger("Failure printing snack: power failure!"))
		return
	var/atom/snack = new selected_snack(src)
	patron.put_in_hand(snack, empty_hand)
	user.do_item_attack_animation(patron, null, snack)
	playsound(loc, 'sound/machines/click.ogg', 10, TRUE)
	to_chat(patron, span_notice("[user] dispenses [snack] into your empty hand and you reflexively grasp it."))
	to_chat(user, span_notice("You dispense [snack] into the hand of [user]."))

/obj/item/food/cookie/bacon
	name = "Strip of Bacon"
	desc = "BACON!!!"
	icon = 'modular_skyrat/master_files/icons/obj/food/snacks.dmi'
	icon_state = "bacon_strip"
	foodtypes = MEAT

/obj/item/food/cookie/cloth
	name = "Odd Cookie"
	desc = "A cookie that appears to be made out of... some form of cloth?"
	icon = 'modular_skyrat/master_files/icons/obj/food/snacks.dmi'
	icon_state = "cookie_cloth"
	foodtypes = CLOTH
