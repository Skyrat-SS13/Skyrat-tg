// Numbing effects
/datum/reagent/medicine/morphine/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	ADD_TRAIT(affected_mob, TRAIT_NUMBED, type) // ANAESTHETIC FOR SURGERY PAIN
	affected_mob.throw_alert("numbed", /atom/movable/screen/alert/numbed)

/datum/reagent/medicine/morphine/on_mob_end_metabolize(mob/living/affected_mob)
	REMOVE_TRAIT(affected_mob, TRAIT_NUMBED, type) // ANAESTHETIC FOR SURGERY PAIN
	affected_mob.clear_alert("numbed")
	return ..()

/datum/reagent/consumable/ethanol/drunken_espatier/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	ADD_TRAIT(affected_mob, TRAIT_NUMBED, type)
	affected_mob.throw_alert("numbed", /atom/movable/screen/alert/numbed)

/datum/reagent/consumable/ethanol/drunken_espatier/on_mob_end_metabolize(mob/living/affected_mob)
	REMOVE_TRAIT(affected_mob, TRAIT_NUMBED, type)
	affected_mob.clear_alert("numbed")
	return ..()

/datum/reagent/medicine/mine_salve/on_mob_metabolize(mob/living/affected_mob)
	ADD_TRAIT(affected_mob, TRAIT_NUMBED, type)
	affected_mob.throw_alert("numbed", /atom/movable/screen/alert/numbed)
	return ..()

/datum/reagent/medicine/mine_salve/on_mob_end_metabolize(mob/living/affected_mob)
	REMOVE_TRAIT(affected_mob, TRAIT_NUMBED, type)
	affected_mob.clear_alert("numbed")
	return ..()

//Changeling balancing
/datum/reagent/medicine/rezadone/expose_mob(mob/living/carbon/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!istype(exposed_mob))
		return
	if(HAS_TRAIT_FROM(exposed_mob, TRAIT_HUSK, CHANGELING_DRAIN) && (exposed_mob.reagents.get_reagent_amount(/datum/reagent/medicine/rezadone) + reac_volume >= SYNTHFLESH_LING_UNHUSK_AMOUNT))//Costs a little more than a normal husk
		exposed_mob.cure_husk(CHANGELING_DRAIN)
		exposed_mob.visible_message("<span class='nicegreen'>A rubbery liquid coats [exposed_mob]'s tissues. [exposed_mob] looks a lot healthier!")

/datum/reagent/medicine/regen_jelly/expose_mob(mob/living/carbon/human/exposed_mob, reac_volume)
	. = ..()
	if(!istype(exposed_mob) || (reac_volume < 0.5))
		return

	exposed_mob.update_mutant_bodyparts(force_update=TRUE)
