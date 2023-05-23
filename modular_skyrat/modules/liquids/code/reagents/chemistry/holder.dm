/// Like add_reagent but you can enter a list. Adds them with no_react = TRUE. Format it like this: list(/datum/reagent/toxin = 10, "beer" = 15)
/datum/reagents/proc/add_noreact_reagent_list(list/list_reagents, list/data=null)
	for(var/r_id in list_reagents)
		var/amt = list_reagents[r_id]
		add_reagent(r_id, amt, data, no_react = TRUE)
