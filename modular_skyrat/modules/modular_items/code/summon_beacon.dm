/obj/item/summon_beacon
	name = "summoner beacon"
	desc = "Summons a thing. Probably shouldn't use this one, though."
	icon = 'icons/obj/devices/remote.dmi'
	icon_state = "generic_delivery"
	inhand_icon_state = "generic_delivery"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL

	/// How many uses the beacon has left
	var/uses = 1

	/// A list of allowed areas that the atom can be spawned in
	var/list/allowed_areas = list(
		/area,
	)

	/// A list of possible atoms available to spawn
	var/list/selectable_atoms = list(
		/obj/item/summon_beacon,
	)

	/// The currently selected atom, if any
	var/atom/selected_atom = null

	/// Descriptor of what area it should work in
	var/area_string = "any"

	/// If the supply pod should stay or not
	var/supply_pod_stay = FALSE

/obj/item/summon_beacon/examine()
	. = ..()
	. += span_warning("Caution: Only works in [area_string].")
	. += span_notice("Currently selected: [selected_atom ? initial(selected_atom.name) : "None"].")

/obj/item/summon_beacon/attack_self(mob/user)
	if(!can_use_beacon(user))
		return
	if(length(selectable_atoms) == 1)
		selected_atom = selectable_atoms[1]
		return
	show_options(user)

/obj/item/summon_beacon/proc/can_use_beacon(mob/living/user)
	if(user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return TRUE
	else
		playsound(src, 'sound/machines/buzz-sigh.ogg', 40, TRUE)
		return FALSE

/obj/item/summon_beacon/proc/generate_display_names()
	var/list/atom_list = list()
	for(var/atom/iterated_atom as anything in selectable_atoms)
		atom_list[initial(iterated_atom.name)] = iterated_atom
	return atom_list

/obj/item/summon_beacon/proc/show_options(mob/user)
	var/list/radial_build = get_available_options()
	if(!radial_build)
		return

	selected_atom = show_radial_menu(user, src, radial_build, radius = 40, tooltips = TRUE)

/obj/item/summon_beacon/proc/get_available_options()
	var/list/options = list()
	for(var/iterating_choice in selectable_atoms)
		var/obj/our_object = iterating_choice
		var/datum/radial_menu_choice/option = new
		option.image = image(icon = initial(our_object.icon), icon_state = initial(our_object.icon_state))
		option.info = span_boldnotice("[initial(our_object.desc)]")

		options[our_object] = option

	sort_list(options)

	return options

/obj/item/summon_beacon/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!selected_atom)
		balloon_alert(user, "no choice selected!")
		return NONE
	var/turf/target_turf = get_turf(interacting_with)
	var/area/target_area = get_area(interacting_with)
	if(!target_turf || !target_area || !is_type_in_list(target_area, allowed_areas))
		balloon_alert(user, "can't call here!")
		return NONE

	var/confirmed = tgui_alert(user, "Are you sure you want to call [initial(selected_atom.name)] here?", "Confirmation", list("Yes", "No"))
	if(confirmed != "Yes")
		return ITEM_INTERACT_BLOCKING

	if(!uses)
		return ITEM_INTERACT_BLOCKING

	uses -= 1
	balloon_alert(user, "[uses] use[uses == 1 ? "" : "s"] left!")

	podspawn(list(
		"target" = target_turf,
		"path" = supply_pod_stay ? /obj/structure/closet/supplypod/podspawn/no_return : /obj/structure/closet/supplypod/podspawn,
		"style" = STYLE_CENTCOM,
		"spawn" = selected_atom,
	))

	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		if(istype(human_user.ears, /obj/item/radio/headset))
			to_chat(user, span_notice("You hear something crackle in your ears for a moment before a voice speaks. \
				\"Please stand by for a message from Central Command.  Message as follows: \
				[span_bold("Request received. Pod inbound, please stand back from the landing site.")] \
				Message ends.\""))

	if(!uses)
		qdel(src)
	return ITEM_INTERACT_SUCCESS

// Misc stuff here

/obj/structure/closet/supplypod/podspawn/no_return
	bluespace = FALSE

/obj/item/storage/box/gas_miner_beacons
	name = "box of gas miner delivery beacons"
	desc = "Contains two beacons for delivery of atmospheric gas miners."

/obj/item/storage/box/gas_miner_beacons/PopulateContents()
	new /obj/item/summon_beacon/gas_miner(src)
	new /obj/item/summon_beacon/gas_miner(src)


// Actual beacons start here

/obj/item/summon_beacon/gas_miner
	name = "gas miner beacon"
	desc = "Once a gas miner type is selected, delivers a gas miner to the target location."

	allowed_areas = list(
		/area/station/engineering/atmos,
		/area/station/engineering/atmospherics_engine,
	)

	selectable_atoms = list(
		/obj/machinery/atmospherics/miner/carbon_dioxide,
		/obj/machinery/atmospherics/miner/n2o,
		/obj/machinery/atmospherics/miner/nitrogen,
		/obj/machinery/atmospherics/miner/oxygen,
		/obj/machinery/atmospherics/miner/plasma,
	)

	area_string = "atmospherics"
	supply_pod_stay = TRUE
