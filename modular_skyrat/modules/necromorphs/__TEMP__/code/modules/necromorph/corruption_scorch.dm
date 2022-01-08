/*
	This simple extension prevents corruption from regrowing here until it fades away
*/
/datum/extension/scorched_earth
	flags = EXTENSION_FLAG_IMMEDIATE
	var/scorched_until
	var/turf/simulated/floor/earth


/datum/extension/scorched_earth/New(var/turf/simulated/floor/earth)

	//No scorching tiles which contain nodes
	if (locate(/obj/structure/corruption_node) in earth)
		qdel(src)

	.=..()
	src.earth = earth
	src.scorched_until = scorched_until
	addtimer(CALLBACK(src, /datum/extension/proc/remove_self), wait = CORRUPTION_SCORCH_DURATION)

	var/obj/effect/decal/scorch/scorch = new (earth)
	QDEL_IN(scorch, CORRUPTION_SCORCH_DURATION)
	animate(scorch, alpha = 0, time = CORRUPTION_SCORCH_DURATION)

	earth.incorruptible = TRUE

/datum/extension/scorched_earth/Destroy()
	if (earth)
		earth.incorruptible = FALSE
		GLOB.clarity_set_event.raise_event(earth)
	.=..()


/obj/effect/decal/scorch

	color = "#808080"
	anchored = TRUE
	icon = 'icons/turf/flooring/damage.dmi'
	icon_state = "burned1"

/obj/effect/decal/scorch/Initialize()
	.=..()
	layer = DECAL_LAYER
	icon_state = pick("burned1", "burned2")
	var/matrix/M = matrix()
	var/rotation = rand_between(0, 360)	//Randomly rotate it
	transform = turn(M, rotation)

//When deleted, let nearby vines know this turf is safe to spread into
/obj/effect/decal/scorch/Destroy()

	.=..()