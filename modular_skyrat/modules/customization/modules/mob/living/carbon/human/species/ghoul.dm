/datum/species/ghoul
	name = "Ghoul"
	id = SPECIES_GHOUL
	examine_limb_id = "ghoul"
	say_mod = "rasps"
	species_traits = list(NOEYESPRITES, DYNCOLORS, HAS_FLESH, HAS_BONE, HAIR, FACEHAIR)
	can_have_genitals = FALSE //WHY WOULD YOU WANT TO FUCK ONE OF THESE THINGS?
	mutant_bodyparts = list("ghoulcolor" = "Tan Necrotic")
	default_mutant_bodyparts = list(
		"tail" = "None",
		"ears" = "None"
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_RADIMMUNE,
		TRAIT_CAN_STRIP,
		TRAIT_EASYDISMEMBER,
		TRAIT_EASILY_WOUNDED, //theyre like fuckin skin and bones
	)
	offset_features = list(
		OFFSET_UNIFORM = list(0,0),
		OFFSET_ID = list(0,0),
		OFFSET_GLOVES = list(0,0),
		OFFSET_GLASSES = list(0,1),
		OFFSET_EARS = list(0,1),
		OFFSET_SHOES = list(0,0),
		OFFSET_S_STORE = list(0,0),
		OFFSET_FACEMASK = list(0,1),
		OFFSET_HEAD = list(0,1),
		OFFSET_FACE = list(0,1),
		OFFSET_BELT = list(0,0),
		OFFSET_BACK = list(0,0),
		OFFSET_SUIT = list(0,0),
		OFFSET_NECK = list(0,1),
	)
	toxic_food = DAIRY | PINEAPPLE
	disliked_food = VEGETABLES | FRUIT | CLOTH
	liked_food = RAW | MEAT
	payday_modifier = 0.75 //-- "Equality"
	//armor = -100 //2x more damage
	brutemod = 2
	burnmod = 2
	stunmod = 1.25 //multiplier for stun durations
	punchdamagelow = 1 //lowest possible punch damage. if this is set to 0, punches will always miss
	punchdamagehigh = 5 //highest possible punch damage
	bodytemp_normal = T20C
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/mutant/ghoul,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/mutant/ghoul,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/ghoul,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/mutant/ghoul,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/mutant/ghoul,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/ghoul,
	)
	//the chest and head cannot be turned into meat
	//i dont have to worry about sprites due to limbs_icon, thank god
	//also the head needs to be normal for hair to work

/proc/proof_ghoul_features(list/inFeatures)
	// Missing Defaults in DNA? Randomize!
	if(inFeatures["ghoulcolor"] == null || inFeatures["ghoulcolor"] == "")
		inFeatures["ghoulcolor"] = GLOB.color_list_ghoul[pick(GLOB.color_list_ghoul)]

/datum/species/ghoul/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	// Missing Defaults in DNA? Randomize!
	proof_ghoul_features(C.dna.features)

	. = ..()

	if(ishuman(C))
		var/mob/living/carbon/human/H = C

		set_ghoul_color(H)

		// 2) BODYPARTS
		C.part_default_head = /obj/item/bodypart/head/mutant/ghoul
		C.part_default_chest = /obj/item/bodypart/chest/mutant/ghoul
		C.part_default_l_arm = /obj/item/bodypart/l_arm/mutant/ghoul
		C.part_default_r_arm = /obj/item/bodypart/r_arm/mutant/ghoul
		C.part_default_l_leg = /obj/item/bodypart/l_leg/mutant/ghoul
		C.part_default_r_leg = /obj/item/bodypart/r_leg/mutant/ghoul
		C.ReassignForeignBodyparts()

/datum/species/proc/set_ghoul_color(mob/living/carbon/human/H)
	return // Do Nothing

/datum/species/ghoul/set_ghoul_color(mob/living/carbon/human/H)
	// Called on Assign, or on Color Change (or any time proof_ghoul_features() is used)
	fixed_mut_color = H.dna.features["ghoulcolor"]

/mob/living/carbon/proc/ReassignForeignBodyparts()
	var/obj/item/bodypart/head = get_bodypart(BODY_ZONE_HEAD)
	if (head?.type != part_default_head)
		qdel(head)
		var/obj/item/bodypart/limb = new part_default_head
		limb.replace_limb(src,TRUE)
	var/obj/item/bodypart/chest = get_bodypart(BODY_ZONE_CHEST)
	if (chest?.type != part_default_chest)
		qdel(chest)
		var/obj/item/bodypart/limb = new part_default_chest
		limb.replace_limb(src,TRUE)
	var/obj/item/bodypart/l_arm = get_bodypart(BODY_ZONE_L_ARM)
	if (l_arm?.type != part_default_l_arm)
		qdel(l_arm)
		var/obj/item/bodypart/limb = new part_default_l_arm
		limb.replace_limb(src,TRUE)
	var/obj/item/bodypart/r_arm = get_bodypart(BODY_ZONE_R_ARM)
	if (r_arm?.type != part_default_r_arm)
		qdel(r_arm)
		var/obj/item/bodypart/limb = new part_default_r_arm
		limb.replace_limb(src,TRUE)
	var/obj/item/bodypart/l_leg = get_bodypart(BODY_ZONE_L_LEG)
	if (l_leg?.type != part_default_l_leg)
		qdel(l_leg)
		var/obj/item/bodypart/limb = new part_default_l_leg
		limb.replace_limb(src,TRUE)
	var/obj/item/bodypart/r_leg = get_bodypart(BODY_ZONE_R_LEG)
	if (r_leg?.type != part_default_r_leg)
		qdel(r_leg)
		var/obj/item/bodypart/limb = new part_default_r_leg
		limb.replace_limb(src,TRUE)

/datum/species/ghoul/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	..()

	// 2) BODYPARTS
	C.part_default_head = /obj/item/bodypart/head
	C.part_default_chest = /obj/item/bodypart/chest
	C.part_default_l_arm = /obj/item/bodypart/l_arm
	C.part_default_r_arm = /obj/item/bodypart/r_arm
	C.part_default_l_leg = /obj/item/bodypart/l_leg
	C.part_default_r_leg = /obj/item/bodypart/r_leg
	C.ReassignForeignBodyparts()

//////////////////
// ATTACK PROCS //
//////////////////

/datum/species/ghoul/disarm(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	// Targeting Self? With "DISARM"
	if (user == target)
		var/target_zone = user.zone_selected
		var/list/allowedList = list ( BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG )
		var/obj/item/bodypart/affecting = user.get_bodypart(check_zone(user.zone_selected)) //stabbing yourself always hits the right target

		if ((target_zone in allowedList) && affecting)

			if (user.handcuffed)
				to_chat(user, span_alert("You can't get a good enough grip with your hands bound."))
				return FALSE

			// Robot Arms Fail
			if (!IS_ORGANIC_LIMB(affecting))
				to_chat(user, "That thing is on there good. It's not coming off with a gentle tug.")
				return FALSE

			// Pry it off...
			user.visible_message("[user] grabs onto [p_their()] own [affecting.name] and pulls.", span_notice("You grab hold of your [affecting.name] and yank hard."))
			if (!do_mob(user,target))
				return TRUE

			user.visible_message("[user]'s [affecting.name] comes right off in their hand.", span_notice("Your [affecting.name] pops right off."))
			playsound(get_turf(user), 'sound/effects/meatslap.ogg', 40, 1) //ill change these sounds later

			// Destroy Limb, Drop Meat, Pick Up
			var/obj/item/I = affecting.drop_limb()
			if (istype(I, /obj/item/food/meat/slab))
				user.put_in_hands(I)

			new /obj/effect/temp_visual/dir_setting/bloodsplatter(target.loc, target.dir)
			target.add_splatter_floor(target.loc)
			target.bleed(60)

			return TRUE
	return ..()

/datum/species/ghoul/proc/handle_limb_mashing()
	SIGNAL_HANDLER

/datum/species/ghoul/spec_attacked_by(obj/item/I, mob/living/user, obj/item/bodypart/affecting, mob/living/carbon/human/H, modifiers)
	handle_limb_mashing()
	// MEAT LIMBS: If our limb is missing, and we're using meat, stick it in!
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		return
	if(H.stat < DEAD && !affecting && istype(I, /obj/item/food/meat/slab))
		var/target_zone = user.zone_selected
		var/list/limbs = list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)

		if((target_zone in limbs))
			if(user == H)
				user.visible_message("[user] begins mashing [I] into [H]'s torso.", span_notice("You begin mashing [I] into your torso."))
			else
				user.visible_message("[user] begins mashing [I] into [H]'s torso.", span_notice("You begin mashing [I] into [H]'s torso."))

			// Leave Melee Chain (so deleting the meat doesn't throw an error) <--- aka, deleting the meat that called this very proc.
			spawn(1)
				if(do_mob(user,H))
					// Attach the part!
					var/obj/item/bodypart/newBP = H.newBodyPart(target_zone, FALSE)
					H.visible_message("The meat sprouts digits and becomes [H]'s new [newBP.name]!", span_notice("The meat sprouts digits and becomes your new [newBP.name]!"))
					newBP.attach_limb(H)
					qdel(I)
					playsound(get_turf(H), 'sound/effects/meatslap.ogg', 50, 1)

			return TRUE // True CANCELS the sequence.

	return ..() // TRUE FALSE

/mob/living/carbon
	// Type References for Bodyparts
	var/obj/item/bodypart/head/part_default_head = /obj/item/bodypart/head
	var/obj/item/bodypart/chest/part_default_chest = /obj/item/bodypart/chest
	var/obj/item/bodypart/l_arm/part_default_l_arm = /obj/item/bodypart/l_arm
	var/obj/item/bodypart/r_arm/part_default_r_arm = /obj/item/bodypart/r_arm
	var/obj/item/bodypart/l_leg/part_default_l_leg = /obj/item/bodypart/l_leg
	var/obj/item/bodypart/r_leg/part_default_r_leg = /obj/item/bodypart/r_leg

/datum/species/ghoul/get_species_description()
	return placeholder_description

/datum/species/ghoul/get_species_lore()
	return list(placeholder_lore)
