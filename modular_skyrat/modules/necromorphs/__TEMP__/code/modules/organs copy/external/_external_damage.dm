/****************************************************
			   DAMAGE PROCS
****************************************************/
//Organ bullet act. Only used for organs already on the ground when they are shot
/obj/item/organ/external/bullet_act(var/obj/item/projectile/P, var/def_zone)
	if (P.damtype == BRUTE)
		take_external_damage(P.damage, 0, P.damage_flags(), P)
	else if (P.damtype == BURN)
		take_external_damage(0, P.damage, P.damage_flags(), P)


/obj/item/organ/external/proc/is_damageable(var/additional_damage = 0)
	//Continued damage to vital organs can kill you, and robot organs don't count towards total damage so no need to cap them.
	return (BP_IS_ROBOTIC(src) || brute_dam + burn_dam + additional_damage < max_damage * 4)

obj/item/organ/external/take_general_damage(var/amount, var/silent = FALSE)
	take_external_damage(amount)

/obj/item/organ/external/proc/take_external_damage(var/brute = 0, var/burn = 0, var/damage_flags = 0, var/used_weapon = null, var/allow_dismemberment = TRUE)
	//We no longer exist, no damage allowed
	if (QDELETED(src))
		return

	//If this limb is retracted, pass all hits directly to our parent
	if (retracted && parent)
		return parent.take_external_damage(brute, burn, damage_flags, used_weapon, allow_dismemberment)

	//These may be null if the organ is taking damage while severed and lying on the ground
	if (owner && owner.species)
		SET_ARGS(owner.species.handle_organ_external_damage(arglist(list(src)+args)))
	brute = round(brute * get_brute_mod(), 0.35)
	burn = round(burn * get_burn_mod(), 0.35)
	if((brute <= 0) && (burn <= 0))
		return 0

	var/sharp = (damage_flags & DAM_SHARP)
	var/edge  = (damage_flags & DAM_EDGE)
	var/laser = (damage_flags & DAM_LASER)
	var/blunt = brute && !sharp && !edge

	if(used_weapon)
		add_autopsy_data("[used_weapon]", brute + burn)
	var/can_cut = (!BP_IS_ROBOTIC(src) && (sharp || prob(brute*2)))
	var/spillover = 0
	var/pure_brute = brute
	if(!is_damageable(brute + burn))
		spillover =  brute_dam + burn_dam + brute - max_damage
		if(spillover > 0)
			brute = max(brute - spillover, 0)
		else
			spillover = brute_dam + burn_dam + brute + burn - max_damage
			if(spillover > 0)
				burn = max(burn - spillover, 0)

	//There may not be an owner if this organ is severed and taking damage while on the floor
	if (owner)
		owner.updatehealth() //droplimb will call updatehealth() again if it does end up being called

	//There may not be an owner if this organ is severed and taking damage while on the floor
	if (owner)
		if(status & ORGAN_BROKEN && brute)
			jostle_bone(brute)
			if(can_feel_pain() && prob(40))
				owner.emote("scream")	//getting hit on broken hand hurts

	if(brute_dam > min_broken_damage && prob(brute_dam + brute * (1+blunt)) ) //blunt damage is gud at fracturing
		fracture()

	// If the limbs can break, make sure we don't exceed the maximum damage a limb can take before breaking
	var/datum/wound/created_wound
	var/block_cut = !(brute > 15 || !(species.species_flags & SPECIES_FLAG_NO_MINOR_CUT))

	if(brute)
		var/to_create = BRUISE
		if(can_cut)
			if(!block_cut)
				to_create = CUT
			//need to check sharp again here so that blunt damage that was strong enough to break skin doesn't give puncture wounds
			if(sharp && !edge)
				to_create = PIERCE
		created_wound = createwound(to_create, brute)

	if(burn)
		if(laser)
			createwound(LASER, burn)
			if(prob(40) && owner)
				owner.IgniteMob()
		else
			createwound(BURN, burn)



	// sync the organ's damage with its wounds
	update_damages()

	//There may not be an owner if this organ is severed and taking damage while on the floor
	if (owner)
		//Initial pain spike
		add_pain(0.5*burn + 0.4*brute)

		//Disturb treated burns
		if(owner && brute > 5)
			var/disturbed = 0
			for(var/datum/wound/burn/W in wounds)
				if((W.disinfected || W.salved) && prob(brute + W.damage))
					W.disinfected = 0
					W.salved = 0
					disturbed += W.damage
			if(disturbed)
				to_chat(owner,"<span class='warning'>Ow! Your burns were disturbed.</span>")
				add_pain(0.3*disturbed)

		//If there are still hurties to dispense
		if (spillover && owner)
			owner.shock_stage += spillover * CONFIG_GET(number/organ_damage_spillover_multiplier)



		owner.updatehealth()

		//If limb took enough damage, try to cut or tear it off
		if(allow_dismemberment && loc == owner && !is_stump())
			if((limb_flags & ORGAN_FLAG_CAN_AMPUTATE) && CONFIG_GET(flag/limbs_can_break))
				var/total_damage = brute_dam + burn_dam + brute + burn + spillover
				var/threshold = max_damage * CONFIG_GET(number/organ_health_multiplier)
				if(total_damage > threshold)
					if(attempt_dismemberment(pure_brute, burn, edge, used_weapon, spillover, total_damage > threshold*3))
						return

		if(owner && update_damstate())
			owner.UpdateDamageIcon()

	return created_wound

/obj/item/organ/external/heal_damage(brute, burn, internal = 0, robo_repair = 0)
	if(BP_IS_ROBOTIC(src) && !robo_repair)
		return

	if (!number_wounds)
		return 0

	//Heal damage on the individual wounds
	for(var/datum/wound/W in wounds)
		if(brute == 0 && burn == 0)
			break

		// heal brute damage
		if(W.damage_type == BURN)
			burn = W.heal_damage(burn)
		else
			brute = W.heal_damage(brute)

	if(internal)
		set_status(ORGAN_BROKEN, FALSE)

	//Sync the organ's damage with its wounds
	src.update_damages()
	owner.updatehealth()

	return update_damstate()

// Brute/burn
/obj/item/organ/external/proc/get_brute_damage()
	return brute_dam

/obj/item/organ/external/proc/get_burn_damage()
	return burn_dam

// Geneloss/cloneloss.
/obj/item/organ/external/proc/get_genetic_damage()
	return ((species && (species.species_flags & SPECIES_FLAG_NO_SCAN)) || BP_IS_ROBOTIC(src)) ? 0 : genetic_degradation

/obj/item/organ/external/proc/remove_genetic_damage(var/amount)
	if((species.species_flags & SPECIES_FLAG_NO_SCAN) || BP_IS_ROBOTIC(src))
		genetic_degradation = 0
		status &= ~ORGAN_MUTATED
		return
	if (!genetic_degradation)
		return 0

	var/last_gene_dam = genetic_degradation
	genetic_degradation = min(100,max(0,genetic_degradation - amount))
	if(genetic_degradation <= 30)
		if(status & ORGAN_MUTATED)
			unmutate()
			to_chat(owner, "<span class = 'notice'>Your [name] is shaped normally again.</span>")
	if (owner)
		owner.updatehealth()
	return -(genetic_degradation - last_gene_dam)

/obj/item/organ/external/proc/add_genetic_damage(var/amount)
	if((species.species_flags & SPECIES_FLAG_NO_SCAN) || BP_IS_ROBOTIC(src))
		genetic_degradation = 0
		status &= ~ORGAN_MUTATED
		return
	var/last_gene_dam = genetic_degradation
	genetic_degradation = min(100,max(0,genetic_degradation + amount))
	if(genetic_degradation > 30)
		if(!(status & ORGAN_MUTATED) && prob(genetic_degradation))
			mutate()
			to_chat(owner, "<span class = 'notice'>Something is not right with your [name]...</span>")
	if (owner)
		owner.updatehealth()
	return (genetic_degradation - last_gene_dam)

/obj/item/organ/external/proc/mutate()
	if(BP_IS_ROBOTIC(src))
		return
	src.status |= ORGAN_MUTATED
	if(owner) owner.update_body()

/obj/item/organ/external/proc/unmutate()
	src.status &= ~ORGAN_MUTATED
	if(owner) owner.update_body()

// Pain/halloss
/obj/item/organ/external/proc/get_pain()
	if(!can_feel_pain() || BP_IS_ROBOTIC(src))
		return 0
	var/lasting_pain = 0
	if(is_broken())
		lasting_pain += 10
	else if(is_dislocated())
		lasting_pain += 5
	var/tox_dam = 0
	for(var/obj/item/organ/internal/I in internal_organs)
		tox_dam += I.getToxLoss()
	return pain + lasting_pain + 0.7 * brute_dam + 0.8 * burn_dam + 0.3 * tox_dam + 0.5 * get_genetic_damage()

/obj/item/organ/external/proc/remove_pain(var/amount)
	if(!can_feel_pain())
		pain = 0
		return
	if (!pain)
		return 0
	var/last_pain = pain
	pain = max(0,min(max_damage,pain-amount))
	if (owner)
		owner.updatehealth()
	return -(pain-last_pain)

/obj/item/organ/external/proc/add_pain(var/amount)
	if(!can_feel_pain())
		pain = 0
		return
	var/last_pain = pain
	pain = max(0,min(max_damage,pain+amount))
	if(owner)

		if (((amount > 15 && prob(20)) || (amount > 30 && prob(60))))
			owner.emote("scream")
		owner.updatehealth()
	return pain-last_pain

/obj/item/organ/external/proc/stun_act(var/stun_amount, var/agony_amount)
	if(agony_amount > 5 && owner)

		if((limb_flags & ORGAN_FLAG_CAN_GRASP) && prob(25))
			owner.grasp_damage_disarm(src)

		if((limb_flags & ORGAN_FLAG_CAN_STAND) && prob(min(agony_amount * ((body_part == LEG_LEFT || body_part == LEG_RIGHT)? 2 : 4),70)))
			owner.stance_damage_prone(src)

		if(vital && get_pain() > 0.5 * max_damage)
			owner.visible_message("<span class='warning'>[owner] reels in pain!</span>")
			if(has_genitals() || get_pain() + agony_amount > max_damage)
				owner.Weaken(6)
			else
				owner.Stun(6)
				owner.drop_l_hand()
				owner.drop_r_hand()
			return 1

/obj/item/organ/external/proc/get_agony_multiplier()
	return has_genitals() ? 2 : 1

/obj/item/organ/external/proc/sever_artery()
	if(species && species.has_organ[BP_HEART])
		var/obj/item/organ/internal/heart/O = species.has_organ[BP_HEART]
		if(!BP_IS_ROBOTIC(src) && !(status & ORGAN_ARTERY_CUT) && !initial(O.open))
			status |= ORGAN_ARTERY_CUT
			return TRUE
	return FALSE

/obj/item/organ/external/proc/sever_tendon()
	if((limb_flags & ORGAN_FLAG_HAS_TENDON) && !BP_IS_ROBOTIC(src) && !(status & ORGAN_TENDON_CUT))
		set_status(ORGAN_TENDON_CUT, TRUE)
		return TRUE
	return FALSE

/obj/item/organ/external/proc/get_brute_mod()
	return species.brute_mod + 0.2 * burn_dam/max_damage //burns make you take more brute damage

/obj/item/organ/external/proc/get_burn_mod()
	return species.burn_mod

//organs can come off in three cases
//1. If the damage source is edge_eligible and the brute damage dealt exceeds the edge threshold, then the organ is cut off.
//2. If the damage amount dealt exceeds the disintegrate threshold, the organ is completely obliterated.
//3. If the organ has already reached or would be put over it's max damage amount (currently redundant),
//   and the brute damage dealt exceeds the tearoff threshold, the organ is torn off.
/obj/item/organ/external/proc/attempt_dismemberment(brute, burn, edge, used_weapon, spillover, force_droplimb)
	//Check edge eligibility
	var/edge_eligible = 0
	if(edge)
		if(istype(used_weapon,/obj/item))
			var/obj/item/W = used_weapon
			if(W.w_class >= w_class)
				edge_eligible = 1
		else
			edge_eligible = 1

	if(force_droplimb)
		if(burn)
			droplimb(0, DROPLIMB_BURN)
		else if(brute)
			droplimb(0, edge_eligible ? DROPLIMB_EDGE : DROPLIMB_BLUNT)
		return TRUE

	if((edge_eligible && brute >= max_damage / DROPLIMB_THRESHOLD_EDGE) && prob(brute))
		droplimb(0, DROPLIMB_EDGE, cutter = used_weapon)
		return TRUE
	else if((burn >= max_damage / DROPLIMB_THRESHOLD_DESTROY) && prob(burn/3))
		droplimb(0, DROPLIMB_BURN, cutter = used_weapon)
		return TRUE
	else if((brute >= max_damage / DROPLIMB_THRESHOLD_DESTROY) && prob(brute))
		droplimb(0, DROPLIMB_BLUNT, cutter = used_weapon)
		return TRUE
	else if((brute >= max_damage / DROPLIMB_THRESHOLD_TEAROFF) && prob(brute/3))
		droplimb(0, DROPLIMB_EDGE, cutter = used_weapon)
		return TRUE
	else
		//Lets handle cumulative damage. No probabilities, guaranteed effect if enough damage accumulates
		//Any edge weapon can cut off a limb if its been thoroughly broken
		if (edge && damage >= max_damage * DROPLIMB_CUMULATIVE_TEAROFF)
			droplimb(0, DROPLIMB_EDGE, cutter = used_weapon)
			return TRUE

		//Non-edged weapons can snap off limbs with enough hits
		else if (damage >= max_damage * DROPLIMB_CUMULATIVE_BREAKOFF)
			droplimb(0, DROPLIMB_EDGE, cutter = used_weapon)
			return TRUE

		//Any limb can be beaten to a pulp with enough repeated hits. This is fairly uncommon since it will usually breakoff first
		else if (damage >= max_damage * DROPLIMB_CUMULATIVE_DESTROY)
			droplimb(0, DROPLIMB_BLUNT, cutter = used_weapon)
			return TRUE