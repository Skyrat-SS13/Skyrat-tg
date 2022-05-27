/obj/item/analyzer/ranged
	desc = "A hand-held scanner which uses advanced spectroscopy and infrared readings to analyze gases as a distance. Alt-Click to use the built in barometer function."
	name = "long-range analyzer"
	icon = 'modular_skyrat/modules/modular_items/icons/tools.dmi'
	icon_state = "ranged_analyzer"

/obj/item/analyzer/ranged/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	//First check to make sure its actually in sight (This is literally stolen from the ARCD)
	if(!(target in view(7, get_turf(user))))
		to_chat(user, span_warning("The \'Out of Range\' light on [src] blinks red."))
		return FALSE
	//Second check to see if we're scanning an item or a turf
	if(target.tool_act(user, src, tool_behaviour))
		return
	//Final check, we scan the turf if all else fails
	var/turf/location = get_turf(target)
	scan_turf(user, location)

/datum/design/ranged_analyzer
	name = "Long-range Analyzer"
	desc = "A new advanced atmospheric analyzer design, capable of performing scans at long range."
	id = "ranged_analyzer"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 400, /datum/material/glass = 1000, /datum/material/uranium = 800, /datum/material/gold = 200, /datum/material/plastic = 200)
	build_path = /obj/item/analyzer/ranged
	category = list("Tool Designs")
	departmental_flags =  DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING

//Half-overwrites original tg proc for analyzer/attack_self()
//(This is literally just the commented out portion of the old proc in scanners.dm; it needs to be seperate so we can call it at varying ranges, though)
/obj/item/analyzer/proc/scan_turf(mob/user, turf/location)
	var/render_list = list()
	var/datum/gas_mixture/environment = location.return_air()
	var/pressure = environment.return_pressure()
	var/total_moles = environment.total_moles()

	render_list += "[span_info("<B>Results:</B>")]\
				\n<span class='[abs(pressure - ONE_ATMOSPHERE) < 10 ? "info" : "alert"]'>Pressure: [round(pressure, 0.01)] kPa</span>\n"
	if(total_moles)
		var/list/env_gases = environment.gases

		environment.assert_gases(/datum/gas/oxygen, /datum/gas/nitrogen, /datum/gas/carbon_dioxide, /datum/gas/plasma)
		var/o2_concentration = env_gases[/datum/gas/oxygen][MOLES]/total_moles
		var/n2_concentration = env_gases[/datum/gas/nitrogen][MOLES]/total_moles
		var/co2_concentration = env_gases[/datum/gas/carbon_dioxide][MOLES]/total_moles
		var/plasma_concentration = env_gases[/datum/gas/plasma][MOLES]/total_moles

		render_list += "<span class='[abs(n2_concentration - N2STANDARD) < 20 ? "info" : "alert"]'>Nitrogen: [round(n2_concentration*100, 0.01)] % ([round(env_gases[/datum/gas/nitrogen][MOLES], 0.01)] mol)</span>\
			\n<span class='[abs(o2_concentration - O2STANDARD) < 2 ? "info" : "alert"]'>Oxygen: [round(o2_concentration*100, 0.01)] % ([round(env_gases[/datum/gas/oxygen][MOLES], 0.01)] mol)</span>\
			\n<span class='[co2_concentration > 0.01 ? "alert" : "info"]'>CO2: [round(co2_concentration*100, 0.01)] % ([round(env_gases[/datum/gas/carbon_dioxide][MOLES], 0.01)] mol)</span>\
			\n<span class='[plasma_concentration > 0.005 ? "alert" : "info"]'>Plasma: [round(plasma_concentration*100, 0.01)] % ([round(env_gases[/datum/gas/plasma][MOLES], 0.01)] mol)</span>\n"

		environment.garbage_collect()

		for(var/id in env_gases)
			if(id in list(/datum/gas/oxygen, /datum/gas/nitrogen, /datum/gas/carbon_dioxide, /datum/gas/plasma))
				continue
			var/gas_concentration = env_gases[id][MOLES]/total_moles
			render_list += "[span_alert("[env_gases[id][GAS_META][META_GAS_NAME]]: [round(gas_concentration*100, 0.01)] % ([round(env_gases[id][MOLES], 0.01)] mol)")]\n"
		render_list += "[span_info("Temperature: [round(environment.temperature-T0C, 0.01)] &deg;C ([round(environment.temperature, 0.01)] K)")]\n"
	to_chat(user, examine_block(jointext(render_list, "")), trailing_newline = FALSE, type = MESSAGE_TYPE_INFO) // we handled the last <br> so we don't need handholding	//SKYRAT PAST HERE - This last line is the only change, adding the examine_block
