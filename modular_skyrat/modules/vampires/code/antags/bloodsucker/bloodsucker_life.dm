

// 		TO PLUG INTO LIFE:

// Cancel BLOOD life
// Cancel METABOLISM life   (or find a way to control what gets digested)
// Create COLDBLOODED trait (thermal homeostasis)

// 		EXAMINE
//
// Show as dead when...

/datum/antagonist/bloodsucker/proc/LifeTick()// Should probably run from life.dm, same as handle_changeling, but will be an utter pain to move
	set waitfor = FALSE // Don't make on_gain() wait for this function to finish. This lets this code run on the side.
	var/notice_healing
	while(owner && !AmFinalDeath()) // owner.has_antag_datum(ANTAG_DATUM_BLOODSUCKER) == src
		if(owner.current.stat == CONSCIOUS && !poweron_feed && !HAS_TRAIT(owner.current, TRAIT_FAKEDEATH)) // Deduct Blood
			AddBloodVolume(passive_blood_drain) // -.1 currently
		if(HandleHealing(1)) 		// Heal
			if(!notice_healing && owner.current.blood_volume > 0)
				to_chat(owner, "<span class='notice'>The power of your blood begins knitting your wounds...</span>")
				notice_healing = TRUE
		else if(notice_healing == TRUE)
			notice_healing = FALSE 	// Apply Low Blood Effects
		HandleStarving()  // Death
		HandleDeath() // Standard Update
		update_hud()// Daytime Sleep in Coffin
		if(SSticker.mode.is_daylight() && !HAS_TRAIT_FROM(owner.current, TRAIT_FAKEDEATH, "bloodsucker"))
			if(istype(owner.current.loc, /obj/structure/closet/crate/coffin))
				Torpor_Begin()
					// Wait before next pass
		sleep(10)
	FreeAllVassals() 	// Free my Vassals! (if I haven't yet)

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//			BLOOD

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/antagonist/bloodsucker/proc/AddBloodVolume(value)
	owner.current.blood_volume = clamp(owner.current.blood_volume + value, 0, max_blood_volume)
	update_hud()

/datum/antagonist/bloodsucker/proc/HandleFeeding(mob/living/carbon/target, mult=1)
	// mult: SILENT feed is 1/3 the amount
	var/blood_taken = min(feed_amount, target.blood_volume) * mult	// Starts at 15 (now 8 since we doubled the Feed time)
	target.blood_volume -= blood_taken
	// Simple Animals lose a LOT of blood, and take damage. This is to keep cats, cows, and so forth from giving you insane amounts of blood.
	if(!ishuman(target))
		target.blood_volume -= (blood_taken / max(target.mob_size, 0.1)) * 3.5 // max() to prevent divide-by-zero
		target.apply_damage_type(blood_taken / 3.5) // Don't do too much damage, or else they die and provide no blood nourishment.
		if(target.blood_volume <= 0)
			target.blood_volume = 0
			target.death(0)
	///////////
	// Shift Body Temp (toward Target's temp, by volume taken)
	owner.current.bodytemperature = ((owner.current.blood_volume * owner.current.bodytemperature) + (blood_taken * target.bodytemperature)) / (owner.current.blood_volume + blood_taken)
	// our volume * temp, + their volume * temp, / total volume
	///////////
	// Reduce Value Quantity
	if(target.stat == DEAD)	// Penalty for Dead Blood
		blood_taken /= 3
	if(!ishuman(target))		// Penalty for Non-Human Blood
		blood_taken /= 2
	//if (!iscarbon(target))	// Penalty for Animals (they're junk food)
	// Apply to Volume
	AddBloodVolume(blood_taken)
	// Reagents (NOT Blood!)
	if(target.reagents && target.reagents.total_volume)
		target.reagents.reaction(owner.current, INGEST, 1) // Run Reaction: what happens when what they have mixes with what I have?
		target.reagents.trans_to(owner.current, 1)	// Run transfer of 1 unit of reagent from them to me.
	// Blood Gulp Sound
	owner.current.playsound_local(null, 'sound/effects/singlebeat.ogg', 40, 1) // Play THIS sound for user only. The "null" is where turf would go if a location was needed. Null puts it right in their head.

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//			HEALING

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/antagonist/bloodsucker/proc/HandleHealing(mult = 1)
	// NOTE: Mult of 0 is just a TEST to see if we are injured and need to go into Torpor!
	//It is called from your coffin on close (by you only)
	var/actual_regen = regen_rate + additional_regen
	if(poweron_masquerade|| owner.current.AmStaked())
		return FALSE
	if(owner.current.reagents.has_reagent(/datum/reagent/consumable/garlic))
		return FALSE
	if(istype(owner.current.get_item_by_slot(SLOT_NECK), /obj/item/clothing/neck/garlic_necklace))
		return FALSE
	owner.current.adjustStaminaLoss(-1.5 + (actual_regen * -7) * mult, 0) // Humans lose stamina damage really quickly. Vamps should heal more.
	owner.current.adjustCloneLoss(-0.1 * (actual_regen * 2) * mult, 0)
	owner.current.adjustOrganLoss(ORGAN_SLOT_BRAIN, -1 * (actual_regen * 4) * mult)
	// No Bleeding
	/*if(ishuman(owner.current)) //NOTE Current bleeding is horrible, not to count the amount of blood ballistics delete.
		var/mob/living/carbon/human/H = owner.current
		if(H.bleed_rate > 0) //Only heal bleeding if we are actually bleeding
			H.bleed_rate =- 0.5 + actual_regen * 0.2 */
	if(iscarbon(owner.current)) // Damage Heal: Do I have damage to ANY bodypart?
		var/mob/living/carbon/C = owner.current
		var/costMult = 1 // Coffin makes it cheaper
		var/fireheal = 0 	// BURN: Heal in Coffin while Fakedeath, or when damage above maxhealth (you can never fully heal fire)
			// Check for mult 0 OR death coma. (mult 0 means we're testing from coffin)
		if(istype(C.loc, /obj/structure/closet/crate/coffin) && (mult == 0 || HAS_TRAIT(C, TRAIT_FAKEDEATH)))
			mult *= 4 // Increase multiplier if we're sleeping in a coffin.
			fireheal = min(C.getFireLoss(), regen_rate) // NOTE: Burn damage ONLY heals in torpor.
			C.ExtinguishMob()
			CureDisabilities() 	// Extinguish Fire
			C.remove_all_embedded_objects() // Remove Embedded!
			owner.current.regenerate_organs() // Heal Organs (will respawn original eyes etc. but we replace right away, next)
			CheckVampOrgans() // Heart, Eyes
			if(check_limbs(costMult))
				return TRUE
		else if(owner.current.stat >= UNCONSCIOUS) //Faster regeneration and slight burn healing while unconcious
			mult *= 2
			fireheal = min(C.getFireLoss(), regen_rate * 0.2)

		// BRUTE: Always Heal
		var/bruteheal = min(C.getBruteLoss(), actual_regen)
		var/toxinheal = min(C.getToxLoss(), actual_regen)
		// Heal if Damaged
		if(bruteheal + fireheal + toxinheal > 0) 	// Just a check? Don't heal/spend, and return.
			if(mult == 0)
				return TRUE
			// We have damage. Let's heal (one time)
			C.adjustBruteLoss(-bruteheal * mult, forced = TRUE)// Heal BRUTE / BURN in random portions throughout the body.
			C.adjustFireLoss(-fireheal * mult, forced = TRUE)
			C.adjustToxLoss(-toxinheal * mult * 2, forced = TRUE) //Toxin healing because vamps arent immune
			//C.heal_overall_damage(bruteheal * mult, fireheal * mult)				 // REMOVED: We need to FORCE this, because otherwise, vamps won't heal EVER. Swapped to above.
			AddBloodVolume((bruteheal * -0.5 + fireheal * -1 + toxinheal * -0.2) / mult * costMult)	// Costs blood to heal
			return TRUE // Healed! Done for this tick.



/datum/antagonist/bloodsucker/proc/check_limbs(costMult)
	var/limb_regen_cost = 50 * costMult
	var/mob/living/carbon/C = owner.current
	var/list/missing = C.get_missing_limbs()
	if(missing.len && C.blood_volume < limb_regen_cost + 5)
		return FALSE
	for(var/targetLimbZone in missing) 			// 1) Find ONE Limb and regenerate it.
		C.regenerate_limb(targetLimbZone, FALSE)		// regenerate_limbs() <--- If you want to EXCLUDE certain parts, do it like this ----> regenerate_limbs(0, list("head"))
		AddBloodVolume(50)
		var/obj/item/bodypart/L = C.get_bodypart(targetLimbZone) // 2) Limb returns Damaged
		L.brute_dam = 60
		to_chat(C, "<span class='notice'>Your flesh knits as it regrows your [L]!</span>")
		playsound(C, 'sound/magic/demon_consume.ogg', 50, TRUE)
		return TRUE

/datum/antagonist/bloodsucker/proc/CureDisabilities()
	var/mob/living/carbon/C = owner.current
	C.cure_blind(list(EYE_DAMAGE))//()
	C.cure_nearsighted(EYE_DAMAGE)
	C.set_blindness(0) 	// Added 9/2/19
	C.set_blurriness(0) // Added 9/2/19
	C.update_tint() 	// Added 9/2/19
	C.update_sight() 	// Added 9/2/19
	for(var/O in C.internal_organs) //owner.current.adjust_eye_damage(-100)  // This was removed by TG
		var/obj/item/organ/organ = O
		organ.setOrganDamage(0)
	owner.current.cure_husk()

// I am thirsty for blud!
/datum/antagonist/bloodsucker/proc/HandleStarving()

	// High: 	Faster Healing
	// Med: 	Pale
	// Low: 	Twitch
	// V.Low:   Blur Vision
	// EMPTY:	Frenzy!
	// BLOOD_VOLUME_GOOD: [336]  Pale (handled in bloodsucker_integration.dm
	// BLOOD_VOLUME_BAD: [224]  Jitter
	if(owner.current.blood_volume < BLOOD_VOLUME_BAD && !prob(0.5 && HAS_TRAIT(owner, TRAIT_FAKEDEATH)) && !poweron_masquerade)
		owner.current.Jitter(3)
	// BLOOD_VOLUME_SURVIVE: [122]  Blur Vision
	if(owner.current.blood_volume < BLOOD_VOLUME_BAD / 2)
		owner.current.blur_eyes(8 - 8 * (owner.current.blood_volume / BLOOD_VOLUME_BAD))
	// Nutrition
	owner.current.set_nutrition(min(owner.current.blood_volume, NUTRITION_LEVEL_FED)) //The amount of blood is how full we are.
	//A bit higher regeneration based on blood volume
	if(owner.current.blood_volume < 700)
		additional_regen = 0.4
	else if(owner.current.blood_volume < BLOOD_VOLUME_NORMAL)
		additional_regen = 0.3
	else if(owner.current.blood_volume < BLOOD_VOLUME_OKAY)
		additional_regen = 0.2
	else if(owner.current.blood_volume < BLOOD_VOLUME_BAD)
		additional_regen  = 0.1
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//			DEATH

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/antagonist/bloodsucker/proc/HandleDeath()
	// 	FINAL DEATH
	// Fire Damage? (above double health)
	if(owner.current.getFireLoss() >= owner.current.maxHealth * 3)
		FinalDeath()
		return
	// Staked while "Temp Death" or Asleep
	if(owner.current.StakeCanKillMe() && owner.current.AmStaked())
		FinalDeath()
		return
	// Not "Alive"?
	if(!owner.current || !isliving(owner.current) || isbrain(owner.current) || !get_turf(owner.current))
		FinalDeath()
		return
	// Missing Brain or Heart?
	if(!owner.current.HaveBloodsuckerBodyparts())
		FinalDeath()
		return
				// Disable Powers: Masquerade	* NOTE * This should happen as a FLAW!
				//if (stat >= UNCONSCIOUS)
				//	for (var/datum/action/bloodsucker/masquerade/P in powers)
				//		P.Deactivate()
		//	TEMP DEATH
	var/total_brute = owner.current.getBruteLoss()
	var/total_burn = owner.current.getFireLoss()
	var/total_toxloss = owner.current.getToxLoss() //This is neater than just putting it in total_damage
	var/total_damage = total_brute + total_burn + total_toxloss
	// Died? Convert to Torpor (fake death)
	if(owner.current.stat >= DEAD)
		Torpor_Begin()
		to_chat(owner, "<span class='danger'>Your immortal body will not yet relinquish your soul to the abyss. You enter Torpor.</span>")
		sleep(30) //To avoid spam
		if(poweron_masquerade)
			to_chat(owner, "<span class='warning'>Your wounds will not heal until you disable the <span class='boldnotice'>Masquerade</span> power.</span>")
	// End Torpor:
	else	// No damage, OR toxin healed AND brute healed and NOT in coffin (since you cannot heal burn)
		if(total_damage <= 0 || total_toxloss <= 0 && total_brute <= 0 && !istype(owner.current.loc, /obj/structure/closet/crate/coffin))
			// Not Daytime, Not in Torpor, enough health to not die the moment you end torpor
			if(!SSticker.mode.is_daylight() && HAS_TRAIT_FROM(owner.current, TRAIT_FAKEDEATH, "bloodsucker") && total_damage < owner.current.getMaxHealth())
				Torpor_End()
		// Fake Unconscious
		if(poweron_masquerade && total_damage >= owner.current.getMaxHealth() - HEALTH_THRESHOLD_FULLCRIT)
			owner.current.Unconscious(20, 1)

/datum/antagonist/bloodsucker/proc/Torpor_Begin(amInCoffin = FALSE)
	owner.current.stat = UNCONSCIOUS
	owner.current.apply_status_effect(STATUS_EFFECT_UNCONSCIOUS)
	ADD_TRAIT(owner.current, TRAIT_FAKEDEATH, "bloodsucker") // Come after UNCONSCIOUS or else it fails
	ADD_TRAIT(owner.current, TRAIT_NODEATH, "bloodsucker")	// Without this, you'll just keep dying while you recover.
	ADD_TRAIT(owner.current, TRAIT_RESISTHIGHPRESSURE, "bloodsucker")	// So you can heal in space. Otherwise you just...heal forever.
	ADD_TRAIT(owner.current, TRAIT_RESISTLOWPRESSURE, "bloodsucker")
	owner.current.Jitter(0)
	// Visuals
	owner.current.update_sight()
	owner.current.reload_fullscreen()
	// Disable ALL Powers
	for(var/datum/action/bloodsucker/power in powers)
		if(power.active && !power.can_use_in_torpor)
			power.DeactivatePower()
	if(owner.current.suiciding)
		owner.current.suiciding = FALSE //Youll die but not for long.
		to_chat(owner.current, "<span class='warning'>Your body keeps you going, even as you try to end yourself.</span>")

/datum/antagonist/bloodsucker/proc/Torpor_End()
	owner.current.stat = SOFT_CRIT
	owner.current.remove_status_effect(STATUS_EFFECT_UNCONSCIOUS)
	REMOVE_TRAIT(owner.current, TRAIT_FAKEDEATH, "bloodsucker")
	REMOVE_TRAIT(owner.current, TRAIT_NODEATH, "bloodsucker")
	REMOVE_TRAIT(owner.current, TRAIT_RESISTHIGHPRESSURE, "bloodsucker")
	REMOVE_TRAIT(owner.current, TRAIT_RESISTLOWPRESSURE, "bloodsucker")
	to_chat(owner, "<span class='warning'>You have recovered from Torpor.</span>")


/datum/antagonist/proc/AmFinalDeath()
	// Standard Antags can be dead OR final death
 	return owner && (owner.current && owner.current.stat >= DEAD || owner.AmFinalDeath())

/datum/antagonist/bloodsucker/AmFinalDeath()
 	return owner && owner.AmFinalDeath()
/datum/antagonist/changeling/AmFinalDeath()
 	return owner && owner.AmFinalDeath()

/datum/mind/proc/AmFinalDeath()
 	return !current || QDELETED(current) || !isliving(current) || isbrain(current) || !get_turf(current) // NOTE: "isliving()" is not the same as STAT == CONSCIOUS. This is to make sure you're not a BORG (aka silicon)

/datum/antagonist/bloodsucker/proc/FinalDeath()
	if(!iscarbon(owner.current)) //Check for non carbons.
		owner.current.gib()
		return
	playsound(get_turf(owner.current), 'sound/effects/tendril_destroyed.ogg', 60, 1)
	owner.current.drop_all_held_items()
	owner.current.unequip_everything()
	var/mob/living/carbon/C = owner.current
	C.remove_all_embedded_objects()
	// Make me UN-CLONEABLE
	owner.current.hellbound = TRUE // This was done during creation, but let's do it again one more time...to make SURE this guy stays dead, but they dont stay dead because brains can be cloned!
	// Free my Vassals!
	FreeAllVassals()
	// Elders get Dusted
	if(bloodsucker_level >= 4) // (bloodsucker_title)
		owner.current.visible_message("<span class='warning'>[owner.current]'s skin crackles and dries, their skin and bones withering to dust. A hollow cry whips from what is now a sandy pile of remains.</span>", \
			 "<span class='userdanger'>Your soul escapes your withering body as the abyss welcomes you to your Final Death.</span>", \
			 "<span class='italics'>You hear a dry, crackling sound.</span>")
		sleep(50)
		owner.current.dust()
	// Fledglings get Gibbed
	else
		owner.current.visible_message("<span class='warning'>[owner.current]'s skin bursts forth in a spray of gore and detritus. A horrible cry echoes from what is now a wet pile of decaying meat.</span>", \
			 "<span class='userdanger'>Your soul escapes your withering body as the abyss welcomes you to your Final Death.</span>", \
			 "<span class='italics'>You hear a wet, bursting sound.</span>")
		owner.current.gib(TRUE, FALSE, FALSE) //Brain cloning is wierd and allows hellbounds. Lets destroy the brain for safety.
	playsound(owner.current, 'sound/effects/tendril_destroyed.ogg', 40, TRUE)



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//			HUMAN FOOD

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/mob/proc/CheckBloodsuckerEatFood(food_nutrition)
	if(!isliving(src))
		return
	var/mob/living/L = src
	if(!AmBloodsucker(L))
		return
	// We're a bloodsucker? Try to eat food...
	var/datum/antagonist/bloodsucker/B = L.mind.has_antag_datum(ANTAG_DATUM_BLOODSUCKER)
	B.handle_eat_human_food(food_nutrition)


/datum/antagonist/bloodsucker/proc/handle_eat_human_food(food_nutrition, puke_blood = TRUE, masquerade_override) // Called from snacks.dm and drinks.dm
	set waitfor = FALSE
	if(!owner.current || !iscarbon(owner.current))
		return
	var/mob/living/carbon/C = owner.current
	// Remove Nutrition, Give Bad Food
	C.adjust_nutrition(-food_nutrition)
	foodInGut += food_nutrition
	// Already ate some bad clams? Then we can back out, because we're already sick from it.
	if(foodInGut != food_nutrition)
		return
	// Haven't eaten, but I'm in a Human Disguise.
	else if(poweron_masquerade && !masquerade_override)
		to_chat(C, "<span class='notice'>Your stomach turns, but your \"human disguise\" keeps the food down...for now.</span>")
	// Keep looping until we purge. If we have activated our Human Disguise, we ignore the food. But it'll come up eventually...
	var/sickphase = 0
	while(foodInGut)
		sleep(50)
		C.adjust_disgust(10 * sickphase)
		// Wait an interval...
		sleep(50 + 50 * sickphase) // At intervals of 100, 150, and 200. (10 seconds, 15 seconds, and 20 seconds)
		// Died? Cancel
		if(C.stat == DEAD)
			return
		// Put up disguise? Then hold off the vomit.
		if(poweron_masquerade && !masquerade_override)
			if(sickphase > 0)
				to_chat(C, "<span class='notice'>Your stomach settles temporarily. You regain your composure...for now.</span>")
			sickphase = 0
			continue
		switch(sickphase)
			if(1)
				to_chat(C, "<span class='warning'>You feel unwell. You can taste ash on your tongue.</span>")
				C.Stun(10)
			if(2)
				to_chat(C, "<span class='warning'>Your stomach turns. Whatever you ate tastes of grave dirt and brimstone.</span>")
				C.Dizzy(15)
				C.Stun(13)
			if(3)
				to_chat(C, "<span class='warning'>You purge the food of the living from your viscera! You've never felt worse.</span>")
				 //Puke blood only if puke_blood is true, and loose some blood, else just puke normally.
				if(puke_blood)
					C.blood_volume = max(0, C.blood_volume - foodInGut * 2)
					C.vomit(foodInGut * 4, foodInGut * 2, 0)
				else
					C.vomit(foodInGut * 4, FALSE, 0)
				C.Stun(30)
				//C.Dizzy(50)
				foodInGut = 0
				SEND_SIGNAL(C, COMSIG_ADD_MOOD_EVENT, "vampdisgust", /datum/mood_event/bloodsucker_disgust)
		sickphase ++
