/obj/item/anomaly_neutralizer/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/effect_remover, \
		success_feedback = "You neutralize %THEEFFECT with %THEWEAPON, frying its circuitry in the process.", \
		on_clear_callback = CALLBACK(src, .proc/on_use_cme), \
		effects_we_clear = list(/obj/effect/cme))

/**
 * Callback for the effect remover component to handle neutralizing CMEs.
 */
/obj/item/anomaly_neutralizer/proc/on_use_cme(obj/effect/target, mob/living/user)
	var/obj/effect/cme/cme_target = target
	if(cme_target.neutralized)
		return
	electrocute_mob(user, get_area(src), src, 1, TRUE)
	cme_target.anomalyNeutralize()
	on_use(target, user)
