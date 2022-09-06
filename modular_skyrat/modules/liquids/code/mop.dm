/**
 * The procedure for remove water from turf
 *
 * The object is called from liquid_interaction element.
 * The procedure check range of mop owner and tile, then check reagents in mop, if reagents volume < mop capacity - liquids absorbs from tile
 * In another way, input a chat about mop capacity
 * Arguments:
 * * the_mop - Mop what used to absorb liquids(???)
 * * tile - On which tile mop try absorb liquids
 * * user - Who try to absorb liquids with mop
 * * liquids - Liquids which user try to absorb with the_mop
 */
/obj/item/mop/proc/attack_on_liquids_turf(obj/item/mop/the_mop, turf/tile, mob/user, obj/effect/abstract/liquid_turf/liquids)
	if(!in_range(user, tile))
		return
	var/free_space = the_mop.reagents.maximum_volume - the_mop.reagents.total_volume
	if(free_space <= 0)
		to_chat(user, span_warning("Your mop can't absorb any more!"))
		return TRUE
	var/datum/reagents/tempr = liquids.take_reagents_flat(free_space)
	tempr.trans_to(the_mop.reagents, tempr.total_volume)
	to_chat(user, span_notice("You soak the mop with some liquids."))
	qdel(tempr)
	user.changeNext_move(CLICK_CD_MELEE)
	return TRUE
