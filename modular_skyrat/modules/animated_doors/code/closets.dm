/obj/structure/closet
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	var/obj/effect/overlay/closet_door/door_obj
	var/is_animating_door = FALSE
	var/door_anim_squish = 0.30
	var/door_anim_angle = 136
	var/door_hinge = -6.5
	var/door_anim_time = 2.0 // set to 0 to make the door not animate at all

/obj/structure/closet/proc/animate_door(closing = FALSE)
	if(!door_anim_time)
		return
	if(!door_obj) door_obj = new
	vis_contents |= door_obj
	door_obj.icon = icon
	door_obj.icon_state = "[icon_door || icon_state]_door"
	is_animating_door = TRUE
	var/num_steps = door_anim_time / world.tick_lag
	for(var/I in 0 to num_steps)
		var/angle = door_anim_angle * (closing ? 1 - (I/num_steps) : (I/num_steps))
		var/matrix/M = get_door_transform(angle)
		var/door_state = angle >= 90 ? "[icon_door_override ? icon_door : icon_state]_back" : "[icon_door || icon_state]_door"
		var/door_layer = angle >= 90 ? FLOAT_LAYER : ABOVE_MOB_LAYER

		if(I == 0)
			door_obj.transform = M
			door_obj.icon_state = door_state
			door_obj.layer = door_layer
		else if(I == 1)
			animate(door_obj, transform = M, icon_state = door_state, layer = door_layer, time = world.tick_lag, flags = ANIMATION_END_NOW)
		else
			animate(transform = M, icon_state = door_state, layer = door_layer, time = world.tick_lag)
	addtimer(CALLBACK(src,.proc/end_door_animation),door_anim_time,TIMER_UNIQUE|TIMER_OVERRIDE)

/obj/structure/closet/proc/end_door_animation()
	is_animating_door = FALSE
	vis_contents -= door_obj
	update_appearance()
	COMPILE_OVERLAYS(src)

/obj/structure/closet/proc/get_door_transform(angle)
	var/matrix/M = matrix()
	M.Translate(-door_hinge, 0)
	M.Multiply(matrix(cos(angle), 0, 0, -sin(angle) * door_anim_squish, 1, 0))
	M.Translate(door_hinge, 0)
	return M

//////////////////////////ANIM OVERRIDES
/obj/structure/closet/body_bag
	door_anim_time = 0

/obj/structure/closet/cardboard
	door_anim_time = 0

/obj/structure/closet/cabinet
	door_anim_time = 0

/obj/structure/closet/acloset
	door_anim_time = 0

/obj/structure/closet/secure_closet/bar
	door_anim_time = 0

/obj/structure/closet/secure_closet/freezer
	door_anim_squish = 0.22
	door_anim_angle = 123
	door_anim_time = 2.50

/obj/structure/closet/secure_closet/personal/cabinet
	door_anim_time = 0

/obj/structure/closet/secure_closet/detective
	door_anim_time = 0

/obj/structure/closet/crate
	door_anim_time = 0
