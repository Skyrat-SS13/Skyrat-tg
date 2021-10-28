#define ceil(x) (-round(-(x)))
/client
	var/obj/skybox/skybox
	var/last_view_x_dim = 7
	var/last_view_y_dim = 7

	verb/SetWindowIconSize(var/val as num|text)
		set hidden = 1
		winset(src, "mapwindow.map", "icon-size=[val]")
		if(prefs && val != prefs.icon_size)
			prefs.icon_size = val
	//		SScharacter_setup.queue_preferences_save(prefs) // no SS
		OnResize()
	verb/OnResize()
		set hidden = 1

		var/divisor = text2num(winget(src, "mapwindow.map", "icon-size")) || world.icon_size
		if(!isnull(config.lock_client_view_x) && !isnull(config.lock_client_view_y))
			last_view_x_dim = config.lock_client_view_x
			last_view_y_dim = config.lock_client_view_y
		else
			var/winsize_string = winget(src, "mapwindow.map", "size")
			last_view_x_dim = config.lock_client_view_x || clamp(ceil(text2num(winsize_string) / divisor), 15, config.max_client_view_x || 41)
			last_view_y_dim = config.lock_client_view_y || clamp(ceil(text2num(copytext(winsize_string,findtext(winsize_string,"x")+1,0)) / divisor), 15, config.max_client_view_y || 41)
			if(last_view_x_dim % 2 == 0) last_view_x_dim++
			if(last_view_y_dim % 2 == 0) last_view_y_dim++
		for(var/check_icon_size in global.valid_icon_sizes)
			winset(src, "menu.icon[check_icon_size]", "is-checked=false")
		winset(src, "menu.icon[divisor]", "is-checked=true")

		view = "[last_view_x_dim]x[last_view_y_dim]"

		// Reset eye/perspective
		var/last_perspective = perspective
		perspective = MOB_PERSPECTIVE
		if(perspective != last_perspective)
			perspective = last_perspective
		var/last_eye = eye
		eye = mob
		if(eye != last_eye)
			eye = last_eye

		// Recenter skybox and lighting.
		if(mob)
			mob.reload_fullscreen()
	verb/force_onresize_view_update()
		set name = "Force Client View Update"
		set src = usr
		set category = "Debug"
		OnResize()

	verb/show_winset_debug_values()
		set name = "Show Client View Debug Values"
		set src = usr
		set category = "Debug"

		var/divisor = text2num(winget(src, "mapwindow.map", "icon-size")) || world.icon_size
		var/winsize_string = winget(src, "mapwindow.map", "size")

		to_chat(usr, "Current client view: [view]")
		to_chat(usr, "Icon size: [divisor]")
		to_chat(usr, "xDim: [round(text2num(winsize_string) / divisor)]")
		to_chat(usr, "yDim: [round(text2num(copytext(winsize_string,findtext(winsize_string,"x")+1,0)) / divisor)]")
	// proc/set_skybox_offsets(var/x_dim, var/y_dim) // No skybox on TG code.
	// 	if(!skybox)
	// 		update_skybox()
	// 	if(skybox)
	// 		skybox.base_x_dim = x_dim
	// 		skybox.base_y_dim = y_dim
	// 		skybox.base_offset_x = -((world.icon_size * skybox.base_x_dim)/2)
	// 		skybox.base_offset_y = -((world.icon_size * skybox.base_y_dim)/2)

	// 		// Check if the skybox needs to be scaled to fit large displays.
	// 		var/new_max_tile_bound = max(skybox.base_x_dim, skybox.base_y_dim)
	// 		var/old_max_tile_bound = 736/world.icon_size
	// 		if(new_max_tile_bound > old_max_tile_bound)
	// 			var/matrix/M = matrix()
	// 			M.Scale(1 + (new_max_tile_bound/old_max_tile_bound))
	// 			skybox.transform = M
	// 		else
	// 			skybox.transform = null
	// 		update_skybox()

	// proc/update_skybox(rebuild)
	// 	if(!skybox)
	// 		skybox = new()
	// 		screen += skybox
	// 		rebuild = 1
	// 	var/turf/T = get_turf(eye)
	// 	if(T)
	// 		if(rebuild)
	// 			skybox.overlays.Cut()
	// 			skybox.overlays += SSskybox.get_skybox(T.z)
	// 			screen |= skybox
	// 		skybox.screen_loc = "CENTER:[skybox.base_offset_x - T.x],CENTER:[skybox.base_offset_y - T.y]"


/datum/controller/configuration
	var/lock_client_view_x
	var/lock_client_view_y
	var/max_client_view_x
	var/max_client_view_y

/datum/preferences
	var/icon_size = 64


var/global/list/valid_icon_sizes = list(32, 48, 64, 96, 128)

/datum/hud
	var/icon_size = 64
