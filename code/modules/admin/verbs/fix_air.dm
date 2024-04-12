// Proc taken from yogstation, credit to nichlas0010 for the original
ADMIN_VERB(fix_air, R_ADMIN, "Fix Air", "Fixes air in a specified radius.", ADMIN_CATEGORY_GAME, turf/open/locale in world, range = 2 as num)
	message_admins("[key_name_admin(user)] fixed air with range [range] in area [locale.loc.name]")
	user.mob.log_message("fixed air with range [range] in area [locale.loc.name]", LOG_ADMIN)

<<<<<<< HEAD
	if(!holder)
		to_chat(src, "Only administrators may use this command.", confidential = TRUE)
		return
	if(check_rights(R_ADMIN,1))
		var/range=input("Enter range:","Num",2) as num
		message_admins("[key_name_admin(usr)] fixed air with range [range] in area [T.loc.name]")
		usr.log_message("fixed air with range [range] in area [T.loc.name]", LOG_ADMIN)
		for(var/turf/open/F in range(range,T))
			if(F.blocks_air)
			//skip walls
				continue
			var/datum/gas_mixture/GM = SSair.parse_gas_string(F.initial_gas_mix, /datum/gas_mixture/turf)
			F.copy_air(GM)
			F.update_visuals()

			if(F.pollution) //SKYRAT EDIT ADDITION
				qdel(F.pollution)
=======
	for(var/turf/open/valid_range_turf in range(range,locale))
		if(valid_range_turf.blocks_air)
		//skip walls
			continue
		var/datum/gas_mixture/GM = SSair.parse_gas_string(valid_range_turf.initial_gas_mix, /datum/gas_mixture/turf)
		valid_range_turf.copy_air(GM)
		valid_range_turf.update_visuals()
>>>>>>> 7f8752be147 (Admin Verb Datums MkIII | Now with functional command bar (#82511))
