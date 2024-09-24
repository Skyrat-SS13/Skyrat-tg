
/**
 * Face decal component
 *
 * For when you have some dirt on your face
 */

/datum/component/face_decal
	dupe_mode = COMPONENT_DUPE_HIGHLANDER
	/// Overlay we use for non-carbon mobs
	var/mutable_appearance/normal_overlay
	/// Bodypart overlay we use for carbon mobs
	var/datum/bodypart_overlay/simple/bodypart_overlay
	/// Cached head for carbons, to ensure proper removal of our overlay
	var/obj/item/bodypart/my_head
	/// Base icon state we use for the effect
	var/icon_state
	/// Layers for the bodypart_overlay to draw on
	var/layers
	/// Color that the overlay is modified by
	var/color

/datum/component/face_decal/Initialize(icon_state, layers, color)
	src.icon_state = icon_state
	src.layers = layers
	src.color = color

/datum/component/face_decal/Destroy(force)
	. = ..()
	normal_overlay = null
	my_head = null
	QDEL_NULL(bodypart_overlay)

/datum/component/face_decal/RegisterWithParent()
	if(iscarbon(parent))
		var/mob/living/carbon/human/carbon_parent = parent
		my_head = carbon_parent.get_bodypart(BODY_ZONE_HEAD)
		if(!my_head) //just to be sure
			qdel(src)
			return
		bodypart_overlay = new()
		bodypart_overlay.layers = layers
		if(carbon_parent.bodyshape & BODYSHAPE_SNOUTED) //stupid, but external organ bodytypes are not stored on the limb
			bodypart_overlay.icon_state = "[icon_state]_lizard"
		else if(my_head.bodyshape & BODYSHAPE_MONKEY)
			bodypart_overlay.icon_state = "[icon_state]_monkey"
		else
			bodypart_overlay.icon_state = "[icon_state]_human"
		if (!isnull(color))
			bodypart_overlay.draw_color = color
		my_head.add_bodypart_overlay(bodypart_overlay)
		RegisterSignals(my_head, list(COMSIG_BODYPART_REMOVED, COMSIG_QDELETING), PROC_REF(lost_head))
		carbon_parent.update_body_parts()
	else
		normal_overlay = get_normal_overlay()

	RegisterSignals(parent, list(
		COMSIG_COMPONENT_CLEAN_ACT,
		COMSIG_COMPONENT_CLEAN_FACE_ACT),
		PROC_REF(clean_up)
	)

	if (!isnull(normal_overlay))
		if (!isnull(color))
			normal_overlay.color = color
		var/atom/atom_parent = parent
		RegisterSignal(atom_parent, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(update_overlays))
		atom_parent.update_appearance()

/datum/component/face_decal/proc/get_normal_overlay()
	return

/datum/component/face_decal/UnregisterFromParent()
	UnregisterSignal(parent, list(
		COMSIG_COMPONENT_CLEAN_ACT,
		COMSIG_COMPONENT_CLEAN_FACE_ACT))
	if(my_head)
		if(bodypart_overlay)
			my_head.remove_bodypart_overlay(bodypart_overlay)
			if(!my_head.owner)
				my_head.update_icon_dropped()
			QDEL_NULL(bodypart_overlay)
		UnregisterSignal(my_head, list(COMSIG_BODYPART_REMOVED, COMSIG_QDELETING))
		my_head = null
	if(iscarbon(parent))
		var/mob/living/carbon/carbon_parent = parent
		carbon_parent.update_body_parts()
	if(normal_overlay)
		var/atom/atom_parent = parent
		UnregisterSignal(atom_parent, COMSIG_ATOM_UPDATE_OVERLAYS)
		atom_parent.update_appearance()
		normal_overlay = null

///Callback to remove our decal
/datum/component/face_decal/proc/clean_up(datum/source, clean_types)
	SIGNAL_HANDLER

	if(!(clean_types & CLEAN_TYPE_BLOOD))
		return NONE

	qdel(src)
	return COMPONENT_CLEANED

/// Ensures normal_overlay overlay in case the mob is not a carbon
/datum/component/face_decal/proc/update_overlays(atom/parent_atom, list/overlays)
	SIGNAL_HANDLER

	if(normal_overlay)
		overlays += normal_overlay

/// Removes the decal when the head gets dismembered
/datum/component/face_decal/proc/lost_head(obj/item/bodypart/source, mob/living/carbon/owner, dismembered)
	SIGNAL_HANDLER
	qdel(src)

/// Creampie subtype, handling signals and mood logic

GLOBAL_LIST_INIT(creamable, typecacheof(list(
	/mob/living/carbon/human,
	/mob/living/basic/pet/dog/corgi,
	/mob/living/silicon/ai,
)))

/datum/component/face_decal/creampie/Initialize()
	. = ..()
	if(!is_type_in_typecache(parent, GLOB.creamable))
		return COMPONENT_INCOMPATIBLE

	SEND_SIGNAL(parent, COMSIG_MOB_CREAMED, src)
	add_memory_in_range(parent, 7, /datum/memory/witnessed_creampie, protagonist = parent)

/datum/component/face_decal/creampie/get_normal_overlay()
	if(iscorgi(parent))
		return mutable_appearance('icons/mob/effects/creampie.dmi', "[icon_state]_corgi")

	if(isAI(parent))
		return mutable_appearance('icons/mob/effects/creampie.dmi', "[icon_state]_ai")

/datum/component/face_decal/creampie/RegisterWithParent()
	. = ..()
	if(iscarbon(parent))
		var/mob/living/carbon/human/carbon_parent = parent
		carbon_parent.add_mood_event("creampie", /datum/mood_event/creampie)

/datum/component/face_decal/creampie/UnregisterFromParent()
	. = ..()
	if(iscarbon(parent))
		var/mob/living/carbon/carbon_parent = parent
		carbon_parent.clear_mood_event("creampie")
