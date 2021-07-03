/datum/datacore/proc/get_manifest()
	var/list/manifest_out = list(
		"Command",
		"Security",
		"Engineering",
		"Medical",
		"Science",
		"Supply",
		"Service",
		"Silicon"
	)
	var/list/departments = list(
		"Central Command" = GLOB.central_command_positions + GLOB.central_command_alttitles,
		"Command" = GLOB.command_positions + GLOB.command_alttitles,
		"Security" = GLOB.security_positions + GLOB.security_sub_positions + GLOB.security_alttitles,
		"Engineering" = GLOB.engineering_positions + GLOB.engineering_alttitles,
		"Medical" = GLOB.medical_positions + GLOB.medical_alttitles,
		"Science" = GLOB.science_positions + GLOB.science_alttitles,
		"Supply" = GLOB.supply_positions + GLOB.supply_alttitles,
		"Service" = GLOB.service_positions + GLOB.service_alttitles,
		"Silicon" = GLOB.nonhuman_positions + GLOB.nonhuman_alttitles
	)
	var/list/heads = GLOB.command_positions + GLOB.command_alttitles

	for(var/datum/data/record/t in GLOB.data_core.general)
		var/name = t.fields["name"]
		var/rank = t.fields["rank"]

		var/is_captain = FALSE
		if(rank == "Captain")
			is_captain = TRUE
		for(var/captitle in GLOB.captain_alttitles)
			if(rank == captitle)
				is_captain = TRUE
				break
			else
				continue

		var/has_department = FALSE
		for(var/department in departments)
			var/list/jobs = departments[department]
			if(rank in jobs)
				if(!manifest_out[department])
					manifest_out[department] = list()
				// Append to beginning of list if captain or department head
				if (is_captain == TRUE || (department != "Command" && (rank in heads)))
					manifest_out[department] = list(list(
						"name" = name,
						"rank" = rank
					)) + manifest_out[department]
				else
					manifest_out[department] += list(list(
						"name" = name,
						"rank" = rank
					))
				has_department = TRUE
		if(!has_department)
			if(!manifest_out["Misc"])
				manifest_out["Misc"] = list()
			manifest_out["Misc"] += list(list(
				"name" = name,
				"rank" = rank
			))
	for (var/department in departments)
		if (!manifest_out[department])
			manifest_out -= department
	return manifest_out
