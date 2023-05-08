GLOBAL_LIST_EMPTY(customizable_races)

/datum/species
	mutant_bodyparts = list()
	digitigrade_customization = DIGITIGRADE_OPTIONAL // Doing this so that the legs preference actually works for everyone.
	///Self explanatory
	var/can_have_genitals = TRUE
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
	///Path to BODYTYPE_CUSTOM species worn icons. An assoc list of ITEM_SLOT_X => /icon
	var/list/custom_worn_icons = list()
	///Is this species restricted from changing their body_size in character creation?
	var/body_size_restricted = FALSE
	///What accessories can a species have aswell as their default accessory of such type e.g. "frills" = "Aquatic". Default accessory colors is dictated by the accessory properties and mutcolors of the specie
	var/list/default_mutant_bodyparts = list()
	/// A static list of all genital slot possibilities.
	var/static/list/genitals_list = list(ORGAN_SLOT_VAGINA, ORGAN_SLOT_WOMB, ORGAN_SLOT_TESTICLES, ORGAN_SLOT_BREASTS, ORGAN_SLOT_ANUS, ORGAN_SLOT_PENIS)

/datum/species/proc/handle_mutant_bodyparts(mob/living/carbon/human/owner, forced_colour, force_update = FALSE)
	return

/datum/species/New()
	. = ..()
	if(can_have_genitals)
		for(var/genital in genitals_list)
			default_mutant_bodyparts[genital] = "None"

/datum/species/dullahan
	mutant_bodyparts = list()

/datum/species/human/felinid
	mutant_bodyparts = list()
	default_mutant_bodyparts = list("tail" = "Cat", "ears" = "Cat")

/datum/species/human
	mutant_bodyparts = list()
	default_mutant_bodyparts = list("ears" = "None", "tail" = "None", "wings" = "None")

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
	return

/datum/species/proc/get_random_mutant_bodyparts(list/features) //Needs features to base the colour off of
	var/list/mutantpart_list = list()
	var/list/bodyparts_to_add = default_mutant_bodyparts.Copy()
	if(CONFIG_GET(flag/disable_erp_preferences))
		for(var/genital in genitals_list)
			bodyparts_to_add.Remove(genital)
	for(var/key in bodyparts_to_add)
		var/datum/sprite_accessory/SP
		if(bodyparts_to_add[key] == ACC_RANDOM)
			SP = random_accessory_of_key_for_species(key, src)
		else
			SP = GLOB.sprite_accessories[key][bodyparts_to_add[key]]
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
	var/height_offset = species_human.get_top_offset() // From high changed by varying limb height
	var/list/standing = list()

	var/obj/item/bodypart/head/noggin = species_human.get_bodypart(BODY_ZONE_HEAD)

	if(noggin && !(HAS_TRAIT(species_human, TRAIT_HUSK)))
		// lipstick
		if(species_human.lip_style && (LIPS in species_traits))
			var/mutable_appearance/lip_overlay = mutable_appearance('icons/mob/species/human/human_face.dmi', "lips_[species_human.lip_style]", -BODY_LAYER)
			lip_overlay.color = species_human.lip_color
			noggin.worn_face_offset?.apply_offset(lip_overlay)
			lip_overlay.pixel_y += height_offset
			standing += lip_overlay

		// eyes
		if(!(NOEYESPRITES in species_traits))
			var/obj/item/organ/internal/eyes/eye_organ = species_human.get_organ_slot(ORGAN_SLOT_EYES)
			var/mutable_appearance/no_eyeslay
			var/add_pixel_x = 0
			var/add_pixel_y = 0
			//cut any possible vis overlays
			if(body_vis_overlays.len)
				SSvis_overlays.remove_vis_overlay(species_human, body_vis_overlays)
			var/list/feature_offset = noggin.worn_face_offset?.get_offset()
			if(feature_offset)
				add_pixel_x = feature_offset["x"]
				add_pixel_y = feature_offset["y"]
			add_pixel_y += height_offset

			if(!eye_organ)
				no_eyeslay = mutable_appearance('icons/mob/species/human/human_face.dmi', "eyes_missing", -BODY_LAYER)
				no_eyeslay.pixel_x += add_pixel_x
				no_eyeslay.pixel_y += add_pixel_y
				standing += no_eyeslay
			else
				eye_organ.refresh(call_update = FALSE)

			if(!no_eyeslay)
				for(var/mutable_appearance/eye_overlay in eye_organ.generate_body_overlay(species_human))
					eye_overlay.pixel_y += height_offset
					standing += eye_overlay
					if(eye_organ.is_emissive)
						var/mutable_appearance/eye_emissive = emissive_appearance_copy(eye_overlay, species_human)
						eye_emissive.pixel_x += add_pixel_x
						eye_emissive.pixel_y += add_pixel_y
						standing += eye_emissive

	//Underwear, Undershirts & Socks
	if(!(NO_UNDERWEAR in species_traits))
		if(species_human.underwear && !(species_human.underwear_visibility & UNDERWEAR_HIDE_UNDIES))
			var/datum/sprite_accessory/underwear/underwear = GLOB.underwear_list[species_human.underwear]
			var/mutable_appearance/underwear_overlay
			if(underwear)
				var/icon_state = underwear.icon_state
				if(underwear.has_digitigrade && (bodytype & BODYTYPE_DIGITIGRADE))
					icon_state += "_d"
				underwear_overlay = mutable_appearance(underwear.icon, icon_state, -BODY_LAYER)
				if(!underwear.use_static)
					underwear_overlay.color = species_human.underwear_color
				standing += underwear_overlay

		if(species_human.undershirt && !(species_human.underwear_visibility & UNDERWEAR_HIDE_SHIRT))
			var/datum/sprite_accessory/undershirt/undershirt = GLOB.undershirt_list[species_human.undershirt]
			if(undershirt)
				var/mutable_appearance/undershirt_overlay
				if(species_human.dna.species.sexes && species_human.gender == FEMALE)
					undershirt_overlay = wear_female_version(undershirt.icon_state, undershirt.icon, BODY_LAYER)
				else
					undershirt_overlay = mutable_appearance(undershirt.icon, undershirt.icon_state, -BODY_LAYER)
				if(!undershirt.use_static)
					undershirt_overlay.color = species_human.undershirt_color
				standing += undershirt_overlay

		if(species_human.socks && species_human.num_legs >= 2 && !(mutant_bodyparts["taur"]) && !(species_human.underwear_visibility & UNDERWEAR_HIDE_SOCKS))
			var/datum/sprite_accessory/socks/socks = GLOB.socks_list[species_human.socks]
			if(socks)
				var/mutable_appearance/socks_overlay
				var/icon_state = socks.icon_state
				if((bodytype & BODYTYPE_DIGITIGRADE))
					icon_state += "_d"
				socks_overlay = mutable_appearance(socks.icon, icon_state, -BODY_LAYER)
				if(!socks.use_static)
					socks_overlay.color = species_human.socks_color
				standing += socks_overlay

	if(standing.len)
		species_human.overlays_standing[BODY_LAYER] = standing

	species_human.apply_overlay(BODY_LAYER)
	handle_mutant_bodyparts(species_human)

//I wag in death
/datum/species/spec_death(gibbed, mob/living/carbon/human/H)
	if(H)
		stop_wagging_tail(H)

/datum/species/spec_stun(mob/living/carbon/human/H,amount)
	if(H)
		stop_wagging_tail(H)
	. = ..()

/*
*	TAIL WAGGING
*/

/datum/species/proc/can_wag_tail(mob/living/carbon/human/H)
	if(!H) //Somewhere in the core code we're getting those procs with H being null
		return FALSE
	var/obj/item/organ/external/tail/T = H.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(!T)
		return FALSE
	if(T.can_wag)
		return TRUE
	return FALSE

/datum/species/proc/is_wagging_tail(mob/living/carbon/human/H)
	if(!H) //Somewhere in the core code we're getting those procs with H being null
		return FALSE
	var/obj/item/organ/external/tail/T = H.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(!T)
		return FALSE
	return T.wagging

/datum/species/proc/start_wagging_tail(mob/living/carbon/human/H)
	if(!H) //Somewhere in the core code we're getting those procs with H being null
		return
	var/obj/item/organ/external/tail/T = H.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(!T)
		return FALSE
	T.wagging = TRUE
	H.update_body()

/datum/species/proc/stop_wagging_tail(mob/living/carbon/human/H)
	if(!H) //Somewhere in the core code we're getting those procs with H being null
		return
	var/obj/item/organ/external/tail/T = H.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(!T)
		return
	T.wagging = FALSE
	H.update_body()

/datum/species/regenerate_organs(mob/living/carbon/target, datum/species/old_species, replace_current = TRUE, list/excluded_zones, visual_only = FALSE)
	. = ..()

	var/robot_organs = (ROBOTIC_DNA_ORGANS in target.dna.species.species_traits)

	for(var/key in target.dna.mutant_bodyparts)
		if(!islist(target.dna.mutant_bodyparts[key]) || !(target.dna.mutant_bodyparts[key][MUTANT_INDEX_NAME] in GLOB.sprite_accessories[key]))
			continue

		var/datum/sprite_accessory/mutant_accessory = GLOB.sprite_accessories[key][target.dna.mutant_bodyparts[key][MUTANT_INDEX_NAME]]

		if(mutant_accessory?.factual && mutant_accessory.organ_type)
			var/obj/item/organ/current_organ = target.get_organ_by_type(mutant_accessory.organ_type)

			if(!current_organ || replace_current)
				var/obj/item/organ/replacement = SSwardrobe.provide_type(mutant_accessory.organ_type)
				replacement.sprite_accessory_flags = mutant_accessory.flags_for_organ
				replacement.relevant_layers = mutant_accessory.relevent_layers

				if(robot_organs)
					replacement.status = ORGAN_ROBOTIC
					replacement.organ_flags |= ORGAN_SYNTHETIC

				// If there's an existing mutant organ, we're technically replacing it.
				// Let's abuse the snowflake proc that skillchips added. Basically retains
				// feature parity with every other organ too.
				if(current_organ)
					current_organ.before_organ_replacement(replacement)

				replacement.build_from_dna(target.dna, key)
				// organ.Insert will qdel any current organs in that slot, so we don't need to.
				replacement.Insert(target, special = TRUE, drop_if_replaced = FALSE)

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
