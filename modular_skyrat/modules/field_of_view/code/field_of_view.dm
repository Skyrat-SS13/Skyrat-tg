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

/mob/living/Login()
	. = ..()
	if(has_field_of_view && CONFIG_GET(flag/fov_enabled))
		AddComponent(/datum/component/field_of_vision)

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

/mob/living/face_atom(atom/A)
	. = ..()
	if(combat_mode && client?.prefs?.read_preference(/datum/preference/toggle/combat_mode_sticky_directions))
		sticky_facing_until = world.time + 2 SECONDS

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
