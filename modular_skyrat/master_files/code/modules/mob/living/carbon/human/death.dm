// Pocket contents fly out when gibbed
/mob/living/carbon/human/gib(no_brain, no_organs, no_bodyparts, safe_gib = FALSE)
	if(safe_gib) // we are just going to drop everything regardless
		return ..()
	if(no_bodyparts) // don't drop any items when the mob is being reduced to a paste
		return ..()

	var/obj/item/left_pocket = l_store
	var/obj/item/right_pocket = r_store
	if(l_store)
		dropItemToGround(l_store, TRUE)
		left_pocket.throw_at(get_edge_target_turf(src, pick(GLOB.alldirs)), rand(1,3), 5)
	if(r_store)
		dropItemToGround(r_store, TRUE)
		right_pocket.throw_at(get_edge_target_turf(src, pick(GLOB.alldirs)), rand(1,3), 5)

	return ..()
