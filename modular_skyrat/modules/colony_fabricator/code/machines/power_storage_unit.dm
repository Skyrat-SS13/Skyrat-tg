/obj/machinery/power/smes/battery_pack
	name = "stationary battery"
	desc = "An about table-height block of power storage, commonly seen in low storage high output power applications. \
		Smaller units such as these tend to have a respectively <b>smaller energy storage</b>, though also are capable of \
		<b>higher maximum output</b> than some larger units. Most commonly seen being used not for their ability to store \
		power, but rather for use in regulating power input and output."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/power_storage_unit/small_battery.dmi'
	capacity = 125e4
	input_level_max = 4e5
	output_level_max = 4e5
	circuit = null
	flags_1 = NODECONSTRUCT_1
	/// The item we turn into when repacked
	var/repacked_type = /obj/item/flatpacked_machine/station_battery

/obj/machinery/power/smes/battery_pack/Initialize(mapload)
	. = ..()
	flick("smes_deploy", src)

/obj/machinery/power/smes/battery_pack/examine(mob/user)
	. = ..()
	. += span_notice("You could probably <b>repack</b> this with <b>right click</b>.")

/obj/machinery/power/smes/battery_pack/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return

	if(!can_interact(user) || !user.can_perform_action(src))
		return

	balloon_alert_to_viewers("repacking...")
	if(do_after(user, 3 SECONDS, target = src))
		playsound(src, 'sound/items/ratchet.ogg', 50, TRUE)
		deconstruct(disassembled = TRUE)

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/power/smes/battery_pack/deconstruct(disassembled = TRUE)
	new repacked_type(drop_location())
	return ..()

/obj/machinery/power/smes/battery_pack/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	if(screwdriver.tool_behaviour != TOOL_SCREWDRIVER)
		return FALSE

	screwdriver.play_tool_sound(src, 50)
	toggle_panel_open()
	if(panel_open)
		icon_state = icon_state_open
		to_chat(user, span_notice("You open the maintenance hatch of [src]."))
	else
		icon_state = icon_state_closed
		to_chat(user, span_notice("You close the maintenance hatch of [src]."))
	return TRUE

// We don't care about the parts updates because we don't want them to change
/obj/machinery/power/smes/battery_pack/RefreshParts()
	return

// We also don't need to bother with fuddling with charging power cells, there are none to remove
/obj/machinery/power/smes/on_deconstruction()
	return

// Item for creating the small battery and carrying it around

/obj/item/flatpacked_machine/station_battery
	name = "\improper flatpacked stationary battery"
	desc = "An about table-height block of power storage, commonly seen in low storage high output power applications. \
		Smaller units such as these tend to have a respectively <b>smaller energy storage</b>, though also are capable of \
		<b>higher maximum output</b> than some larger units. Most commonly seen being used not for their ability to store \
		power, but rather for use in regulating power input and output."
	icon_state = "battery_small_packed"
	type_to_deploy = /obj/machinery/power/smes/battery_pack

// Larger station batteries, hold more but have less in/output

/obj/machinery/power/smes/battery_pack/large
	name = "large stationary battery"
	desc = "A massive block of power storage, commonly seen in high storage low output power applications. \
		Larger units such as these tend to have a respectively <b>larger energy storage</b>, though only capable of \
		<b>low maximum output</b> compared to smaller units. Most commonly seen as large backup batteries, or simply \
		for large power storage where throughput is not a concern."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/power_storage_unit/large_battery.dmi'
	capacity = 1e7
	input_level_max = 5e4
	output_level_max = 5e4
	repacked_type = /obj/item/flatpacked_machine/large_station_battery

/obj/item/flatpacked_machine/large_station_battery
	name = "\improper flatpacked large stationary battery"
	desc = "A massive block of power storage, commonly seen in high storage low output power applications. \
		Larger units such as these tend to have a respectively <b>larger energy storage</b>, though only capable of \
		<b>low maximum output</b> compared to smaller units. Most commonly seen as large backup batteries, or simply \
		for large power storage where throughput is not a concern."
	icon_state = "battery_large_packed"
	type_to_deploy = /obj/machinery/power/smes/battery_pack/large
