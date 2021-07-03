/proc/AnnounceArrival(mob/living/carbon/human/character, rank)
	if(!SSticker.IsRoundInProgress() || QDELETED(character))
		return
	var/area/A = get_area(character)
	deadchat_broadcast("<span class='game'> has arrived at the station at <span class='name'>[A.name]</span>.</span>", "<span class='game'><span class='name'>[character.real_name]</span> ([rank])</span>", follow_target = character, message_type=DEADCHAT_ARRIVALRATTLE)
	if(!character.mind)
		return
	if(!GLOB.announcement_systems.len)
		return
	if((character.mind.assigned_role == "Cyborg") || (character.mind.assigned_role == character.mind.special_role))
		return

	var/displayed_rank = rank
	if(character.client && character.client.prefs && character.client.prefs.alt_titles_preferences[rank])
		displayed_rank = character.client.prefs.alt_titles_preferences[rank]
	var/obj/machinery/announcement_system/announcer = pick(GLOB.announcement_systems)
	announcer.announce("ARRIVAL", character.real_name, displayed_rank, list()) //make the list empty to make it announce it in common
