/obj/item/stack/catwalk
	name = "broken catwalk"
	singular_name = "broken catwalk"
	desc = "A broken catwalk. This should not exist."
	icon = 'modular_skyrat/modules/mapping/icons/obj/items/catwalk_item.dmi'
	icon_state = "catwalk"
	w_class = WEIGHT_CLASS_NORMAL
	force = 1
	throwforce = 1
	throw_speed = 3
	throw_range = 7
	max_amount = 60
	novariants = TRUE
	var/catwalk_type
	merge_type = /obj/item/stack/catwalk

/obj/item/stack/catwalk/normal
	name = "catwalk rods"
	singular_name = "catwalk rod"
	desc = "Rods that could be used to make a construction catwalk."
	icon_state = "catwalk_normal"
	catwalk_type = /obj/structure/lattice/catwalk
	merge_type = /obj/item/stack/catwalk/normal

/obj/item/stack/catwalk/plated
	name = "plated catwalk rods"
	singular_name = "plated catwalk rod"
	desc = "Rods that could be used to make a plated catwalk."
	icon_state = "catwalk_plated"
	catwalk_type = /obj/structure/lattice/catwalk/plated
	merge_type = /obj/item/stack/catwalk/plated

/obj/item/stack/catwalk/plated/dark
	name = "dark plated catwalk rods"
	singular_name = "dark plated catwalk rod"
	desc = "Rods that could be used to make a plated catwalk, with style."
	icon_state = "catwalk_plated_dark"
	catwalk_type = /obj/structure/lattice/catwalk/plated/dark
	merge_type = /obj/item/stack/catwalk/plated/dark

/obj/item/stack/catwalk/swarmer
	name = "swarmer catwalk rods"
	singular_name = "swarmer catwalk rod"
	desc = "Rods that could be used to make a quite peculiar catwalk."
	icon_state = "catwalk_swarmer"
	catwalk_type = /obj/structure/lattice/catwalk/swarmer_catwalk
	merge_type = /obj/item/stack/catwalk/swarmer

/turf/open
	var/can_be_latticed

/turf/open/attackby(obj/item/C, mob/user, params)
	if(istype(C, /obj/item/stack/catwalk))
		if(can_be_latticed)
			var/obj/item/stack/catwalk/catitem = C
			if(locate(/obj/structure/lattice/catwalk, src))
				return
			if(locate(/obj/structure/lattice/catwalk/plated, src))
				return
			if(locate(/obj/structure/lattice/catwalk/plated/dark, src))
				return
			var/cost = 2
			var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
			if(L)
				qdel(L)
				cost = 1
			if(catitem.use(cost))
				new catitem.catwalk_type(src)
				playsound(src, 'sound/weapons/genhit.ogg', 50, TRUE)
				to_chat(user, "<span class='notice'>You place down the catwalk.</span>")
			else
				to_chat(user, "<span class='warning'>You need two rods to build a catwalk!</span>")
			return
		to_chat(user, "<span class='warning'>You can't place down a catwalk in this spot!</span>")
	return ..()

/turf/open/space
	can_be_latticed = TRUE

/turf/open/openspace
	can_be_latticed = TRUE

/turf/open/floor/plating
	can_be_latticed = TRUE

/turf/open/transparent/openspace
	can_be_latticed = TRUE

/turf/open/floor/circuit
	can_be_latticed = TRUE
