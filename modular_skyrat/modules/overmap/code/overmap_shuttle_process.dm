/datum/overmap_object/shuttle/process(delta_time)
	//Resolve lock
	if(lock)
		lock.Resolve()

	//Process target commands
	if(lock) //Lock needs to be checked again as Resolve() may delete and null it
		switch(target_command)
			if(TARGET_FIRE_ONCE, TARGET_KEEP_FIRING)
				if(!length(weapon_extensions) || !(lock.target.overmap_flags & OV_CAN_BE_ATTACKED))
					target_command = TARGET_IDLE
				else
					for(var/i in weapon_extensions)
						var/datum/shuttle_extension/weapon/weapon_extension = i
						if(weapon_extension.CanFire(lock.target))
							weapon_extension.Fire(lock.target)
					if(target_command == TARGET_FIRE_ONCE)
						target_command = TARGET_IDLE
			if(TARGET_BEAM_ON_BOARD)
				if(!(lock.target.overmap_flags & OV_CAN_BE_TRANSPORTED) && !CapableOfTransporting())
					target_command = TARGET_IDLE
				else
					var/datum/shuttle_extension/transporter/transp_in_use = GetTransporter()
					transp_in_use.ProcessTransport()

	else if (target_command != TARGET_IDLE)
		//No lock and not an idle command
		target_command = TARGET_IDLE

	//Process shields
	for(var/i in shield_extensions)
		var/datum/shuttle_extension/shield/shield = i
		shield.process(delta_time)

	//Process helm command
	var/icon_state_to_update_to = SHUTTLE_ICON_IDLE
	if(shuttle_capability & SHUTTLE_CAN_USE_ENGINES)
		switch(helm_command)
			if(HELM_MOVE_TO_DESTINATION)
				if(x == destination_x && y == destination_y)
					StopMove()
				else
					var/target_angle = ATAN2(((destination_y*32)-((y*32)+partial_y)),((destination_x*32)-((x*32)+partial_x)))

					if(target_angle < 0)
						target_angle = 360 + target_angle

					var/my_angle = angle
					if(my_angle < 0)
						my_angle = 360 + my_angle

					var/diff = target_angle - my_angle

					var/left_turn = FALSE
					if(diff < 0)
						diff += 360
					if(diff > 180)
						diff = 360 - diff
						left_turn = TRUE


					if(!(diff < 3))
						if(left_turn)
							angle -= min(diff,10)
						else
							angle += min(diff,10)

					if(angle > 180)
						angle -= 360
					else if (angle < -180)
						angle += 360

					var/target_angle_in_byond_rad = target_angle
					if(target_angle > 180)
						target_angle_in_byond_rad -= 360

					var/vector_len = VECTOR_LENGTH(velocity_x, velocity_y)
					var/speed_cap = GetCapSpeed()
					if(diff < 180 && vector_len < speed_cap)
						var/drawn_thrust = DrawThrustFromAllEngines()
						if(drawn_thrust)
							var/added_velocity_x = drawn_thrust * sin(target_angle_in_byond_rad)
							var/added_velocity_y = drawn_thrust * cos(target_angle_in_byond_rad)

							if(diff > 10)
								var/angle_multiplier = 1-(diff/360)
								added_velocity_x *= angle_multiplier
								added_velocity_y *= angle_multiplier

							velocity_x += added_velocity_x
							velocity_y += added_velocity_y

							icon_state_to_update_to = SHUTTLE_ICON_FORWARD
					else if (vector_len > speed_cap + SHUTTLE_SLOWDOWN_MARGIN)
						if(velocity_y)
							velocity_y *= 0.8
							icon_state_to_update_to = SHUTTLE_ICON_BACKWARD
						if(velocity_x)
							velocity_x *= 0.8
							icon_state_to_update_to = SHUTTLE_ICON_BACKWARD
					else
						icon_state_to_update_to = SHUTTLE_ICON_FORWARD

			if(HELM_FULL_STOP)
				if(!velocity_x && !velocity_y)
					helm_command = HELM_IDLE
				else //Lazy
					if(velocity_y)
						velocity_y *= 0.7
						icon_state_to_update_to = SHUTTLE_ICON_BACKWARD
					if(velocity_x)
						velocity_x *= 0.7
						icon_state_to_update_to = SHUTTLE_ICON_BACKWARD

	//Update icon based on the helm actions
	var/obj/effect/abstract/overmap/shuttle/shuttle_visual = my_visual
	switch(icon_state_to_update_to)
		if(SHUTTLE_ICON_IDLE)
			shuttle_visual.icon_state = shuttle_visual.shuttle_idle_state
		if(SHUTTLE_ICON_FORWARD)
			shuttle_visual.icon_state = shuttle_visual.shuttle_forward_state
		if(SHUTTLE_ICON_BACKWARD)
			shuttle_visual.icon_state = shuttle_visual.shuttle_backward_state

	//Do velocity processing
	if(velocity_x || velocity_y)
		var/velocity_length = VECTOR_LENGTH(velocity_x, velocity_y)
		if(velocity_length < SHUTTLE_MINIMUM_VELOCITY)
			velocity_x = 0
			velocity_y = 0
		else
			//"Friction"
			velocity_x *= 0.95
			velocity_y *= 0.95

			var/add_partial_x = velocity_x
			var/add_partial_y = velocity_y

			partial_x += add_partial_x
			partial_y += add_partial_y

			ProcessPartials()
		update_perceived_parallax()
		if(transit_instance)
			transit_instance.ApplyVelocity(REVERSE_DIR(current_parallax_dir), velocity_length)

	//Update rotation
	if(uses_rotation)
		var/matrix/M = new
		M.Turn(angle)
		my_visual.transform = M
