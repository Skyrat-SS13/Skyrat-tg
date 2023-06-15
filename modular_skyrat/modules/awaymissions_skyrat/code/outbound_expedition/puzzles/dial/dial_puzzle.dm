#define DIAL_NUM 4

/datum/outbound_teamwork_puzzle/dials
	name = "Dials"
	tgui_name = "DialPuzzle"
	terminal_name = "dial board"
	terminal_desc = "A small board of dials, all unlabelled."
	/// Assoc ist of dials and their values ("number dial":value)
	var/list/dials = list()
	/// Assoc list of potential "phrases" that will determine what the 4 dials need to be set to (phrase:dialnums)
	var/list/phrases = list("North" = list(), "East" = list(), "South" = list(), "West" = list())
	/// Currently selected phrase
	var/current_phrase = ""


/datum/outbound_teamwork_puzzle/dials/New()
	. = ..()
	generate_dials()


/datum/outbound_teamwork_puzzle/dials/proc/generate_dials()
	var/compiled_desc = ""

	for(var/phrase in phrases)
		var/list/phrase_list = phrases[phrase]
		for(var/i in 1 to DIAL_NUM)
			phrase_list["[i]"] = rand(1, 100)
		compiled_desc += "If the phrase [phrase] is visible on the panel, turn the dials to "
		for(var/num in phrases[phrase])
			num = phrases[phrase][num]
			compiled_desc += "[num]\
			[num == length(phrases[phrase]) - 1 ? ", and " : ", "]"
		compiled_desc += "respectively. \n"
	desc = compiled_desc


/datum/outbound_teamwork_puzzle/dials/proc/choose_phrase()
	current_phrase = pick(phrases)
	for(var/i in 1 to DIAL_NUM)
		dials["[i]"] = rand(1, 100)


/datum/outbound_teamwork_puzzle/dials/ui_data(mob/user)
	var/list/data = list()
	data["current_phrase"] = current_phrase
	var/list/compiled_dials = list()

	for(var/i in 1 to DIAL_NUM)
		compiled_dials.Add(list(list(
			"dial_num" = "[i]",
			"dial_value" = dials["[i]"],
		)))
	data["dials"] = compiled_dials
	return data


/datum/outbound_teamwork_puzzle/dials/ui_act(action, list/params)
	OUTBOUND_CONTROLLER
	. = ..()

	switch(action)
		if("dial_adjust")
			dials[params["dial_number"]] = params["dial_val"]
			var/list/important_list = phrases[current_phrase]
			var/dials_matching = 0
			for(var/number in important_list)
				for(var/dial_number in dials)
					if(number != dial_number)
						continue
					if(dials[dial_number] == important_list[number])
						dials_matching++
			if(dials_matching >= DIAL_NUM)
				terminal.balloon_alert_to_viewers("dials adjusted", vision_distance = 3)
				SEND_SIGNAL(outbound_controller.puzzle_controller, COMSIG_AWAY_PUZZLE_COMPLETED, src)
			return TRUE

#undef DIAL_NUM
