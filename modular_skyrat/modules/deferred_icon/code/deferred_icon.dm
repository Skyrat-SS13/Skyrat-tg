/// Similar to [/proc/get_flat_human_icon], except it returns a list(dir = image) instead of an icon.
/proc/get_human_image(icon_id, datum/job/job, datum/preferences/prefs, dummy_key, showDirs = GLOB.cardinals, outfit_override = null)
	var/static/list/humanoid_appearance_cache = list()
	if(icon_id && humanoid_appearance_cache[icon_id])
		return humanoid_appearance_cache[icon_id]

	var/mob/living/carbon/human/dummy/body = generate_or_wait_for_human_dummy(dummy_key)

	if(prefs)
		prefs.apply_prefs_to(body, TRUE)

	var/datum/outfit/outfit = outfit_override || job?.outfit
	if(job)
		body.dna.species.pre_equip_species_outfit(job, body, TRUE)
	if(outfit)
		body.equip_outfit_and_loadout(outfit, prefs, TRUE)

	var/list/out_list = list()
	COMPILE_OVERLAYS(body)
	for(var/D in showDirs)
		body.setDir(D)
		out_list["[D]"] = image(body.appearance)

	humanoid_appearance_cache[icon_id] = out_list
	dummy_key? unset_busy_human_dummy(dummy_key) : qdel(body)
	return out_list

/// Similar to [/proc/getFlatIcon] but uses CHECK_TICK
/proc/getFlatIconAsync(image/appearance, defdir, deficon, defstate, defblend, start = TRUE, no_anim = FALSE)
	// Loop through the underlays, then overlays, sorting them into the layers list
	#define PROCESS_OVERLAYS_OR_UNDERLAYS(flat, process, base_layer) \
		for (var/i in 1 to process.len) { \
			var/image/current = process[i]; \
			if (!current) { \
				continue; \
			} \
			if (current.plane != FLOAT_PLANE && current.plane != appearance.plane) { \
				continue; \
			} \
			var/current_layer = current.layer; \
			if (current_layer < 0) { \
				if (current_layer <= -1000) { \
					return flat; \
				} \
				current_layer = base_layer + appearance.layer + current_layer / 1000; \
			} \
			for (var/index_to_compare_to in 1 to layers.len) { \
				var/compare_to = layers[index_to_compare_to]; \
				if (current_layer < layers[compare_to]) { \
					layers.Insert(index_to_compare_to, current); \
					break; \
				} \
			} \
			layers[current] = current_layer; \
		}

	var/static/icon/flat_template = icon('icons/blanks/32x32.dmi', "nothing")

	if(!appearance || appearance.alpha <= 0)
		return icon(flat_template)

	if(start)
		if(!defdir)
			defdir = appearance.dir
		if(!deficon)
			deficon = appearance.icon
		if(!defstate)
			defstate = appearance.icon_state
		if(!defblend)
			defblend = appearance.blend_mode

	var/curicon = appearance.icon || deficon
	var/curstate = appearance.icon_state || defstate
	var/curdir = (!appearance.dir || appearance.dir == SOUTH) ? defdir : appearance.dir

	var/render_icon = curicon

	if (render_icon)
		var/curstates = icon_states(curicon)
		if(!(curstate in curstates))
			if ("" in curstates)
				curstate = ""
			else
				render_icon = FALSE

	var/base_icon_dir //We'll use this to get the icon state to display if not null BUT NOT pass it to overlays as the dir we have

	//Try to remove/optimize this section ASAP, CPU hog.
	//Determines if there's directionals.
	if(render_icon && curdir != SOUTH)
		if (
			!length(icon_states(icon(curicon, curstate, NORTH))) \
			&& !length(icon_states(icon(curicon, curstate, EAST))) \
			&& !length(icon_states(icon(curicon, curstate, WEST))) \
		)
			base_icon_dir = SOUTH

	if(!base_icon_dir)
		base_icon_dir = curdir

	var/curblend = appearance.blend_mode || defblend

	if(appearance.overlays.len || appearance.underlays.len)
		var/icon/flat = icon(flat_template)
		// Layers will be a sorted list of icons/overlays, based on the order in which they are displayed
		var/list/layers = list()
		var/image/copy
		// Add the atom's icon itself, without pixel_x/y offsets.
		if(render_icon)
			copy = image(icon=curicon, icon_state=curstate, layer=appearance.layer, dir=base_icon_dir)
			copy.color = appearance.color
			copy.alpha = appearance.alpha
			copy.blend_mode = curblend
			layers[copy] = appearance.layer

		PROCESS_OVERLAYS_OR_UNDERLAYS(flat, appearance.underlays, 0)
		PROCESS_OVERLAYS_OR_UNDERLAYS(flat, appearance.overlays, 1)

		var/icon/add // Icon of overlay being added

		var/flatX1 = 1
		var/flatX2 = flat.Width()
		var/flatY1 = 1
		var/flatY2 = flat.Height()

		var/addX1 = 0
		var/addX2 = 0
		var/addY1 = 0
		var/addY2 = 0

		for(var/image/layer_image as anything in layers)
			if(layer_image.alpha == 0)
				continue

			if(layer_image == copy) // 'layer_image' is an /image based on the object being flattened.
				curblend = BLEND_OVERLAY
				add = icon(layer_image.icon, layer_image.icon_state, base_icon_dir)
			else // 'I' is an appearance object.
				add = getFlatIcon(image(layer_image), curdir, curicon, curstate, curblend, FALSE, no_anim)
			if(!add)
				continue

			CHECK_TICK

			// Find the new dimensions of the flat icon to fit the added overlay
			addX1 = min(flatX1, layer_image.pixel_x + 1)
			addX2 = max(flatX2, layer_image.pixel_x + add.Width())
			addY1 = min(flatY1, layer_image.pixel_y + 1)
			addY2 = max(flatY2, layer_image.pixel_y + add.Height())

			if (
				addX1 != flatX1 \
				&& addX2 != flatX2 \
				&& addY1 != flatY1 \
				&& addY2 != flatY2 \
			)
				// Resize the flattened icon so the new icon fits
				flat.Crop(
					addX1 - flatX1 + 1,
					addY1 - flatY1 + 1,
					addX2 - flatX1 + 1,
					addY2 - flatY1 + 1
				)

				flatX1 = addX1
				flatX2 = addY1
				flatY1 = addX2
				flatY2 = addY2

			// Blend the overlay into the flattened icon
			flat.Blend(add, blendMode2iconMode(curblend), layer_image.pixel_x + 2 - flatX1, layer_image.pixel_y + 2 - flatY1)

			CHECK_TICK

		if(appearance.color)
			if(islist(appearance.color))
				flat.MapColors(arglist(appearance.color))
			else
				flat.Blend(appearance.color, ICON_MULTIPLY)
			CHECK_TICK

		if(appearance.alpha < 255)
			flat.Blend(rgb(255, 255, 255, appearance.alpha), ICON_MULTIPLY)
			CHECK_TICK

		if(no_anim)
			//Clean up repeated frames
			var/icon/cleaned = new /icon()
			cleaned.Insert(flat, "", SOUTH, 1, 0)
			return cleaned
		else
			return icon(flat, "", SOUTH)
	else if (render_icon) // There's no overlays.
		var/icon/final_icon = icon(icon(curicon, curstate, base_icon_dir), "", SOUTH, no_anim ? TRUE : null)

		if (appearance.alpha < 255)
			final_icon.Blend(rgb(255,255,255, appearance.alpha), ICON_MULTIPLY)

		if (appearance.color)
			if (islist(appearance.color))
				final_icon.MapColors(arglist(appearance.color))
			else
				final_icon.Blend(appearance.color, ICON_MULTIPLY)

		return final_icon

	#undef PROCESS_OVERLAYS_OR_UNDERLAYS

#define DUMMY_HUMAN_SLOT_MANIFEST "dummy_manifest_generation"
/datum/datacore/proc/get_id_image(mob/living/carbon/human/H, client/C, show_directions = list(SOUTH))
	var/datum/job/J = H.mind.assigned_role
	var/datum/preferences/P
	if(!C)
		C = H.client
	if(C)
		P = C.prefs
	return get_human_image(null, J, P, DUMMY_HUMAN_SLOT_MANIFEST, show_directions)
#undef DUMMY_HUMAN_SLOT_MANIFEST
