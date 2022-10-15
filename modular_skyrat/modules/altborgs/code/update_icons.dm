/mob/living/silicon/robot/update_icons()
	icon = (model.cyborg_icon_override ? model.cyborg_icon_override : initial(icon))
	. = ..()
	update_altborg_icons()

/mob/living/silicon/robot/proc/update_altborg_icons()
	var/extra_overlay
	for(var/i in held_items)
		var/obj/item/O = i
		if(istype(O,/obj/item/gun/energy/laser/cyborg))
			extra_overlay = "laser"
			break
		if(istype(O,/obj/item/gun/energy/disabler/cyborg) || istype(O,/obj/item/gun/energy/e_gun/advtaser/cyborg))
			extra_overlay = "disabler"
			break

	if(extra_overlay)
		add_overlay(extra_overlay)


	//if(sleeper_g && model.sleeper_overlay)
	//	add_overlay("[model.sleeper_overlay]_g[sleeper_nv ? "_nv" : ""]")
	//if(sleeper_r && model.sleeper_overlay)
	//	add_overlay("[model.sleeper_overlay]_r[sleeper_nv ? "_nv" : ""]")

	if(robot_resting)
		if(stat != DEAD && can_rest())
			switch(robot_resting)
				if(ROBOT_REST_NORMAL)
					icon_state = "[model.cyborg_base_icon]-rest"
				if(ROBOT_REST_SITTING)
					icon_state = "[model.cyborg_base_icon]-sit"
				if(ROBOT_REST_BELLY_UP)
					icon_state = "[model.cyborg_base_icon]-bellyup"
				else
					icon_state = "[model.cyborg_base_icon]"
			cut_overlays()

			if(hat)  // Don't forget your hat
				var/mutable_appearance/head_overlay = hat.build_worn_icon(default_layer = 20, default_icon_file = 'icons/mob/clothing/head.dmi')
				head_overlay.pixel_y += (hat_offset - 14)
				add_overlay(head_overlay)

	else
		icon_state = "[model.cyborg_base_icon]"

	if((R_TRAIT_UNIQUETIP in model.model_features) && (TRAIT_IMMOBILIZED in status_traits))
		icon_state = "[model.cyborg_base_icon]-tipped"
		if(particles)
			dissipate()
		cut_overlays()

	if(stat == DEAD && (R_TRAIT_UNIQUEWRECK in model.model_features))
		icon_state = "[model.cyborg_base_icon]-wreck"

	update_fire()
