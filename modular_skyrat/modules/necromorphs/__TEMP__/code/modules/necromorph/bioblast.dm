/*
	Bioblast is a type of explosion which is organic in origin, and focused on splashing things with acid.
	This here is a rough first draft, i would like in future to make acid eat through clothing
*/






//Reagent holders need a host atom. Lets cache one globally to save on constantly remaking them
GLOBAL_DATUM_INIT(bioblast_acid_holder, /obj/item, new)

/*
	Range can be decimal, it is a circular value. Diagonals require 1.4 range
*/
/proc/bioblast(var/atom/epicentre, var/power = 10, var/maxrange = 1, var/falloff_factor = 1)

	epicentre = get_turf(epicentre)	//Lets make sure we do this on a turf
	new /obj/effect/effect/bioblast(epicentre, 0.5 SECOND, maxrange)
	var/list/turfs = epicentre.turfs_in_view(Ceiling(maxrange))	//Find all the possible turfs in range

	//And narrow it to those actually in range, probably clipping off the corners of a square
	for (var/turf/T as anything in turfs)
		var/dist = get_dist_euclidian(epicentre, T)
		if (dist > maxrange)
			turfs.Remove(T)
			continue

		turfs[T] = dist	//Also record the distance, we'll use that in a sec

	//Now we'll affect the turfs
	for (var/turf/T as anything in turfs)
		//Power falls off with distance, the rate at which this happens is multiplied by falloff factor
		var/distance_reduction = turfs[T] * falloff_factor
		var/reduced_power = power / (1+distance_reduction)

		T.bioblast_act(reduced_power)

/datum/proc/bioblast_act(var/power = 1)
	return


/turf/bioblast_act(var/power = 1)
	for (var/atom/A in contents)
		A.bioblast_act(power)



//On living mobs, power is dealt as burn damage
/mob/living/bioblast_act(var/power = 1)
	if (is_necromorph())
		power *= NECROMORPH_FRIENDLY_FIRE_FACTOR	//Less friendly fire damage
	take_overall_damage(brute = 0, burn = power, used_weapon = "bioblast")


//For carbon mobs, half of the damage is dealt over time by dousing the victim in acid
/mob/living/carbon/bioblast_act(var/power = 1)
	var/acid_volume = (power*0.5) / NECROMORPH_ACID_POWER	//Figure out how many units of acid we need to deal half of the power in damage
	//var/atom/bioblast_acid_holder = new()
	var/datum/reagents/R = new(acid_volume, GLOB.bioblast_acid_holder)	//Populate this
	R.add_reagent(/datum/reagent/acid/necromorph, acid_volume, safety = TRUE)
	R.trans_to(src, R.total_volume)	//Apply acid to mob
	qdel(R)
	//Pass the remaining half of the power back to be dealt as ordinary burns
	.=..(power*0.5)


/atom/bioblast_act(var/power = 1)
	if (power >= BIOBLAST_TIER_1)
		ex_act(1)
	else if (power >= BIOBLAST_TIER_2)
		ex_act(2)
	else if (power >= BIOBLAST_TIER_3)
		ex_act(3)

/*
	Visual FX
*/
/obj/effect/effect/bioblast
	alpha = 255
	var/lifespan
	var/expansion_rate
	icon = 'icons/effects/96x96.dmi'
	icon_state = "bioblast"
	pixel_x = -32
	pixel_y = -32
	var/target_scale = 1


/obj/effect/effect/bioblast/New(var/atom/loc, var/_lifespan = 1 SECOND, var/radius = 1)
	//Lets figure out the desired scale. Since this is a 96x96 sprite, its 3x3 at 1 scale
	var/target_diameter = (radius*2)+1
	target_scale = target_diameter / 3
	lifespan = _lifespan
	..()

/obj/effect/effect/bioblast/Initialize()
	.=..()
	transform = transform.Scale(0.01)//Start off tiny
	transform = turn(transform, rand_between(0, 360))	//Random starting rotation
	var/matrix/M = new
	animate(src, transform = M.Scale(target_scale), alpha = 0, time = lifespan)
	QDEL_IN(src, lifespan)