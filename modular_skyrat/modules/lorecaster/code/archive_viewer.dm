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
	var/list/data = get_header_data()
	return data

/datum/computer_file/program/news_archive/ui_static_data(mob/user)
	var/list/data = list()
	data["stories"] = story_list
	return data

/datum/computer_file/program/news_archive/proc/generate_stories()
	if(!fexists(ARCHIVE_FILE))
		return

	var/list/compiled_stories = list()
	var/list/uncompiled_stories = json_load(ARCHIVE_FILE)
	var/list/day_to_story = list()

	for(var/story in uncompiled_stories)

		var/generated_num = (text2num(uncompiled_stories[story]["year"]) * 365) + (text2num(uncompiled_stories[story]["month"]) * 30) + text2num(uncompiled_stories[story]["day"])
		day_to_story["[generated_num]"] = story

		// the TGUI needs _all_ of these to work
		if(!("title" in uncompiled_stories[story]))
			uncompiled_stories[story]["title"] = "Nanotrasen News Broadcast"
		if(!("text" in uncompiled_stories[story]))
			uncompiled_stories[story]["text"] = "Someone forgot to fill out the article!"
		if(!("year" in uncompiled_stories[story]))
			uncompiled_stories[story]["year"] = "[GLOB.year_integer + 540]"
		if(!("month" in uncompiled_stories[story]))
			uncompiled_stories[story]["month"] = "[time2text(world.timeofday, "MM")]]"
		if(!("day" in uncompiled_stories[story]))
			uncompiled_stories[story]["day"] = "[time2text(world.timeofday, "DD")]]"

	// Sorting my beloathed
	var/list/just_numbers = list()
	for(var/timestamp in day_to_story)
		just_numbers += text2num(timestamp)

	sortTim(just_numbers)

	for(var/num in just_numbers)
		for(var/date in day_to_story)
			if(text2num(date) != num)
				continue
			compiled_stories += list(uncompiled_stories[day_to_story[date]])
			day_to_story -= date

	return compiled_stories

/obj/machinery/modular_computer/console/preset/curator
	starting_programs = list(
		/datum/computer_file/program/portrait_printer,
		/datum/computer_file/program/news_archive,
	)
