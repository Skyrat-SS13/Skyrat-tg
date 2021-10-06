/obj/item/clothing
	/// Needs to follow this syntax: either a list() with the x and y coordinates of the pixel you want to get the colour from, or a hexcolour. Colour one replaces red, two replaces blue, and three replaces green in the icon state.
	var/list/greyscale_colors_clothing[3]
	/// Needs to be a RGB-greyscale format icon state in all species' clothing icon files.
	var/greyscale_icon_state

/obj/item/clothing/proc/generate_species_clothing(file2use, state2use, species)
	var/icon/human_clothing_icon = icon(file2use, state2use)

	if(!greyscale_colors_clothing || !greyscale_icon_state)
		GLOB.species_clothing_icons[species]["[file2use]-[state2use]"] = human_clothing_icon
		return

	var/icon/species_icon = icon(species, greyscale_icon_state)
	var/list/final_list = list()
	for(var/i in 1 to 3)
		if(length(greyscale_colors_clothing) < i)
			final_list += "#00000000"
			continue
		var/color = greyscale_colors_clothing[i]
		if(islist(color))
			final_list += human_clothing_icon.GetPixel(color[1], color[2]) || "#00000000"
		else if(istext(color))
			final_list += color

	species_icon.MapColors(final_list[1], final_list[2], final_list[3])
	species_icon = fcopy_rsc(species_icon)
	GLOB.species_clothing_icons[species]["[file2use]-[state2use]"] = species_icon

