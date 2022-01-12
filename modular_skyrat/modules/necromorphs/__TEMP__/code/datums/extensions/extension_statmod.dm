/*
	Extension statmod system:
	To prevent cumulative math errors, extensions must use this system to modify any commonly shared attributes on a mob. This currently includes:

	To set a mod, just add DEFINE = value to the statmods list on the extension.
	If you change the contents of that list during runtime, call unregister_statmods before the change, then register_statmods after

	Name:								Define:									Expected Value
	Movespeed (additive)				STATMOD_MOVESPEED_ADDITIVE				A percentage value, 0=no change, 1 = +100%, etc. Negative allowed
	Movespeed (multiplicative)			STATMOD_MOVESPEED_MULTIPLICATIVE		A multiplier. 1 = no change, 2 = double, etc. Must be > 0
	Incoming Damage						STATMOD_INCOMING_DAMAGE_MULTIPLICATIVE	A multiplier. 1 = no change, 2 = double, etc. Must be > 0
	Ranged Accuracy						STATMOD_RANGED_ACCURACY					A flat number of percentage points
	Vision Range						STATMOD_VIEW_RANGE					An integer number of tiles to add/remove from vision range
	Evasion								STATMOD_EVASION							An number of percentage points which will be additively added to evasion, negative allowed
	Scale								STATMOD_SCALE							A percentage value, 0=no change, 1 = +100%, etc. Negative allowed
	Max Health							STATMOD_HEALTH							A flat value which is added or removed
	Conversion Compatibility			STATMOD_CONVERSION_COMPATIBILITY			A flat value which is added or removed
	Layer								STATMOD_LAYER							A flat value, the highest one is used and all others are ignored. Note that any specified value, even if lower, will override the base layer
*/



//This list is in the following format:
//Define = list (update_proc)
GLOBAL_LIST_INIT(statmods, list(
STATMOD_MOVESPEED_ADDITIVE = list(/datum/proc/update_movespeed_factor),
STATMOD_MOVESPEED_MULTIPLICATIVE = list(/datum/proc/update_movespeed_factor),
STATMOD_INCOMING_DAMAGE_MULTIPLICATIVE = list(/datum/proc/update_incoming_damage_factor),
STATMOD_RANGED_ACCURACY = list(/datum/proc/update_ranged_accuracy_factor),
STATMOD_ATTACK_SPEED = list(/datum/proc/update_attack_speed),
STATMOD_EVASION = list(/datum/proc/update_evasion),
STATMOD_VIEW_RANGE = list(/datum/proc/update_vision_range),
STATMOD_SCALE	=	list(/datum/proc/update_scale),
STATMOD_HEALTH	=	list(/datum/proc/update_max_health),
STATMOD_LAYER	=	list(/datum/proc/reset_layer)
//Conversion compatibility doesn't get an entry here, its only used by infector conversions
))

/datum/extension
	var/auto_register_statmods = TRUE
	var/list/statmods = null

/datum/extension/proc/register_statmods(var/update = TRUE)
	for (var/modtype in statmods)
		register_statmod(modtype, update)

/datum/extension/proc/unregister_statmods()
	for (var/modtype in statmods)
		unregister_statmod(modtype)

//Trigger all relevant update procs without changing registration
/datum/extension/proc/update_statmods()
	var/mob/M = holder
	if (!istype(M))
		return
	for (var/modtype in statmods)
		var/list/data = GLOB.statmods[modtype]
		var/update_proc = data[1]
		call(M, update_proc)()

/datum/extension/proc/register_statmod(var/modtype, var/update = TRUE)
	//Currently only supported for mobs
	var/mob/M = holder
	if (!istype(M))
		return


	//Initialize the list
	if (!LAZYACCESS(M.statmods, modtype))
		//This will create the statmods list AND insert a key/value pair for modtype/list()
		LAZYASET(M.statmods, modtype, list())

	LAZYDISTINCTADD(M.statmods[modtype], src)

	//Now lets make them update
	if (update)
		var/list/data = GLOB.statmods[modtype]
		var/update_proc = data[1]
		call(M, update_proc)()//And call it

/datum/extension/proc/unregister_statmod(var/modtype)
	//Currently only supported for mobs
	var/mob/M = holder
	if (!istype(M))
		return

	//If it doesn't exist we dont need to do anything
	if (!LAZYACCESS(M.statmods, modtype))
		return



	LAZYAMINUS(M.statmods,modtype, src)
	//Now lets make them update
	var/list/data = GLOB.statmods[modtype]
	var/update_proc = data[1]
	call(M, update_proc)()//And call it


/datum/extension/proc/get_statmod(var/modtype)
	return LAZYACCESS(statmods, modtype)


/*
	Movespeed
*/
/datum/proc/update_movespeed_factor()

/mob/update_movespeed_factor()
	move_speed_factor = 1

	//We add the result of each additive modifier
	for (var/datum/extension/E as anything in LAZYACCESS(statmods, STATMOD_MOVESPEED_ADDITIVE))
		move_speed_factor += E.get_statmod(STATMOD_MOVESPEED_ADDITIVE)

	//We multiply by the result of each multiplicative modifier
	for (var/datum/extension/E as anything in LAZYACCESS(statmods, STATMOD_MOVESPEED_MULTIPLICATIVE))
		move_speed_factor *= E.get_statmod(STATMOD_MOVESPEED_MULTIPLICATIVE)



/*
	Incoming Damage
*/
//Additive modifiers first, then multiplicative
/datum/proc/update_incoming_damage_factor()

/mob/living/update_incoming_damage_factor()
	incoming_damage_mult = 1

	//We multiply by the result of each multiplicative modifier
	for (var/datum/extension/E as anything in LAZYACCESS(statmods, STATMOD_INCOMING_DAMAGE_MULTIPLICATIVE))
		incoming_damage_mult *= E.get_statmod(STATMOD_INCOMING_DAMAGE_MULTIPLICATIVE)



/*
	Ranged Accuracy
*/
/datum/proc/update_ranged_accuracy_factor()

/mob/living/update_ranged_accuracy_factor()
	ranged_accuracy_modifier = 0

	//We multiply by the result of each multiplicative modifier
	for (var/datum/extension/E as anything in LAZYACCESS(statmods, STATMOD_RANGED_ACCURACY))
		ranged_accuracy_modifier += E.get_statmod(STATMOD_RANGED_ACCURACY)


/*
	attackspeed
*/
/datum/proc/update_attack_speed()

/mob/living/update_attack_speed()
	attack_speed_factor = 1

	//We multiply by the result of each multiplicative modifier
	for (var/datum/extension/E as anything in LAZYACCESS(statmods, STATMOD_ATTACK_SPEED))
		attack_speed_factor += E.get_statmod(STATMOD_ATTACK_SPEED)



/*
	Evasion
*/
/datum/proc/update_evasion()

/mob/living/update_evasion()
	evasion = get_base_evasion()

	//We multiply by the result of each multiplicative modifier
	for (var/datum/extension/E as anything in LAZYACCESS(statmods, STATMOD_EVASION))
		evasion += E.get_statmod(STATMOD_EVASION)



/datum/proc/get_base_evasion()
	return 0

/mob/living/get_base_evasion()
	return initial(evasion)


/mob/living/carbon/human/get_base_evasion()
	return species.evasion





/*
	Vision Range
*/
/datum/proc/update_vision_range()

/datum/proc/get_base_view_range()
	return world.view

/mob/living/get_base_view_range()
	if (eyeobj)
		return eyeobj.get_base_view_range()
	return initial(view_range)

/mob/dead/observer/eye/get_base_view_range()
	return initial(view_range)

/mob/living/carbon/human/get_base_view_range()
	if (eyeobj)
		return eyeobj.get_base_view_range()
	return species.view_range


/mob/update_vision_range()
	var/range = get_base_view_range()

	//We multiply by the result of each multiplicative modifier
	for (var/datum/extension/E as anything in LAZYACCESS(statmods, STATMOD_VIEW_RANGE))
		range += E.get_statmod(STATMOD_VIEW_RANGE)

	//Vision range can't go below 1
	range = clamp(range, 1, INFINITY)

	view_range = range
	if (client)
		client.change_view(view_range)




/*
	Scale

	Controls the visible sprite size of the thing.
*/

/datum/proc/update_scale()
	return

//The speed var controls how fast we visibly transition scale, it is in cubic volume units per second
/atom/update_scale(var/speed = 0.3)
	var/old_scale = default_scale
	default_scale = get_base_scale()
	for (var/datum/extension/E as anything in LAZYACCESS(statmods, STATMOD_SCALE))
		default_scale += E.get_statmod(STATMOD_SCALE)

	//We're going to do a smooth transition to the new scale

	//Lets get the difference in the volume between these shapes
	var/volume_difference = abs(default_scale**3 - old_scale**3)
	var/time_required	=	(volume_difference / speed)	SECONDS	//This define converts it to deciseconds

	//Do the animation
	animate_to_default(time_required)

	if (ishuman(src))
		var/mob/living/carbon/human/H = src
		spawn(time_required)
			H.update_icons()	//This will adjust pixel offsets to fit our new size

/datum/proc/get_base_scale()

/atom/get_base_scale()
	return 1.0




/*
	Health:
	The max health of this mob, how much damage it can take before dying

	Currently only meaningful for necromorphs and animals. Won't do much for non-necro humans because brainmed
*/

/datum/proc/update_max_health()
	return

/mob/living/update_max_health()
	max_health = get_base_health()
	for (var/datum/extension/E as anything in LAZYACCESS(statmods, STATMOD_HEALTH))
		max_health += E.get_statmod(STATMOD_HEALTH)

	updatehealth()

/datum/proc/get_base_health()

/mob/living/get_base_health()
	return max(initial(health), initial(max_health))

/mob/living/carbon/human/get_base_health()
	return species.total_health



//Layer

//Layer is an atomic property so the datum procs are stubs
/datum/proc/reset_layer()

/atom/reset_layer()
	var/newlayer = get_base_layer()
	var/modified_layer
	for (var/datum/extension/E as anything in LAZYACCESS(statmods, STATMOD_LAYER))
		var/value = E.get_statmod(STATMOD_LAYER)
		if (isnull(modified_layer) || value > modified_layer)
			modified_layer = value

	layer = (modified_layer ? modified_layer : newlayer)


/mob/reset_layer()
	var/newlayer
	if(lying)
		newlayer = get_base_lying_layer()
	else
		newlayer = get_base_layer()

	var/modified_layer
	for (var/datum/extension/E as anything in LAZYACCESS(statmods, STATMOD_LAYER))
		var/value = E.get_statmod(STATMOD_LAYER)
		if (isnull(modified_layer) || value > modified_layer)
			modified_layer = value

	layer = (modified_layer ? modified_layer : newlayer)





/datum/proc/get_base_layer()

/atom/get_base_layer()
	return initial(layer)


/mob/proc/get_base_lying_layer()
	return LYING_MOB_LAYER



/mob/living/carbon/human/get_base_layer()
	return species.layer

/mob/living/carbon/human/get_base_lying_layer()
	return species.layer_lying


//Legacy use, maybe needs refactoring, although we don't usually change planes on atoms anymore
/atom/proc/reset_plane_and_layer()
	plane = initial(plane)
	reset_layer()