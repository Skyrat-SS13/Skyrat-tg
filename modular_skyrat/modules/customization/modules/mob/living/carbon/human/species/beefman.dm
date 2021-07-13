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
	speedmod = -0.3 // this affects the race's speed. positive numbers make it move slower, negative numbers make it move faster
	armor = -25 // overall defense for the race... or less defense, if it's negative.
	stunmod = 1.25 //multiplier for stun durations
	punchdamagelow = 1 //lowest possible punch damage. if this is set to 0, punches will always miss
	punchdamagehigh = 5 // 10 //highest possible punch damage
	siemens_coeff = 0.7 // Due to lack of density.   //base electrocution coefficient
	attack_sound = 'sound/effects/meatslap.ogg'
	grab_sound = 'sound/effects/meatslap.ogg' //Special sound for grabbing
	bodytemp_normal = T20C
	limbs_icon = 'modular_skyrat/master_files/icons/mob/species/beefman_bodyparts.dmi'

	var/dehydrate = 0

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

/datum/species/proc/set_beef_color(mob/living/carbon/human/H)
	return // Do Nothing

/datum/species/beefman/set_beef_color(mob/living/carbon/human/H)
	// Called on Assign, or on Color Change (or any time proof_beefman_features() is used)
	fixed_mut_color = H.dna.features["beefcolor"]
	default_color = fixed_mut_color

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

/datum/species/beefman/spec_unarmedattacked(mob/living/carbon/human/user, mob/living/carbon/human/target)
	// Bleed On
	if (user != target && user.is_bleeding())
		target.add_mob_blood(user) //  from atoms.dm, this is how you bloody something!s
	return ..()

/datum/species/beefman/before_equip_job(datum/job/playerJob, mob/living/carbon/human/H)

	// Pre-Equip: Give us a sash so we don't end up with a Uniform!
	var/obj/item/clothing/under/bodysash/newSash
	switch(playerJob.title)

		// Assistant
		if("Assistant")
			newSash = new /obj/item/clothing/under/bodysash()
		// Captain
		if("Captain")
			newSash = new /obj/item/clothing/under/bodysash/captain()
		// Security
		if("Head of Security")
			newSash = new /obj/item/clothing/under/bodysash/hos()
		if("Warden")
			newSash = new /obj/item/clothing/under/bodysash/warden()
		if("Security Officer")
			newSash = new /obj/item/clothing/under/bodysash/security()
		if("Detective")
			newSash = new /obj/item/clothing/under/bodysash/detective()
		if("Brig Physician")
			newSash = new /obj/item/clothing/under/bodysash/brigdoc()

		// Medical
		if("Chief Medical Officer")
			newSash = new /obj/item/clothing/under/bodysash/cmo()
		if("Medical Doctor")
			newSash = new /obj/item/clothing/under/bodysash/medical()
		if("Chemist")
			newSash = new /obj/item/clothing/under/bodysash/chemist()
		if("Virologist")
			newSash = new /obj/item/clothing/under/bodysash/virologist()
		if("Paramedic")
			newSash = new /obj/item/clothing/under/bodysash/paramedic()

		// Engineering
		if("Chief Engineer")
			newSash = new /obj/item/clothing/under/bodysash/ce()
		if("Station Engineer")
			newSash = new /obj/item/clothing/under/bodysash/engineer()
		if("Atmospheric Technician")
			newSash = new /obj/item/clothing/under/bodysash/atmos()

		// Science
		if("Research Director")
			newSash = new /obj/item/clothing/under/bodysash/rd()
		if("Scientist")
			newSash = new /obj/item/clothing/under/bodysash/scientist()
		if("Roboticist")
			newSash = new /obj/item/clothing/under/bodysash/roboticist()
		if("Geneticist")
			newSash = new /obj/item/clothing/under/bodysash/geneticist()

		// Supply/Service
		if("Head of Personnel")
			newSash = new /obj/item/clothing/under/bodysash/hop()
		if("Quartermaster")
			newSash = new /obj/item/clothing/under/bodysash/qm()
		if("Cargo Technician")
			newSash = new /obj/item/clothing/under/bodysash/cargo()
		if("Shaft Miner")
			newSash = new /obj/item/clothing/under/bodysash/miner()

		// Clown
		if("Clown")
			newSash = new /obj/item/clothing/under/bodysash/clown()
		// Mime
		if("Mime")
			newSash = new /obj/item/clothing/under/bodysash/mime()

		if("Prisoner")
			newSash = new /obj/item/clothing/under/bodysash/prisoner()
		if("Cook")
			newSash = new /obj/item/clothing/under/bodysash/cook()
		if("Bartender")
			newSash = new /obj/item/clothing/under/bodysash/bartender()
		if("Chaplain")
			newSash = new /obj/item/clothing/under/bodysash/chaplain()
		if("Curator")
			newSash = new /obj/item/clothing/under/bodysash/curator()
		if("Lawyer")
			newSash = new /obj/item/clothing/under/bodysash/lawyer()
		if("Botanist")
			newSash = new /obj/item/clothing/under/bodysash/botanist()
		if("Janitor")
			newSash = new /obj/item/clothing/under/bodysash/janitor()
		if("Psychologist")
			newSash = new /obj/item/clothing/under/bodysash/psychologist()

		//skyrat exclusive jobs
		//cc rep
		if("Nanotrasen Representative")
			newSash = new /obj/item/clothing/under/bodysash/centcom()
		//cdo
		if("Civil Disputes Officer")
			newSash = new /obj/item/clothing/under/bodysash/cdo()
		//sec sergeant
		if("Security Sergeant")
			newSash = new /obj/item/clothing/under/bodysash/deputy()
		//sec medic
		if("Security Medic")
			newSash = new /obj/item/clothing/under/bodysash/security()
		//sec medic
		if("Blueshield")
			newSash = new /obj/item/clothing/under/bodysash/blueshield()
		//expeditionary trooper
		if("Vanguard Operative")
			newSash = new /obj/item/clothing/under/bodysash/expcorp()

		// Civilian
		else
			newSash = new /obj/item/clothing/under/bodysash/civilian()

	// Destroy Original Uniform
	if (H.w_uniform)
		qdel(H.w_uniform)
	// Equip New
	H.equip_to_slot_or_del(newSash, ITEM_SLOT_ICLOTHING, TRUE) // TRUE is whether or not this is "INITIAL", as in startup
	return ..()

/datum/species/beefman/after_equip_job(datum/job/J, mob/living/carbon/human/H, visualsOnly = FALSE)
	to_chat(H, "<span class='danger'>Meatmen come from Fulpstation, a server with a looser ruleset than ours. This is NOT a pass to grief. Policy still applies!</span>")

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
