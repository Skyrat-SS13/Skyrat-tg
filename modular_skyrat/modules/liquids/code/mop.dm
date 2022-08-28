/obj/item/mop/proc/attack_on_liquids_turf(obj/item/mop/the_mop, turf/tile, mob/user, obj/effect/abstract/liquid_turf/liquids)
	if(!in_range(user, tile))
		return
	var/free_space = the_mop.reagents.maximum_volume - the_mop.reagents.total_volume
	if(free_space <= 0)
		to_chat(user, "<span class='warning'>Your mop can't absorb any more!</span>")
		return TRUE
	var/datum/reagents/tempr = liquids.take_reagents_flat(free_space)
	tempr.trans_to(the_mop.reagents, tempr.total_volume)
	to_chat(user, "<span class='notice'>You soak the mop with some liquids.</span>")
	qdel(tempr)
	user.changeNext_move(CLICK_CD_MELEE)
	return TRUE
