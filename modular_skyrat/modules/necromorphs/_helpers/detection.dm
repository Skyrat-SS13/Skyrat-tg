/atom/proc/get_turf_at_offset(var/vector2/offset)
	return locate(x + offset.x, y + offset.y, z)

/proc/get_aiming_height(var/mob/user, var/mob/living/carbon/human/target)
	if (!user)
		return GLOB.organ_altitudes[BP_CHEST]

	var/aiming_zone = get_zone_sel(user)
	if (istype(target))

		//We will do substitutions of course
		//But we won't run find_target_organ, we will allow things to be aimed at already-severed limbs
		if (target.species.organ_substitutions[aiming_zone])
			aiming_zone = target.species.organ_substitutions[aiming_zone]


		//Get the list of data, this contains typepath and height vector
		var/list/organ_data = target.species.has_limbs[aiming_zone]

		//Check that the data exists
		if(organ_data["height"])
			//This is a vector range, we'll average it out
			return Vector2.VectorAverage(organ_data["height"])

	else
		//No human target, get whatever we're aiming towards if it were human
		return GLOB.organ_altitudes[aiming_zone]
