// Make disposal pipes hurt you if you ride them.

/obj/structure/disposalpipe
	/// Whether a disposal pipe will hurt if a person changes direction. `FALSE` for hurting, `TRUE` to prevent making them hurt.
	var/padded_corners = FALSE

/obj/structure/disposalpipe/transfer_to_dir(obj/structure/disposalholder/holder, nextdir)
	. = ..(holder, nextdir)
	var/obj/structure/disposalpipe/next_pipe = .

	if(!next_pipe || dir == next_pipe.dir || padded_corners)
		return

	if(!prob(20))
		return

	for(var/objects_within in holder.contents)
		if(!isliving(objects_within))
			continue
		var/mob/living/living_within = objects_within
		if(living_within.stat == DEAD)
			continue
		if(HAS_TRAIT(living_within, TRAIT_TRASHMAN))
			continue
		living_within.adjustBruteLoss(5)
