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

