/datum/species/beefman
	name = "Beefman"
	id = "beefman"
	limbs_id = "beefman"
	say_mod = "gurgles"
	sexes = FALSE
	default_color = "e73f4e"
	species_traits = list(NOEYESPRITES, NO_UNDERWEAR, DYNCOLORS, AGENDER, HAS_FLESH, HAS_BONE)
	can_have_genitals = FALSE //WHY WOULD YOU WANT TO FUCK ONE OF THESE THINGS?
	mutant_bodyparts = list("beefcolor" = "Medium Rare")
	default_mutant_bodyparts = list("beefmouth" = ACC_RANDOM, "beefeyes" = ACC_RANDOM)
	inherent_traits = list(TRAIT_ADVANCEDTOOLUSER,
		TRAIT_RESISTCOLD,
		TRAIT_CAN_STRIP,
		TRAIT_EASYDISMEMBER,
		TRAIT_SLEEPIMMUNE,
	)
	offset_features = list(OFFSET_UNIFORM = list(0,2), OFFSET_ID = list(0,2), OFFSET_GLOVES = list(0,-4), OFFSET_GLASSES = list(0,3), OFFSET_EARS = list(0,3), OFFSET_SHOES = list(0,0), \
						   OFFSET_S_STORE = list(0,2), OFFSET_FACEMASK = list(0,3), OFFSET_HEAD = list(0,3), OFFSET_FACE = list(0,3), OFFSET_BELT = list(0,3), OFFSET_BACK = list(0,2), \
						   OFFSET_SUIT = list(0,2), OFFSET_NECK = list(0,3))

	skinned_type = /obj/item/food/meatball
	meat = /obj/item/food/meat/slab //What the species drops on gibbing
	toxic_food = DAIRY | PINEAPPLE
	disliked_food = VEGETABLES | FRUIT | CLOTH
	liked_food = RAW | MEAT
	attack_verb = "meat"
	payday_modifier = 0.75 //-- "Equality"
	speedmod = -0.2 // this affects the race's speed. positive numbers make it move slower, negative numbers make it move faster
	armor = -2 // overall defense for the race... or less defense, if it's negative.
	punchdamagelow = 1 //lowest possible punch damage. if this is set to 0, punches will always miss
	punchdamagehigh = 5 // 10 //highest possible punch damage
	siemens_coeff = 0.7 // Due to lack of density.   //base electrocution coefficient
	attack_sound = 'sound/effects/meatslap.ogg'
	grab_sound = 'sound/effects/meatslap.ogg' //Special sound for grabbing
	bodytemp_normal = T20C
	limbs_icon = 'modular_skyrat/master_files/icons/mob/species/beefman_bodyparts.dmi'

	var/dehydrate = 0

	bodypart_overides = list(
	BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/beef,\
	BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/beef,\
	BODY_ZONE_HEAD = /obj/item/bodypart/head/beef,\
	BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/beef,\
	BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/beef,\
	BODY_ZONE_CHEST = /obj/item/bodypart/chest/beef)

/proc/proof_beefman_features(list/inFeatures)
	// Missing Defaults in DNA? Randomize!
	if(inFeatures["beefcolor"] == null || inFeatures["beefcolor"] == "")
		inFeatures["beefcolor"] = GLOB.color_list_beefman[pick(GLOB.color_list_beefman)]
	if(inFeatures["beefeyes"] == null || inFeatures["beefeyes"] == "")
		inFeatures["beefeyes"] = pick(GLOB.eyes_beefman)
	if(inFeatures["beefmouth"] == null || inFeatures["beefmouth"] == "")
		inFeatures["beefmouth"] = pick(GLOB.mouths_beefman)

/datum/species/beefman/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	// Missing Defaults in DNA? Randomize!
	proof_beefman_features(C.dna.features)

	. = ..()

	if(ishuman(C)) // Taken DIRECTLY from ethereal!
		var/mob/living/carbon/human/H = C

		set_beef_color(H)

		// 2) BODYPARTS
		C.part_default_head = /obj/item/bodypart/head/beef
		C.part_default_chest = /obj/item/bodypart/chest/beef
		C.part_default_l_arm = /obj/item/bodypart/l_arm/beef
		C.part_default_r_arm = /obj/item/bodypart/r_arm/beef
		C.part_default_l_leg = /obj/item/bodypart/l_leg/beef
		C.part_default_r_leg = /obj/item/bodypart/r_leg/beef
		C.ReassignForeignBodyparts()

/datum/species/proc/set_beef_color(mob/living/carbon/human/H)
	return // Do Nothing

/datum/species/beefman/set_beef_color(mob/living/carbon/human/H)
	// Called on Assign, or on Color Change (or any time proof_beefman_features() is used)
	fixed_mut_color = H.dna.features["beefcolor"]
	default_color = fixed_mut_color

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


/datum/species/beefman/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	..()

	// 2) BODYPARTS
	C.part_default_head = /obj/item/bodypart/head
	C.part_default_chest = /obj/item/bodypart/chest
	C.part_default_l_arm = /obj/item/bodypart/l_arm
	C.part_default_r_arm = /obj/item/bodypart/r_arm
	C.part_default_l_leg = /obj/item/bodypart/l_leg
	C.part_default_r_leg = /obj/item/bodypart/r_leg
	C.ReassignForeignBodyparts()


/datum/species/beefman/spec_life(mob/living/carbon/human/H)	// This is your life ticker.
	..()
	// 		** BLEED YOUR JUICES **         //-- BODYTEMP_NORMAL = 293.15

	// Step 1) Being burned keeps the juices in.
	var/searJuices = H.getFireLoss() / 30 //-- Now that is a lot of damage

	// Step 2) Bleed out those juices by warmth, minus burn damage. If we are salted - bleed more
	if (dehydrate > 0)
		if(!H.blood_volume)
			return
		H.bleed(clamp((H.bodytemperature - 297.15) / 20 - searJuices, 2, 10))
		dehydrate -= 0.5
	else
		H.bleed(clamp((H.bodytemperature - 297.15) / 20 - searJuices, 0, 5))

	// Replenish Blood Faster! (But only if you actually make blood)
	var/bleed_rate = 0
	for(var/i in H.bodyparts)
		var/obj/item/bodypart/BP = i
		bleed_rate += BP.generic_bleedstacks

/datum/species/beefman/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	. = ..() // Let species run its thing by default, TRUST ME
	// Salt HURTS
	if(chem.type == /datum/reagent/saltpetre || chem.type == /datum/reagent/consumable/salt)
		H.adjustToxLoss(0.5, 0) // adjustFireLoss
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
		if (prob(5) || dehydrate == 0)
			to_chat(H, span_alert("Your beefy mouth tastes dry."))
		dehydrate ++
		return TRUE
	// Regain BLOOD
	if(istype(chem, /datum/reagent/consumable/nutriment) || istype(chem, /datum/reagent/iron))
		if (H.blood_volume < BLOOD_VOLUME_NORMAL)
			H.blood_volume += 5
			H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
			return TRUE

//////////////////
// ATTACK PROCS //
//////////////////
/datum/species/beefman/help(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	// Bleed On
	if (user != target && user.is_bleeding())
		target.add_mob_blood(user)
	return ..()

/datum/species/beefman/grab(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	// Bleed On
	if (user != target && user.is_bleeding())
		target.add_mob_blood(user) //  from atoms.dm, this is how you bloody something!
	return ..()

/datum/species/beefman/disarm(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
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
			if (affecting.status != BODYPART_ORGANIC)
				to_chat(user, "That thing is on there good. It's not coming off with a gentle tug.")
				return FALSE

			// Pry it off...
			user.visible_message("[user] grabs onto [p_their()] own [affecting.name] and pulls.", span_notice("You grab hold of your [affecting.name] and yank hard."))
			if (!do_mob(user,target))
				return TRUE

			user.visible_message("[user]'s [affecting.name] comes right off in their hand.", span_notice("Your [affecting.name] pops right off."))
			playsound(get_turf(user), 'sound/effects/meatslap.ogg', 40, 1)

			// Destroy Limb, Drop Meat, Pick Up
			var/obj/item/I = affecting.drop_limb() //  <--- This will return a meat vis drop_meat(), even if only Beefman limbs return anything. If this was another species' limb, it just comes off.
			if (istype(I, /obj/item/food/meat/slab))
				user.put_in_hands(I)

			return TRUE
	return ..()

/datum/species/beefman/spec_unarmedattacked(mob/living/carbon/human/user, mob/living/carbon/human/target)
	// Bleed On
	if (user != target && user.is_bleeding())
		target.add_mob_blood(user) //  from atoms.dm, this is how you bloody something!s
	return ..()

/datum/species/beefman/proc/handle_limb_mashing()
	SIGNAL_HANDLER

/datum/species/beefman/spec_attacked_by(obj/item/I, mob/living/user, obj/item/bodypart/affecting, mob/living/carbon/human/H, modifiers)
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
					if(I.reagents && I.reagents.total_volume)
						I.reagents.trans_to(user, I.reagents.total_volume)	//transfer reagents to player
					qdel(I)
					playsound(get_turf(H), 'sound/effects/meatslap.ogg', 50, 1)

			return TRUE // True CANCELS the sequence.

	return ..() // TRUE FALSE

/datum/species/beefman/after_equip_job(datum/job/J, mob/living/carbon/human/H, visualsOnly = FALSE)
	to_chat(H, "<span class='danger'>Meatmen come from Fulpstation, a server with a looser ruleset than ours. This is NOT a pass to grief. Policy still applies!</span>")

//
//LIMBS
//

/obj/item/bodypart/head/beef
	icon = 'modular_skyrat/master_files/icons/mob/species/beefman_bodyparts.dmi'

/obj/item/bodypart/chest/beef
	icon = 'modular_skyrat/master_files/icons/mob/species/beefman_bodyparts.dmi'

/obj/item/bodypart/r_arm/beef
	icon = 'modular_skyrat/master_files/icons/mob/species/beefman_bodyparts.dmi'

/obj/item/bodypart/l_arm/beef
	icon = 'modular_skyrat/master_files/icons/mob/species/beefman_bodyparts.dmi'

/obj/item/bodypart/r_leg/beef
	icon = 'modular_skyrat/master_files/icons/mob/species/beefman_bodyparts.dmi'

/obj/item/bodypart/l_leg/beef
	icon = 'modular_skyrat/master_files/icons/mob/species/beefman_bodyparts.dmi'

/obj/item/bodypart/chest/beef/drop_limb(special)
	//amCondemned = TRUE
	//var/mob/owner_cache = owner
	..() // Create Meat, Remove Limb
	var/percentHealth = 1 - (brute_dam + burn_dam) / max_damage
	if (percentHealth > 0)
		// Create Meat
		var/obj/item/food/meat/slab/newMeat = new /obj/item/food/meat/slab(src.loc)

		. = newMeat // Return MEAT

	qdel(src)

/obj/item/bodypart/r_arm/beef/drop_limb(special)
	//amCondemned = TRUE
	//var/mob/owner_cache = owner
	..() // Create Meat, Remove Limb
	var/percentHealth = 1 - (brute_dam + burn_dam) / max_damage
	if (percentHealth > 0)
		// Create Meat
		var/obj/item/food/meat/slab/newMeat = new /obj/item/food/meat/slab(src.loc)

		. = newMeat // Return MEAT

	qdel(src)

/obj/item/bodypart/l_arm/beef/drop_limb(special)
	//amCondemned = TRUE
	//var/mob/owner_cache = owner
	..() // Create Meat, Remove Limb
	var/percentHealth = 1 - (brute_dam + burn_dam) / max_damage
	if (percentHealth > 0)
		// Create Meat
		var/obj/item/food/meat/slab/newMeat = new /obj/item/food/meat/slab(src.loc)

		. = newMeat // Return MEAT

	qdel(src)

/obj/item/bodypart/r_leg/beef/drop_limb(special)
	//amCondemned = TRUE
	//var/mob/owner_cache = owner
	..() // Create Meat, Remove Limb
	var/percentHealth = 1 - (brute_dam + burn_dam) / max_damage
	if (percentHealth > 0)
		// Create Meat
		var/obj/item/food/meat/slab/newMeat = new /obj/item/food/meat/slab(src.loc)

		. = newMeat // Return MEAT

	qdel(src)

/obj/item/bodypart/l_leg/beef/drop_limb(special)
	//amCondemned = TRUE
	//var/mob/owner_cache = owner
	..() // Create Meat, Remove Limb
	var/percentHealth = 1 - (brute_dam + burn_dam) / max_damage
	if (percentHealth > 0)
		// Create Meat
		var/obj/item/food/meat/slab/newMeat = new /obj/item/food/meat/slab(src.loc)

		. = newMeat // Return MEAT

	qdel(src)

// SPRITE PARTS //
/datum/sprite_accessory/beef
	icon = 'modular_skyrat/master_files/icons/mob/species/beefman_bodyparts.dmi'

/datum/sprite_accessory/beef/eyes
	key = "beefeyes"
	generic = "Beef Eyes"
	color_src = EYECOLOR
	relevent_layers = list(BODY_ADJ_LAYER)

/datum/sprite_accessory/beef/eyes/capers
	name = "Capers"
	icon_state = "capers"

/datum/sprite_accessory/beef/eyes/cloves
	name = "Cloves"
	icon_state = "cloves"

/datum/sprite_accessory/beef/eyes/peppercorns
	name = "Peppercorns"
	icon_state = "peppercorns"

/datum/sprite_accessory/beef/eyes/olives
	name = "Olives"
	icon_state = "olives"

/datum/sprite_accessory/beef/mouth
	key = "beefmouth"
	generic = "Beef Mouth"
	use_static = TRUE
	color_src = 0
	relevent_layers = list(BODY_ADJ_LAYER)

/datum/sprite_accessory/beef/mouth/frown1
	name = "Frown1"
	icon_state = "frown1"

/datum/sprite_accessory/beef/mouth/frown2
	name = "Frown2"
	icon_state = "frown2"

/datum/sprite_accessory/beef/mouth/grit1
	name = "Grit1"
	icon_state = "grit1"

/datum/sprite_accessory/beef/mouth/grit2
	name = "Grit2"
	icon_state = "grit2"

/datum/sprite_accessory/beef/mouth/smile1
	name = "Smile1"
	icon_state = "smile1"

/datum/sprite_accessory/beef/mouth/smile2
	name = "Smile2"
	icon_state = "smile2"


/mob/living/carbon
	// Type References for Bodyparts
	var/obj/item/bodypart/head/part_default_head = /obj/item/bodypart/head
	var/obj/item/bodypart/chest/part_default_chest = /obj/item/bodypart/chest
	var/obj/item/bodypart/l_arm/part_default_l_arm = /obj/item/bodypart/l_arm
	var/obj/item/bodypart/r_arm/part_default_r_arm = /obj/item/bodypart/r_arm
	var/obj/item/bodypart/l_leg/part_default_l_leg = /obj/item/bodypart/l_leg
	var/obj/item/bodypart/r_leg/part_default_r_leg = /obj/item/bodypart/r_leg
