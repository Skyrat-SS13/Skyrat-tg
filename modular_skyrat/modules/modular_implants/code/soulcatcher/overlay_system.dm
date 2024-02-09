/datum/soulcatcher_room
	/// What overlay is being currently used? Don't directly change this, use `change_fullscreen_overlay()`
	var/atom/movable/screen/fullscreen/carrier/current_overlay_path = /atom/movable/screen/fullscreen/carrier/default
	/// What color do we want the overlay to be, if any?
	var/overlay_color
	/// Is our overlay recolorable? This is here for TGUI
	var/overlay_recolorable

/// Changes the fullscreen overlay for everyone inside of the soulcatcher
/datum/soulcatcher_room/proc/change_fullscreen_overlay(atom/movable/screen/fullscreen/carrier/new_fullscreen)
	current_overlay_path = new_fullscreen
	// If we don't have a new one, go ahead and clear it
	if(!ispath(new_fullscreen))
		overlay_recolorable = FALSE // Can't color what isn't there :3
		for(var/mob/living/occupant as anything in current_souls)
			set_overlay_for_mob(FALSE)

	overlay_recolorable = initial(new_fullscreen.recolorable)
	if(!overlay_recolorable)
		overlay_color = null

	for(var/mob/living/occupant as anything in current_souls)
		set_overlay_for_mob(occupant, new_fullscreen)

	return TRUE

/// Sets the current overlay for a mob
/datum/soulcatcher_room/proc/set_overlay_for_mob(mob/living/occupant)
	if(!istype(occupant))
		return FALSE

	if(!ispath(current_overlay_path))
		occupant.clear_fullscreen("carrier", FALSE)
		return TRUE

	var/atom/movable/screen/fullscreen/carrier/new_screen = occupant.overlay_fullscreen("carrier", current_overlay_path)
	if(overlay_color)
		new_screen.color = overlay_color

	return TRUE

/atom/movable/screen/fullscreen/carrier
	icon = 'modular_skyrat/master_files/icons/mob/carrier_fullscreen.dmi'
	icon_state = "da_tumby"
	layer = CARRIER_LAYER
	plane = FULLSCREEN_PLANE

	/// Is the overlay able to be recolored?
	var/recolorable = FALSE

/atom/movable/screen/fullscreen/carrier/default
	name = "default"
/atom/movable/screen/fullscreen/carrier/test
	name = "Animated Belly"
	icon_state = "a_anim_belly"
	recolorable = TRUE

