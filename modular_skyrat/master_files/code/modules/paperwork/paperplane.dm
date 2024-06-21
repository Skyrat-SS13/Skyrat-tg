// Better paper planes
/obj/item/paperplane/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(delete_on_impact)
		qdel(src)
