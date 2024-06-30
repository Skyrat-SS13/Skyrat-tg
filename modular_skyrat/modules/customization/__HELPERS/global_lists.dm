/proc/make_skyrat_datum_references()
	init_prefs_emotes()
	make_default_mutant_bodypart_references()
	make_body_marking_references()
	make_body_marking_set_references()
	make_body_marking_dna_block_references()
	populate_total_ui_len_by_block()
	populate_total_uf_len_by_block()
	make_augment_references()

/proc/init_prefs_emotes()
	//Scream types
	for(var/spath in subtypesof(/datum/scream_type))
		var/datum/scream_type/S = new spath()
		GLOB.scream_types[S.name] = spath
	sort_list(GLOB.scream_types, GLOBAL_PROC_REF(cmp_typepaths_asc))

	//Laugh types
	for(var/spath in subtypesof(/datum/laugh_type))
		var/datum/laugh_type/L = new spath()
		GLOB.laugh_types[L.name] = spath
	sort_list(GLOB.laugh_types, GLOBAL_PROC_REF(cmp_typepaths_asc))

/proc/make_laugh_datum_references()
	//Laugh types
	GLOB.laugh_types = list()
	for(var/spath in subtypesof(/datum/laugh_type))
		var/datum/laugh_type/L = new spath()
		GLOB.laugh_types[L.name] = spath
	sort_list(GLOB.laugh_types, GLOBAL_PROC_REF(cmp_typepaths_asc))


/proc/make_default_mutant_bodypart_references()
	// Build the global list for default species' mutant_bodyparts
	for(var/path in subtypesof(/datum/species))
		var/datum/species/species_type = path
		var/datum/species/species_instance = new species_type
		if(!isnull(species_instance.name))
			GLOB.default_mutant_bodyparts[species_instance.name] = species_instance.get_default_mutant_bodyparts()
			if(species_instance.can_have_genitals)
				for(var/genital in GLOB.possible_genitals)
					GLOB.default_mutant_bodyparts[species_instance.name] += list((genital) = list("None", FALSE))
		qdel(species_instance)

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
		GLOB.dna_body_marking_blocks[marking_zone] = SSaccessories.dna_total_feature_blocks+1
		for(var/feature_block_set in 1 to MAXIMUM_MARKINGS_PER_LIMB)
			for(var/color_block in 1 to DNA_MARKING_COLOR_BLOCKS_PER_MARKING)
				SSaccessories.features_block_lengths["[GLOB.dna_body_marking_blocks[marking_zone] + (feature_block_set - 1) * DNA_BLOCKS_PER_MARKING + color_block]"] = DNA_BLOCK_SIZE_COLOR
		SSaccessories.dna_total_feature_blocks += DNA_BLOCKS_PER_MARKING_ZONE

/proc/init_skyrat_stack_recipes()
	var/list/additional_stack_recipes = list(
		/obj/item/stack/sheet/leather = list(GLOB.skyrat_leather_recipes, GLOB.skyrat_leather_belt_recipes),
		/obj/item/stack/sheet/mineral/titanium = list(GLOB.skyrat_titanium_recipes),
		/obj/item/stack/sheet/mineral/snow = list(GLOB.skyrat_snow_recipes),
		/obj/item/stack/sheet/iron = list(GLOB.skyrat_metal_recipes, GLOB.skyrat_metal_airlock_recipes),
		/obj/item/stack/sheet/plasteel = list(GLOB.skyrat_plasteel_recipes),
		/obj/item/stack/sheet/mineral/wood = list(GLOB.skyrat_wood_recipes),
		/obj/item/stack/sheet/cloth = list(GLOB.skyrat_cloth_recipes),
		/obj/item/stack/ore/glass = list(GLOB.skyrat_sand_recipes),
		/obj/item/stack/rods = list(GLOB.skyrat_rod_recipes),
		/obj/item/stack/sheet/mineral/stone = list(GLOB.stone_recipes),
		/obj/item/stack/sheet/plastic_wall_panel = list(GLOB.plastic_wall_panel_recipes),
		/obj/item/stack/sheet/spaceshipglass = list(GLOB.spaceshipglass_recipes),
	)
	for(var/stack in additional_stack_recipes)
		for(var/material_list in additional_stack_recipes[stack])
			for(var/stack_recipe in material_list)
				if(istype(stack_recipe, /datum/stack_recipe_list))
					var/datum/stack_recipe_list/stack_recipe_list = stack_recipe
					for(var/nested_recipe in stack_recipe_list.recipes)
						if(!nested_recipe)
							continue
						var/datum/crafting_recipe/stack/recipe = new/datum/crafting_recipe/stack(stack, nested_recipe)
						if(recipe.name != "" && recipe.result)
							GLOB.crafting_recipes += recipe
				else
					if(!stack_recipe)
						continue
					var/datum/crafting_recipe/stack/recipe = new/datum/crafting_recipe/stack(stack, stack_recipe)
					if(recipe.name != "" && recipe.result)
						GLOB.crafting_recipes += recipe

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


	// Underwear
	for(var/sprite_name in SSaccessories.underwear_list)
		var/datum/sprite_accessory/sprite_datum = SSaccessories.underwear_list[sprite_name]
		if(!sprite_datum?.erp_accessory)
			continue
		SSaccessories.underwear_list -= sprite_name

	for(var/sprite_name in SSaccessories.underwear_f)
		var/datum/sprite_accessory/sprite_datum = SSaccessories.underwear_f[sprite_name]
		if(!sprite_datum?.erp_accessory)
			continue
		SSaccessories.underwear_f -= sprite_name

	for(var/sprite_name in SSaccessories.underwear_m)
		var/datum/sprite_accessory/sprite_datum = SSaccessories.underwear_m[sprite_name]
		if(!sprite_datum?.erp_accessory)
			continue
		SSaccessories.underwear_m -= sprite_name

	// Undershirts
	for(var/sprite_name in SSaccessories.undershirt_list)
		var/datum/sprite_accessory/sprite_datum = SSaccessories.undershirt_list[sprite_name]
		if(!sprite_datum?.erp_accessory)
			continue
		SSaccessories.undershirt_list -= sprite_name

	for(var/sprite_name in SSaccessories.undershirt_f)
		var/datum/sprite_accessory/sprite_datum = SSaccessories.undershirt_f[sprite_name]
		if(!sprite_datum?.erp_accessory)
			continue
		SSaccessories.undershirt_f -= sprite_name

	for(var/sprite_name in SSaccessories.undershirt_m)
		var/datum/sprite_accessory/sprite_datum = SSaccessories.undershirt_m[sprite_name]
		if(!sprite_datum?.erp_accessory)
			continue
		SSaccessories.undershirt_m -= sprite_name


	// Bras
	for(var/sprite_name in SSaccessories.bra_list)
		var/datum/sprite_accessory/sprite_datum = SSaccessories.bra_list[sprite_name]
		if(!sprite_datum?.erp_accessory)
			continue

		SSaccessories.bra_list -= sprite_name

	for(var/sprite_name in SSaccessories.bra_f)
		var/datum/sprite_accessory/sprite_datum = SSaccessories.bra_f[sprite_name]
		if(!sprite_datum?.erp_accessory)
			continue

		SSaccessories.bra_f -= sprite_name

	for(var/sprite_name in SSaccessories.bra_m)
		var/datum/sprite_accessory/sprite_datum = SSaccessories.bra_m[sprite_name]
		if(!sprite_datum?.erp_accessory)
			continue

		SSaccessories.bra_m -= sprite_name
