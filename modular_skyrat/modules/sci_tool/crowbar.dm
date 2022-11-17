/obj/item/crowbar/science
	name = "\improper Combi-Tool"
	desc = "A versatile tool made for commercial use. Comes with interchangeable cutting and prying implements."
	icon = 'modular_skyrat/modules/sci_tool/icons/sci_tool.dmi'
	icon_state = "combitool"
	inhand_icon_state = "combitool"
	worn_icon_state = null
	belt_icon_state = null
	lefthand_file = 'modular_skyrat/modules/sci_tool/icons/sci_tool_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/sci_tool/icons/sci_tool_righthand.dmi'
	custom_materials = list(/datum/material/iron = 3000, /datum/material/silver = 1500, /datum/material/titanium = 2000)
	usesound = 'sound/items/jaws_pry.ogg'
	force = 8
	throwforce = 8
	throw_speed = 2
	throw_range = 3
	attack_verb_continuous = list("jabs", "whacks")
	attack_verb_simple = list("jab", "whack")
	hitsound = 'sound/items/drill_hit.ogg'
	usesound = 'sound/items/drill_use.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 0.85
	force_opens = FALSE

/obj/item/crowbar/science/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/transforming, \
		force_on = force, \
		throwforce_on = throwforce, \
		hitsound_on = hitsound, \
		w_class_on = w_class, \
		clumsy_check = FALSE)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, .proc/on_transform)

/*
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 *
 * Toggles between crowbar and wirecutters and gives feedback to the user.
 */
/obj/item/crowbar/science/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER
	tool_behaviour = (active ? TOOL_WIRECUTTER : TOOL_CROWBAR)
	balloon_alert(user, "attached [active ? "cutting" : "prying"]")
	playsound(user ? user : src, 'sound/items/change_drill.ogg', 50, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE