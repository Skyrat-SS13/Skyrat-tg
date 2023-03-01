/// The greatest amount of colors that can be in a matrixed bodypart_overlay.
#define MAX_MATRIXED_COLORS 3

/datum/bodypart_overlay/mutant
	/// An associative list of color indexes (i.e. "1") to boolean that says
	/// whether or not that color should get an emissive overlay. Can be null.
	var/list/emissive_eligibility_by_color_index


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

	if(islist(draw_color))
		for(var/sub_color in draw_color)
			. += "[sub_color]"

	else
		. += "[draw_color]"

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


/// Get the images we need to draw on the person. Called from get_overlay() which is called from _bodyparts.dm.
/// `limb` can be null.
/// This is different from the base procs as it allows for multiple overlays to
/// be generated for one bodypart_overlay. Useful for matrixed color mutant bodyparts.
/datum/bodypart_overlay/mutant/proc/get_images(image_layer, obj/item/bodypart/limb)
	if(!sprite_datum)
		return

	var/returned_images = list()

	var/gender = (limb?.limb_gender == FEMALE) ? "f" : "m"

	switch(sprite_datum.color_src)
		if(USE_MATRIXED_COLORS)
			var/static/list/color_layer_names = list("1" = "primary", "2" = "secondary", "3" = "tertiary")

			for (var/color_index in color_layer_names)

				returned_images += get_singular_image(build_icon_state(gender, image_layer, sprite_datum.color_layer_names[color_index]))

		else
			returned_images = list(get_singular_image(build_icon_state(gender, image_layer), image_layer))


	return returned_images


/// Colors the given overlays list. Limb can be null.
/// This is different from the base procs as it allows for multiple overlays to be colored at once.
/// Useful for matrixed color mutant bodyparts.
/datum/bodypart_overlay/mutant/proc/color_images(list/image/overlays, layer, obj/item/bodypart/limb)
	if(!sprite_datum || !overlays)
		return

	/* Uncomment when the fact that the body is husked is stored on the limbs too.
	if(HAS_TRAIT(limb, TRAIT_HUSK))
		if(sprite_datum.color_src == USE_MATRIXED_COLORS) //Matrixed+husk needs special care, otherwise we get sparkle dogs
			draw_color = HUSK_COLOR_LIST
		else
			draw_color = "#AAA" //The gray husk color
	*/

	var/specific_alpha = limb?.alpha || 255
	var/i = 1 // Starts at 1 for color layers.

	for(var/image/overlay in overlays)
		switch(sprite_datum.color_src)
			if(USE_ONE_COLOR)
				overlay.color = draw_color
				overlay.alpha = specific_alpha

			if(USE_MATRIXED_COLORS)
				overlay.color = islist(draw_color) ? draw_color[num2text(i)] : draw_color
				overlay.alpha = specific_alpha

			else
				overlay.color = limb?.color
				overlay.alpha = specific_alpha

		i++
		if(i > MAX_MATRIXED_COLORS)
			break


/**
 * Helper to generate the icon_state for the bodypart_overlay we're trying to draw.
 *
 * Arguments:
 * * gender - The gender of the limb. Can be "f" or "m".
 * * image_layer - The layer on which the icon will be drawn.
 * * color_layer - The color_layer of this icon_state, if any. Should be either "primary", "secondary", "tertiary" or `null`.
 * Defaults to `null`.
 */
/datum/bodypart_overlay/mutant/proc/build_icon_state(gender, image_layer, color_layer = null)
	var/list/icon_state_builder = list()

	icon_state_builder += sprite_datum.gender_specific ? gender : "m" //Male is default because sprite accessories are so ancient they predate the concept of not hardcoding gender
	icon_state_builder += get_feature_key_for_overlay()
	icon_state_builder += get_base_icon_state()
	icon_state_builder += mutant_bodyparts_layertext(image_layer)

	if(color_layer)
		icon_state_builder += color_layer

	return icon_state_builder.Join("_")


/**
 * Helper to generate one individual image for a multi-image overlay.
 * Very similar to get_image(), just a little simplified.
 */
/datum/bodypart_overlay/mutant/proc/get_singular_image(image_icon_state, image_layer)
	var/mutable_appearance/appearance = mutable_appearance(sprite_datum.icon, image_icon_state, layer = -image_layer)

	if(sprite_datum.center)
		center_image(appearance, sprite_datum.dimension_x, sprite_datum.dimension_y)

	return appearance




/**
 *
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


#undef MAX_MATRIXED_COLORS
