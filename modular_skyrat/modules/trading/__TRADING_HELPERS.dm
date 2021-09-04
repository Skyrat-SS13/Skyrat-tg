///Since both datums which otherwise dont inherit, use this exact function, I put it here
/proc/compile_typelist_for_trading(list/passed_list)
	var/compiled_types = list()
	var/list/blacklist_types = list()
	for(var/type in passed_list)
		var/value = passed_list[type]
		switch(value)
			if(TRADER_THIS_TYPE)
				compiled_types[type] = TRUE
			if(TRADER_TYPES)
				for(var/typeof in typesof(type))
					compiled_types[typeof] = TRUE
			if(TRADER_SUBTYPES)
				for(var/subtypeof in subtypesof(type))
					compiled_types[subtypeof] = TRUE
			if(TRADER_BLACKLIST)
				blacklist_types[type] = TRUE
			if(TRADER_BLACKLIST_TYPES)
				for(var/typeof in typesof(type))
					blacklist_types[typeof] = TRUE
			if(TRADER_BLACKLIST_SUBTYPES)
				for(var/subtypeof in subtypesof(type))
					blacklist_types[subtypeof] = TRUE
	for(var/blacklist_type in blacklist_types)
		if(compiled_types[blacklist_type])
			compiled_types -= blacklist_type
	return compiled_types
