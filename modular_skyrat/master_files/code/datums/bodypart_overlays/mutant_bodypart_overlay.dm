/// The greatest amount of colors that can be in a matrixed bodypart_overlay.
#define MAX_MATRIXED_COLORS 3
/// Default value for alpha, making it fully opaque.
#define ALPHA_OPAQUE 255

/datum/bodypart_overlay/mutant
	/// Alpha value associated to the overlay, to be inherited from the parent limb.
	var/alpha = ALPHA_OPAQUE
	/// An associative list of color indexes (i.e. "1") to boolean that says
	/// whether or not that color should get an emissive overlay. Can be null.
	var/list/emissive_eligibility_by_color_index
	/// A simple list of indexes to color (as we don't want to color emissives, MOD overlays or inner ears)
	var/list/overlay_indexes_to_color
	/// Whether or not this overlay can be affected by MODsuit-related procs.
	var/modsuit_affected = FALSE
	/// Additional information we might want to add to the cache_key, stored into a list.
	/// Should only ever contain strings.
	var/list/cache_key_extra_information
	/// A simple cache of what the last icon_states built were.
	/// It's really only there to help with debugging what's happening.
	var/list/last_built_icon_states


/**
 * Allows us to set the appearance from data that's located within the provided DNA,
 * for a little more control over what exactly is displayed.
 *
 * Arguments:
 * * dna - The `/datum/dna` datum from which we're going to be extracting the data to set the
 * appearance.
 */
/datum/bodypart_overlay/mutant/proc/set_appearance_from_dna(datum/dna/dna)
	sprite_datum = fetch_sprite_datum_from_name(dna.mutant_bodyparts[feature_key][MUTANT_INDEX_NAME])
	modsuit_affected = sprite_datum.use_custom_mod_icon
	draw_color = dna.mutant_bodyparts[feature_key][MUTANT_INDEX_COLOR_LIST]
	build_emissive_eligibility(dna.mutant_bodyparts[feature_key][MUTANT_INDEX_EMISSIVE_LIST])
	cache_key = jointext(generate_icon_cache(), "_")


// We do this here like this so that we handle matrixed color bodypart overlays and emissives.
/datum/bodypart_overlay/mutant/get_overlay(layer, obj/item/bodypart/limb)
	layer = bitflag_to_layer(layer)
	. = get_images(layer, limb)
	color_images(., layer, limb)
	. = add_emissives(., limb)


/// Generate a unique key based on our sprites. So that if we've aleady drawn these sprites,
/// they can be found in the cache and wont have to be drawn again (blessing and curse, but mostly curse)
/datum/bodypart_overlay/mutant/generate_icon_cache()
	. = list()
	. += "[get_base_icon_state()]"
	. += "[get_feature_key_for_overlay()]"

	. += cache_key_extra_information // We can do it like this because it's meant to be a list of strings anyway. BYOND list operations actually being useful for once.

	if(islist(draw_color))
		for(var/sub_color in draw_color)
			. += "[sub_color]"

	else
		. += "[draw_color]"

	if(alpha != ALPHA_OPAQUE)
		. += "[alpha]"

	if(emissive_eligibility_by_color_index)
		for(var/index in emissive_eligibility_by_color_index)
			. += "[emissive_eligibility_by_color_index[index]]"

	return .


/**
 * Helper to fetch the `feature_key` of the bodypart_overlay, so that it can be
 * overriden in the cases where `feature_key` is not what we want to use here.
 */
/datum/bodypart_overlay/mutant/proc/get_feature_key_for_overlay()
	return feature_key


/datum/bodypart_overlay/mutant/can_draw_on_bodypart(mob/living/carbon/human/human)
	return !sprite_datum.is_hidden(human)


/// Get the images we need to draw on the person. Called from get_overlay() which is called from _bodyparts.dm.
/// `limb` can be null.
/// This is different from the base procs as it allows for multiple overlays to
/// be generated for one bodypart_overlay. Useful for matrixed color mutant bodyparts.
/datum/bodypart_overlay/mutant/proc/get_images(image_layer, obj/item/bodypart/limb)
	if(!sprite_datum)
		CRASH("Trying to call get_images() on [type] while it didn't have a sprite_datum. This shouldn't happen, report it as soon as possible.")

	var/returned_images = list()
	var/gender = (limb?.limb_gender == FEMALE) ? "f" : "m"

	overlay_indexes_to_color = list()
	var/index = 1

	var/mob/living/carbon/human/owner = limb?.owner
	var/mutable_appearance/mod_overlay
	var/icon/custom_mod_icon = sprite_datum.get_custom_mod_icon(owner)

	cache_key_extra_information = list()
	last_built_icon_states = list()

	if(custom_mod_icon)
		mod_overlay = get_singular_image(image_layer = image_layer, owner = owner, icon_override = custom_mod_icon)

	switch(sprite_datum.color_src)
		if(USE_MATRIXED_COLORS)
			var/list/color_layer_names = get_color_layer_names(build_icon_state(gender, image_layer))

			for (var/color_index in color_layer_names)

				var/mutable_appearance/color_layer_image = get_singular_image(build_icon_state(gender, image_layer, color_layer_names[color_index]), image_layer, owner)
				returned_images += color_layer_image

				overlay_indexes_to_color += index
				index++

				if(mod_overlay)
					mod_overlay.add_overlay(sprite_datum.get_custom_mod_icon(owner, color_layer_image))

		else
			var/mutable_appearance/image_to_return = get_singular_image(build_icon_state(gender, image_layer), image_layer, owner)
			returned_images = list(image_to_return)
			overlay_indexes_to_color += index

			if(mod_overlay)
				mod_overlay.add_overlay(sprite_datum.get_custom_mod_icon(owner, image_to_return))

	if(sprite_datum.hasinner)
		returned_images += get_singular_image(build_icon_state(gender, image_layer, feature_key_suffix = "inner"), image_layer, owner)

	// Gets the icon_state of a single or matrix colored accessory and overlays it with a texture
	if(mod_overlay)
		returned_images += mod_overlay
		cache_key_extra_information += "MOD"

	return returned_images


/**
 * Returns the color_layer_names of the sprite_datum associated with our datum.
 * Mainly here so that it can be overriden elsewhere to have other effects.
 */
/datum/bodypart_overlay/mutant/proc/get_color_layer_names(icon_state_to_lookup)
	return sprite_datum.color_layer_names


/// Colors the given overlays list. Limb can be null.
/// This is different from the base procs as it allows for multiple overlays to be colored at once.
/// Useful for matrixed color mutant bodyparts.
/datum/bodypart_overlay/mutant/proc/color_images(list/image/overlays, layer, obj/item/bodypart/limb)
	if(!sprite_datum || !overlays)
		return

	if(limb?.is_husked)
		if(sprite_datum.color_src == USE_MATRIXED_COLORS) //Matrixed+husk needs special care, otherwise we get sparkle dogs
			draw_color = HUSK_COLOR_LIST
		else
			draw_color = "#AAA" //The gray husk color

	var/i = 1 // Starts at 1 for color layers.
	alpha = limb?.alpha || ALPHA_OPAQUE

	for(var/index_to_color in overlay_indexes_to_color)
		if(index_to_color > length(overlays))
			break

		var/image/overlay = overlays[index_to_color]

		switch(sprite_datum.color_src)
			if(USE_ONE_COLOR)
				overlay.color = islist(draw_color) ? draw_color[i] : draw_color
				overlay.alpha = alpha

			if(USE_MATRIXED_COLORS)
				overlay.color = islist(draw_color) ? draw_color[i] : draw_color
				overlay.alpha = alpha
				i++

			else
				overlay.color = limb?.color
				overlay.alpha = alpha


/**
 * Helper to generate the icon_state for the bodypart_overlay we're trying to draw.
 *
 * Arguments:
 * * gender - The gender of the limb. Can be "f" or "m".
 * * image_layer - The layer on which the icon will be drawn.
 * * color_layer - The color_layer of this icon_state, if any. Should be either "primary", "secondary", "tertiary" or `null`.
 * Defaults to `null`.
 * * feature_key_suffix - A string that will be directly appended to the result
 * of `get_feature_key_for_overlay()`. Defaults to `null`.
 */
/datum/bodypart_overlay/mutant/proc/build_icon_state(gender, image_layer, color_layer = null, feature_key_suffix = null)
	var/list/icon_state_builder = list()

	icon_state_builder += sprite_datum.gender_specific ? gender : "m" //Male is default because sprite accessories are so ancient they predate the concept of not hardcoding gender
	icon_state_builder += get_feature_key_for_overlay() + feature_key_suffix
	icon_state_builder += get_base_icon_state()
	icon_state_builder += mutant_bodyparts_layertext(image_layer)

	if(color_layer)
		icon_state_builder += color_layer

	var/built_icon_state = icon_state_builder.Join("_")

	LAZYADD(last_built_icon_states, built_icon_state)

	return built_icon_state


/**
 * Helper to generate one individual image for a multi-image overlay.
 * Very similar to get_image(), just a little simplified.
 *
 * Arguments:
 * * image_icon_state - The icon_state of the mutable_appearance we want to get.
 * * image_layer - The layer of the mutable_appearance we want to get.
 * * owner - The owner of the limb this is drawn on. Can be null.
 * * icon_override - The icon to use for the mutable_appearance, rather than
 * `sprite_datum.icon`. Default is `null`, and its value will be used if it's
 * anything else.
 */
/datum/bodypart_overlay/mutant/proc/get_singular_image(image_icon_state, image_layer, mob/living/carbon/human/owner, icon_override = null)
	// We get from icon_override if it is filled, and from sprite_datum.icon if not.
	var/mutable_appearance/appearance = mutable_appearance(icon_override || sprite_datum.get_special_icon(owner), image_icon_state, layer = image_layer)

	if(sprite_datum.center)
		center_image(appearance, sprite_datum.special_x_dimension ? sprite_datum.get_special_x_dimension(owner) : sprite_datum.dimension_x, sprite_datum.dimension_y)

	return appearance


/**
 * Helper proc to add the appropriate emissives to the overlays, based on the preferences.
 *
 * Arguments:
 * * overlays - The list of mutable appearances previously generated and colored.
 * * limb - The limb containing this bodypart_overlay. Cannot be null, otherwise
 * there's going to be issues with how the emissives are generated, so it won't
 * add them if the limb is missing, somehow.
 */
/datum/bodypart_overlay/mutant/proc/add_emissives(list/image/overlays, obj/item/bodypart/limb)
	if(!limb || !length(emissive_eligibility_by_color_index))
		return overlays

	var/index = 1
	var/list/image/emissives = list()

	for(var/image/overlay in overlays)
		if(emissive_eligibility_by_color_index[num2text(index)])
			emissives += emissive_appearance_copy(overlay, limb)

		index++

	return overlays + emissives


/**
 * Builds `emissive_eligibility_by_layer` from the input list of three booleans.
 * Will not do anything if the given argument is `null`.
 */
/datum/bodypart_overlay/mutant/proc/build_emissive_eligibility(list/emissive_eligibility)
	if(!emissive_eligibility || !islist(emissive_eligibility))
		return

	emissive_eligibility_by_color_index = list()
	var/i = 1

	for(var/eligibility in emissive_eligibility)
		emissive_eligibility_by_color_index[num2text(i)] = eligibility
		i++


/**
 * Helper to set the MOD-related info on the overlay, useful for MODsuit overlays.
 *
 * Arguments:
 * * status - boolean of whether or not this overlay should currently be under the
 * effect of MODsuit overlays.
 */
/datum/bodypart_overlay/mutant/proc/set_modsuit_status(status)
	if(!modsuit_affected)
		return

	// Honestly refactor this later if it's not actually useful for anything else ever (which is likely going to be the case).
	if(status)
		LAZYADD(cache_key_extra_information, "MOD")
		return

	LAZYREMOVE(cache_key_extra_information, "MOD")


#undef MAX_MATRIXED_COLORS
#undef ALPHA_OPAQUE
