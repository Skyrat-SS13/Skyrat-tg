/proc/accessory_list_of_key_for_species(key, datum/species/S, mismatched, ckey)
	var/list/accessory_list = list()
	for(var/name in SSaccessories.sprite_accessories[key])
		var/datum/sprite_accessory/SP = SSaccessories.sprite_accessories[key][name]
		if(!mismatched && SP.recommended_species && !(S.id in SP.recommended_species))
			continue
		if(SP.ckey_whitelist && !SP.ckey_whitelist[ckey])
			continue
		accessory_list += SP.name
	return accessory_list


/proc/random_accessory_of_key_for_species(key, datum/species/S, mismatched=FALSE, ckey)
	var/list/accessory_list = accessory_list_of_key_for_species(key, S, mismatched, ckey)
	var/datum/sprite_accessory/SP = SSaccessories.sprite_accessories[key][pick(accessory_list)]
	if(!SP)
		CRASH("Cant find random accessory of [key] key, for species [S.id]")
	return SP

/proc/assemble_body_markings_from_set(datum/body_marking_set/BMS, list/features, datum/species/pref_species)
	var/list/body_markings = list()
	for(var/set_name in BMS.body_marking_list)
		var/datum/body_marking/BM = GLOB.body_markings[set_name]
		for(var/zone in GLOB.body_markings_per_limb)
			var/list/marking_list = GLOB.body_markings_per_limb[zone]
			if(set_name in marking_list)
				if(!body_markings[zone])
					body_markings[zone] = list()
				body_markings[zone][set_name] = list(BM.get_default_color(features, pref_species), FALSE)
	return body_markings

/proc/random_bra(gender)
	switch(gender)
		if(MALE)
			return pick(SSaccessories.bra_m)
		if(FEMALE)
			return pick(SSaccessories.bra_f)
		else
			return pick(SSaccessories.bra_list)
