//Moved from code/game/objects/structures/lattice.dm
/obj/structure/lattice/catwalk/Move()
	var/turf/T = loc
	if(isspaceturf(loc))
		for(var/obj/structure/cable/C in T)
			C.deconstruct()
	..()

/obj/structure/lattice/catwalk/deconstruct()
	var/turf/T = loc
	if(isspaceturf(loc))
		for(var/obj/structure/cable/C in T)
			C.deconstruct()
	..()
