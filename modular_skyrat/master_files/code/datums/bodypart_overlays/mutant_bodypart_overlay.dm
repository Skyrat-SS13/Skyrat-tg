/datum/bodypart_overlay/mutant
	/// An associative list of `EXTERNAL_X` layer to boolean that says whether or not
	/// that layer should get an emissive overlay. Can be null.
	var/list/emissive_eligibility_by_layer

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
	store_draw_color(dna.mutant_bodyparts[feature_key][MUTANT_INDEX_NAME])
	build_emissive_eligibility(dna.mutant_bodyparts[feature_key][MUTANT_INDEX_EMISSIVE_LIST])
	cache_key = jointext(generate_icon_cache(), "_")

// Doing this here because that way we don't have to override it directly in the /tg/ file.
/datum/bodypart_overlay/mutant/color_image(image/overlay, layer, obj/item/bodypart/limb)
	if(!sprite_datum || !overlay)
		return

	switch(sprite_datum.color_src)
		if(USE_ONE_COLOR)
			overlay.color = draw_color

		if(USE_MATRIXED_COLORS)
			overlay.color = draw_color[layer]

		else
			overlay.color = null


/// Stores the `draw_color` appropriately, and renames the entries in the list to
/// be layers if need be.
/datum/bodypart_overlay/mutant/proc/store_draw_color(new_color)
	if(!islist(new_color))
		draw_color = new_color
		return

	draw_color = list()
	var/i = 0

	// What we do here is essentially convert from a list of "1" = "color", etc. to `EXTERNAL_FRONT` = "color", etc.
	for(var/key in new_color)
		draw_color[all_layers[i]] = new_color[key]
		i++


/**
 * Builds `emissive_eligibility_by_layer` from the input list of three booleans.
 * Will not do anything if the given argument is `null`.
 */
/datum/bodypart_overlay/mutant/proc/build_emissive_eligibility(list/emissive_eligibility)
	if(!emissive_eligibility || !islist(emissive_eligibility))
		return

	emissive_eligibility_by_layer = list()
	var/i = 0
	for(var/eligibility in emissive_eligibility)
		emissive_eligibility_by_layer[all_layers[i]] = eligibility
		i++


/**
 * Returns whether or not the `bodypart_overlay` should have an emissive overlay
 * at the given layer.
 *
 * Arguments:
 * * layer - The layer we want to know the emissive status of.
 *
 * Returns `TRUE` if it should get an emissive overlay, `FALSE` if not.
 */
/datum/bodypart_overlay/mutant/needs_emissive_at_layer(layer)
	return emissive_eligibility_by_layer && emissive_eligibility_by_layer[layer]

