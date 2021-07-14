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
	var/obj/item/organ/heart/our_heart = M.getorganslot(ORGAN_SLOT_HEART)
	our_heart.applyOrganDamage(3)
	..()

//Inverse Medicines//

/datum/reagent/inverse/lidocaine
	name = "Lidopaine"
	description = "A paining agent used often for... being a jerk, metabolizes very slowly."
	reagent_state = LIQUID
	color = "#85111f" // 133, 17, 31
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	ph = 6.09
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	addiction_types = list(/datum/addiction/medicine = 8)

/datum/reagent/inverse/lidocaine/on_mob_life(mob/living/carbon/owner, delta_time, times_fired)
	..()
	to_chat(owner, "<span class='userdanger'>Your body aches with unimaginable pain!</span>")
	var/obj/item/organ/heart/our_heart = owner.getorganslot(ORGAN_SLOT_HEART)
	our_heart.applyOrganDamage(2)
	owner.adjustStaminaLoss(3 * REM * delta_time, 0)
