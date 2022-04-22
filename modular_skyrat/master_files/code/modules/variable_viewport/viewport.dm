#define ceil(x) (-round(-(x)))
/client
	var/obj/skybox/skybox
	var/last_view_x_dim = 7
	var/last_view_y_dim = 7



/client/verb/SetWindowIconSize(var/val as num|text)
	set hidden = 1
	winset(src, "mapwindow.map", "icon-size=[val]")
	if(val != prefs?.icon_size)
		prefs.icon_size = val
		prefs.save_preferences()
	OnResize()
/client/verb/OnResize()
	set hidden = 1
	if(!prefs.read_preference(/datum/preference/toggle/widescreen))
		return


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
	mob?.reload_fullscreen()
	// What's this batman? A HACK?!
	change_view(getScreenSize(prefs.read_preference(/datum/preference/toggle/widescreen))) //This is kept around as a hack to fix strange darkness issues when swapping mobs.

/client/verb/force_onresize_view_update()
	set name = "Force Client View Update"
	set src = usr
	set category = "Debug"
	OnResize()

/client/verb/show_winset_debug_values()
	set name = "Show Client View Debug Values"
	set src = usr
	set category = "Debug"

	var/divisor = text2num(winget(src, "mapwindow.map", "icon-size")) || world.icon_size
	var/winsize_string = winget(src, "mapwindow.map", "size")

	to_chat(usr, "Current client view: [view]")
	to_chat(usr, "Icon size: [divisor]")
	to_chat(usr, "xDim: [round(text2num(winsize_string) / divisor)]")
	to_chat(usr, "yDim: [round(text2num(copytext(winsize_string,findtext(winsize_string,"x")+1,0)) / divisor)]")

/client/verb/fix_viewport()
	set name = "Fix Viewport Bug"
	set category = "Debug"
	change_view(getScreenSize(prefs.read_preference(/datum/preference/toggle/widescreen))) //This is kept around as a hack to fix strange darkness issues when swapping mobs.
	SetWindowIconSize(prefs.icon_size)

/client/attempt_auto_fit_viewport()
	if((prefs?.read_preference(/datum/preference/toggle/widescreen)))
		return
	. = ..()
/client/change_view(new_size)
	if((!prefs?.read_preference(/datum/preference/toggle/widescreen)))
		. = ..()
	else
//		SetWindowIconSize(prefs.icon_size)
		mob?.hud_used?.screentip_text.update_view()
		apply_clickcatcher()
		mob?.reload_fullscreen()

/mob/Login()
	. = ..()
//	if(client)
	client?.change_view(getScreenSize(client.prefs.read_preference(/datum/preference/toggle/widescreen)))  //This is kept around as a hack to fix strange darkness issues when swapping mobs. Yeah, you can notice this when aghosting. Also done on /client/new
	//	client.SetWindowIconSize(client.prefs.icon_size)
/datum/controller/configuration
	var/lock_client_view_x
	var/lock_client_view_y

//Limits for the view range
	var/max_client_view_x = 50
	var/max_client_view_y = 50

/datum/preferences
	var/icon_size = 64


var/global/list/valid_icon_sizes = list(32, 48, 64, 96, 128)

/datum/hud
	var/icon_size = 64
