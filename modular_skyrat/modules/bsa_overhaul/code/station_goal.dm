/**
 * Bluespace artillery goal
 *
 * Requires the crew to construct an artillery piece by shift end.
 */

/datum/station_goal/bluespace_cannon
	name = "Bluespace Artillery"

/datum/station_goal/bluespace_cannon/get_report()
	return list(
		"<blockquote>Our military presence is inadequate in your sector.",
		"We need you to construct BSA-[rand(1,99)] Artillery position aboard your station.",
		"",
		"Base parts are available for shipping via cargo.",
		"-Nanotrasen Naval Command</blockquote>",
	).Join("\n")

/datum/station_goal/bluespace_cannon/on_report()
	//Unlock BSA parts
	var/datum/supply_pack/engineering/bsa/parts = SSshuttle.supply_packs[/datum/supply_pack/engineering/bsa]
	parts.special_enabled = TRUE

/datum/station_goal/bluespace_cannon/check_completion()
	if(..())
		return TRUE
	var/obj/machinery/bsa/full/built_cannon = locate()
	if(built_cannon && !built_cannon.machine_stat)
		return TRUE
	return FALSE
