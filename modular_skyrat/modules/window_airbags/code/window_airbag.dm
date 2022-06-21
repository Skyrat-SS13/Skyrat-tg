/obj/structure/window/reinforced/fulltile/Initialize(mapload, direct)
	. = ..()
	AddElement(/datum/element/airbag)

/**
 * Airbag Element
 *
 * Basically a fancy create on destroy. I would love to add a disarm function, but that would mean it would need to be a component.
 *
 * And since this is going on every window, an element is more reasonable for performance :)
 */
/datum/element/airbag
	/// The type we spawn when our parent is destroyed
	var/airbag_type = /obj/item/airbag/immediate_arm

/datum/element/airbag/Attach(datum/target, airbag_type_override)
	. = ..()
	if(!ismovable(target))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_ATOM_DESTRUCTION, .proc/deploy_airbag)
	RegisterSignal(target, COMSIG_PARENT_EXAMINE, .proc/on_examine)

/datum/element/airbag/Detach(datum/target)
	UnregisterSignal(target, list(COMSIG_ATOM_DESTRUCTION, COMSIG_PARENT_EXAMINE))

/datum/element/airbag/proc/deploy_airbag(atom/movable/destroying_atom, damage_flag)
	SIGNAL_HANDLER

	new airbag_type(get_turf(destroying_atom))

/datum/element/airbag/proc/on_examine(datum/source, mob/user, list/examine_text)
	SIGNAL_HANDLER

	examine_text += span_warning("It has a blinking red light indicating an airbag is primed and ready to trigger on harsh impact.")



// A fun little gadget!
/obj/item/airbag
	name = "airbag"
	desc = "A small package with an explosive package attached."
	icon = 'modular_skyrat/modules/inflatables/icons/inflatable.dmi'
	icon_state = "airbag_safe"
	base_icon_state = "airbag"
	/// The time in which we deploy
	var/detonate_time = 6.7 SECONDS
	/// The item we drop on detonation
	var/drop_type = /obj/structure/inflatable/window_airbag
	/// Are we immediately armed?
	var/immediate_arm = FALSE
	/// Are we currently armed?
	var/armed = FALSE
	/// The sound we play when armed
	var/armed_sound = 'modular_skyrat/modules/window_airbags/sound/airbag_arm.ogg'
	/// The sound we play when we go bang
	var/bang_sound = 'modular_skyrat/modules/window_airbags/sound/airbag_bang.ogg'

/obj/item/airbag/Initialize(mapload)
	. = ..()
	if(immediate_arm)
		arm()
		anchored = TRUE

/obj/item/airbag/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[armed ? "armed" : "safe"]"

/obj/item/airbag/proc/arm()
	if(armed)
		return
	balloon_alert_to_viewers("armed!")
	if(!anchored)
		addtimer(CALLBACK(src, .proc/deploy_anchor), 1 SECONDS)
	addtimer(CALLBACK(src, .proc/bang), detonate_time, TIMER_CLIENT_TIME)
	armed = TRUE
	playsound(src, armed_sound, 100)
	update_appearance()

/obj/item/airbag/proc/deploy_anchor()
	if(!isturf(loc) || anchored)
		return
	balloon_alert_to_viewers("anchor deployed!")
	anchored = TRUE

/obj/item/airbag/proc/bang()
	var/obj/created_object = new drop_type(get_turf(src))
	playsound(src, bang_sound, 100)
	do_smoke(1, 1, created_object, get_turf(src))
	qdel(src)

/obj/item/airbag/immediate_arm
	immediate_arm = TRUE

/obj/structure/inflatable/window_airbag
	name = "window airbag"
	desc = "A quick deploying airbag that seals holes when a window is broken!"
	icon_state = "airbag_wall"
	torn_type = null // No debris left behind!
	deflated_type = null
