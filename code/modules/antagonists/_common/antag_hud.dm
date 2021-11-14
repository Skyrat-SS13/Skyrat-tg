<<<<<<< HEAD
/datum/atom_hud/antag
	hud_icons = list(ANTAG_HUD)
	var/self_visible = TRUE
	var/icon_color //will set the icon color to this

/datum/atom_hud/antag/hidden
	self_visible = FALSE

/datum/atom_hud/antag/proc/join_hud(mob/M)
	//sees_hud should be set to 0 if the mob does not get to see it's own hud type.
	if(!istype(M))
		CRASH("join_hud(): [M] ([M.type]) is not a mob!")
	if(M.mind.antag_hud) //note: please let this runtime if a mob has no mind, as mindless mobs shouldn't be getting antagged
		M.mind.antag_hud.leave_hud(M)

	if(ANTAG_HUD in M.hud_possible) //Current mob does not support antag huds ie newplayer
		add_to_hud(M)
		if(self_visible)
			add_hud_to(M)

	M.mind.antag_hud = src

/datum/atom_hud/antag/proc/leave_hud(mob/M)
	if(!M)
		return
	if(!istype(M))
		CRASH("leave_hud(): [M] ([M.type]) is not a mob!")
	remove_from_hud(M)
	remove_hud_from(M)
	if(M.mind)
		M.mind.antag_hud = null

//GAME_MODE PROCS
//called to set a mob's antag icon state
/proc/set_antag_hud(mob/M, new_icon_state, hudindex)
	if(!istype(M))
		CRASH("set_antag_hud(): [M] ([M.type]) is not a mob!")
	var/image/holder = M.hud_list[ANTAG_HUD]
	var/datum/atom_hud/antag/specific_hud = hudindex ? GLOB.huds[hudindex] : null
	if(holder)
		holder.icon_state = new_icon_state
		holder.color = specific_hud?.icon_color
	if(M.mind || new_icon_state) //in mindless mobs, only null is acceptable, otherwise we're antagging a mindless mob, meaning we should runtime
		M.mind.antag_hud_icon_state = new_icon_state


//MIND PROCS
//these are called by mind.transfer_to()
/datum/mind/proc/transfer_antag_huds(datum/atom_hud/antag/newhud)
	leave_all_antag_huds()
	set_antag_hud(current, antag_hud_icon_state)
	if(newhud)
		newhud.join_hud(current)

/datum/mind/proc/leave_all_antag_huds()
	for(var/datum/atom_hud/antag/hud in GLOB.huds)
		if(hud.hudusers[current])
			hud.leave_hud(current)
=======
/// All active /datum/atom_hud/alternate_appearance/basic/has_antagonist instances
GLOBAL_LIST_EMPTY_TYPED(has_antagonist_huds, /datum/atom_hud/alternate_appearance/basic/has_antagonist)

/// An alternate appearance that will only show if you have the antag datum
/datum/atom_hud/alternate_appearance/basic/has_antagonist
	var/antag_datum_type

/datum/atom_hud/alternate_appearance/basic/has_antagonist/New(key, image/I, antag_datum_type)
	src.antag_datum_type = antag_datum_type
	GLOB.has_antagonist_huds += src
	return ..(key, I, NONE)

/datum/atom_hud/alternate_appearance/basic/has_antagonist/Destroy()
	GLOB.has_antagonist_huds -= src
	return ..()

/datum/atom_hud/alternate_appearance/basic/has_antagonist/mobShouldSee(mob/M)
	return !!M.mind?.has_antag_datum(antag_datum_type)

/// An alternate appearance that will show all the antagonists this mob has
/datum/atom_hud/alternate_appearance/basic/antagonist_hud
	var/list/antag_hud_images = list()
	var/index = 1

	var/datum/mind/mind

/datum/atom_hud/alternate_appearance/basic/antagonist_hud/New(key, datum/mind/mind)
	src.mind = mind

	antag_hud_images = get_antag_hud_images(mind)

	var/image/first_antagonist = get_antag_image(1) || image(icon('icons/blanks/32x32.dmi', "nothing"), mind.current)

	RegisterSignal(
		mind,
		list(COMSIG_ANTAGONIST_GAINED, COMSIG_ANTAGONIST_REMOVED),
		.proc/update_antag_hud_images
	)

	check_processing()

	return ..(key, first_antagonist, NONE)

/datum/atom_hud/alternate_appearance/basic/antagonist_hud/Destroy()
	QDEL_LIST(antag_hud_images)
	STOP_PROCESSING(SSantag_hud, src)
	mind.antag_hud = null
	mind = null

	return ..()

/datum/atom_hud/alternate_appearance/basic/antagonist_hud/mobShouldSee(mob/mob)
	return Master.current_runlevel >= RUNLEVEL_POSTGAME || mob.client?.combo_hud_enabled

/datum/atom_hud/alternate_appearance/basic/antagonist_hud/process(delta_time)
	index += 1
	update_icon()

/datum/atom_hud/alternate_appearance/basic/antagonist_hud/proc/check_processing()
	if (antag_hud_images.len > 1 && !(DF_ISPROCESSING in datum_flags))
		START_PROCESSING(SSantag_hud, src)
	else if (antag_hud_images.len <= 1)
		STOP_PROCESSING(SSantag_hud, src)

/datum/atom_hud/alternate_appearance/basic/antagonist_hud/proc/get_antag_image(index)
	RETURN_TYPE(/image)
	if (antag_hud_images.len)
		return antag_hud_images[(index % antag_hud_images.len) + 1]

/datum/atom_hud/alternate_appearance/basic/antagonist_hud/proc/get_antag_hud_images(datum/mind/mind)
	var/list/final_antag_hud_images = list()

	for (var/datum/antagonist/antagonist as anything in mind?.antag_datums)
		if (isnull(antagonist.antag_hud_name))
			continue
		final_antag_hud_images += image('icons/mob/hud.dmi', mind.current, antagonist.antag_hud_name)

	return final_antag_hud_images

/datum/atom_hud/alternate_appearance/basic/antagonist_hud/proc/update_icon()
	if (antag_hud_images.len == 0)
		image.icon = icon('icons/blanks/32x32.dmi', "nothing")
	else
		image.icon = icon('icons/mob/hud.dmi', get_antag_image(index).icon_state)

/datum/atom_hud/alternate_appearance/basic/antagonist_hud/proc/update_antag_hud_images(datum/mind/source)
	SIGNAL_HANDLER

	antag_hud_images = get_antag_hud_images(source)
	index = clamp(index, 1, antag_hud_images.len)
	update_icon()
	check_processing()
>>>>>>> dd30542dff8 (Fix team antag HUDs displaying when they shouldn't, and the other way around, fix round end antag HUDs (#62771))
