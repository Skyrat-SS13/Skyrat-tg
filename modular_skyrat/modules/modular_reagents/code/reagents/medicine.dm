/datum/reagent/medicine/lidocaine
	name = "Lidocaine"
	description = "A numbing agent used often for surgeries, metabolizes slowly."
	reagent_state = LIQUID
	color = "#6dbdbd" // 109, 189, 189
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	overdose_threshold = 20
	ph = 6.09
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	addiction_types = list(/datum/addiction/opiods = 20)
	inverse_chem_val = 0.55
	inverse_chem = /datum/reagent/inverse/lidocaine

/datum/reagent/medicine/lidocaine/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_NUMBED, src)
	L.throw_alert("numbed", /atom/movable/screen/alert/numbed)

/datum/reagent/medicine/lidocaine/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_NUMBED, src)
	L.clear_alert("numbed")
	..()

/datum/reagent/medicine/lidocaine/overdose_process(mob/living/M, delta_time, times_fired)
	M.adjustOrganLoss(ORGAN_SLOT_HEART,3 * REM * delta_time, 80)
	..()


/datum/reagent/medicine/ataraxydone
	name = "Ataraxydone"
	description = "A stasis-inducing chemical used for exotic surgeries or emergency medicine."
	taste_description = "liquid"
	reagent_state = LIQUID
	color = "#e0d394" // 224, 211, 148
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	overdose_threshold = 20
	ph = 7
	purity = REAGENT_STANDARD_PURITY
	creation_purity = REAGENT_STANDARD_PURITY
	impure_chem = /datum/reagent/impurity/ataraxydone
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED | REAGENT_DEAD_PROCESS | REAGENT_IGNORE_STASIS

/datum/reagent/medicine/ataraxydone/on_mob_dead(mob/living/carbon/owner, delta_time)
	.=..()
	owner.apply_status_effect(STATUS_EFFECT_STASIS_MOBILE, STASIS_CHEMICAL_EFFECT)
	metabolization_rate = 0.1 * REAGENTS_METABOLISM

/datum/reagent/medicine/ataraxydone/on_mob_life(mob/living/carbon/owner, delta_time, times_fired)
	var/ataraxydone_speed = max(1, min(current_cycle/10, 8))
	if(owner.resting || owner.stat >= SOFT_CRIT)
		owner.apply_status_effect(STATUS_EFFECT_STASIS_MOBILE, STASIS_CHEMICAL_EFFECT)
		owner.add_movespeed_modifier(/datum/movespeed_modifier/reagent/ataraxyprone)
		current_cycle += 1
	else
		owner.remove_status_effect(STATUS_EFFECT_STASIS_MOBILE, STASIS_CHEMICAL_EFFECT)
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/ataraxyprone)
	if(current_cycle >= 10)
		owner.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/reagent/ataraxydone, multiplicative_slowdown = ataraxydone_speed)
	if(owner.stat < SOFT_CRIT)
		switch(current_cycle)
			if(1)
				to_chat(owner, span_notice("You feel a comfortable stillness begin to set in throughout your body."))
			if(12)
				to_chat(owner, span_notice("It'd be easy to lay down for a bit..."))
			if(32)
				to_chat(owner, span_notice("It's getting hard to move..."))
			if(52)
				to_chat(owner, span_notice("...have I even been breathing..?"))
			if(48 to 79)
				owner.adjust_drowsyness(4 * REM * delta_time)
			if(80 to INFINITY)
				owner.Sleeping(50 * REM * delta_time)
				. = TRUE
	..()

/datum/reagent/medicine/ataraxydone/on_mob_delete(mob/living/carbon/owner, amount)
	.=..()
	owner.remove_status_effect(STATUS_EFFECT_STASIS_MOBILE, STASIS_CHEMICAL_EFFECT)
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/ataraxydone)
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/ataraxyprone)
	REMOVE_TRAIT(owner, TRAIT_PACIFISM, "ataraxydone")

/datum/reagent/medicine/ataraxydone/overdose_process(mob/living/owner, delta_time, times_fired)
	if(owner.stat != DEAD)
		if(current_cycle >= 16 && !HAS_TRAIT(owner, TRAIT_PACIFISM))
			if(DT_PROB(15, delta_time))
				to_chat(owner, span_notice("...what's the point of fighting, anyway?"))
				ADD_TRAIT(owner, TRAIT_PACIFISM, "ataraxydone")
		owner.adjustCloneLoss(0.1 * REM * delta_time)
	..()

//Impure Medicines//

/datum/reagent/impurity/ataraxydone
	name = "Dynamydine"
	description = "A byproduct of impure ataraxydone. Causes significant damage to the telomeres of living cells."
	taste_description = "old age"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	ph = 3.8
	liver_damage = 0

/datum/reagent/impurity/ataraxydone/on_mob_life(mob/living/carbon/owner, delta_time, times_fired)
	owner.adjustCloneLoss(0.5 * REM * delta_time)
	.=..()

//Inverse Medicines//

/datum/reagent/inverse/lidocaine
	name = "Lidopaine"
	description = "A paining agent used often for... being a jerk, metabolizes faster than lidocaine."
	reagent_state = LIQUID
	color = "#85111f" // 133, 17, 31
	metabolization_rate = 0.4 * REAGENTS_METABOLISM
	ph = 6.09
	tox_damage = 0

/datum/reagent/inverse/lidocaine/on_mob_life(mob/living/carbon/owner, delta_time, times_fired)
	..()
	to_chat(owner, span_userdanger("Your body aches with unimaginable pain!"))
	owner.adjustOrganLoss(ORGAN_SLOT_HEART,3 * REM * delta_time, 85)
	owner.adjustStaminaLoss(5 * REM * delta_time, 0)
	if(prob(30))
		INVOKE_ASYNC(owner, /mob.proc/emote, "scream")

//Medigun Clotting Medicine
/datum/reagent/medicine/coagulant/fabricated
	name = "fabricated coagulant"
	description = "A synthesized coagulant created by Mediguns."
	color = "#ff7373" //255, 155. 155
	clot_rate = 0.15 //Half as strong as standard coagulant
	passive_bleed_modifier = 0.5 // around 2/3 the bleeding reduction


/datum/reagent/consumable/ethanol/drunken_espatier/on_mob_metabolize(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_NUMBED, src) // SKYRAT EDIT ADD -- ANAESTHETIC FOR SURGERY PAIN
	L.throw_alert("numbed", /atom/movable/screen/alert/numbed) // SKYRAT EDIT ADD END -- i should probably have worked these both into a status effect, maybe

/datum/reagent/consumable/ethanol/drunken_espatier/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_NUMBED, src) // SKYRAT EDIT ADD -- ANAESTHETIC FOR SURGERY PAIN
	L.clear_alert("numbed") // SKYRAT EDIT ADD END
	..()

/datum/reagent/medicine/mine_salve/on_mob_metabolize(mob/living/L)
	ADD_TRAIT(L, TRAIT_NUMBED, src) // SKYRAT EDIT ADD -- ANAESTHETIC FOR SURGERY PAIN
	L.throw_alert("numbed", /atom/movable/screen/alert/numbed) // SKYRAT EDIT ADD END
	..()
