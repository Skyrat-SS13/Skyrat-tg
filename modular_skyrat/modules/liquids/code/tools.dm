ADMIN_VERB(spawn_liquid, R_ADMIN, "Spawn Liquid", "Spawns an amount of chosen liquid at your current location.", ADMIN_CATEGORY_FUN)
	var/choice
	var/valid_id
	while(!valid_id)
		choice = tgui_input_text(user, "Enter the ID of the reagent you want to add.", "Search reagents")
		if(isnull(choice)) //Get me out of here!
			break
		if (!ispath(text2path(choice)))
			choice = pick_closest_path(choice, make_types_fancy(subtypesof(/datum/reagent)))
			if (ispath(choice))
				valid_id = TRUE
		else
			valid_id = TRUE
		if(!valid_id)
			to_chat(user, span_warning("A reagent with that ID doesn't exist!"))
	if(!choice)
		return
	var/volume = tgui_input_number(user, "Volume:", "Choose volume")
	if(!volume)
		return
	var/turf/epicenter = get_turf(user.mob)
	epicenter.add_liquid(choice, volume)
	message_admins("[ADMIN_LOOKUPFLW(user)] spawned liquid at [epicenter.loc] ([choice] - [volume]).")
	log_admin("[key_name(user)] spawned liquid at [epicenter.loc] ([choice] - [volume]).")

ADMIN_VERB_AND_CONTEXT_MENU(remove_liquid, R_ADMIN, "Remove liquids", "Removes all liquids in specified radius.", ADMIN_CATEGORY_GAME, turf/epicenter in world)
	var/range = tgui_input_number(user, "Enter range:", "Range selection", 2)

	for(var/obj/effect/abstract/liquid_turf/liquid in range(range, epicenter))
		qdel(liquid, TRUE)

	message_admins("[key_name_admin(user)] removed liquids with range [range] in [epicenter.loc.name]")
