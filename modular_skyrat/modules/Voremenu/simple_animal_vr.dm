#define VORACIOUS_CHANCE 40
#define VORE_SWALLOW_TIME 50

/mob/living/simple_animal
	//Specific vore behaviors
	var/vore_active = FALSE						// If vore behavior is enabled for this mob
	var/isPredator = FALSE 						//Are they capable of performing and pre-defined vore actions for their species?
	var/swallowTime = VORE_SWALLOW_TIME 		//How long it takes to eat Human and other Simple_animal prey in 1/10 of a second. The default is 5 seconds.
	var/list/prey_excludes = list()				//For excluding people from being eaten.
	var/voracious_chance = VORACIOUS_CHANCE		//Mob AI Engagement probability when rolling between regular melee strike and a vore attempt, default 40%

	// Vore belly interactions
	// Most mobs are only going to have the one gut. Multi-gut set ups should refer to Ash Drake's dragon_vore.dm for set up.

	var/vore_default_sound = "Gulp"				// Default vore sound
	var/vore_default_release = "Splatter" 		// Default release sound
	var/vore_wetness = TRUE						// Default for a wet belly
	var/vore_default_mode = DM_DIGEST			// Default bellymode (DM_DIGEST, DM_HOLD, DM_ABSORB)
	var/vore_digest_chance = VORACIOUS_CHANCE	// Chance to switch to digest mode if resisted, default 40%
	var/vore_escape_chance = VORACIOUS_CHANCE	// Chance of resisting out of mob, default 40%
	var/vore_absorb_chance = 0					// chance of absorbtion by mob, default 0%
	var/vore_stomach_name						// The name for the first belly if not "stomach"
	var/vore_stomach_flavor						// The flavortext for the first belly if not the default

	//Icon Memes
	var/vore_fullness = 0					// How "full" the belly is (controls icons)

// Release belly contents before being gc'd!
/mob/living/simple_animal/Destroy()
	release_vore_contents(include_absorbed = TRUE, silent = TRUE)
	prey_excludes.Cut()
	QDEL_NULL_LIST(vore_organs)
	. = ..()

// Update fullness based on size & quantity of belly contents
/mob/living/simple_animal/proc/update_fullness(var/atom/movable/M)
	var/new_fullness = 0
	for(var/belly in vore_organs)
		var/obj/belly/B = vore_organs[belly]
		if (!(M in B.contents))
			return FALSE // Nothing's inside
		new_fullness += M

	vore_fullness = new_fullness

/mob/living/simple_animal/death()
	release_vore_contents()
	. = ..()

// Simple animals have only one belly.  This creates it (if it isn't already set up)
/mob/living/simple_animal/init_vore()
	ENABLE_BITFIELD(vore_flags, VORE_INIT)
	if(CHECK_BITFIELD(flags_1, HOLOGRAM_1))
		return
	if(!vore_active || CHECK_BITFIELD(vore_flags, NO_VORE)) //If it can't vore, let's not give it a stomach.
		return
	if(vore_active && !IsAdvancedToolUser()) //vore active, but doesn't have thumbs to grab people with.
		verbs |= /mob/living/simple_animal/proc/animal_nom

/mob/living/simple_animal/lazy_init_belly()
	if(!LAZYLEN(vore_organs))
		LAZYINITLIST(vore_organs)
		var/obj/belly/B = new (src)
		vore_selected = B
		B.immutable = TRUE
		B.name = vore_stomach_name ? vore_stomach_name : "stomach"
		B.desc = vore_stomach_flavor ? vore_stomach_flavor : "Your surroundings are warm, soft, and slimy. Makes sense, considering you're inside \the [name]."
		B.digest_mode = vore_default_mode
		B.vore_sound = vore_default_sound
		B.release_sound = vore_default_release
		B.is_wet = vore_wetness
		B.escapable = vore_escape_chance > 0
		B.escapechance = vore_escape_chance
		B.digestchance = vore_digest_chance
		B.absorbchance = vore_absorb_chance
		B.human_prey_swallow_time = swallowTime
		B.nonhuman_prey_swallow_time = swallowTime
		B.vore_verb = "swallow"
		B.emote_lists[DM_HOLD] = list( // We need more that aren't repetitive. I suck at endo. -Ace
			"The insides knead at you gently for a moment.",
			"The guts glorp wetly around you as some air shifts.",
			"The predator takes a deep breath and sighs, shifting you somewhat.",
			"The stomach squeezes you tight for a moment, then relaxes harmlessly.",
			"The predator's calm breathing and thumping heartbeat pulses around you.",
			"The warm walls kneads harmlessly against you.",
			"The liquids churn around you, though there doesn't seem to be much effect.",
			"The sound of bodily movements drown out everything for a moment.",
			"The predator's movements gently force you into a different position.")
		B.emote_lists[DM_DIGEST] = list(
			"The burning acids eat away at your form.",
			"The muscular stomach flesh grinds harshly against you.",
			"The caustic air stings your chest when you try to breathe.",
			"The slimy guts squeeze inward to help the digestive juices soften you up.",
			"The onslaught against your body doesn't seem to be letting up; you're food now.",
			"The predator's body ripples and crushes against you as digestive enzymes pull you apart.",
			"The juices pooling beneath you sizzle against your sore skin.",
			"The churning walls slowly pulverize you into meaty nutrients.",
			"The stomach glorps and gurgles as it tries to work you into slop.")

//
// Simple proc for animals to have their digestion toggled on/off externally
//
/mob/living/simple_animal/verb/toggle_digestion()
	set name = "Toggle Animal's Digestion"
	set desc = "Enables digestion on this mob for 20 minutes."
	set category = "Object"
	set src in oview(1)

	var/mob/living/carbon/human/user = usr
	if(!istype(user) || user.stat) return

	if(!vore_active)
		return

	if(vore_selected.digest_mode == DM_HOLD)
		var/confirm = alert(usr, "Enabling digestion on [name] will cause it to digest all stomach contents. Using this to break OOC prefs is against the rules. Digestion will disable itself after 20 minutes.", "Enabling [name]'s Digestion", "Enable", "Cancel")
		if(confirm == "Enable")
			vore_selected.digest_mode = DM_DIGEST
			sleep(20 MINUTES)
			vore_selected.digest_mode = vore_default_mode
	else
		var/confirm = alert(usr, "This mob is currently set to digest all stomach contents. Do you want to disable this?", "Disabling [name]'s Digestion", "Disable", "Cancel")
		if(confirm == "Disable")
			vore_selected.digest_mode = DM_HOLD

//
// Simple nom proc for if you get ckey'd into a simple_animal mob! Avoids grabs.
//
/mob/living/simple_animal/proc/animal_nom(var/mob/living/T in oview(1))
	set name = "Animal Nom (pull target)"
	set category = "Vore"
	set desc = "Since you can't grab, you get a verb!"

	if (stat != CONSCIOUS)
		return
	if(!CHECK_BITFIELD(T.vore_flags,DEVOURABLE))
		return
	return vore_attack(src,T,src)
