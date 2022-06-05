/obj/item/gas_miner_beacon
	name = "gas miner beacon"
	desc = "Once a gas miner type is selected, delivers a gas miner to the target location."
	icon = 'icons/obj/device.dmi'
	icon_state = "gangtool-blue"
	inhand_icon_state = "radio"
	w_class = WEIGHT_CLASS_SMALL
	/// How many charges the beacon has left
	var/uses = 1
	/// A list of allowed areas that a miner can be spawned in
	var/static/list/allowed_areas = list(
		/area/station/engineering/atmos,
		/area/station/engineering/atmospherics_engine,
	)
	/// A list of possible gas miners available to spawn
	var/static/list/miners = list(
		/obj/machinery/atmospherics/miner/carbon_dioxide,
		/obj/machinery/atmospherics/miner/n2o,
		/obj/machinery/atmospherics/miner/nitrogen,
		/obj/machinery/atmospherics/miner/oxygen,
		/obj/machinery/atmospherics/miner/plasma,
	)
	/// The currently selected gas miner, if any
	var/obj/machinery/atmospherics/miner/selected_miner = null

/obj/item/gas_miner_beacon/examine()
	. = ..()
	. += span_warning("Caution: Only works in atmospherics areas.")
	. += span_notice("Currently selected: [selected_miner ? selected_miner.name : "None"].")

/obj/item/gas_miner_beacon/attack_self(mob/user)
	if(!can_use_beacon(user))
		return
	show_options(user)

/obj/item/gas_miner_beacon/proc/can_use_beacon(mob/living/user)
	if(user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return TRUE
	else
		playsound(src, 'sound/machines/buzz-sigh.ogg', 40, TRUE)
		return FALSE

/obj/item/gas_miner_beacon/proc/generate_display_names()
	var/list/miner_list = list()
	for(var/obj/machinery/atmospherics/miner/iterated_miner as anything in miners)
		miner_list[initial(iterated_miner.name)] = iterated_miner
	return miner_list

/obj/item/gas_miner_beacon/proc/show_options(mob/user)
	var/list/display_names = generate_display_names()
	if(!length(display_names))
		return
	var/choice = tgui_input_list(user, "Choose a miner", "Miner selection", display_names)
	if(isnull(choice))
		return
	if(isnull(display_names[choice]))
		return
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	selected_miner = display_names[choice]

/obj/item/gas_miner_beacon/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!selected_miner)
		balloon_alert(user, "no miner selected!")
		return
	var/turf/target_turf = get_turf(target)
	var/area/target_area = get_area(target)
	if(!target_turf || !target_area || !is_type_in_list(target_area, allowed_areas))
		balloon_alert(user, "can't call here!")
		return

	var/confirmed = tgui_alert(user, "Are you sure you want to call it here?", "Confirmation", list("Yes", "No"))
	if(confirmed != "Yes")
		return

	podspawn(list(
		"target" = get_turf(target),
		"path" = /obj/structure/closet/supplypod/podspawn/no_return,
		"style" = STYLE_CENTCOM,
		"spawn" = selected_miner,
	))

	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		if(istype(human_user.ears, /obj/item/radio/headset))
			to_chat(user, span_notice("You hear something crackle in your ears for a moment before a voice speaks. \
				\"Please stand by for a message from Central Command.  Message as follows: \
				[span_bold("Request received. Your miner is inbound, please stand back from the landing site.")] \
				Message ends.\""))

	uses--
	if(!uses)
		qdel(src)
	else
		balloon_alert(user, "[uses] use[uses > 1 ? "s" : ""] left!")

/obj/structure/closet/supplypod/podspawn/no_return
	bluespace = FALSE

/obj/item/storage/box/gas_miner_beacons
	name = "box of gas miner delivery beacons"
	desc = "Contains two beacons for delivery of atmospheric gas miners."

/obj/item/storage/box/gas_miner_beacons/PopulateContents()
	new /obj/item/gas_miner_beacon(src)
	new /obj/item/gas_miner_beacon(src)
