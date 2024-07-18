/obj/item/circuitboard/machine/powerator
	name = "Powerator"
	desc = "The powerator is a machine that allows stations to sell their power to other stations that require additional sources."
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/powerator
	req_components = list(
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/ore/bluespace_crystal/refined = 1,
		/obj/item/stack/cable_coil = 5,
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/micro_laser = 2,
		/datum/stock_part/servo = 2,
	)
	needs_anchored = TRUE

/datum/supply_pack/misc/powerator
	name = "Powerator"
	desc = "We know the feeling of losing power and Central sending power, it is our time to do the same."
	cost = CARGO_CRATE_VALUE * 50 // 10,000
	contains = list(/obj/item/circuitboard/machine/powerator)
	crate_name = "Powerator Circuitboard Crate"
	crate_type = /obj/structure/closet/crate

/datum/design/board/powerator
	name = "Machine Design (Powerator)"
	desc = "Allows for the construction of circuit boards used to build a powerator."
	id = "powerator"
	build_path = /obj/item/circuitboard/machine/powerator
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/techweb_node/powerator
	id = TECHWEB_NODE_POWERATOR
	display_name = "Powerator"
	description = "We've been saved by it in the past, we should send some power ourselves!"
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
	hidden = TRUE
	experimental = TRUE
	prereq_ids = list(TECHWEB_NODE_PARTS_ADV)
	design_ids = list(
		"powerator",
	)

/obj/machinery/powerator
	name = "powerator"
	desc = "Beyond the ridiculous name, it is the standard for transporting and selling energy to power networks that require additional sources!"
	icon = 'modular_skyrat/modules/power/icons/machines.dmi'
	icon_state = "powerator"

	density = TRUE
	circuit = /obj/item/circuitboard/machine/powerator
	idle_power_usage = 100

	/// the current amount of power that we are trying to process
	var/current_power = 10 KILO WATTS
	/// the max amount of power that can be sent per process, from 100 KW (t1) to 10000 KW (t4)
	var/max_power = 100 KILO WATTS
	/// how much the current_power is divided by to determine the profit
	var/divide_ratio = 0.00001
	/// the attached cable to the machine
	var/obj/structure/cable/attached_cable
	/// how many credits this machine has actually made so far
	var/credits_made = 0

/obj/machinery/powerator/Initialize(mapload)
	. = ..()
	SSpowerator_penality.sum_powerators()
	SSpowerator_penality.calculate_penality()
	START_PROCESSING(SSobj, src)

/obj/machinery/powerator/Destroy()
	STOP_PROCESSING(SSobj, src)
	SSpowerator_penality.remove_deled_powerators(src)
	SSpowerator_penality.calculate_penality()
	attached_cable = null
	return ..()

/obj/machinery/powerator/examine(mob/user)
	. = ..()
	. += "<br>"
	if(panel_open)
		. += span_warning("The maintainence panel is currently open, preventing [src] from working!")
	else
		. += span_notice("The maintainence panel is closed.")

	if(!anchored)
		. += span_warning("The anchors are not bolted to the floor, preventing [src] from working!")
	else
		. += span_notice("The anchors are bolted to the floor.")

	if(machine_stat & (NOPOWER | BROKEN))
		. += span_warning("There is either damage or no power being supplied, preventing [src] from working!")
	else
		. += span_notice("There is no damage and power is being supplied.")

	if(!attached_cable)
		. += span_warning("There is no power cable underneath, preventing [src] from working!")
	else
		. += span_notice("There is a power cable underneath.")

	. += span_notice("Current Power: [display_power(current_power)]/[display_power(max_power)]")
	. += span_notice("This machine has made [credits_made] credits from selling power so far.")
	if(length(SSpowerator_penality.powerator_list) > 1)
		. += span_notice("Multiple powerators detected, total efficiency reduced by [(SSpowerator_penality.diminishing_gains_multiplier)*100]%")

/obj/machinery/powerator/RefreshParts()
	. = ..()

	var/efficiency = -2 //set to -2 so that tier 1 parts do nothing
	max_power = 100 KILO WATTS
	for(var/datum/stock_part/micro_laser/laser_part in component_parts)
		efficiency += laser_part.tier
	max_power += (efficiency * 1650 KILO WATTS)

	efficiency = -2
	divide_ratio = 0.00001
	for(var/datum/stock_part/servo/servo_part in component_parts)
		efficiency += servo_part.tier
	divide_ratio += (efficiency * 0.000005)

/obj/machinery/powerator/update_overlays()
	. = ..()
	cut_overlays()
	if(panel_open)
		add_overlay("panel_open")

	else
		add_overlay("panel_close")

	if(machine_stat & (NOPOWER | BROKEN) || !anchored || panel_open)
		add_overlay("error")
		return

	if(!attached_cable)
		add_overlay("cable")
		return

	if(!attached_cable.avail(current_power))
		add_overlay("power")
		return

	add_overlay("work")

/obj/machinery/powerator/process()
	update_appearance() //lets just update this
	var/turf/src_turf = get_turf(src)
	attached_cable = locate() in src_turf
	if(machine_stat & (NOPOWER | BROKEN) || !anchored || panel_open || !attached_cable) //no power, broken, unanchored, maint panel open, or no cable? lets reset
		return

	if(!attached_cable)
		return

	if(current_power <= 0)
		current_power = 0 //this is just for the fringe case, wouldn't want it to somehow produce power for money! unless...
		return

	if(!attached_cable.avail(current_power))
		if(!attached_cable.newavail())
			return
		current_power = attached_cable.newavail()
	attached_cable.add_delayedload(current_power)

	var/money_ratio = round(current_power * divide_ratio) * SSpowerator_penality.diminishing_gains_multiplier
	var/datum/bank_account/synced_bank_account = SSeconomy.get_dep_account(ACCOUNT_CAR)
	synced_bank_account.adjust_money(money_ratio)
	credits_made += money_ratio

	update_appearance() //lets just update this

/obj/machinery/powerator/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	current_power = tgui_input_number(user, "How much power (in Watts) would you like to draw? Max: [display_power(max_power)]", "Power Draw", current_power, max_power, 0)
	if(isnull(current_power))
		current_power = 10 KILO WATTS
		return

/obj/machinery/powerator/screwdriver_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	panel_open = !panel_open
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/machinery/powerator/crowbar_act(mob/user, obj/item/tool)
	if(default_deconstruction_crowbar(tool))
		return ITEM_INTERACT_SUCCESS

/obj/machinery/powerator/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	default_unfasten_wrench(user, tool)
	return ITEM_INTERACT_SUCCESS
