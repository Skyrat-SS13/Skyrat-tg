/datum/hud
	var/atom/movable/screen/holomap

/datum/hud/New(mob/owner)
	. = ..()

	holomap = new /atom/movable/screen()
	holomap.name = "holomap"
	holomap.icon = null
	holomap.screen_loc = ui_holomap
	holomap.mouse_opacity = 0
