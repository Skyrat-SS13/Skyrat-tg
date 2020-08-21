/datum/species/proc/handle_mutant_bodyparts(mob/living/carbon/human/H, forced_colour)
	var/list/bodyparts_to_add = mutant_bodyparts.Copy()
	var/list/relevent_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	var/list/standing	= list()

	H.remove_overlay(BODY_BEHIND_LAYER)
	H.remove_overlay(BODY_ADJ_LAYER)
	H.remove_overlay(BODY_FRONT_LAYER)

	if(!mutant_bodyparts)
		return

	var/obj/item/bodypart/head/HD = H.get_bodypart(BODY_ZONE_HEAD)

	/*if("tail_lizard" in mutant_bodyparts)
		if(H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT))
			bodyparts_to_add -= "tail_lizard"

	if("waggingtail_lizard" in mutant_bodyparts)
		if(H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT))
			bodyparts_to_add -= "waggingtail_lizard"
		else if ("tail_lizard" in mutant_bodyparts)
			bodyparts_to_add -= "waggingtail_lizard"

	if("tail_human" in mutant_bodyparts)
		if(H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT))
			bodyparts_to_add -= "tail_human"


	if("waggingtail_human" in mutant_bodyparts)
		if(H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT))
			bodyparts_to_add -= "waggingtail_human"
		else if ("tail_human" in mutant_bodyparts)
			bodyparts_to_add -= "waggingtail_human"

	if("spines" in mutant_bodyparts)
		if(!H.dna.features["spines"] || H.dna.features["spines"] == "None" || H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT))
			bodyparts_to_add -= "spines"

	if("waggingspines" in mutant_bodyparts)
		if(!H.dna.features["spines"] || H.dna.features["spines"] == "None" || H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT))
			bodyparts_to_add -= "waggingspines"
		else if ("tail" in mutant_bodyparts)
			bodyparts_to_add -= "waggingspines"

	if("snout" in mutant_bodyparts) //Take a closer look at that snout!
		if((H.wear_mask && (H.wear_mask.flags_inv & HIDEFACE)) || (H.head && (H.head.flags_inv & HIDEFACE)) || !HD || HD.status == BODYPART_ROBOTIC)
			bodyparts_to_add -= "snout"

	if("frills" in mutant_bodyparts)
		if(!H.dna.features["frills"] || H.dna.features["frills"] == "None" || H.head && (H.head.flags_inv & HIDEEARS) || !HD || HD.status == BODYPART_ROBOTIC)
			bodyparts_to_add -= "frills"

	if("horns" in mutant_bodyparts)
		if(!H.dna.features["horns"] || H.dna.features["horns"] == "None" || H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD || HD.status == BODYPART_ROBOTIC)
			bodyparts_to_add -= "horns"

	if("ears" in mutant_bodyparts)
		if(!H.dna.features["ears"] || H.dna.features["ears"] == "None" || H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD || HD.status == BODYPART_ROBOTIC)
			bodyparts_to_add -= "ears"

	if("wings" in mutant_bodyparts)
		if(!H.dna.features["wings"] || H.dna.features["wings"] == "None" || (H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT) && (!H.wear_suit.species_exception || !is_type_in_list(src, H.wear_suit.species_exception))))
			bodyparts_to_add -= "wings"

	if("wings_open" in mutant_bodyparts)
		if(H.wear_suit && (H.wear_suit.flags_inv & HIDEJUMPSUIT) && (!H.wear_suit.species_exception || !is_type_in_list(src, H.wear_suit.species_exception)))
			bodyparts_to_add -= "wings_open"
		else if ("wings" in mutant_bodyparts)
			bodyparts_to_add -= "wings_open"*/

	//Digitigrade legs are stuck in the phantom zone between true limbs and mutant bodyparts. Mainly it just needs more agressive updating than most limbs.
	var/update_needed = FALSE
	var/not_digitigrade = TRUE
	for(var/X in H.bodyparts)
		var/obj/item/bodypart/O = X
		if(!O.use_digitigrade)
			continue
		not_digitigrade = FALSE
		if(!(DIGITIGRADE in species_traits)) //Someone cut off a digitigrade leg and tacked it on
			species_traits += DIGITIGRADE
		var/should_be_squished = FALSE
		if((H.wear_suit && H.wear_suit.flags_inv & HIDEJUMPSUIT && !(H.wear_suit.mutant_variants & STYLE_DIGITIGRADE) && (H.wear_suit.body_parts_covered & LEGS)) || (H.w_uniform && (H.w_uniform.body_parts_covered & LEGS) && !(H.w_uniform.mutant_variants & STYLE_DIGITIGRADE)))
			should_be_squished = TRUE
		if(O.use_digitigrade == FULL_DIGITIGRADE && should_be_squished)
			O.use_digitigrade = SQUISHED_DIGITIGRADE
			update_needed = TRUE
		else if(O.use_digitigrade == SQUISHED_DIGITIGRADE && !should_be_squished)
			O.use_digitigrade = FULL_DIGITIGRADE
			update_needed = TRUE
	if(update_needed)
		H.update_body_parts()
	if(not_digitigrade && (DIGITIGRADE in species_traits)) //Curse is lifted
		species_traits -= DIGITIGRADE

	if(!bodyparts_to_add)
		return

	var/g = (H.body_type == FEMALE) ? "f" : "m"

	for(var/layer in relevent_layers)
		var/layertext = mutant_bodyparts_layertext(layer)

		for(var/bodypart in bodyparts_to_add)
			var/datum/sprite_accessory/S = GLOB.sprite_accessories[bodypart][bodyparts_to_add[bodypart][MUTANT_INDEX_NAME]]
			if(!S || S.icon_state == "none")
				continue
			if(S.is_hidden(H, HD))
				continue

			var/mutable_appearance/accessory_overlay = mutable_appearance(S.icon, layer = -layer)

			if(S.gender_specific)
				accessory_overlay.icon_state = "[g]_[bodypart]_[S.icon_state]_[layertext]"
			else
				accessory_overlay.icon_state = "m_[bodypart]_[S.icon_state]_[layertext]"

			if(S.center)
				accessory_overlay = center_image(accessory_overlay, S.dimension_x, S.dimension_y)

			if(!(HAS_TRAIT(H, TRAIT_HUSK)))
				if(!forced_colour)
					switch(S.color_src)
						if(USE_ONE_COLOR)
							accessory_overlay.color = "#"+bodyparts_to_add[bodypart][MUTANT_INDEX_COLOR_LIST][1]
						if(USE_MATRIXED_COLORS)
							var/list/color_list = bodyparts_to_add[bodypart][MUTANT_INDEX_COLOR_LIST]
							var/list/finished_list = list()
							finished_list += ReadRGB("[color_list[1]]0")
							finished_list += ReadRGB("[color_list[2]]0")
							finished_list += ReadRGB("[color_list[3]]0")
							finished_list += list(0,0,0,255)
							for(var/index in 1 to finished_list.len)
								finished_list[index] /= 255
							accessory_overlay.color = finished_list
						if(MUTCOLORS)
							if(fixed_mut_color)
								accessory_overlay.color = "#[fixed_mut_color]"
							else
								accessory_overlay.color = "#[H.dna.features["mcolor"]]"
						if(HAIR)
							if(hair_color == "mutcolor")
								accessory_overlay.color = "#[H.dna.features["mcolor"]]"
							else if(hair_color == "fixedmutcolor")
								accessory_overlay.color = "#[fixed_mut_color]"
							else
								accessory_overlay.color = "#[H.hair_color]"
						if(FACEHAIR)
							accessory_overlay.color = "#[H.facial_hair_color]"
						if(EYECOLOR)
							accessory_overlay.color = "#[H.eye_color]"
				else if(USE_MATRIXED_COLORS) //Matrixed+husk needs special care, otherwise we get sparkle dogs
					accessory_overlay.color = HUSK_COLOR_LIST
				else
					accessory_overlay.color = forced_colour
			standing += accessory_overlay

			if(S.hasinner)
				var/mutable_appearance/inner_accessory_overlay = mutable_appearance(S.icon, layer = -layer)
				if(S.gender_specific)
					inner_accessory_overlay.icon_state = "[g]_[bodypart]inner_[S.icon_state]_[layertext]"
				else
					inner_accessory_overlay.icon_state = "m_[bodypart]inner_[S.icon_state]_[layertext]"

				if(S.center)
					inner_accessory_overlay = center_image(inner_accessory_overlay, S.dimension_x, S.dimension_y)

				standing += inner_accessory_overlay

		H.overlays_standing[layer] = standing.Copy()
		standing = list()

	H.apply_overlay(BODY_BEHIND_LAYER)
	H.apply_overlay(BODY_ADJ_LAYER)
	H.apply_overlay(BODY_FRONT_LAYER)

/datum/species
	///This holds 3 lists. Each of the list is possible colors to choose for randomization of a species, first list is primary, second secondary, third tertiary
	default_features = list(list("FFF"), list("FFF"), list("FFF"))
	///What accessories can a species have aswell as their default accessory of such type e.g. "frills" = "Aquatic". Default accessory colors is dictated by the accessory properties and mutcolors of the specie
	var/list/default_mutant_bodyparts = list()

/datum/species/dullahan
	default_features = list(list("FFF"), list("FFF"), list("FFF"))
	mutant_bodyparts = list()

/datum/species/human/felinid
	default_features = list(list("FFF"), list("FFF"), list("FFF"))
	mutant_bodyparts = list()

/datum/species/human
	default_features = list(list("FFF"), list("FFF"), list("FFF"))
	mutant_bodyparts = list()

/datum/species/moth
	default_features = list(list("FFF"), list("FFF"), list("FFF"))
	mutant_bodyparts = list()

/datum/species/mush
	default_features = list(list("FFF"), list("FFF"), list("FFF"))
	mutant_bodyparts = list()

/datum/species/vampire
	default_features = list(list("FFF"), list("FFF"), list("FFF"))
	mutant_bodyparts = list()

/datum/species/lizard
	default_features = list(list("FFF"), list("FFF"), list("FFF"))
	mutant_bodyparts = list()
	default_mutant_bodyparts = list("tail" = "Smooth", "snout" = ACC_RANDOM, "spines" = ACC_RANDOM, "horns" = ACC_RANDOM, "frills" = ACC_RANDOM, "body_markings" = ACC_RANDOM, "legs" = "Digitigrade Legs", "taur" = "None")

/datum/species/proc/get_random_features()
	var/list/feature_list = list()
	feature_list["mcolor"] = pick(default_features[1])
	feature_list["mcolor2"] = pick(default_features[2])
	feature_list["mcolor3"] = pick(default_features[3])
	return feature_list

/datum/species/proc/get_random_mutant_bodyparts(list/features) //Needs features to base the colour off of
	var/list/mutantpart_list = list()
	for(var/key in default_mutant_bodyparts)
		var/datum/sprite_accessory/SP
		if(default_mutant_bodyparts[key] == ACC_RANDOM)
			SP = random_accessory_of_key_for_species(key, src)
		else
			SP = GLOB.sprite_accessories[key][default_mutant_bodyparts[key]]
		var/list/color_list = SP.get_default_color(features)
		var/list/final_list = list()
		final_list[MUTANT_INDEX_NAME] = SP.name
		final_list[MUTANT_INDEX_COLOR_LIST] = color_list
		mutantpart_list[key] = final_list

	return mutantpart_list

/datum/species/proc/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	// Drop the items the new species can't wear
	if((AGENDER in species_traits))
		C.gender = PLURAL
	for(var/slot_id in no_equip)
		var/obj/item/thing = C.get_item_by_slot(slot_id)
		if(thing && (!thing.species_exception || !is_type_in_list(src,thing.species_exception)))
			C.dropItemToGround(thing)
	if(C.hud_used)
		C.hud_used.update_locked_slots()

	// this needs to be FIRST because qdel calls update_body which checks if we have DIGITIGRADE legs or not and if not then removes DIGITIGRADE from species_traits
	if(C.dna.species.mutant_bodyparts["legs"] && C.dna.species.mutant_bodyparts["legs"][MUTANT_INDEX_NAME] == "Digitigrade Legs")
		species_traits += DIGITIGRADE
	if(DIGITIGRADE in species_traits)
		C.Digitigrade_Leg_Swap(FALSE)

	C.mob_biotypes = inherent_biotypes

	regenerate_organs(C,old_species)

	if(exotic_bloodtype && C.dna.blood_type != exotic_bloodtype)
		C.dna.blood_type = exotic_bloodtype

	if(old_species.mutanthands)
		for(var/obj/item/I in C.held_items)
			if(istype(I, old_species.mutanthands))
				qdel(I)

	if(mutanthands)
		// Drop items in hands
		// If you're lucky enough to have a TRAIT_NODROP item, then it stays.
		for(var/V in C.held_items)
			var/obj/item/I = V
			if(istype(I))
				C.dropItemToGround(I)
			else	//Entries in the list should only ever be items or null, so if it's not an item, we can assume it's an empty hand
				C.put_in_hands(new mutanthands())

	for(var/X in inherent_traits)
		ADD_TRAIT(C, X, SPECIES_TRAIT)

	if(TRAIT_VIRUSIMMUNE in inherent_traits)
		for(var/datum/disease/A in C.diseases)
			A.cure(FALSE)

	if(TRAIT_TOXIMMUNE in inherent_traits)
		C.setToxLoss(0, TRUE, TRUE)

	if(TRAIT_NOMETABOLISM in inherent_traits)
		C.reagents.end_metabolization(C, keep_liverless = TRUE)

	if(TRAIT_GENELESS in inherent_traits)
		C.dna.remove_all_mutations() // Radiation immune mobs can't get mutations normally

	if(inherent_factions)
		for(var/i in inherent_factions)
			C.faction += i //Using +=/-= for this in case you also gain the faction from a different source.

	if(flying_species && isnull(fly))
		fly = new
		fly.Grant(C)

	C.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/species, multiplicative_slowdown=speedmod)

	SEND_SIGNAL(C, COMSIG_SPECIES_GAIN, src, old_species)

/datum/species/proc/handle_body(mob/living/carbon/human/H)
	H.remove_overlay(BODY_LAYER)

	var/list/standing = list()

	var/obj/item/bodypart/head/HD = H.get_bodypart(BODY_ZONE_HEAD)

	if(HD && !(HAS_TRAIT(H, TRAIT_HUSK)))
		// lipstick
		if(H.lip_style && (LIPS in species_traits))
			var/mutable_appearance/lip_overlay = mutable_appearance('icons/mob/human_face.dmi', "lips_[H.lip_style]", -BODY_LAYER)
			lip_overlay.color = H.lip_color
			if(OFFSET_FACE in H.dna.species.offset_features)
				lip_overlay.pixel_x += H.dna.species.offset_features[OFFSET_FACE][1]
				lip_overlay.pixel_y += H.dna.species.offset_features[OFFSET_FACE][2]
			standing += lip_overlay

		// eyes
		if(!(NOEYESPRITES in species_traits))
			var/obj/item/organ/eyes/E = H.getorganslot(ORGAN_SLOT_EYES)
			var/mutable_appearance/eye_overlay
			if(!E)
				eye_overlay = mutable_appearance('icons/mob/human_face.dmi', "eyes_missing", -BODY_LAYER)
			else
				eye_overlay = mutable_appearance('icons/mob/human_face.dmi', E.eye_icon_state, -BODY_LAYER)
			if((EYECOLOR in species_traits) && E)
				eye_overlay.color = "#" + H.eye_color
			if(OFFSET_FACE in H.dna.species.offset_features)
				eye_overlay.pixel_x += H.dna.species.offset_features[OFFSET_FACE][1]
				eye_overlay.pixel_y += H.dna.species.offset_features[OFFSET_FACE][2]
			standing += eye_overlay

	//Underwear, Undershirts & Socks
	if(!(NO_UNDERWEAR in species_traits))
		if(H.underwear)
			var/datum/sprite_accessory/underwear/underwear = GLOB.underwear_list[H.underwear]
			var/mutable_appearance/underwear_overlay
			if(underwear)
				var/icon_state = underwear.icon_state
				if(underwear.has_digitigrade && (DIGITIGRADE in species_traits))
					icon_state += "_d" 
				underwear_overlay = mutable_appearance(underwear.icon, icon_state, -BODY_LAYER)
				if(!underwear.use_static)
					underwear_overlay.color = "#" + H.underwear_color
				standing += underwear_overlay

		if(H.undershirt)
			var/datum/sprite_accessory/undershirt/undershirt = GLOB.undershirt_list[H.undershirt]
			if(undershirt)
				var/mutable_appearance/undershirt_overlay
				if(H.dna.species.sexes && H.gender == FEMALE)
					undershirt_overlay = wear_female_version(undershirt.icon_state, undershirt.icon, BODY_LAYER)
				else
					undershirt_overlay = mutable_appearance(undershirt.icon, undershirt.icon_state, -BODY_LAYER)
				if(!undershirt.use_static)
					undershirt_overlay.color = "#" + H.undershirt_color
				standing += undershirt_overlay

		if(H.socks && H.get_num_legs(FALSE) >= 2 && !(mutant_bodyparts["taur"]))
			var/datum/sprite_accessory/socks/socks = GLOB.socks_list[H.socks]
			if(socks)
				var/mutable_appearance/socks_overlay
				var/icon_state = socks.icon_state
				if(DIGITIGRADE in species_traits)
					icon_state += "_d" 
				socks_overlay = mutable_appearance(socks.icon, icon_state, -BODY_LAYER)
				if(!socks.use_static)
					socks_overlay.color = "#" + H.socks_color
				standing += socks_overlay

	if(standing.len)
		H.overlays_standing[BODY_LAYER] = standing

	H.apply_overlay(BODY_LAYER)
	handle_mutant_bodyparts(H)
