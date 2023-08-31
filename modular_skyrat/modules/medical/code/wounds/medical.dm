#define SELF_AID_REMOVE_DELAY 5 SECONDS
#define OTHER_AID_REMOVE_DELAY 2 SECONDS

/obj/item/stack/medical/gauze
	/// TODO: DOC
	var/datum/bodypart_aid/bodypart_aid
	var/integrity = 2
	var/obj/item/bodypart/bodypart
	var/splint_prefix = "splint"
	var/gauze_prefix = "gauze"
	var/can_splint = TRUE

/**
 * rip_off() called when someone rips it off
 *
 * It will return the bandage if it's considered pristine
 *
 */

/obj/item/bodypart/apply_gauze(obj/item/stack/gauze)
	RegisterSignal(src, COMSIG_BODYPART_GAUZED, PROC_REF(got_gauzed))

	. = ..()

	UnregisterSignal(src, COMSIG_BODYPART_GAUZED)

/obj/item/bodypart/proc/got_gauzed(datum/signal_source, obj/item/stack/medical/gauze/new_gauze)
	SIGNAL_HANDLER

	if (istype(current_gauze, /obj/item/stack/medical/gauze))
		var/obj/item/stack/medical/gauze/applied_gauze = current_gauze
		applied_gauze.set_limb(src) // new_gauze isnt actually the gauze that was applied weirdly

/obj/item/stack/medical/gauze/Destroy()
	bodypart?.current_gauze = null
	bodypart?.owner?.update_bandage_overlays()
	set_limb(null)
	return ..()

/obj/item/stack/medical/gauze/proc/rip_off()
	if (is_pristine())
		. = new src.type(null, 1)
		bodypart?.owner?.update_bandage_overlays()
	qdel(src)

/obj/item/stack/medical/gauze/proc/get_overlay_prefix()
	var/splinting = is_splinting()
	if (can_splint)
		for (var/datum/wound/iterated_wound as anything in bodypart.wounds)
			if (iterated_wound.wound_flags & SPLINT_OVERLAY)
				splinting = TRUE
				break

	var/prefix
	if (splinting)
		prefix = splint_prefix
	else
		prefix = gauze_prefix

	var/suffix = bodypart.body_zone
	if(bodypart.bodytype & BODYTYPE_DIGITIGRADE)
		suffix += "_digitigrade"

	return "[prefix]_[suffix]"

/obj/item/stack/medical/gauze/proc/is_splinting()
	SHOULD_BE_PURE(TRUE)

	if (!can_splint)
		return FALSE

	for (var/datum/wound/iterated_wound as anything in bodypart.wounds)
		if (iterated_wound.wound_flags & SPLINT_OVERLAY)
			return TRUE

	return FALSE

/**
 * is_pristine() called by rip_off()
 *
 * Used to determine whether the bandage can be re-used and won't qdel itself
 *
 */

/obj/item/stack/medical/gauze/proc/is_pristine()
	return (integrity == initial(integrity))

/**
 * take_damage() called when the bandage gets damaged
 *
 * This proc will subtract integrity and delete the bandage with a to_chat message to whoever was bandaged
 *
 */

/obj/item/stack/medical/gauze/proc/get_hit()
	integrity--
	if(integrity <= 0)
		if(bodypart.owner)
			to_chat(bodypart.owner, span_warning("The [name] on your [bodypart.name] tears and falls off!"))
		qdel(src)

/obj/item/stack/medical/gauze/Topic(href, href_list)
	. = ..()
	if(href_list["remove"])
		if(!bodypart.owner)
			return
		if(!iscarbon(usr))
			return
		if(!in_range(usr, bodypart.owner))
			return
		var/mob/living/carbon/C = usr
		var/self = (C == bodypart.owner)
		C.visible_message(span_notice("[C] begins removing [name] from [self ? "[bodypart.owner.p_Their()]" : "[bodypart.owner]'s" ] [bodypart.name]..."), span_notice("You begin to remove [name] from [self ? "your" : "[bodypart.owner]'s"] [bodypart.name]..."))
		if(!do_after(C, (self ? SELF_AID_REMOVE_DELAY : OTHER_AID_REMOVE_DELAY), target=bodypart.owner))
			return
		if(QDELETED(src))
			return
		C.visible_message(span_notice("[C] removes [name] from [self ? "[bodypart.owner.p_Their()]" : "[bodypart.owner]'s" ] [bodypart.name]."), span_notice("You remove [name] from [self ? "your" : "[bodypart.owner]'s" ] [bodypart.name]."))
		var/obj/item/gotten = rip_off()
		if(gotten && !C.put_in_hands(gotten))
			gotten.forceMove(get_turf(C))

/// limb is nullable
/obj/item/stack/medical/gauze/proc/set_limb(limb)
	bodypart = limb
	bodypart?.owner?.update_bandage_overlays()

/obj/item/stack/proc/get_gauze_description()
	return "[name]"

/obj/item/stack/proc/get_gauze_usage_prefix()
	return "bandaged"

/obj/item/stack/medical/gauze/get_gauze_usage_prefix()
	if (is_splinting())
		return "fastened"
	else
		return ..()

/obj/item/stack/medical/gauze/proc/has_overlay()
	return (!isnull(gauze_prefix) && !isnull(splint_prefix))

/obj/item/stack/medical/gauze/improvised
	splint_prefix = "splint_improv"
