/mob/living/silicon/robot/update_icons()
	icon = (model.cyborg_icon_override ? model.cyborg_icon_override : initial(icon))
	. = ..()
	/// Let's give custom borgs the ability to have flavor panels for their model
	if(opened && (TRAIT_R_UNIQUEPANEL in model.model_features))
		if(wiresexposed)
			add_overlay("[model.cyborg_base_icon]_w")
		else if(cell)
			add_overlay("[model.cyborg_base_icon]_c")
		else
			add_overlay("[model.cyborg_base_icon]_cl")
	update_altborg_icons()

	if(combat_indicator)
		add_overlay(GLOB.combat_indicator_overlay)

	if(temporary_flavor_text)
		add_overlay(GLOB.temporary_flavor_text_indicator)

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

			if(hat_overlay)  // Don't forget your hat
				add_overlay(hat_overlay)

	else
		icon_state = "[model.cyborg_base_icon]"

	if((TRAIT_R_UNIQUETIP in model.model_features) && (TRAIT_IMMOBILIZED in _status_traits))
		icon_state = "[model.cyborg_base_icon]-tipped"
		if(particles)
			dissipate()
		cut_overlays()

	if(stat == DEAD && (TRAIT_R_UNIQUEWRECK in model.model_features))
		icon_state = "[model.cyborg_base_icon]-wreck"


	update_appearance(UPDATE_OVERLAYS)
