/obj/structure/window/reinforced/fulltile/Initialize(mapload, direct)
	. = ..()
	AddElement(/datum/element/airbag)

/obj/structure/inflatable/window_airbag
	name = "window airbag"
	desc = "A quick deploying airbag that seals holes when a window is broken!"
	icon_state = "airbag_wall"
	torn_type = null // No debris left behind!
	deflated_type = null

/datum/element/airbag
	/// The type we spawn when our parent is destroyed
	var/airbag_type = /obj/structure/inflatable/window_airbag

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
