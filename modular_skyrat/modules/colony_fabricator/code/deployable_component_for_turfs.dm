/datum/component/deployable/for_turfs

/datum/component/deployable/for_turfs/deploy(obj/source, mob/user, location, direction) //If there's no user, location and direction are used
	// The object we are going to create
	var/atom/deployed_object
	// The turf our object is going to be deployed to
	var/turf/deploy_location
	// What direction will the deployed object be placed facing
	var/new_direction

	if(user)
		deploy_location = get_step(user, user.dir) //Gets spawn location for thing_to_be_deployed if there is a user
		if(deploy_location.is_blocked_turf(TRUE, parent))
			source.balloon_alert(user, "insufficient room to deploy here.")
			return
		new_direction = user.dir //Gets the direction for thing_to_be_deployed if there is a user
		source.balloon_alert(user, "deploying...")
		playsound(source, 'sound/items/ratchet.ogg', 50, TRUE)
		if(!do_after(user, deploy_time))
			return
	else // If there is for some reason no user, then the location and direction are set here
		deploy_location = location
		new_direction = direction

	if(!isturf(thing_to_be_deployed))
		deployed_object = new thing_to_be_deployed(deploy_location)
		deployed_object.setDir(new_direction)
	else
		deploy_location.place_on_top(thing_to_be_deployed)

	// Sets the direction of the resulting object if the variable says to
	if(direction_setting)
		deployed_object.update_icon_state()

	deployments -= 1

	if(!multiple_deployments || deployments < 1)
		qdel(source)
