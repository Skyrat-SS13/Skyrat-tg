/datum/design/borg_snack_dispenser
	name = "Snack Dispenser Module"
	id = "borg_upgrade_snacks"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/snack_dispenser
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 1 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL,
	)

/obj/item/borg/upgrade/snack_dispenser
	name = "Snack Dispenser Module"
	desc = "Gives any borg the ability to dispense speciality snacks."
	/// For storing modules that we remove, since the upgraded snack dispensor automatically removes inferior versions
	var/list/removed_modules = list()

/obj/item/borg/upgrade/snack_dispenser/action(mob/living/silicon/robot/R, user)
	. = ..()
	if(!.)
		return
	var/obj/item/borg_snack_dispenser/snack_dispenser = new(R.model)
	R.model.basic_modules += snack_dispenser
	R.model.add_module(snack_dispenser, FALSE, TRUE)
	for(var/obj/item/rsf/cookiesynth/cookiesynth in R.model)
		removed_modules += cookiesynth
		R.model.remove_module(cookiesynth)
	for(var/obj/item/borg/lollipop/lollipop in R.model)
		removed_modules += lollipop
		R.model.remove_module(lollipop)

/obj/item/borg/upgrade/snack_dispenser/deactivate(mob/living/silicon/robot/R, user)
	. = ..()
	if(!.)
		return
	for(var/obj/item/borg_snack_dispenser/dispenser in R.model)
		R.model.remove_module(dispenser, TRUE)
	for(var/obj/item as anything in removed_modules)
		R.model.basic_modules += item
		R.model.add_module(item, FALSE, TRUE)

/obj/item/borg_snack_dispenser
	name = "\improper Automated Borg Snack Dispenser"
	desc = "Has the ability to automatically print many differnt forms of snacks. Now Lizard approved!"
	icon = 'icons/obj/tools.dmi'
	icon_state = "rsf"
	/// Contains the PATH of the selected snack
	var/atom/selected_snack
	/// Whether snacks are launched when targeted at a distance
	var/launch_mode = FALSE
	/// A list of all valid snacks
	var/list/valid_snacks = list(
		/obj/item/food/cookie/bacon,
		/obj/item/food/cookie/cloth,
		/obj/item/food/cookie/sugar,
		/obj/item/food/lollipop/cyborg
	)
	/// Minimum amount of charge a borg can have before snack printing is disallowed
	var/borg_charge_cutoff = 200
	/// The amount of charge used per print of a snack
	var/borg_charge_usage = STANDARD_CELL_CHARGE * 0.05

/obj/item/borg_snack_dispenser/Initialize(mapload)
	. = ..()
	selected_snack = selected_snack ||  LAZYACCESS(valid_snacks, 1)

/obj/item/borg_snack_dispenser/examine(mob/user)
	. = ..()
	. += "It is currently set to dispense [initial(selected_snack.name)]."
	. += "You can AltClick it to [(launch_mode ? "disable" : "enable")] launch mode."

/obj/item/borg_snack_dispenser/attack_self(mob/user, modifiers)
	var/list/choices = list()
	for(var/atom/snack as anything in valid_snacks)
		choices[initial(snack.name)] = snack
	if(!length(choices))
		to_chat(user, span_warning("No valid snacks in database."))
	if(length(choices) == 1)
		selected_snack = choices[1]
	else
		var/selected = tgui_input_list(user, "Select Snack", "Snack Selection", choices)
		if(!selected)
			return
		selected_snack = choices[selected]
	var/snack_name = initial(selected_snack.name)
	to_chat(user, span_notice("[src] is now dispensing [snack_name]."))

/obj/item/borg_snack_dispenser/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/mob/living/patron = interacting_with
	if(!istype(patron))
		return NONE
	var/empty_hand = LAZYACCESS(patron.get_empty_held_indexes(), 1)
	if(!empty_hand)
		to_chat(user, span_warning("[patron] has no free hands!"))
		return ITEM_INTERACT_BLOCKING
	if(!selected_snack)
		to_chat(user, span_warning("No snack selected."))
		return ITEM_INTERACT_BLOCKING
	var/mob/living/silicon/robot/borg = user
	if(!istype(borg))
		CRASH("[src] being used by non borg [borg]")
	if(borg.cell.charge < borg_charge_cutoff)
		to_chat(borg, span_danger("Automated Safety Measures restrict the operation of [src] while under [borg_charge_cutoff]!"))
		return ITEM_INTERACT_BLOCKING
	if(!borg.cell.use(borg_charge_usage))
		to_chat(borg, span_danger("Failure printing snack: power failure!"))
		return ITEM_INTERACT_BLOCKING
	var/atom/snack = new selected_snack(src)
	patron.put_in_hand(snack, empty_hand)
	borg.do_item_attack_animation(patron, null, snack)
	playsound(loc, 'sound/machines/click.ogg', 10, TRUE)
	to_chat(patron, span_notice("[borg] dispenses [snack] into your empty hand and you reflexively grasp it."))
	to_chat(borg, span_notice("You dispense [snack] into the hand of [borg]."))
	return ITEM_INTERACT_SUCCESS

/obj/item/borg_snack_dispenser/click_alt(mob/user)
	launch_mode = !launch_mode
	to_chat(user, span_notice("[src] is [(launch_mode ? "now" : "no longer")] launching snacks at a distance."))
	return CLICK_ACTION_SUCCESS

/obj/item/borg_snack_dispenser/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!launch_mode)
		return NONE
	if(!selected_snack)
		to_chat(user, span_warning("No snack selected."))
		return ITEM_INTERACT_BLOCKING
	var/mob/living/silicon/robot/borg = user
	if(!istype(borg))
		CRASH("[src] being used by non borg [borg]")
	if(borg.cell.charge < borg_charge_cutoff)
		to_chat(borg, span_danger("Automated Safety Measures restrict the operation of [src] while under [borg_charge_cutoff]!"))
		return ITEM_INTERACT_BLOCKING
	if(!borg.cell.use(borg_charge_usage))
		to_chat(borg, span_danger("Failure printing snack: power failure!"))
		return ITEM_INTERACT_BLOCKING
	var/atom/movable/snack = new selected_snack(get_turf(src))
	snack.throw_at(interacting_with, 7, 2, borg, TRUE, FALSE)
	playsound(loc, 'sound/machines/click.ogg', 10, TRUE)
	borg.visible_message(span_notice("[src] launches [snack] at [interacting_with]!"))
	return ITEM_INTERACT_SUCCESS

/obj/item/food/cookie/bacon
	name = "strip of bacon"
	desc = "BACON!!!"
	icon = 'modular_skyrat/master_files/icons/obj/food/snacks.dmi'
	icon_state = "bacon_strip"
	foodtypes = MEAT

/obj/item/food/cookie/cloth
	name = "odd cookie"
	desc = "A cookie that appears to be made out of... some form of cloth?"
	icon = 'modular_skyrat/master_files/icons/obj/food/snacks.dmi'
	icon_state = "cookie_cloth"
	foodtypes = CLOTH
