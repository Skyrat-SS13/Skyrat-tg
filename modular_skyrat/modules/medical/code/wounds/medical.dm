/obj/item/stack/medical/gauze
	/// TODO: DOC
	var/datum/bodypart_aid/bodypart_aid
	var/integrity = 2
	var/obj/item/bodypart/bodypart
	var/splint_prefix = "splint"
	var/gauze_prefix = "gauze"

/**
 * rip_off() called when someone rips it off
 *
 * It will return the bandage if it's considered pristine
 *
 */

/obj/item/stack/medical/gauze/Destroy()
	if(overlay_prefix && bodypart?.owner)
		bodypart.owner.update_bandage_overlays()
	bodypart = null
	return ..()

/obj/item/stack/medical/gauze/proc/set_limb(obj/item/bodypart/limb)
	bodypart = limb
	if (overlay_prefix && bodypart?.owner)
		bodypart.owner.update_bandage_overlays()

/obj/item/stack/medical/gauze/proc/rip_off()
	if(is_pristine())
		. = new src.type(null, 1)
	qdel(src)

/obj/item/stack/medical/gauze/proc/get_overlay_prefix()
	var/splinting = FALSE
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
	if(BP.bodytype & BODYTYPE_DIGITIGRADE)
		suffix += "_digitigrade"

	return "[prefix]_[suffix]"

/**
 * get_description() called by examine procs
 *
 * It will returns a description of the bandage
 *
 */

/datum/bodypart_aid/proc/get_description()
	return "[name]"

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
