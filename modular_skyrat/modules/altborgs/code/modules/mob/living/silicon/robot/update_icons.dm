/mob/living/silicon/robot/update_icons()
	. = ..()
	update_dogborg_icons()

/mob/living/silicon/robot/proc/update_dogborg_icons()
	icon = (module.cyborg_icon_override ? module.cyborg_icon_override : initial(icon))
	if(laser)
		add_overlay("laser")//Is this even used??? - Yes borg/inventory.dm
	if(disabler)
		add_overlay("disabler")//ditto


	//if(sleeper_g && module.sleeper_overlay)
	//	add_overlay("[module.sleeper_overlay]_g[sleeper_nv ? "_nv" : ""]")
	//if(sleeper_r && module.sleeper_overlay)
	//	add_overlay("[module.sleeper_overlay]_r[sleeper_nv ? "_nv" : ""]")

	if(stat == DEAD && module.has_snowflake_deadsprite)
		icon_state = "[module.cyborg_base_icon]-wreck"

	if(module.cyborg_pixel_offset)
		pixel_x = module.cyborg_pixel_offset

	if(module.cyborg_base_icon == "robot")
		icon = 'icons/mob/robots.dmi'
		pixel_x = initial(pixel_x)

	if(client && stat != DEAD && module.dogborg)
		if(resting)
			if(sitting)
				icon_state = "[module.cyborg_base_icon]-sit"
			if(bellyup)
				icon_state = "[module.cyborg_base_icon]-bellyup"
			else if(!sitting && !bellyup)
				icon_state = "[module.cyborg_base_icon]-rest"
			cut_overlays()
		else
			icon_state = "[module.cyborg_base_icon]"
	update_fire()
