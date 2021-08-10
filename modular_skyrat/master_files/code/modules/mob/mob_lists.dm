/mob/add_to_current_living_players()
	. = ..()
	if(!SSticker?.mode)
		return
	if(mind?.assigned_role.type == /datum/job/assistant)
		return
	GLOB.useful_player_list |= src

/mob/remove_from_current_living_players()
	. = ..()
	if(!SSticker?.mode)
		return
	if(mind?.assigned_role.type == /datum/job/assistant)
		return
	GLOB.useful_player_list -= src
