/datum/overmap_object/projectile
	name = "projectile"
	visual_type = /obj/effect/abstract/overmap/projectile
	overmap_process = TRUE
	overmap_flags = NONE
	/// Parent of the projectile, used for avoiding it
	var/datum/overmap_object/parent
	/// Target of the projectile, used for homing
	var/datum/overmap_object/target
	/// Whether it does avoid the parent
	var/avoids_parent = TRUE
	/// Whether it is homing on the target
	var/homing_on_target = TRUE
	/// Whether it only hits the target, or can hit things that get inbetween
	var/only_hits_target = TRUE
	/// Vector velocity of the projectile
	var/speed = 5
	/// Maximum distance in pixels (32 per tile)
	var/max_distance = 64
	var/distance_so_far = 0

	var/absolute_dest_x = 0
	var/absolute_dest_y = 0

	var/last_angle

	var/visual_rotation = TRUE

/datum/overmap_object/projectile/New(datum/overmap_sun_system/passed_system, x_coord, y_coord, part_x, part_y, passed_parent, passed_target)
	. = ..()
	partial_x = part_x
	partial_y = part_y
	UpdateVisualOffsets()
	if(passed_parent)
		parent = passed_parent
		RegisterSignal(parent, COMSIG_PARENT_QDELETING, .proc/LoseParent)
	//Target currently needs to be passed
	target = passed_target
	RegisterSignal(target, COMSIG_PARENT_QDELETING, .proc/LoseTarget)

	absolute_dest_x = (target.x * 32) + target.partial_x
	absolute_dest_y = (target.y * 32) + target.partial_y

	UpdateAngle()

/datum/overmap_object/projectile/proc/UpdateAngle()
	var/absolute_pos_x = (x*32)+partial_x
	var/aboslute_pos_y = (y*32)+partial_y
	var/target_angle = ATAN2((absolute_dest_y-aboslute_pos_y),(absolute_dest_x-absolute_pos_x))
	if(target_angle < 0)
		target_angle = 360 + target_angle
	if(target_angle > 180)
		target_angle -= 360
	last_angle = target_angle
	if(visual_rotation)
		var/matrix/M = new
		M.Turn(last_angle)
		my_visual.transform = M

/datum/overmap_object/projectile/process()
	if(homing_on_target && target)
		absolute_dest_x = (target.x * 32) + target.partial_x
		absolute_dest_y = (target.y * 32) + target.partial_y
		UpdateAngle()

	//Movement
	var/x_to_add = sin(last_angle) * speed
	var/y_to_add = cos(last_angle) * speed
	partial_x += x_to_add
	partial_y += y_to_add
	ProcessPartials()

	//Collisions
	var/my_absolute_pos_x = (x*32)+partial_x
	var/my_aboslute_pos_y = (y*32)+partial_y
	if(!(only_hits_target && !target)) //Dont even try collisions if thats true
		var/list/possible_targets = current_system.GetObjectsOnCoords(x, y)
		for(var/i in possible_targets)
			var/datum/overmap_object/evaluatee = i
			if(!(evaluatee.overmap_flags & OV_CAN_BE_ATTACKED))
				continue
			if(only_hits_target && evaluatee != target)
				continue
			if(avoids_parent && evaluatee == parent)
				continue
			//Check distance
			var/evaluatee_absolute_pos_x = (evaluatee.x*32)+evaluatee.partial_x
			var/evaluatee_aboslute_pos_y = (evaluatee.y*32)+evaluatee.partial_y
			var/distance_in_pixels = TWO_POINT_DISTANCE(my_absolute_pos_x,my_aboslute_pos_y,evaluatee_absolute_pos_x,evaluatee_aboslute_pos_y)
			if(distance_in_pixels > OVERMAP_PROJECTILE_COLLISION_DISTANCE)
				continue
			//And finally, hit
			HitObject(evaluatee)
			qdel(src)
			return

	//Distance cap
	distance_so_far += speed
	if(distance_so_far >= max_distance)
		qdel(src)

/datum/overmap_object/projectile/proc/LoseParent()
	UnregisterSignal(parent, COMSIG_PARENT_QDELETING)
	parent = null

/datum/overmap_object/projectile/proc/LoseTarget()
	UnregisterSignal(target, COMSIG_PARENT_QDELETING)
	target = null

/datum/overmap_object/projectile/Destroy()
	if(parent)
		LoseParent()
	if(target)
		LoseTarget()
	return ..()

/datum/overmap_object/projectile/proc/HitObject(datum/overmap_object/hit_object)
	return

/datum/overmap_object/projectile/damaging
	var/damage_type = OV_DAMTYPE_LASER
	var/damage_amount = 10

/datum/overmap_object/projectile/damaging/HitObject(datum/overmap_object/hit_object)
	hit_object.DealtDamage(damage_type, damage_amount)

/datum/overmap_object/projectile/damaging/mining
	visual_type = /obj/effect/abstract/overmap/projectile/mining
	damage_type = OV_DAMTYPE_MINING
	damage_amount = 5

/obj/effect/abstract/overmap/projectile
	animate_movement = NO_STEPS
	icon = 'icons/overmap/overmap_projectiles.dmi'
	icon_state = "white_laser"
	layer = OVERMAP_LAYER_PROJECTILE

/obj/effect/abstract/overmap/projectile/mining
	icon_state = "orange_laser"
