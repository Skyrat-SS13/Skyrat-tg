/proc/make_skyrat_datum_references()
	make_sprite_accessory_references()
	make_body_marking_references()
	make_body_marking_set_references()
	make_body_marking_dna_block_references()
	populate_total_ui_len_by_block()
	populate_total_uf_len_by_block()
	make_augment_references()
	make_culture_references()
	//We're loading donators here because it's the least intrusive way modularly
	load_donators()
	load_veteran_players()

/proc/make_culture_references()
	for(var/path in subtypesof(/datum/cultural_info/culture))
		var/datum/cultural_info/L = path
		if(!initial(L.name))
			continue
		L = new path()
		GLOB.culture_cultures[path] = L
	for(var/path in subtypesof(/datum/cultural_info/location))
		var/datum/cultural_info/L = path
		if(!initial(L.name))
			continue
		L = new path()
		GLOB.culture_locations[path] = L
	for(var/path in subtypesof(/datum/cultural_info/faction))
		var/datum/cultural_info/L = path
		if(!initial(L.name))
			continue
		L = new path()
		GLOB.culture_factions[path] = L

/proc/make_sprite_accessory_references()
	// Here we build the global list for all accessories
	for(var/path in subtypesof(/datum/sprite_accessory))
		var/datum/sprite_accessory/P = path
		if(initial(P.key) && initial(P.name))
			P = new path()
			if(!GLOB.sprite_accessories[P.key])
				GLOB.sprite_accessories[P.key] = list()
			GLOB.sprite_accessories[P.key][P.name] = P
			if(P.genetic)
				if(!GLOB.dna_mutant_bodypart_blocks[P.key])
					GLOB.dna_mutant_bodypart_blocks[P.key] = GLOB.dna_total_feature_blocks+1
				if(!GLOB.genetic_accessories[P.key])
					GLOB.genetic_accessories[P.key] = list()
					for(var/color_block in 1 to DNA_FEATURE_COLOR_BLOCKS_PER_FEATURE)
						GLOB.features_block_lengths["[GLOB.dna_mutant_bodypart_blocks[P.key] + color_block]"] = DNA_BLOCK_SIZE_COLOR
					GLOB.dna_total_feature_blocks += DNA_BLOCKS_PER_FEATURE

				GLOB.genetic_accessories[P.key] += P.name
			//TODO: Replace "generic" definitions with something better
			if(P.generic && !GLOB.generic_accessories[P.key])
				GLOB.generic_accessories[P.key] = P.generic

/proc/make_body_marking_references()
	// Here we build the global list for all body markings
	for(var/path in subtypesof(/datum/body_marking))
		var/datum/body_marking/BM = path
		if(initial(BM.name))
			BM = new path()
			GLOB.body_markings[BM.name] = BM
			//We go through all the possible affected bodyparts and a name reference where applicable
			for(var/marking_zone in GLOB.marking_zones)
				var/bitflag = GLOB.marking_zone_to_bitflag[marking_zone]
				if(BM.affected_bodyparts & bitflag)
					if(!GLOB.body_markings_per_limb[marking_zone])
						GLOB.body_markings_per_limb[marking_zone] = list()
					GLOB.body_markings_per_limb[marking_zone] += BM.name

/proc/make_body_marking_set_references()
	// Here we build the global list for all body markings sets
	for(var/path in subtypesof(/datum/body_marking_set))
		var/datum/body_marking_set/BM = path
		if(initial(BM.name))
			BM = new path()
			GLOB.body_marking_sets[BM.name] = BM

/proc/make_body_marking_dna_block_references()
	for(var/marking_zone in GLOB.marking_zones)
		GLOB.dna_body_marking_blocks[marking_zone] = GLOB.dna_total_feature_blocks+1
		for(var/feature_block_set in 1 to MAXIMUM_MARKINGS_PER_LIMB)
			for(var/color_block in 1 to DNA_MARKING_COLOR_BLOCKS_PER_MARKING)
				GLOB.features_block_lengths["[GLOB.dna_body_marking_blocks[marking_zone] + (feature_block_set - 1) * DNA_BLOCKS_PER_MARKING + color_block]"] = DNA_BLOCK_SIZE_COLOR
		GLOB.dna_total_feature_blocks += DNA_BLOCKS_PER_MARKING_ZONE

/proc/make_augment_references()
	// Here we build the global loadout lists
	for(var/path in subtypesof(/datum/augment_item))
		var/datum/augment_item/L = path
		if(initial(L.path))
			L = new path()
			GLOB.augment_items[L.path] = L

			if(!GLOB.augment_slot_to_items[L.slot])
				GLOB.augment_slot_to_items[L.slot] = list()
				if(!GLOB.augment_categories_to_slots[L.category])
					GLOB.augment_categories_to_slots[L.category] = list()
				GLOB.augment_categories_to_slots[L.category] += L.slot
			GLOB.augment_slot_to_items[L.slot] += L.path

/// If the "Remove ERP Interaction" config is disabled, remove ERP things from various lists
/proc/remove_erp_things()
	if(!CONFIG_GET(flag/disable_erp_preferences))
		return
	// Chemical reactions aren't handled here because they're loaded in the reagents SS
	// See Initialize() on SSReagents

	// Loadouts
	for(var/loadout_path in GLOB.all_loadout_datums)
		var/datum/loadout_item/loadout_datum = GLOB.all_loadout_datums[loadout_path]
		if(!loadout_datum.erp_item)
			continue
		GLOB.all_loadout_datums -= loadout_path
		// Ensure this FULLY works later

	// Underwear
	for(var/sprite_name in GLOB.underwear_list)
		var/datum/sprite_accessory/sprite_datum = GLOB.underwear_list[sprite_name]
		if(!sprite_datum?.erp_accessory)
			continue
		GLOB.underwear_list -= sprite_name

	for(var/sprite_name in GLOB.underwear_f)
		var/datum/sprite_accessory/sprite_datum = GLOB.underwear_f[sprite_name]
		if(!sprite_datum?.erp_accessory)
			continue
		GLOB.underwear_f -= sprite_name

	for(var/sprite_name in GLOB.underwear_m)
		var/datum/sprite_accessory/sprite_datum = GLOB.underwear_m[sprite_name]
		if(!sprite_datum?.erp_accessory)
			continue
		GLOB.underwear_m -= sprite_name

	// Undershirts
	for(var/sprite_name in GLOB.undershirt_list)
		var/datum/sprite_accessory/sprite_datum = GLOB.undershirt_list[sprite_name]
		if(!sprite_datum?.erp_accessory)
			continue
		GLOB.undershirt_list -= sprite_name

	for(var/sprite_name in GLOB.undershirt_f)
		var/datum/sprite_accessory/sprite_datum = GLOB.undershirt_f[sprite_name]
		if(!sprite_datum?.erp_accessory)
			continue
		GLOB.undershirt_f -= sprite_name

	for(var/sprite_name in GLOB.undershirt_m)
		var/datum/sprite_accessory/sprite_datum = GLOB.undershirt_m[sprite_name]
		if(!sprite_datum?.erp_accessory)
			continue
		GLOB.undershirt_m -= sprite_name
