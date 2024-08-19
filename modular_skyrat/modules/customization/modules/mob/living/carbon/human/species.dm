GLOBAL_LIST_EMPTY(customizable_races)

/datum/species
	mutant_bodyparts = list()
	digitigrade_customization = DIGITIGRADE_OPTIONAL // Doing this so that the legs preference actually works for everyone.
	///Self explanatory
	var/can_have_genitals = TRUE
	/// Whether or not the gender shaping is disabled for this species
	var/no_gender_shaping
	///A list of actual body markings on the owner of the species. Associative lists with keys named by limbs defines, pointing to a list with names and colors for the marking to be rendered. This is also stored in the DNA
	var/list/list/body_markings = list()
	///Override of the eyes icon file, used for Vox and maybe more in the future - The future is now, with Teshari using it too
	var/eyes_icon
	///How are we treated regarding processing reagents, by default we process them as if we're organic
	var/reagent_flags = PROCESS_ORGANIC
	///Whether a species can use augmentations in preferences
	var/can_augment = TRUE
	///Override for the alpha of bodyparts and mutant parts.
	var/specific_alpha = 255
	///Override for alpha value of markings, should be much lower than the above value.
	var/markings_alpha = 255
	///If a species can always be picked in prefs for the purposes of customizing it for ghost roles or events
	var/always_customizable = FALSE
	/// If a species requires the player to be a Veteran to be able to pick it.
	var/veteran_only = FALSE
	///Flavor text of the species displayed on character creation screeen
	var/flavor_text = "No description."
	///Path to BODYSHAPE_CUSTOM species worn icons. An assoc list of ITEM_SLOT_X => /icon
	var/list/custom_worn_icons = list()
	///Is this species restricted from changing their body_size in character creation?
	var/body_size_restricted = FALSE
	/// Are we lore protected? This prevents people from changing the species lore or species name.
	var/lore_protected = FALSE

/// Returns a list of the default mutant bodyparts, and whether or not they can be randomized or not
/datum/species/proc/get_default_mutant_bodyparts()
	return list()

/datum/species/proc/handle_mutant_bodyparts(mob/living/carbon/human/source, forced_colour)
	return

/datum/species/dullahan
	mutant_bodyparts = list()

/datum/species/human/felinid
	mutant_bodyparts = list()

/datum/species/human/felinid/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Cat", FALSE),
		"ears" = list("Cat", FALSE),
	)

/datum/species/human
	mutant_bodyparts = list()

/datum/species/human/get_default_mutant_bodyparts()
	return list(
		"ears" = list("None", FALSE),
		"tail" = list("None", FALSE),
		"wings" = list("None", FALSE),
	)

/datum/species/mush
	mutant_bodyparts = list()

/datum/species/vampire
	mutant_bodyparts = list()

/datum/species/plasmaman
	mutant_bodyparts = list()
	can_have_genitals = FALSE
	can_augment = FALSE

/datum/species/ethereal
	mutant_bodyparts = list()
	can_have_genitals = FALSE
	can_augment = FALSE

/datum/species/pod
	name = "Primal Podperson"
	always_customizable = TRUE

/datum/species/randomize_features(mob/living/carbon/human/human_mob)
	var/list/features = ..()
	return features

/**
 * Returns a list of mutant_bodyparts
 *
 * Gets the default species mutant_bodyparts list for the given species datum and sets up its sprite accessories.
 *
 * Arguments:
 * * features - Features are needed for the part color
 * * existing_mutant_bodyparts - When passed a list of existing mutant bodyparts, the existing ones will not get overwritten
 */
/datum/species/proc/get_mutant_bodyparts(list/features, list/existing_mutant_bodyparts) //Needs features to base the colour off of
	var/list/mutantpart_list = list()
	if(LAZYLEN(existing_mutant_bodyparts))
		mutantpart_list = existing_mutant_bodyparts.Copy()
	var/list/default_bodypart_data = GLOB.default_mutant_bodyparts[name]
	var/list/bodyparts_to_add = default_bodypart_data.Copy()
	if(CONFIG_GET(flag/disable_erp_preferences))
		for(var/genital in GLOB.possible_genitals)
			bodyparts_to_add.Remove(genital)
	for(var/key in bodyparts_to_add)
		if(LAZYLEN(existing_mutant_bodyparts) && existing_mutant_bodyparts[key])
			continue
		var/datum/sprite_accessory/SP
		if(default_bodypart_data[key][MUTANTPART_CAN_RANDOMIZE])
			SP = random_accessory_of_key_for_species(key, src)
		else
			SP = SSaccessories.sprite_accessories[key][bodyparts_to_add[key][MUTANTPART_NAME]]
			if(!SP)
				CRASH("Cant find accessory of [key] key, [bodyparts_to_add[key]] name, for species [id]")
		var/list/color_list = SP.get_default_color(features, src)
		var/list/final_list = list()
		final_list[MUTANT_INDEX_NAME] = SP.name
		final_list[MUTANT_INDEX_COLOR_LIST] = color_list
		mutantpart_list[key] = final_list

	return mutantpart_list

/datum/species/proc/get_random_body_markings(list/features) //Needs features to base the colour off of
	return list()

/datum/species/proc/handle_body(mob/living/carbon/human/species_human)
	species_human.remove_overlay(BODY_LAYER)
	var/list/standing = list()

	var/obj/item/bodypart/head/noggin = species_human.get_bodypart(BODY_ZONE_HEAD)

	if(noggin && !(HAS_TRAIT(species_human, TRAIT_HUSK)))
		if(noggin.head_flags & HEAD_EYESPRITES)
			var/obj/item/organ/internal/eyes/eye_organ = species_human.get_organ_slot(ORGAN_SLOT_EYES)

			if(eye_organ)
				eye_organ.refresh(call_update = FALSE)
				standing += eye_organ.generate_body_overlay(species_human)

	//Underwear, Undershirts & Socks
	if(!HAS_TRAIT(species_human, TRAIT_NO_UNDERWEAR))
		if(species_human.underwear && !(species_human.underwear_visibility & UNDERWEAR_HIDE_UNDIES))
			var/datum/sprite_accessory/underwear/underwear = SSaccessories.underwear_list[species_human.underwear]
			var/mutable_appearance/underwear_overlay
			var/female_sprite_flags = FEMALE_UNIFORM_FULL // the default gender shaping
			if(underwear)
				var/icon_state = underwear.icon_state
				if(underwear.has_digitigrade && (species_human.bodyshape & BODYSHAPE_DIGITIGRADE))
					icon_state += "_d"
					female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY // for digi gender shaping
				if(species_human.dna.species.sexes && species_human.physique == FEMALE && (underwear.gender == MALE))
					underwear_overlay = wear_female_version(icon_state, underwear.icon, BODY_LAYER, female_sprite_flags)
				else
					underwear_overlay = mutable_appearance(underwear.icon, icon_state, -BODY_LAYER)
				if(!underwear.use_static)
					underwear_overlay.color = species_human.underwear_color
				standing += underwear_overlay

		if(species_human.bra && !(species_human.underwear_visibility & UNDERWEAR_HIDE_BRA))
			var/datum/sprite_accessory/bra/bra = SSaccessories.bra_list[species_human.bra]

			if(bra)
				var/mutable_appearance/bra_overlay
				var/icon_state = bra.icon_state
				bra_overlay = mutable_appearance(bra.icon, icon_state, -BODY_LAYER)
				if(!bra.use_static)
					bra_overlay.color = species_human.bra_color
				standing += bra_overlay

		if(species_human.undershirt && !(species_human.underwear_visibility & UNDERWEAR_HIDE_SHIRT))
			var/datum/sprite_accessory/undershirt/undershirt = SSaccessories.undershirt_list[species_human.undershirt]
			if(undershirt)
				var/mutable_appearance/undershirt_overlay
				if(species_human.dna.species.sexes && species_human.physique == FEMALE)
					undershirt_overlay = wear_female_version(undershirt.icon_state, undershirt.icon, BODY_LAYER)
				else
					undershirt_overlay = mutable_appearance(undershirt.icon, undershirt.icon_state, -BODY_LAYER)
				if(!undershirt.use_static)
					undershirt_overlay.color = species_human.undershirt_color
				standing += undershirt_overlay

		if(species_human.socks && species_human.num_legs >= 2 && !(mutant_bodyparts["taur"]) && !(species_human.underwear_visibility & UNDERWEAR_HIDE_SOCKS))
			var/datum/sprite_accessory/socks/socks = SSaccessories.socks_list[species_human.socks]
			if(socks)
				var/mutable_appearance/socks_overlay
				var/icon_state = socks.icon_state
				if((species_human.bodyshape & BODYSHAPE_DIGITIGRADE))
					icon_state += "_d"
				socks_overlay = mutable_appearance(socks.icon, icon_state, -BODY_LAYER)
				if(!socks.use_static)
					socks_overlay.color = species_human.socks_color
				standing += socks_overlay

	if(standing.len)
		species_human.overlays_standing[BODY_LAYER] = standing

	species_human.apply_overlay(BODY_LAYER)
	handle_mutant_bodyparts(species_human)

/datum/species/spec_stun(mob/living/carbon/human/target, amount)
	if(istype(target))
		target.unwag_tail()
	return ..()

/datum/species/regenerate_organs(mob/living/carbon/target, datum/species/old_species, replace_current = TRUE, list/excluded_zones, visual_only = FALSE)
	. = ..()

	var/robot_organs = HAS_TRAIT(target, TRAIT_ROBOTIC_DNA_ORGANS)

	for(var/key in target.dna.mutant_bodyparts)
		if(!islist(target.dna.mutant_bodyparts[key]) || !(target.dna.mutant_bodyparts[key][MUTANT_INDEX_NAME] in SSaccessories.sprite_accessories[key]))
			continue

		var/datum/sprite_accessory/mutant_accessory = SSaccessories.sprite_accessories[key][target.dna.mutant_bodyparts[key][MUTANT_INDEX_NAME]]

		if(mutant_accessory?.factual && mutant_accessory.organ_type)
			var/obj/item/organ/current_organ = target.get_organ_by_type(mutant_accessory.organ_type)

			if(!current_organ || replace_current)
				var/obj/item/organ/replacement = SSwardrobe.provide_type(mutant_accessory.organ_type)
				replacement.sprite_accessory_flags = mutant_accessory.flags_for_organ
				replacement.relevant_layers = mutant_accessory.relevent_layers

				if(robot_organs)
					replacement.organ_flags |= ORGAN_ROBOTIC

				// If there's an existing mutant organ, we're technically replacing it.
				// Let's abuse the snowflake proc that skillchips added. Basically retains
				// feature parity with every other organ too.
				if(current_organ)
					current_organ.before_organ_replacement(replacement)

				replacement.build_from_dna(target.dna, key)
				// organ.Insert will qdel any current organs in that slot, so we don't need to.
				replacement.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)

			// var/obj/item/organ/path = new SA.organ_type
			// var/obj/item/organ/oldorgan = C.get_organ_slot(path.slot)
			// if(oldorgan)
			// 	oldorgan.Remove(C,TRUE)
			// 	QDEL_NULL(oldorgan)
			// path.build_from_dna(C.dna, key)
			// path.Insert(C, 0, FALSE)


/datum/species/proc/spec_revival(mob/living/carbon/human/H)
	return

/// Gets a list of all customizable races on roundstart.
/proc/get_customizable_races()
	RETURN_TYPE(/list)

	if (!GLOB.customizable_races.len)
		GLOB.customizable_races = generate_customizable_races()

	return GLOB.customizable_races

/**
 * Generates races available to choose in character setup at roundstart, yet not playable on the station.
 *
 * This proc generates which species are available to pick from in character setup.
 */
/proc/generate_customizable_races()
	var/list/customizable_races = list()

	for(var/species_type in subtypesof(/datum/species))
		var/datum/species/species = new species_type
		if(species.always_customizable)
			customizable_races += species.id
			qdel(species)

	return customizable_races
