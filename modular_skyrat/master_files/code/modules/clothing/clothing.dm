/obj/item/clothing
	/// Needs to follow this syntax: either a list() with the x and y coordinates of the pixel you want to get the colour from, or a hexcolour. Colour one replaces red, two replaces blue, and three replaces green in the icon state.
	var/list/species_clothing_colors[3]
	/// Needs to be a RGB-greyscale format icon state in all species' clothing icon files.
	var/species_clothing_icon_state
	// Skyrat edit addition end

/obj/item/clothing/take_damage(damage_amount, damage_type = BRUTE, damage_flag = "", sound_effect = TRUE, attack_dir, armour_penetration = 0)
    if(atom_integrity <= 0 && damage_flag == FIRE) // Our clothes don't get destroyed by fire, shut up stack trace >:(
        return

    return ..()

// Generates a coloured species-specific variant of the clothing item
/obj/item/clothing/proc/generate_species_clothing(file_to_use, state_to_use, species, default_file_to_use)
	var/list/clothing_states = icon_states(file_to_use)

	var/icon/human_clothing_icon = icon(file_to_use, state_to_use) //overriden clothing icon
	var/icon/default_clothing_icon = icon(default_file_to_use, state_to_use) //non overriden clothing icon, important for getting the color matrix to not die

	if(state_to_use in clothing_states)
		//checks if the overriden icon has the correct sprite, and uses it...
		GLOB.species_clothing_icons[species][get_species_clothing_key(file_to_use, state_to_use)] = human_clothing_icon
		return

	//...or else it will generate one
	var/icon/species_icon = icon(species, species_clothing_icon_state)
	var/list/final_list = list()

	// Is this a GAGS outfit?
	if(greyscale_config_worn)
		// Just use the colors already given to us.
		var/list/colors = SSgreyscale.ParseColorString(greyscale_colors)
		var/default_color = (length(colors) >= 1) ? colors[1] : "#00000000"
		for(var/i in 1 to 3)
			final_list += (i < length(colors)) ? colors[i] : default_color
	else
		// Not GAGS, guess using color picking
		for(var/i in 1 to 3)
			if(length(species_clothing_colors) < i)
				final_list += "#00000000"
				continue
			var/color = species_clothing_colors[i]
			if(islist(color)) // The entry is a list of x, y coordinates; find the color at this point
				final_list += default_clothing_icon.GetPixel(color[1], color[2]) || "#00000000"
			else if(istext(color))
				final_list += color

	species_icon.MapColors(final_list[1], final_list[2], final_list[3])
	species_icon = fcopy_rsc(species_icon)
	// Stores the icon in a global list; if it already exists, this proc is skipped
	GLOB.species_clothing_icons[species][get_species_clothing_key(file_to_use, state_to_use)] = species_icon

/**
 * Get the name to cache this clothing's icon with
 * @param file_to_use icon file we're using
 * @param state_to_use icon state we're using
 * @return key string to use in cache
 */
/obj/item/clothing/proc/get_species_clothing_key(file_to_use, state_to_use)
	if(greyscale_config_worn)
		return "[file_to_use]-[state_to_use]-[greyscale_colors]"
	else
		return "[file_to_use]-[state_to_use]"
