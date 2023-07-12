// A lite version of the intercept, which only sends a paper with goals and a trait report (or a lack thereof)
/datum/game_mode/dynamic/proc/send_trait_report()
	. = "<b><i>Central Command Status Summary</i></b><hr>"


	var/min_threat = 100
	for(var/datum/dynamic_ruleset/ruleset as anything in init_rulesets(/datum/dynamic_ruleset))
		if(ruleset.weight <= 0 || ruleset.cost <= 0)
			continue
		min_threat = min(ruleset.cost, min_threat)
	var/greenshift = GLOB.dynamic_forced_extended || (threat_level < min_threat && shown_threat < min_threat) // if both shown and real threat are below any ruleset, its extended time
	generate_station_goals(greenshift)

	if(!GLOB.station_goals.len)
		. = "<hr><b>No assigned goals.</b><BR>"
	else
		. += generate_station_goal_report()
	if(!SSstation.station_traits.len)
		. = "<hr><b>No identified shift divergencies.</b><BR>"
	else
		. += generate_station_trait_report()

	. += "<hr>This concludes your shift-start evaluation. Have a secure shift!<hr>\
	<p style=\"color: grey; text-align: justify;\">This label certifies an Intern has reviewed the above before sending. This document is the property of Nanotrasen Corporation.</p>"

	print_command_report(., "Central Command Status Summary", announce = FALSE)
	priority_announce("Hello, crew of [station_name()]. Our intern has finished their shift-start divergency and goals evaluation, which has been sent to your communications console. Have a secure shift!", "Divergency Report", SSstation.announcer.get_rand_report_sound())

/// Divides threat budget, in this case pure midround because Skyrat doesn't have roundstart antags.
/datum/game_mode/dynamic/generate_budgets()
	round_start_budget = 0
	initial_round_start_budget = round_start_budget
	mid_round_budget = threat_level - round_start_budget

/// Gets the chance for a heavy ruleset midround injection, the dry_run argument is only used for forced injection.
/datum/game_mode/dynamic/get_heavy_midround_injection_chance(dry_run)
	var/chance_modifier = 1
	var/next_midround_roll = next_midround_injection() - SSticker.round_start_time

	var/heavy_coefficient = CLAMP01((next_midround_roll - midround_light_upper_bound) / (midround_heavy_lower_bound - midround_light_upper_bound))

	return 100 * (heavy_coefficient * max(1, chance_modifier))
