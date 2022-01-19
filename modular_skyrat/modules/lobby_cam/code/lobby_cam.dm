/atom/movable/screen/skyrat_logo
	name = "Skyrat Station"
	icon = 'modular_skyrat/modules/lobby_cam/icons/skyrat_logo.dmi'
	icon_state = "skyrat_logo"
	screen_loc = "1:16,1:16"
	plane = SKYRAT_LOGO
	alpha = 0

/atom/movable/screen/movable/black_fade
	name = "black screen"
	icon = 'modular_skyrat/modules/lobby_cam/icons/black_screen.dmi'
	icon_state = "1"
	screen_loc = "SOUTHWEST to NORTHEAST"
	plane = BLACK_FADE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/mob/dead/new_player/Login()
	. = ..()
	var/atom/movable/screen/skyrat_logo/logo_screen = new()
	if (client && SSticker.current_state < GAME_STATE_PLAYING)
		client.screen += logo_screen
		animate(logo_screen, alpha = 255, time = 5 SECONDS)

/obj/new_player_cam
	name = "floor"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	density = FALSE
	anchored = TRUE
	alpha = 0
	invisibility = INVISIBILITY_ABSTRACT

	///how many tiles the camera will do
	var/path_target = 20
	///how many tiles into invalid areas can we go
	var/invalid_reset = 5
	///the areas that are considered invalid
	var/static/list/invalid_areas = list(/area/space, /area/icemoon)
	///how fast the camera will "move"
	var/moving_speed = 2
	///the screen that will fade in and out
	var/atom/movable/screen/movable/black_fade/fading_screen
	///the distance we want to be from the previous location
	var/previous_distance = 40

/obj/new_player_cam/Destroy(force)
	unlock_eyes()
	QDEL_NULL(fading_screen)
	return ..()

/obj/new_player_cam/proc/lock_eyes()
	for(var/mob/checking_mob in GLOB.new_player_list)
		if(!checking_mob.client)
			continue
		if(SSticker.current_state < GAME_STATE_PREGAME)
			continue
		if(!(fading_screen in checking_mob.client.screen))
			checking_mob.client.screen += fading_screen
		if(checking_mob.client.eye != src)
			checking_mob.client.eye = src
		if(checking_mob.lighting_alpha != LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE)
			checking_mob.lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE

/obj/new_player_cam/proc/unlock_eyes()
	for(var/mob/checking_mob in GLOB.new_player_list)
		if(!checking_mob.client)
			continue
		if(fading_screen && (fading_screen in checking_mob.client.screen))
			checking_mob.client.screen -= fading_screen
		if(checking_mob.client.eye != src)
			return
		checking_mob.client.eye = checking_mob.client.mob

/obj/new_player_cam/proc/fade_logo()
	for(var/mob/checking_mob in GLOB.new_player_list)
		var/atom/movable/screen/skyrat_logo/logo_screen = locate() in checking_mob.client.screen
		if(logo_screen?.alpha == 255)
			animate(logo_screen, alpha = 0, time = 5 SECONDS)

/obj/new_player_cam/New()
	fading_screen = new()
	spawn(0)
		while(TRUE)
			var/time_remaining = SSticker.GetTimeLeft()
			if(time_remaining <= 10 SECONDS && SSticker.current_state == GAME_STATE_PREGAME)
				unlock_eyes()
				fade_logo()
				sleep(5)
				continue
			//we wont work if its not GAME_STATE_PREGAME
			if(SSticker.current_state < GAME_STATE_PREGAME | SSticker.current_state > GAME_STATE_PREGAME)
				unlock_eyes()
				if(SSticker.current_state > GAME_STATE_PREGAME)
					loc = null
				sleep(5)
				continue

			//find a starting location
			var/turf/starting_turf = get_safe_random_station_turf()

			//plan out our path
			var/list/pathway = list(starting_turf)
			var/chosen_direction = pick(GLOB.cardinals)
			var/turf/chosen_turf = starting_turf
			var/invalid_crossed = 0
			for(var/creating_pathway in 1 to path_target)
				chosen_turf = get_step(chosen_turf, chosen_direction)
				if(!chosen_turf)
					break
				if(is_type_in_list(get_area(chosen_turf), invalid_areas))
					invalid_crossed++
				if(invalid_crossed >= invalid_reset)
					break
				pathway += chosen_turf

			//set location and lock eyes
			loc = starting_turf
			lock_eyes()

			//do the fade in
			var/alpha_sync = TRUE
			spawn(0)
				for(var/iteration_one = 1, iteration_one < 11, iteration_one++)
					if(!alpha_sync)
						break
					fading_screen.icon_state = "[iteration_one]"
					sleep(1)
				fading_screen.icon_state = "11"

			sleep(moving_speed)

			//start moving
			for(var/turf/moving_turf in pathway)
				if(SSticker.current_state >= GAME_STATE_PLAYING)
					qdel()
					return
				loc = moving_turf
				sleep(moving_speed)

			//do the fade out
			alpha_sync = FALSE
			for(var/iteration_two = 11, iteration_two > 1, iteration_two--)
				fading_screen.icon_state = "[iteration_two]"
				sleep(1)
			fading_screen.icon_state = "1"

			sleep(1)
