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
