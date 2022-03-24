/obj/item/storage/hypospraykit
	name = "hypospray kit"
	desc = "It's a kit containing a hypospray and specific treatment chemical-filled vials."
	icon = 'modular_skyrat/modules/hyposprays/icons/hypokits.dmi'
	icon_state = "firstaid-mini"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	throw_speed = 3
	throw_range = 7
	var/empty = FALSE
	var/current_case = "firstaid"
	var/static/list/case_designs
	var/static/list/cmo_case_designs
	var/cmo_case = FALSE

//Code to give hypospray kits selectable paterns.
/obj/item/storage/hypospraykit/examine(mob/living/user)
	. = ..()
	. += span_notice("Ctrl-Shift-Click to reskin this")

/obj/item/storage/hypospraykit/Initialize()
	. = ..()
	if(!length(case_designs))
		populate_case_designs()
	var/datum/component/storage/stored = GetComponent(/datum/component/storage)
	stored.max_items = 12
	stored.can_hold = typecacheof(list(
		/obj/item/hypospray/mkii,
		/obj/item/reagent_containers/glass/vial
	))
	update_icon_state()
	update_icon()


/obj/item/storage/hypospraykit/Destroy()
	for(var/obj/item in contents)
		if(QDELING(loc))
			if(item.resistance_flags & INDESTRUCTIBLE) // Because we're not supposed to delete stuff that are indestructible, but I'm too lazy to do something more complex upstream now. Later, maybe.
				item.forceMove(get_turf(src))
	. = ..()


/obj/item/storage/hypospraykit/proc/populate_case_designs()
	case_designs = list(
		"firstaid" = image(icon = src.icon, icon_state = "firstaid-mini"),
		"brute" = image(icon = src.icon, icon_state = "brute-mini"),
		"burn" = image(icon = src.icon, icon_state = "burn-mini"),
		"toxin" = image(icon = src.icon, icon_state = "toxin-mini"),
		"rad" = image(icon = src.icon, icon_state = "rad-mini"),
		"purple" = image(icon = src.icon, icon_state = "purple-mini"),
		"oxy" = image(icon = src.icon, icon_state = "oxy-mini"))
	cmo_case_designs = list(
		"tactical" = image(icon= src.icon, icon_state = "tactical-mini"))
	cmo_case_designs += case_designs

/obj/item/storage/hypospraykit/update_icon_state()
	. = ..()
	icon_state = "[current_case]-mini"

/obj/item/storage/hypospraykit/proc/case_menu(mob/user)
	if(.)
		return
	var/casetype = cmo_case_designs
	if(!src.cmo_case)
		casetype = case_designs
	var/choice = show_radial_menu(user, src , casetype, custom_check = CALLBACK(src, .proc/check_menu, user), radius = 42, require_near = TRUE)
	if(!choice)
		return FALSE
	current_case = choice
	update_icon()

/obj/item/storage/hypospraykit/proc/check_menu(mob/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated() || !user.is_holding(src))
		return FALSE
	return TRUE


/obj/item/storage/hypospraykit/CtrlShiftClick(mob/user, obj/item/I)
	case_menu(user)

//END OF HYPOSPRAY CASE MENU CODE

/obj/item/storage/hypospraykit/empty
	desc = "A hypospray kit with general use vials."

/obj/item/storage/hypospraykit/empty/PopulateContents()
	if(empty)
		return
	new /obj/item/hypospray/mkii(src)

/obj/item/storage/hypospraykit/cmo
	name = "deluxe hypospray kit"
	desc = "A kit containing a deluxe hypospray and vials."
	icon_state = "tactical-mini"
	current_case = "tactical"
	cmo_case = TRUE

/obj/item/storage/hypospraykit/cmo/PopulateContents()
	if(empty)
		return
	new /obj/item/hypospray/mkii/cmo(src)
	new /obj/item/reagent_containers/glass/vial/large/multiver(src)
	new /obj/item/reagent_containers/glass/vial/large/salglu(src)
	new /obj/item/reagent_containers/glass/vial/large/synthflesh(src)

/obj/item/storage/box/vials
	name = "box of hypovials"

/obj/item/storage/box/vials/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/reagent_containers/glass/vial/small( src )

/obj/item/storage/box/hypospray
	name = "box of hypospray kits"

/obj/item/storage/box/hypospray/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/storage/hypospraykit/empty(src)
