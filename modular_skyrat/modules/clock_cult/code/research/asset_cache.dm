// Now, you might be asking "why is this hooked into the research designs spritesheet?"
// Well, for some *absurd* reason, any time i tried to add sprites to a new spritesheet, they would always have a *gray* background covering the full 32x32, apart from what my sprite did. After multiple hours of debugging,
// I settled on this, since it's not-really-harmful to have other things in an unrelated spritesheet.
// To see my suffering, look at the convo starting at https://discord.com/channels/326822144233439242/326831214667235328/1098753337698029590
/datum/asset/spritesheet/research_designs/create_spritesheets()
	. = ..()
	var/list/id_list = list()

	for(var/datum/clockwork_research/path as anything in subtypesof(/datum/clockwork_research))
		var/datum/clockwork_research/new_research = new path(FALSE)

		// First we do tinker's cache items
		for(var/datum/tinker_cache_item/unlocked_item as anything in new_research.unlocked_recipes)
			var/icon_file
			var/icon_state

			var/atom/item = initial(unlocked_item.item_path)

			if(initial(unlocked_item.research_icon) && initial(unlocked_item.research_icon_state)) //If the item has an icon replacement
				icon_file = initial(unlocked_item.research_icon)
				icon_state = initial(unlocked_item.research_icon_state)

			else if(initial(item.icon) && initial(item.icon_state))
				icon_file = initial(item.icon)
				icon_state = initial(item.icon_state)

			var/id = sanitize_css_class_name("[icon_file][icon_state]")
			if(id in id_list)
				continue

			id_list += id

			Insert(id, icon_file, icon_state)

		// And now scripture icons
		for(var/datum/scripture/unlocked_scripture as anything in new_research.unlocked_scriptures)
			var/icon_file = 'modular_skyrat/modules/clock_cult/icons/actions_clock.dmi'
			var/icon_state = initial(unlocked_scripture.button_icon_state)

			var/id = sanitize_css_class_name("[icon_file][icon_state]")
			if(id in id_list)
				continue

			id_list += id

			Insert(id, icon_file, icon_state)

		qdel(new_research)
