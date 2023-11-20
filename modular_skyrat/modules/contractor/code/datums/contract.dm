#define RANSOM_LOWER 75
#define RANSOM_UPPER 150
#define CONTRACTOR_RANSOM_CUT 0.35

/// Generation of the contract, called on New()
/datum/syndicate_contract/proc/generate(blacklist)
	. = ..()
	ransom = 100 * rand(RANSOM_LOWER, RANSOM_UPPER)

/datum/syndicate_contract/enter_check(datum/source, mob/living/sent_mob)
	SIGNAL_HANDLER
	if(!istype(source, /obj/structure/closet/supplypod/extractionpod))
		return
	if(!istype(sent_mob))
		return
	var/datum/opposing_force/opfor_data = contract.owner.opposing_force

	if (sent_mob == contract.target.current)
		opfor_data.contractor_hub.contract_TC_to_redeem += contract.payout
		opfor_data.contractor_hub.contracts_completed += 1

		if (sent_mob.stat != DEAD)
			opfor_data.contractor_hub.contract_TC_to_redeem += contract.payout_bonus

		status = CONTRACT_STATUS_COMPLETE

		if (opfor_data.contractor_hub.current_contract == src)
			opfor_data.contractor_hub.current_contract = null

		opfor_data.contractor_hub.contract_rep += 2
	else
		status = CONTRACT_STATUS_ABORTED // Sending a sent_mob that wasn't even yours is as good as just aborting it

		if (opfor_data.contractor_hub.current_contract == src)
			opfor_data.contractor_hub.current_contract = null

	if(iscarbon(sent_mob))
		for(var/obj/item/sent_mob_item in sent_mob)
			if (ishuman(sent_mob))
				var/mob/living/carbon/human/sent_mob_human = sent_mob
				if(sent_mob_item == sent_mob_human.w_uniform)
					continue //So all they're left with are shoes and uniform.
				if(sent_mob_item == sent_mob_human.shoes)
					continue


			sent_mob.transferItemToLoc(sent_mob_item)
			victim_belongings.Add(sent_mob_item)

	var/obj/structure/closet/supplypod/extractionpod/pod = source
	pod.recieving = FALSE

	// Handle the pod returning
	pod.startExitSequence(pod)

	if (ishuman(sent_mob))
		var/mob/living/carbon/human/sent_mob_human = sent_mob

		// After we remove items, at least give them what they need to live.
		sent_mob_human.dna.species.give_important_for_life(sent_mob_human)

	// After pod is sent we start the victim narrative/heal.
	INVOKE_ASYNC(src, PROC_REF(handle_victim_experience), sent_mob)

	// This is slightly delayed because of the sleep calls above to handle the narrative.
	// We don't want to tell the station instantly.
	var/points_to_check
	var/datum/bank_account/bank = SSeconomy.get_dep_account(ACCOUNT_CAR)
	if(bank)
		points_to_check = bank.account_balance
	if(points_to_check >= ransom)
		bank.adjust_money(-ransom)
	else
		bank.adjust_money(-points_to_check)

	priority_announce("One of your crew was captured by a rival organisation - we've needed to pay their ransom to bring them back. \
					As is policy we've taken a portion of the station's funds to offset the overall cost.", null, null, null, "Nanotrasen Asset Protection")

	addtimer(CALLBACK(src, PROC_REF(finish_enter)), 3 SECONDS)

/// Called when person is finished shoving in, awards ransome money
/datum/syndicate_contract/finish_enter()
	// Pay contractor their portion of ransom
	if(status != CONTRACT_STATUS_COMPLETE)
		return

	var/obj/item/card/id/owner_id = contract.owner.current?.get_idcard(TRUE)

	if(owner_id?.registered_account.account_id) // why do we check for account id? because apparently unset agent IDs have existing bank accounts that can't be accessed. this is suboptimal
		owner_id.registered_account.adjust_money(ransom * CONTRACTOR_RANSOM_CUT)

		owner_id.registered_account.bank_card_talk("We've processed the ransom, agent. Here's your cut - your balance is now \
		[owner_id.registered_account.account_balance] credits.", TRUE)
	else
		to_chat(contract.owner.current, span_notice("A briefcase appears at your feet!"))
		var/obj/item/storage/briefcase/secure/case = new(get_turf(contract.owner.current))
		for(var/i in 1 to (round((ransom * CONTRACTOR_RANSOM_CUT) / 1000))) // Gets slightly less/more but whatever
			new /obj/item/stack/spacecash/c1000(case)

/// They're off to holding - handle the return timer and give some text about what's going on.
/datum/syndicate_contract/handle_victim_experience(mob/living/target)
	// Ship 'em back - dead or alive, 4 minutes wait.
	// Even if they weren't the target, we're still treating them the same.
	addtimer(CALLBACK(src, PROC_REF(return_victim), target), 4 MINUTES)

	if (target.stat == DEAD)
		return
	// Heal them up - gets them out of crit/soft crit. If omnizine is removed in the future, this needs to be replaced with a
	// method of healing them, consequence free, to a reasonable amount of health.
	victim_stage_one(target)

/// Adds omnizine and begins the victim handling
/datum/syndicate_contract/proc/victim_stage_one(mob/living/target)
	target.reagents.add_reagent(/datum/reagent/medicine/omnizine, 20)

	target.flash_act()
	target.adjust_confusion(10 SECONDS)
	target.set_eye_blur_if_lower(10 SECONDS)
	to_chat(target, span_warning("You feel strange..."))
	addtimer(CALLBACK(src, PROC_REF(victim_stage_two), target), 6 SECONDS)

/// Continued victim handling
/datum/syndicate_contract/proc/victim_stage_two(mob/living/target)
	var/list/parts_to_fuck_up = list(
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_ARM,
		BODY_ZONE_L_LEG,
		BODY_ZONE_R_LEG,
	)

	to_chat(target, span_warning("That pod did something to you..."))
	target.set_dizzy(70 SECONDS)

	for(var/i in 1 to 2)
		var/obj/item/bodypart/limb = target.get_bodypart(pick_n_take(parts_to_fuck_up))
		var/min_wound = limb.get_wound_threshold_of_wound_type(WOUND_BLUNT, WOUND_SEVERITY_SEVERE, return_value_if_no_wound = 40)
		var/max_wound = limb.get_wound_threshold_of_wound_type(WOUND_BLUNT, WOUND_SEVERITY_CRITICAL, return_value_if_no_wound = 60)
		limb.receive_damage(brute = WOUND_MINIMUM_DAMAGE, wound_bonus = rand(min_wound, max_wound))
		target.update_damage_overlays()

	addtimer(CALLBACK(src, PROC_REF(victim_stage_three), target), 6 SECONDS)

/// Continued victim handling, flashes them as well
/datum/syndicate_contract/proc/victim_stage_three(mob/living/target)
	to_chat(target, span_warning("Your head pounds... It feels like it's going to burst out your skull!"))
	target.flash_act()
	target.adjust_confusion(20 SECONDS)
	target.set_eye_blur_if_lower(6 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(victim_stage_four), target), 3 SECONDS)

/// Continued victim handling
/datum/syndicate_contract/proc/victim_stage_four(mob/living/target)
	to_chat(target, span_warning("Your head pounds..."))

	if(iscarbon(target))
		var/mob/living/carbon/carbon_target = target
		switch(rand(1, 100))
			if(1 to 45)
				carbon_target.gain_trauma_type(BRAIN_TRAUMA_MILD, TRAUMA_RESILIENCE_SURGERY)

			if(46 to 73)
				carbon_target.gain_trauma_type(BRAIN_TRAUMA_MILD, TRAUMA_RESILIENCE_SURGERY)
				carbon_target.gain_trauma_type(BRAIN_TRAUMA_MILD, TRAUMA_RESILIENCE_SURGERY)

			if(74 to 94)
				carbon_target.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_SURGERY)

			if(75 to 100)
				carbon_target.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_SURGERY)
				carbon_target.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_SURGERY)

	addtimer(CALLBACK(src, PROC_REF(victim_stage_five), target), 10 SECONDS)

/// Continued victim handling, some unconsciousness
/datum/syndicate_contract/proc/victim_stage_five(mob/living/target)
	target.flash_act()
	target.Unconscious(200)
	to_chat(target, span_hypnophrase(span_reallybig("A million voices echo in your head... <i>\"Your mind held many valuable secrets - \
				we thank you for providing them. Your value is expended, and you will be ransomed back to your station. We always get paid, \
				so it's only a matter of time before we ship you back...\"</i>")))
	target.set_eye_blur_if_lower(20 SECONDS)
	target.set_dizzy_if_lower(30 SECONDS)
	target.adjust_confusion(20 SECONDS)

/// We're returning the victim
/datum/syndicate_contract/return_victim(mob/living/target)
	var/list/possible_drop_loc = list()

	for(var/turf/possible_drop in contract.dropoff.contents)
		if(is_safe_turf(possible_drop))
			possible_drop_loc += possible_drop
	if(!length(possible_drop_loc)) //Prioritize safe tiles first, then unsafe
		for(var/turf/open/possible_unsafe_drop in contract.dropoff.contents)
			possible_drop_loc += possible_unsafe_drop

	if (length(possible_drop_loc))
		var/pod_rand_loc = rand(1, length(possible_drop_loc))

		var/obj/structure/closet/supplypod/return_pod = new()
		return_pod.bluespace = TRUE
		return_pod.explosionSize = list(0,0,0,0)
		return_pod.style = STYLE_SYNDICATE

		do_sparks(8, FALSE, target)
		target.visible_message(span_notice("[target] vanishes..."))

		for(var/obj/item/target_item as anything in target)
			if(ishuman(target))
				var/mob/living/carbon/human/human_target = target
				if(target_item == human_target.w_uniform)
					continue //So all they're left with are shoes and uniform.
				if(target_item == human_target.shoes)
					continue
			target.dropItemToGround(target_item)

		for(var/obj/item/target_item as anything in victim_belongings)
			target_item.forceMove(return_pod)

		target.forceMove(return_pod)

		target.flash_act()
		target.set_eye_blur_if_lower(60 SECONDS)
		target.set_dizzy_if_lower(70 SECONDS)
		target.adjust_confusion(20 SECONDS)

		new /obj/effect/pod_landingzone(possible_drop_loc[pod_rand_loc], return_pod)
	else
		to_chat(target, span_reallybig(span_hypnophrase("A million voices echo in your head... <i>\"Seems where you got sent here from won't \
					be able to handle our pod... You will die here instead.\"</i>")))
		if(!isliving(target))
			return
		var/mob/living/unlucky_fellow = target
		unlucky_fellow.investigate_log("was returned without a valid drop location by the contractor [contract.owner?.current].", INVESTIGATE_DEATHS)
		unlucky_fellow.death()

#undef RANSOM_LOWER
#undef RANSOM_UPPER
#undef CONTRACTOR_RANSOM_CUT
