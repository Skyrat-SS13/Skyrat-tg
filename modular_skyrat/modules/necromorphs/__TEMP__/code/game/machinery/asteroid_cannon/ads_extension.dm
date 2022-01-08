
/datum/extension/asteroidcannon
	var/obj/structure/asteroidcannon/gun = null
	var/mob/living/carbon/human/gunner = null
	var/mob/dead/observer/eye/turret/eyeobj = null
	var/datum/click_handler/gun/tracked/TCH
	flags = EXTENSION_FLAG_IMMEDIATE


/datum/extension/asteroidcannon/Process()
	if(gunner)
		if(gun.is_firing()) //We've got a gunner, don't fire.
			handle_manual_fire()
			return
	else
		if(!LAZYLEN(GLOB.asteroids))
			return PROCESS_KILL//Nothing to shoot at

		if (gun?.operational)
			handle_auto_fire()
		else
			gun.unset_target()	//Unset so we're not preventing some poor meteor from GCing
			return PROCESS_KILL//Nonfunctional




/datum/extension/asteroidcannon/proc/handle_manual_fire()
	gun.fire_at(gun.target)


/datum/extension/asteroidcannon/proc/handle_auto_fire()
	//Meteor targeting!
	if (!is_valid_meteor(gun.target))

		var/obj/effect/meteor/M = get_valid_meteor()
		if (!M)
			return
		gun.set_target(M)

	gun.fire_at(gun.target)

/datum/extension/asteroidcannon/proc/get_valid_meteor()
	for (var/obj/effect/meteor/M as anything in GLOB.asteroids)
		if (is_valid_meteor(M))
			return M

	return null

/datum/extension/asteroidcannon/proc/is_valid_meteor(var/obj/effect/meteor/M)
	if (QDELETED(M))
		return FALSE
	if (!istype(M))
		return FALSE
	if (!isturf(M.loc))
		return FALSE
	if (abs(gun.rotator.get_total_rotation_to_target(M)) > gun.firing_arc)
		return FALSE	//Out of our firing arc

	return TRUE

/datum/extension/asteroidcannon/proc/target_click(var/mob/user, var/atom/target, var/params)
	gun.fire_at(get_turf(target))


/**
	Sets up the cannon for manual aiming, removes the autofire ability.
*/
/datum/extension/asteroidcannon/proc/set_gunner(mob/living/carbon/human/gunner)
	if(src.gunner)
		remove_gunner()
	src.gunner = gunner
	add_verb(gunner, list(/mob/living/carbon/human/proc/stop_gunning, /mob/living/carbon/human/proc/recenter_gunning))
	gunner.forceMove(gun)
	gunner.pixel_x = (-gun.pixel_x)+4
	gunner.pixel_y = (-gun.pixel_y)+12
	gunner.set_dir(EAST)
	TCH = gunner.PushClickHandler(/datum/click_handler/gun/tracked/asteroidcannon)
	TCH.reciever = gun

	//This is vital to make drawing work right
	gun.cached_plane = gunner.plane
	gunner.plane = gun.plane

	//The gunner must be an overlay, not in vis contents, in order to smoothly rotate with the gun
	gun.overlays += gunner
	//gunner.vis_flags |= VIS_INHERIT_ID
	//gun.vis_contents += gunner
	gun.lead_distance = 1 //Gunners don't get hitscan...
	gunner.set_eyeobj(new /mob/dead/observer/eye/turret(get_turf(gun)))
	gunner.eyeobj.acceleration = FALSE
	gunner.eyeobj.possess(gunner, gun)	//Pass in the gun with possess

	wake_up()

/datum/extension/asteroidcannon/proc/recenter()
	eyeobj?.setLoc(get_turf(gun))

/datum/extension/asteroidcannon/proc/remove_gunner()
	if (eyeobj)
		qdel(eyeobj)
	if (TCH)
		qdel(TCH)
	gun.lead_distance = initial(gun.lead_distance) //Gunners don't get hitscan...
	if (gunner)
		remove_verb(gunner, list(/mob/living/carbon/human/proc/stop_gunning, /mob/living/carbon/human/proc/recenter_gunning))
		gunner.eyeobj = null
		gunner.update_vision_range()
		gun.overlays.Cut()
		gunner.plane = gun.cached_plane
		gunner.forceMove(get_turf(gun))
		gunner.animate_to_default()
		gunner = null

/datum/extension/asteroidcannon/New(datum/holder)
	if(!istype(holder, /obj/structure/asteroidcannon))
		return FALSE
	gun = holder
	wake_up()




/datum/extension/asteroidcannon/proc/wake_up()
	if (!is_processing)
		START_PROCESSING(SSfastprocess, src)
