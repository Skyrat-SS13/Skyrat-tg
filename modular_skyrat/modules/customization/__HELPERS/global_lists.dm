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
	for(var/path in subtypesof(/datum/background_info/employment))
		var/datum/background_info/culture = path
		if(!initial(culture.name))
			continue
		culture = new path()
		GLOB.employment[path] = culture
	for(var/path in subtypesof(/datum/background_info/origin))
		var/datum/background_info/culture = path
		if(!initial(culture.name))
			continue
		culture = new path()
		GLOB.origins[path] = culture
	for(var/path in subtypesof(/datum/background_info/social_background))
		var/datum/background_info/culture = path
		if(!initial(culture.name))
			continue
		culture = new path()
		GLOB.social_backgrounds[path] = culture
	for(var/datum/cultural_feature/cultural_feature as anything in subtypesof(/datum/cultural_feature))
		cultural_feature = new cultural_feature()
		GLOB.culture_features += list("[cultural_feature.name]" = list(
			"name" = cultural_feature.name,
			"description" = cultural_feature.description,
			"icon" = sanitize_css_class_name(cultural_feature.name),
		))

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
		var/datum/augment_item/culture = path
		if(initial(culture.path))
			culture = new path()
			GLOB.augment_items[culture.path] = culture

			if(!GLOB.augment_slot_to_items[culture.slot])
				GLOB.augment_slot_to_items[culture.slot] = list()
				if(!GLOB.augment_categories_to_slots[culture.category])
					GLOB.augment_categories_to_slots[culture.category] = list()
				GLOB.augment_categories_to_slots[culture.category] += culture.slot
			GLOB.augment_slot_to_items[culture.slot] += culture.path
