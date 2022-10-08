/*
*	Looping sound for vibrating stuff
*/

/datum/looping_sound/vibrator
	start_sound = 'modular_skyrat/modules/modular_items/lewd_items/sounds/bzzz-loop-1.ogg'
	start_length = 1
	mid_sounds = 'modular_skyrat/modules/modular_items/lewd_items/sounds/bzzz-loop-1.ogg'
	mid_length = 1
	end_sound = 'modular_skyrat/modules/modular_items/lewd_items/sounds/bzzz-loop-1.ogg'
	falloff_distance = 1
	falloff_exponent = 5
	extra_range = SILENCED_SOUND_EXTRARANGE
	ignore_walls = FALSE

/datum/looping_sound/vibrator/low
	volume = 80

/datum/looping_sound/vibrator/medium
	volume = 90

/datum/looping_sound/vibrator/high
	volume = 100

/*
*	Dancing pole code.
*/

/atom
	var/pseudo_z_axis

/atom/proc/get_fake_z()
	return pseudo_z_axis

/obj/structure/table
	pseudo_z_axis = 8

/turf/open/get_fake_z()
	var/objschecked
	for(var/obj/structure/structurestocheck in contents)
		objschecked++
		if(structurestocheck.pseudo_z_axis)
			return structurestocheck.pseudo_z_axis
		if(objschecked >= 25)
			break
	return pseudo_z_axis

/mob/living/Move(atom/newloc, direct)
	. = ..()
	if(.)
		pseudo_z_axis = newloc.get_fake_z()
		pixel_z = pseudo_z_axis

/// Used to add a cum decal to the floor while transferring viruses and DNA to it
/mob/living/proc/add_cum_splatter_floor(turf/the_turf, female = FALSE)
	if(!the_turf)
		the_turf = get_turf(src)

	var/selected_type = female ? /obj/effect/decal/cleanable/cum/femcum : /obj/effect/decal/cleanable/cum
	var/atom/stain = new selected_type(the_turf, get_static_viruses())

	stain.transfer_mob_blood_dna(src) //I'm not adding a new forensics category for cumstains
