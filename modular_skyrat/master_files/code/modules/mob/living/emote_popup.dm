/obj/effect/overlay/emote_popup
	icon = 'modular_skyrat/master_files/icons/mob/popup_flicks.dmi'
	icon_state = "combat"
	layer = FLY_LAYER
	plane = GAME_PLANE
	appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART
	mouse_opacity = 0

/**
 * Flick_emote_popup_on_(???) -- A proc type that, when called, causes a image/sprite to appear above whatever entity it is called on.
 *
 * There are two types: On_mob and on_obj, they can only be called on their respective typepaths.
 *
 * Arguments:
 * * state -- The ID of whatever .dmi file you're attempting to use for the sprite, in "" format. Ex. "combat", not combat.dmi.
 * * time -- The amount of time the sprite remains before remove_emote_popup_on_(???) is called. Is used in the addtimer.
 */
/mob/living/proc/flick_emote_popup_on_mob(state, time)
	var/obj/effect/overlay/emote_popup/emote_overlay = new
	emote_overlay.icon_state = state
	vis_contents += emote_overlay
	animate(emote_overlay, alpha = 255, time = 5, easing = BOUNCE_EASING, pixel_y = 10)
	addtimer(CALLBACK(src, .proc/remove_emote_popup_on_mob, emote_overlay), time)

/**
 * Flick_emote_popup_on_(???) -- A proc type that, when called, causes a image/sprite to appear above whatever entity it is called on.
 *
 * There are two types: On_mob and on_obj, they can only be called on their respective typepaths.
 *
 * Arguments:
 * * state -- The ID of whatever .dmi file you're attempting to use for the sprite, in "" format. Ex. "combat", not combat.dmi.
 * * time -- The amount of time the sprite remains before remove_emote_popup_on_(???) is called. Is used in the addtimer.
 */

/obj/proc/flick_emote_popup_on_obj(state, time)
	var/obj/effect/overlay/emote_popup/emote_overlay = new
	emote_overlay.icon_state = state
	vis_contents += emote_overlay
	animate(emote_overlay, alpha = 255, time = 5, easing = BOUNCE_EASING, pixel_y = 10)
	addtimer(CALLBACK(src, .proc/remove_emote_popup_on_obj, emote_overlay), time)

/**
 * remove_emote_popup_on_(???) -- A proc that is automatically called whenever flick_emote_popup_on_(???)'s addtimer expires.
 *
 * There are two types: On_mob and on_obj, they can only be called on their respective typepaths.
 *
 * Arguments:
 * * emote_overlay -- Inherits state from the preceding proc.
 */

/mob/living/proc/remove_emote_popup_on_mob(obj/effect/overlay/emote_popup/emote_overlay)
	vis_contents -= emote_overlay
	qdel(emote_overlay)
	return

/**
 * remove_emote_popup_on_(???) -- A proc that is automatically called whenever flick_emote_popup_on_(???)'s addtimer expires.
 *
 * There are two types: On_mob and on_obj, they can only be called on their respective typepaths.
 *
 * Arguments:
 * * emote_overlay -- Inherits state from the preceding proc.
 */

/obj/proc/remove_emote_popup_on_obj(obj/effect/overlay/emote_popup/emote_overlay)
	vis_contents -= emote_overlay
	qdel(emote_overlay)
	return
