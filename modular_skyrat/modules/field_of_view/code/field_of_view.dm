/// Component which applies a visual and blocker masks which rotate with the user, blocking his vision from behind
/datum/component/field_of_vision
	/// Currently applied x size of the fov masks
	var/current_fov_x = BASE_FOV_MASK_X_DIMENSION
	/// Currently applied y size of the fov masks
	var/current_fov_y = BASE_FOV_MASK_Y_DIMENSION
	/// Whether we are applying the masks now
	var/applied_mask = FALSE
	/// The angle of the mask we are applying
	var/shadow_angle = FOV_180_DEGREES
	/// The blocker mask applied to a client's screen
	var/atom/movable/screen/fov_blocker/blocker_mask
	/// The shadow mask applied to a client's screen
	var/atom/movable/screen/fov_shadow/visual_shadow

/datum/component/field_of_vision/Initialize(fov_type = FOV_180_DEGREES)
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	var/mob/living/mob_parent = parent
	var/client/parent_client = mob_parent.client
	if(!parent_client) //Love client volatility!!
		qdel(src)
		return
	shadow_angle = fov_type

	blocker_mask = new
	blocker_mask.icon_state = "[fov_type]"
	visual_shadow = new
	visual_shadow.icon_state = "[fov_type]_v"
	blocker_mask.dir = mob_parent.dir
	visual_shadow.dir = mob_parent.dir
	toggled_combat_mode(mob_parent, mob_parent.combat_mode)
	update_fov_size()
	if(mob_parent.stat != DEAD)
		add_mask()

/datum/component/field_of_vision/Destroy()
	if(applied_mask)
		remove_mask()
	if(blocker_mask) // In a case of early deletion due to volatile client
		QDEL_NULL(blocker_mask)
	if(visual_shadow) // In a case of early deletion due to volatile client
		QDEL_NULL(visual_shadow)
	return ..()

/// Updates the size of the FOV masks by comparing them to client view size.
/datum/component/field_of_vision/proc/update_fov_size()
	var/mob/parent_mob = parent
	var/client/parent_client = parent_mob.client
	if(!parent_client) //Love client volatility!!
		return
	var/list/view_size = getviewsize(parent_client.view)
	if(view_size[1] == current_fov_x && view_size[2] == current_fov_y)
		return
	current_fov_x = BASE_FOV_MASK_X_DIMENSION
	current_fov_y = BASE_FOV_MASK_Y_DIMENSION
	var/matrix/new_matrix = new
	var/x_shift = view_size[1] - current_fov_x
	var/y_shift = view_size[2] - current_fov_y
	var/x_scale = view_size[1] / current_fov_x
	var/y_scale = view_size[2] / current_fov_y
	current_fov_x = view_size[1]
	current_fov_y = view_size[2]
	visual_shadow.transform = blocker_mask.transform = new_matrix.Scale(x_scale, y_scale)
	visual_shadow.transform = blocker_mask.transform = new_matrix.Translate(x_shift * 16, y_shift * 16)

/// Adds the masks to the user
/datum/component/field_of_vision/proc/add_mask()
	SIGNAL_HANDLER
	var/mob/parent_mob = parent
	var/client/parent_client = parent_mob.client
	if(!parent_client) //Love client volatility!!
		return
	parent_client.screen += blocker_mask
	parent_client.screen += visual_shadow
	applied_mask = TRUE

/// Removes the masks from the user
/datum/component/field_of_vision/proc/remove_mask()
	SIGNAL_HANDLER
	var/mob/parent_mob = parent
	var/client/parent_client = parent_mob.client
	if(!parent_client) //Love client volatility!!
		return
	parent_client.screen -= blocker_mask
	parent_client.screen -= visual_shadow
	applied_mask = FALSE

/// When a direction of the user changes, so do the masks
/datum/component/field_of_vision/proc/on_dir_change(mob/source, old_dir, new_dir)
	SIGNAL_HANDLER
	blocker_mask.dir = new_dir
	visual_shadow.dir = new_dir

/// When toggling combat mode, we update the alpha of the shadow mask
/datum/component/field_of_vision/proc/toggled_combat_mode(mob/source, new_state)
	SIGNAL_HANDLER
	var/mob/parent_mob = parent
	var/pref_to_read = new_state ? /datum/preference/numeric/fov_alpha : /datum/preference/numeric/out_of_combat_fov_alpha
	var/target_alpha = parent_mob.client.prefs.read_preference(pref_to_read)
	visual_shadow.alpha = target_alpha

/// When a mob logs out, delete the component
/datum/component/field_of_vision/proc/mob_logout(mob/source)
	SIGNAL_HANDLER
	qdel(src)

/datum/component/field_of_vision/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_ATOM_DIR_CHANGE, .proc/on_dir_change)
	RegisterSignal(parent, COMSIG_LIVING_DEATH, .proc/remove_mask)
	RegisterSignal(parent, COMSIG_LIVING_REVIVE, .proc/add_mask)
	RegisterSignal(parent, COMSIG_LIVING_COMBAT_MODE_TOGGLE, .proc/toggled_combat_mode)
	RegisterSignal(parent, COMSIG_MOB_LOGOUT, .proc/mob_logout)

/datum/component/field_of_vision/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, list(COMSIG_ATOM_DIR_CHANGE, COMSIG_LIVING_DEATH, COMSIG_LIVING_REVIVE, COMSIG_LIVING_COMBAT_MODE_TOGGLE, COMSIG_MOB_LOGOUT))

/mob/living
	var/has_field_of_view = TRUE
	var/fov_degrees = FOV_180_DEGREES

/mob/living/Login()
	. = ..()
	if(has_field_of_view && CONFIG_GET(flag/fov_enabled))
		AddComponent(/datum/component/field_of_vision, fov_degrees)

/mob/living/face_atom(atom/A)
	. = ..()
	if(combat_mode && client?.prefs?.read_preference(/datum/preference/toggle/combat_mode_sticky_directions))
		sticky_facing_until = world.time + 2 SECONDS

/// Is `observed_atom` in a mob's field of view? This takes blindness, nearsightness and FOV into consideration
/mob/living/proc/in_fov(atom/observed_atom, ignore_self = FALSE)
	if(ignore_self && observed_atom == src)
		return TRUE
	if(is_blind())
		return FALSE
	if(!has_field_of_view)
		return TRUE
	var/turf/my_turf = get_turf(src) //Because being inside contents of something will cause our x,y to not be updated
	// If turf doesn't exist, then we wouldn't get a fov check called by `play_fov_effect` or presumably other new stuff that might check this.
	//  ^ If that case has changed and you need that check, add it.
	var/rel_x = observed_atom.x - my_turf.x
	var/rel_y = observed_atom.y - my_turf.y

	if(rel_x == 0 && rel_y == 0) //We are on top of the person, we are in his fov
		return TRUE
	if(rel_x >= -1 && rel_x <= 1 && rel_y >= -1 && rel_y <= 1) //Cheap way to check inside that 3x3 box around you
		return TRUE
	. = FALSE

	// Converts the relative position into a 0-360 rotation
	var/vector_len = sqrt(abs(rel_x) ** 2 + abs(rel_y) ** 2)

	/// Getting a direction vector
	var/dir_x
	var/dir_y
	switch(dir)
		if(SOUTH)
			dir_x = 0
			dir_y = -vector_len
		if(NORTH)
			dir_x = 0
			dir_y = vector_len
		if(EAST)
			dir_x = vector_len
			dir_y = 0
		if(WEST)
			dir_x = -vector_len
			dir_y = 0

	///Calculate angle
	var/angle = arccos((dir_x * rel_x + dir_y * rel_y) / (sqrt(dir_x**2 + dir_y**2) * sqrt(rel_x**2 + rel_y**2)))
	
	/// Calculate vision angle and compare
	var/vision_angle = (360 - fov_degrees) / 2
	if(angle < vision_angle)
		. = TRUE

	// Handling nearsightnedness
	if(. && HAS_TRAIT(src, TRAIT_NEARSIGHT))
		if((rel_x > 3 || rel_x < -3) || (rel_y > 3 || rel_y < -3))
			return FALSE

	if(!. && observed_atom.plane != GAME_PLANE_FOV_HIDDEN) //skyrat bandaid
		return TRUE

/proc/play_fov_effect(atom/center, range, icon_state, dir = SOUTH, ignore_self = FALSE, angle = 0)
	var/turf/anchor_point = get_turf(center)
	var/image/fov_image
	for(var/mob/living/living_mob in get_hearers_in_view(range, center))
		var/client/mob_client = living_mob.client
		if(!mob_client)
			continue
		if(HAS_TRAIT(living_mob, TRAIT_DEAF)) //Deaf people can't hear sounds so no sound indicators
			continue
		if(living_mob.in_fov(center, ignore_self))
			continue
		if(!fov_image)
			fov_image = image(icon = 'modular_skyrat/modules/field_of_view/icons/fov_effects.dmi', icon_state = icon_state, loc = anchor_point)
			fov_image.plane = FULLSCREEN_PLANE
			fov_image.layer = FOV_EFFECTS_LAYER
			fov_image.dir = dir
			if(angle)
				var/matrix/matrix = new
				matrix.Turn(angle)
				fov_image.transform = matrix
				fov_image.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		mob_client.images += fov_image
		addtimer(CALLBACK(GLOBAL_PROC, .proc/remove_image_from_client, fov_image, mob_client), 30)

/atom/movable/screen/fov_blocker
	icon = 'modular_skyrat/modules/field_of_view/icons/field_of_view.dmi'
	icon_state = "90"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	plane = FIELD_OF_VISION_BLOCKER_PLANE
	screen_loc = "BOTTOM,LEFT"

/atom/movable/screen/fov_shadow
	icon = 'modular_skyrat/modules/field_of_view/icons/field_of_view.dmi'
	icon_state = "90_v"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	plane = ABOVE_LIGHTING_PLANE
	screen_loc = "BOTTOM,LEFT"
	alpha = 0

/datum/preference/numeric/out_of_combat_fov_alpha
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "out_of_combat_fov_alpha"
	savefile_identifier = PREFERENCE_PLAYER

	minimum = 0
	maximum = 255

/datum/preference/numeric/out_of_combat_fov_alpha/create_default_value()
	return 0

/datum/preference/numeric/fov_alpha
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "fov_alpha"
	savefile_identifier = PREFERENCE_PLAYER

	minimum = 0
	maximum = 255

/datum/preference/numeric/fov_alpha/create_default_value()
	return 180

/datum/preference/toggle/combat_mode_sticky_directions
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	default_value = TRUE
	savefile_key = "combat_mode_sticky_directions"
	savefile_identifier = PREFERENCE_PLAYER

/client/proc/cmd_admin_toggle_fov()
	set category = "Fun"
	set name = "Enable/Disable Field of View"

	var/static/busy_toggling_fov = FALSE
	if(!check_rights(R_ADMIN) || !check_rights(R_FUN))
		return

	var/on_off = CONFIG_GET(flag/fov_enabled)

	if(busy_toggling_fov)
		to_chat(usr, "<span class='warning'>A previous call of this function is still busy toggling FoV [on_off ? "on" : "off"]. Have some patiece</span>.")
		return
	busy_toggling_fov = TRUE

	log_admin("[key_name(usr)] has [on_off ? "disabled" : "enabled"] the Field of View configuration.")
	CONFIG_SET(flag/fov_enabled, !on_off)

	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggled Field of View", "[on_off ? "Enabled" : "Disabled"]"))

	if(on_off)
		for(var/mob/living/mob in GLOB.player_list)
			var/datum/component/field_of_vision/fov = mob.GetComponent(/datum/component/field_of_vision)
			if(fov)
				qdel(fov)
			CHECK_TICK
	else
		for(var/mob/living/mob in GLOB.player_list)
			if(mob.has_field_of_view)
				mob.AddComponent(/datum/component/field_of_vision)
			CHECK_TICK

	busy_toggling_fov = FALSE
