

/mob/living/carbon/human/proc/has_organ(name)
	var/obj/item/organ/external/O = organs_by_name[name]
	return (O && !O.is_stump())


/mob/living/carbon/human/proc/has_organ_or_replacement(var/organ_tag)
	if (organ_tag in species.organ_substitutions)
		organ_tag = species.organ_substitutions[organ_tag]

	return has_organ(organ_tag)

/mob/proc/has_free_hand()
	return TRUE

//Returns TRUE if src has at least one hand which isn't currently holding anything
/mob/living/carbon/human/has_free_hand()
	var/numhands = 0

	//Possible future todo: Necromorphs with many arms? Bionic limbs?
	for (var/organ_tag in list(BP_R_HAND, BP_L_HAND))
		if (has_organ(organ_tag))
			numhands++


	var/list/held = get_held_items()

	if (length(held) < numhands)
		return TRUE

	return FALSE


/mob/living/carbon/human/proc/get_active_grasping_limb()
	var/numtocheck = 1 + hand //This feels hacky

	if (!length(species.grasping_limbs))
		return null

	var/obj/item/organ/external/E = get_organ(species.grasping_limbs[min(species.grasping_limbs.len, numtocheck)])
	if(!E || E.retracted || E.is_stump())
		return null
	return E

/mob/living/carbon/human/proc/update_eyes()
	var/obj/item/organ/internal/eyes/eyes = internal_organs_by_name[species.vision_organ ? species.vision_organ : BP_EYES]
	if(eyes)
		eyes.update_colour()
		regenerate_icons()

/mob/living/carbon/human/proc/get_bodypart_name(var/zone)
	var/obj/item/organ/external/E = get_organ(zone)
	if(E) . = E.name

/mob/living/carbon/human/proc/recheck_bad_external_organs()
	var/damage_this_tick = getToxLoss()
	for(var/obj/item/organ/external/O in organs)
		damage_this_tick += O.burn_dam + O.brute_dam

	if(damage_this_tick > last_dam)
		. = TRUE
	last_dam = damage_this_tick

// Takes care of organ related updates, such as broken and missing limbs
/mob/living/carbon/human/proc/handle_organs()

	var/force_process = recheck_bad_external_organs()

	if(force_process)
		bad_external_organs.Cut()
		for(var/obj/item/organ/external/Ex in organs)
			bad_external_organs |= Ex

	//processing internal organs is pretty cheap, do that first.
	for(var/obj/item/organ/I in internal_organs)
		I.Process()

	handle_stance()
	handle_grasp()

	if(!force_process && !bad_external_organs.len)
		return

	for(var/obj/item/organ/external/E in bad_external_organs)
		if(!E)
			continue
		if(!E.need_process())
			bad_external_organs -= E
			continue
		else
			E.Process()

			if (!lying && !buckled && world.time - l_move_time < 15)
			//Moving around with fractured ribs won't do you any good
				if (prob(10) && !stat && can_feel_pain() && chem_effects[CE_PAINKILLER] < 50 && E.is_broken() && E.internal_organs.len)
					custom_pain("Pain jolts through your broken [E.encased ? E.encased : E.name], staggering you!", 50, affecting = E)
					unequip_item(loc)
					Stun(2)

				//Moving makes open wounds get infected much faster
				if (E.wounds.len)
					for(var/datum/wound/W in E.wounds)
						if (W.infection_check())
							W.germ_level += 1

/mob/living/carbon/human/proc/handle_stance()
	// Don't need to process any of this if they aren't standing anyways
	// unless their stance is damaged, and we want to check if they should stay down
	if (!stance_damage && (lying || resting) && (life_tick % 4) != 0)
		return

	stance_damage = 0

	// Buckled to a bed/chair. Stance damage is forced to 0 since they're sitting on something solid
	if (istype(buckled, /obj/structure/bed))
		return

	// Can't fall if nothing pulls you down
	var/area/area = get_area(src)
	if (!area || !area.has_gravity())
		return

	var/limb_pain
	for(var/limb_tag in species.locomotion_limbs)
		var/obj/item/organ/external/E = organs_by_name[limb_tag]
		if(!E || !E.is_usable())
			stance_damage += 2 // let it fail even if just foot&leg
		else if (E.is_malfunctioning())
			//malfunctioning only happens intermittently so treat it as a missing limb when it procs
			stance_damage += 2
			if(prob(10))
				visible_message("\The [src]'s [E.name] [pick("twitches", "shudders")] and sparks!")
				var/datum/effect/effect/system/spark_spread/spark_system = new ()
				spark_system.set_up(5, 0, src)
				spark_system.attach(src)
				spark_system.start()
				spawn(10)
					qdel(spark_system)
		else if (E.is_broken())
			stance_damage += 1
		else if (E.is_dislocated())
			stance_damage += 0.5

		if(E) limb_pain = E.can_feel_pain()

	// Canes and crutches help you stand (if the latter is ever added)
	// One cane mitigates a broken leg+foot, or a missing foot.
	// Two canes are needed for a lost leg. If you are missing both legs, canes aren't gonna help you.
	if (l_hand && istype(l_hand, /obj/item/weapon/cane))
		stance_damage -= 2
	if (r_hand && istype(r_hand, /obj/item/weapon/cane))
		stance_damage -= 2

	// standing is poor
	if(stance_damage >= 4 || (stance_damage >= 2 && prob(5)))
		if(!(lying || resting))
			if(limb_pain)
				emote("scream")
			custom_emote(VISIBLE_MESSAGE, "collapses!")
		Weaken(5) //can't emote while weakened, apparently.

/mob/living/carbon/human/proc/handle_grasp()
	if(!l_hand && !r_hand)
		return

	// You should not be able to pick anything up, but stranger things have happened.
	if(l_hand)
		var/obj/item/organ/external/E = get_organ(species.grasping_limbs[min(species.grasping_limbs.len, 2)])
		if(!E || E.retracted || E.is_stump())
			visible_message("<span class='danger'>Lacking a functioning left hand, \the [src] drops \the [l_hand].</span>")
			drop_from_inventory(l_hand)

	if(r_hand)
		var/obj/item/organ/external/E = get_organ(species.grasping_limbs[min(species.grasping_limbs.len, 1)])
		if(!E || E.retracted || E.is_stump())
			visible_message("<span class='danger'>Lacking a functioning right hand, \the [src] drops \the [r_hand].</span>")
			drop_from_inventory(r_hand)

	// Check again...
	if(!l_hand && !r_hand)
		return

	for (var/obj/item/organ/external/E in organs)
		if(!E || !(E.limb_flags & ORGAN_FLAG_CAN_GRASP))
			continue
		if(((E.is_broken() || E.is_dislocated()) && !E.splinted) || E.is_malfunctioning())
			grasp_damage_disarm(E)

/mob/living/carbon/human/proc/stance_damage_prone(var/obj/item/organ/external/affected)

	if(affected)
		switch(affected.body_part)
			if(FOOT_LEFT, FOOT_RIGHT)
				to_chat(src, "<span class='warning'>You lose your footing as your [affected.name] spasms!</span>")
			if(LEG_LEFT, LEG_RIGHT)
				to_chat(src, "<span class='warning'>Your [affected.name] buckles from the shock!</span>")
			else
				return
	Weaken(5)

/mob/living/carbon/human/proc/grasp_damage_disarm(var/obj/item/organ/external/affected)
	var/disarm_slot
	switch(affected.body_part)
		if(HAND_LEFT, ARM_LEFT)
			disarm_slot = slot_l_hand
		if(HAND_RIGHT, ARM_RIGHT)
			disarm_slot = slot_r_hand

	if(!disarm_slot)
		return

	var/obj/item/thing = get_equipped_item(disarm_slot)

	if(!thing)
		return

	if(!unEquip(thing))
		return

	if(BP_IS_ROBOTIC(affected))
		visible_message("<B>\The [src]</B> drops what they were holding, \his [affected.name] malfunctioning!")

		var/datum/effect/effect/system/spark_spread/spark_system = new /datum/effect/effect/system/spark_spread()
		spark_system.set_up(5, 0, src)
		spark_system.attach(src)
		spark_system.start()
		spawn(10)
			qdel(spark_system)

	else
		var/grasp_name = affected.name
		if((affected.body_part in list(ARM_LEFT, ARM_RIGHT)) && affected.children.len)
			var/obj/item/organ/external/hand = pick(affected.children)
			grasp_name = hand.name

		if(affected.can_feel_pain())
			var/emote_scream = pick("screams in pain", "lets out a sharp cry", "cries out")
			var/emote_scream_alt = pick("scream in pain", "let out a sharp cry", "cry out")
			visible_message(
				"<B>\The [src]</B> [emote_scream] and drops what they were holding in their [grasp_name]!",
				null,
				"You hear someone [emote_scream_alt]!"
			)
			custom_pain("The sharp pain in your [affected.name] forces you to drop [thing]!", 30)
		else
			visible_message("<B>\The [src]</B> drops what they were holding in their [grasp_name]!")

/mob/living/carbon/human/proc/sync_organ_dna()
	var/list/all_bits = internal_organs|organs
	for(var/obj/item/organ/O in all_bits)
		O.set_dna(dna)

/mob/living/proc/is_asystole()
	return FALSE

/mob/living/carbon/human/is_asystole()
	if(isSynthetic())
		var/obj/item/organ/internal/cell/C = internal_organs_by_name[BP_CELL]
		if(istype(C))
			if(!C.is_usable())
				return TRUE
	else if(should_have_organ(BP_HEART))
		var/obj/item/organ/internal/heart/heart = internal_organs_by_name[BP_HEART]
		if(!istype(heart) || !heart.is_working())
			return TRUE
	return FALSE

//Used when we target a missing organ but still want to hit something. Tries to find the next organ up the hierarchy to hit instead
//Also handles substitution for targeting something invalid. EG, legs on a leaper
//External only
/mob/living/carbon/human/proc/find_target_organ(var/hit_zone)
	if (species.organ_substitutions[hit_zone])

		hit_zone = species.organ_substitutions[hit_zone]

	var/depth = 4 //Max repetitions to search
	var/obj/item/organ/external/found_organ = null
	while (!found_organ && depth)
		found_organ = organs_by_name[hit_zone]
		if (!found_organ || found_organ.is_stump()) //If we didn't find it, recurse up
			depth--
			hit_zone = GLOB.organ_parents[hit_zone]
			found_organ = null
			if (!hit_zone) //Something went wrong
				return null

		//In the case of retracted limbs, we move upwards
		else if (found_organ.retracted && found_organ.parent)
			hit_zone = found_organ.parent.organ_tag
			found_organ = null
		else
			return found_organ
	return null


//Returns a list of all organs which have no children
/mob/living/carbon/human/proc/get_extremities()
	var/list/extremities = organs.Copy()
	for (var/obj/item/organ/external/E in extremities)
		if (E.is_stump() || E.loc != src)
			//Stumps don't count as organs, remove it from this list
			extremities.Remove(E)
			continue

		if (E.parent)
			extremities.Remove(E.parent)	//If this organ has a parent, that parent becomes ineligible

	return extremities


//This proc tells how many legs we have
/mob/proc/get_locomotion_limbs(var/include_stump = FALSE)
	return list()

/mob/living/carbon/human/get_locomotion_limbs(var/include_stump = FALSE)
	var/found = list()
	for (var/organ_tag in species.locomotion_limbs)
		var/obj/item/organ/external/E = get_organ(organ_tag)
		if (!E)
			continue

		if (!include_stump && E.is_stump())
			continue

		found |= E

	return found



//Used to get limbs that intersect with a plane.
//Altitude is how high the plane is off the ground
//Height is how tall the plane is
/mob/living/carbon/human/proc/get_limbs_at_height(var/altitude, var/height = 0.01)
	var/vector2/ourheight = get_new_vector(altitude, altitude+height)

	var/list/limbs = list()

	//Todo: Pick a better sublist for this
	for (var/obj/item/organ/external/E in organs)

		//If its below our entire height range, we don't overlap
		if (E.limb_height.y < ourheight.x)
			continue

		//Likewise if above
		if (E.limb_height.x > ourheight.y)
			continue

		//Alright we collide
		limbs += E

	release_vector(ourheight)
	return limbs


/mob/living/carbon/human/proc/update_missing_limbs()

	//first we cache and reset this
	var/prior_missing_limbs = missing_limbs
	missing_limbs = 0


	//This list will briefly hold the icon names of missing organs, so we can fetch the appropriate iconstate from their damage mask
	var/list/missing_icon_names = list()

	//Special handling for mobs that have lying down icons
	var/suffix = ""
	if (lying && species.icon_lying)
		suffix = species.icon_lying

	//Lets go through all the organs we're supposed to have
	for (var/organ_tag in species.has_limbs)
		var/obj/item/organ/external/E = get_organ(organ_tag)

		//If we still have the organ, we're cool, continue
		if (E && !E.is_stump())
			continue

		//Alright its not there, now lets figure out what bodyparts it represents, or represented
		var/list/parameters = species.has_limbs[organ_tag]
		var/obj/item/organ/external/typepath = parameters["path"]

		//We fetch the initial bodypart flags and add to our missing limbs
		//We are assuming that the represented bodyparts of a limb never change after initialisation
		missing_limbs |= initial(typepath.body_part)

		missing_icon_names += initial(typepath.icon_name)+suffix



	//Next up, did anything change?
	if (prior_missing_limbs == missing_limbs)
		//If no change, return
		return

	//Drop relevant items
	update_clothing_limbs()

	//We're going to remake the limb mask, toss the old one
	if (limb_mask)
		filters -= limb_mask
		limb_mask = null

	//If we're missing nothing, return
	if (!missing_limbs)
		return

	//Alright, the configuration of missing limbs has changed, so we must update our limb mask
	//This will create a cache key unique to our bodytype and missing limb config
	var/cache_index = "[species.get_bodytype(src)]_[missing_limbs][suffix]"

	//We will try to retrieve it from global cache
	var/icon/I = GLOB.limb_masks[cache_index]

	//It doesnt exist, time to make it!
	if (!istype(I))
		I = create_limb_mask(missing_icon_names, species)
		GLOB.limb_masks[cache_index] = I

	//Add the filter to us
	var/dm_filter/newmask = filter(type="alpha", icon=I, flags = MASK_INVERSE)
	filters.Add(newmask)
	limb_mask = filters[filters.len]

//This proc combines a list of icon names into a mask
/proc/create_limb_mask(var/list/missing_icon_names, var/datum/species/species)
	var/icon/base_icon = new(species && species.icon_template ? species.icon_template : 'icons/mob/human.dmi',"blank")

	var/damage_mask_icon = 'icons/mob/human_races/species/human/damage_mask.dmi'
	if (species)
		damage_mask_icon = species.damage_mask

	for (var/iconstate in missing_icon_names)
		var/icon/limb_icon = new(damage_mask_icon, iconstate)
		base_icon.Blend(limb_icon,ICON_OVERLAY)

	return base_icon


v