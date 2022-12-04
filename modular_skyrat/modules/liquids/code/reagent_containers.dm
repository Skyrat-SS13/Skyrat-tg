/obj/item/reagent_containers/Initialize(mapload, vol)
	. = ..()

	AddComponent(/datum/component/liquids_interaction, TYPE_PROC_REF(/obj/item/reagent_containers/cup/beaker, attack_on_liquids_turf))

/**
 * The procedure for remove liquids from turf
 *
 * Arguments:
 * * my_beaker - Beaker used to absorb liquids
 * * tile - On which tile mop try absorb liquids
 * * user - Who try to absorb liquids with mop
 * * liquids - Liquids which user try to absorb with the_mop
 */
/obj/item/reagent_containers/proc/attack_on_liquids_turf(obj/item/reagent_containers/my_beaker, turf/target_turf, mob/living/user, obj/effect/abstract/liquid_turf/liquids)
	if(user.combat_mode)
		return FALSE
	if(!my_beaker.spillable)
		return FALSE
	if(!user.Adjacent(target_turf))
		return FALSE
	if(liquids.fire_state) //Use an extinguisher first
		to_chat(user, span_warning("You can't scoop up anything while it's on fire!"))
		return TRUE
	if(liquids.height == 1)
		to_chat(user, span_warning("The puddle is too shallow to scoop anything up!"))
		return TRUE
	var/free_space = my_beaker.reagents.maximum_volume - my_beaker.reagents.total_volume
	if(free_space <= 0)
		to_chat(user, span_warning("You can't fit any more liquids inside [my_beaker]!"))
		return TRUE
	var/desired_transfer = my_beaker.amount_per_transfer_from_this
	if(desired_transfer > free_space)
		desired_transfer = free_space
	var/datum/reagents/tempr = liquids.take_reagents_flat(desired_transfer)
	tempr.trans_to(my_beaker.reagents, tempr.total_volume)
	to_chat(user, span_notice("You scoop up around [my_beaker.amount_per_transfer_from_this] units of liquids with [my_beaker]."))
	qdel(tempr)
	user.changeNext_move(CLICK_CD_MELEE)
	return TRUE
