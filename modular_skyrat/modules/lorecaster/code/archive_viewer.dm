/datum/computer_file/program/news_archive
	filename = "NewsArchive"
	filedesc = "Nanotrasen News Archives"
	category = PROGRAM_CATEGORY_CREW
	program_icon_state = "generic"
	extended_desc = "This program lets you view out-of-circulation articles from the Nanotrasen News Network."
	usage_flags = PROGRAM_ALL
	requires_ntnet = TRUE
	size = 6
	tgui_id = "NtosNewsArchive"
	program_icon = "newspaper"
	/// A list created once, on New(), containing all the stories. Static because it won't ever change
	var/static/list/story_list

/datum/computer_file/program/news_archive/New()
	. = ..()
	if(!length(story_list))
		story_list = generate_stories()

/datum/computer_file/program/news_archive/ui_data(mob/user)
	var/list/data = list()
	return data

/datum/computer_file/program/news_archive/ui_static_data(mob/user)
	var/list/data = list()
	data["stories"] = story_list
	return data

/datum/computer_file/program/news_archive/proc/generate_stories()
	RETURN_TYPE(/list)
	if(!fexists(ARCHIVE_FILE))
		return

	var/list/compiled_stories = list()
	var/list/uncompiled_stories = json_load(ARCHIVE_FILE)
	var/list/date_list = list()

	for(var/story in uncompiled_stories)
		date_list += (text2num(uncompiled_stories[story]["year"]) * 365) + (text2num(uncompiled_stories[story]["month"]) * 30) + text2num(uncompiled_stories[story]["day"])

		// the TGUI needs _all_ of these to work
		if(!("title" in uncompiled_stories[story]))
			uncompiled_stories[story]["title"] = "Nanotrasen News Broadcast"
		if(!("text" in uncompiled_stories[story]))
			uncompiled_stories[story]["text"] = "Someone forgot to fill out the article!"
		if(!("year" in uncompiled_stories[story]))
			uncompiled_stories[story]["year"] = "[CURRENT_STATION_YEAR]"
		if(!("month" in uncompiled_stories[story]))
			uncompiled_stories[story]["month"] = "[time2text(world.timeofday, "MM")]"
		if(!("day" in uncompiled_stories[story]))
			uncompiled_stories[story]["day"] = "[time2text(world.timeofday, "DD")]"

	sortTim(date_list, cmp=/proc/cmp_numeric_dsc)

	for(var/date in date_list)
		for(var/story in uncompiled_stories)
			if((text2num(uncompiled_stories[story]["year"]) * 365) + (text2num(uncompiled_stories[story]["month"]) * 30) + text2num(uncompiled_stories[story]["day"]) == date)
				compiled_stories += list(uncompiled_stories[story])
				uncompiled_stories -= story

	return compiled_stories

/obj/machinery/modular_computer/preset/curator
	starting_programs = list(
		/datum/computer_file/program/portrait_printer,
		/datum/computer_file/program/news_archive,
	)
