/obj/item/bodypart
	/// Whether or not this bodypart can be surgically removed. Independant of the `dismemberable` variable,
	/// meaning that you can have one and not the other, both or none, and all will still work. This only
	/// affects amputation and augmentation surgeries.
	var/can_be_surgically_removed = TRUE
	/// The bodypart's currently applied style's name. Only necessary for bodyparts that come in multiple
	/// variants, like prosthetics and cyborg bodyparts.
	var/current_style = null

/obj/item/bodypart/generate_icon_key()
	RETURN_TYPE(/list)
	. = ..()
	if(current_style)
		. += "-[current_style]"

	for(var/key in markings)
		. += limb_id == "digitigrade" ? ("digitigrade_1_" + body_zone) : body_zone
		. += "-[key]_[markings[key][MARKING_INDEX_COLOR]]_[markings[key][MARKING_INDEX_EMISSIVE]]"

	return .

/**
 * # This should only be ran by augments, if you don't know what you're doing, you shouldn't be touching this.
 * A setter for the `icon_static` variable of the bodypart. Runs through `icon_exists()` for sanity, and it won't
 * change anything in the event that the check fails.
 *
 * Arguments:
 * * new_icon - The new icon filepath that you want to replace `icon_static` with.
 */
/obj/item/bodypart/proc/set_icon_static(new_icon)
	var/state_to_verify = "[limb_id]_[body_zone][is_dimorphic ? "_[limb_gender]" : ""]"
	if(icon_exists(new_icon, state_to_verify, scream = TRUE))
		icon_static = new_icon
