/datum/escape_menu/show_home_page()
	. = ..()
	page_holder.give_screen_object(
		new /atom/movable/screen/escape_menu/home_button/opfor(
			null,
			/* hud_owner = */ src,
			src,
			"OPFOR",
			/* offset = */ 3,
			CALLBACK(src, PROC_REF(home_opfor)),
		)
	)

	page_holder.give_screen_object(
		new /atom/movable/screen/escape_menu/home_button/leave_body(
			null,
			/* hud_owner = */ src,
			src,
			"Ghost",
			/* offset = */ 4,
			CALLBACK(src, PROC_REF(home_ghost)),
		)
	)

	page_holder.give_screen_object(
		new /atom/movable/screen/escape_menu/home_button/respawn(
			null,
			/* hud_owner = */ src,
			src,
			"Respawn",
			/* offset = */ 5,
			CALLBACK(src, PROC_REF(home_respawn)),
		)
	)

/datum/escape_menu/proc/home_respawn()
	PRIVATE_PROC(TRUE)
	client?.mob.abandon_mob()
	qdel(src)

/datum/escape_menu/proc/home_ghost()
	PRIVATE_PROC(TRUE)

	// Not guaranteed to be living. Everything defines verb/ghost separately. Fuck you.
	var/mob/living/living_user = client?.mob
	living_user?.ghost()
	qdel(src)

/datum/escape_menu/proc/home_opfor()
	PRIVATE_PROC(TRUE)

	// Not guaranteed to be living. Everything defines verb/ghost separately. Fuck you.
	var/mob/living/living_user = client?.mob
	living_user?.opposing_force()
	qdel(src)

/atom/movable/screen/escape_menu/home_button/respawn

/datum/escape_menu/proc/respawn()
	PRIVATE_PROC(TRUE)

	var/mob/living/client_mob = client?.mob
	client_mob?.abandon_mob()

/atom/movable/screen/escape_menu/home_button/respawn/Initialize(
	mapload,
	datum/escape_menu/escape_menu,
	button_text,
	offset,
	on_click_callback,
)
	. = ..()

/atom/movable/screen/escape_menu/home_button/respawn/enabled()
	if (!..())
		return FALSE

	return !isliving(escape_menu.client?.mob)

/atom/movable/screen/escape_menu/home_button/opfor

/atom/movable/screen/escape_menu/home_button/opfor/Initialize(
	mapload,
	datum/escape_menu/escape_menu,
	button_text,
	offset,
	on_click_callback,
)
	. = ..()

/atom/movable/screen/escape_menu/home_button/opfor/enabled()
	if (!..())
		return FALSE

	return isliving(escape_menu.client?.mob)
