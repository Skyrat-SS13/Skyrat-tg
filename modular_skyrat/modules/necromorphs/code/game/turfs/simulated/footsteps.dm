#define FOOTSTEP_CARPET 	"carpet"
#define FOOTSTEP_TILES 		"tiles"
#define FOOTSTEP_PLATING 	"plating"
#define FOOTSTEP_WOOD 		"wood"
#define FOOTSTEP_ASTEROID 	"asteroid"
#define FOOTSTEP_GRASS 		"grass"
#define FOOTSTEP_WATER		"water"
#define FOOTSTEP_BLANK		"blank"
#define FOOTSTEP_CATWALK	"catwalk"
#define FOOTSTEP_LAVA		"lava"

/turf/simulated/floor/var/global/list/footstep_sounds = list(
	FOOTSTEP_WOOD = list(
		'sound/effects/footstep/wood1.ogg',
		'sound/effects/footstep/wood2.ogg',
		'sound/effects/footstep/wood3.ogg',
		'sound/effects/footstep/wood4.ogg',
		'sound/effects/footstep/wood5.ogg'),
	FOOTSTEP_TILES = list(
		'sound/effects/footstep/floor1.ogg',
		'sound/effects/footstep/floor2.ogg',
		'sound/effects/footstep/floor3.ogg',
		'sound/effects/footstep/floor4.ogg',
		'sound/effects/footstep/floor5.ogg'),
	FOOTSTEP_PLATING =  list(
		'sound/effects/footstep/plating1.ogg',
		'sound/effects/footstep/plating2.ogg',
		'sound/effects/footstep/plating3.ogg',
		'sound/effects/footstep/plating4.ogg',
		'sound/effects/footstep/plating5.ogg'),
	FOOTSTEP_CARPET = list(
		'sound/effects/footstep/carpet1.ogg',
		'sound/effects/footstep/carpet2.ogg',
		'sound/effects/footstep/carpet3.ogg',
		'sound/effects/footstep/carpet4.ogg',
		'sound/effects/footstep/carpet5.ogg'),
	FOOTSTEP_ASTEROID = list(
		'sound/effects/footstep/asteroid1.ogg',
		'sound/effects/footstep/asteroid2.ogg',
		'sound/effects/footstep/asteroid3.ogg',
		'sound/effects/footstep/asteroid4.ogg',
		'sound/effects/footstep/asteroid5.ogg'),
	FOOTSTEP_GRASS = list(
		'sound/effects/footstep/grass1.ogg',
		'sound/effects/footstep/grass2.ogg',
		'sound/effects/footstep/grass3.ogg',
		'sound/effects/footstep/grass4.ogg'),
	FOOTSTEP_WATER = list(
		'sound/effects/footstep/water1.ogg',
		'sound/effects/footstep/water2.ogg',
		'sound/effects/footstep/water3.ogg',
		'sound/effects/footstep/water4.ogg'),
	FOOTSTEP_LAVA = list(
		'sound/effects/footstep/lava1.ogg',
		'sound/effects/footstep/lava2.ogg',
		'sound/effects/footstep/lava3.ogg'),
	FOOTSTEP_BLANK = list(
		'sound/effects/footstep/blank.ogg')
)

/decl/flooring/var/footstep_type
/decl/flooring/footstep_type = FOOTSTEP_BLANK
/decl/flooring/carpet/footstep_type = FOOTSTEP_CARPET
/decl/flooring/tiling/footstep_type = FOOTSTEP_TILES
/decl/flooring/linoleum/footstep_type = FOOTSTEP_TILES
/decl/flooring/wood/footstep_type = FOOTSTEP_WOOD
/decl/flooring/reinforced/footstep_type = FOOTSTEP_PLATING

//ds13 sounds
/decl/flooring/tiling_ds/footstep_type = FOOTSTEP_TILES

/turf/simulated/floor/proc/get_footstep_sound()
	if(is_plating())
		return safepick(footstep_sounds[FOOTSTEP_PLATING])
	else if(!flooring || !flooring.footstep_type)
		return safepick(footstep_sounds[FOOTSTEP_BLANK])
	else
		return safepick(footstep_sounds[flooring.footstep_type])

/turf/simulated/floor/asteroid/get_footstep_sound()
	return safepick(footstep_sounds[FOOTSTEP_ASTEROID])

/turf/simulated/floor/exoplanet/get_footstep_sound()
	return safepick(footstep_sounds[FOOTSTEP_CARPET])

/turf/simulated/floor/exoplanet/grass/get_footstep_sound()
	return safepick(footstep_sounds[FOOTSTEP_GRASS])

/turf/simulated/floor/exoplanet/water/shallow/get_footstep_sound()
	return safepick(footstep_sounds[FOOTSTEP_WATER])

/turf/simulated/floor/fixed/get_footstep_sound()
	return safepick(footstep_sounds[FOOTSTEP_PLATING])

/turf/simulated/floor/Entered(var/mob/living/carbon/human/H)
	..()
	if(istype(H))
		H.step_count += H.move_intent?.step_value
		H.handle_footsteps()


/datum/species/var/silent_steps
/datum/species/nabber/silent_steps = 1

/mob/living/carbon/human
	var/step_count
	var/step_interval	=	2 //We make a footstep sound every time we reach this

/mob/living/carbon/human/proc/handle_footsteps()
	var/turf/simulated/floor/T = get_turf(src)
	if(!istype(T))
		return

	if(buckled || lying || throwing)
		return //people flying, lying down or sitting do not step

	if (pass_flags & PASS_FLAG_FLYING)
		return	//No footstep sounds if we aren't touching the ground

	if(species.silent_steps)
		return //species is silent

	if(shoes && (shoes.item_flags & ITEM_FLAG_SILENT))
		return // quiet shoes

	if(step_count < step_interval)
		return
	step_count = 0

	if(move_intent.flags & MOVE_INTENT_SILENT)
		return

	//Nanako's Priority based footstep system.
	//All structures, floors, and species have a step priority var.
	//When determining which one gets to choose the footstep sound, highest value wins.
	//In case of equal values, species > structure > floor
	//Also heavily optimised an awful structure loop here
	var/footsound
	var/best_priority = 0

	if (species.step_priority > best_priority)
		//Note: Species step priority should be set to zero when that species doesn't have any species-specific footstep sounds
		footsound = get_species_audio(SOUND_FOOTSTEP)
		best_priority = species.step_priority

	for(var/obj/structure/S as anything in T.step_structures)
		if (S.step_priority > best_priority)
			best_priority = S.step_priority
			footsound = S.get_footstep_sound()

	if(T.step_priority > best_priority)
		best_priority = T.step_priority
		footsound = T.get_footstep_sound()
	if(footsound)

		var/range = species.step_range//-(world.view - 2)
		var/volume = species.step_volume

		if(MOVING_DELIBERATELY(src))
			volume -= 20
			range -= 1
		if(shoes)
			volume += shoes.step_volume
			range += shoes.step_range

		playsound(T, footsound, volume, 1, range)
