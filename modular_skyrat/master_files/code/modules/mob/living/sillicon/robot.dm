// 	Typing indicator icon change
/mob/living/silicon/robot/set_typing_indicator(state, emote)
	var/static/mutable_appearance/type_indicator = mutable_appearance('modular_skyrat/modules/indicators/icons/typing_indicator.dmi', "borg0", CHAT_INDICATOR_LAYER)
	var/static/mutable_appearance/emote_indicator = mutable_appearance('modular_skyrat/modules/indicators/icons/emote_indicator.dmi', "borg0", CHAT_INDICATOR_LAYER)
	typing_indicator = state

	if(typing_indicator)

		// Tallborg stuff
		if((!robot_resting) && model && model.model_features && (R_TRAIT_TALL in model.model_features))
			type_indicator.pixel_y = 16
			emote_indicator.pixel_y = 16
		else
			type_indicator.pixel_y = 0
			emote_indicator.pixel_y = 0
		add_overlay((emote ? emote_indicator : type_indicator))

	else
		regenerate_icons()

// 	Smoke particle effect for heavy-duty cyborgs
/datum/component/robot_smoke

/datum/component/robot_smoke/RegisterWithParent()
	add_verb(parent, /mob/living/silicon/robot/proc/toggle_smoke)
	RegisterSignal(parent, COMSIG_ATOM_DIR_CHANGE, .proc/dir_change)

/datum/component/robot_smoke/UnregisterFromParent()
	remove_verb(parent, /mob/living/silicon/robot/proc/toggle_smoke)
	UnregisterSignal(parent, COMSIG_ATOM_DIR_CHANGE)

/datum/component/robot_smoke/Destroy()
	return ..()

/datum/component/robot_smoke/proc/dir_change(datum/source, olddir, newdir)
	SIGNAL_HANDLER

	var/atom/movable/movable_parent = parent

	if(!movable_parent.particles)
		return

	var/truedir = movable_parent.dir
	if(newdir && (truedir != newdir))
		truedir = newdir

	switch(truedir)
		if(NORTH)
			movable_parent.particles.position = list(-6, 12, 0)
			movable_parent.particles.drift = generator("vector", list(0, 0.4), list(0.2, -0.2))
		if(EAST)
			movable_parent.particles.position = list(-6, 12, 0)
			movable_parent.particles.drift = generator("vector", list(0, 0.4), list(-0.8, 0.2))
		if(SOUTH)
			movable_parent.particles.position = list(5, 12, 0)
			movable_parent.particles.drift = generator("vector", list(0, 0.4), list(0.2, -0.2))
		if(WEST)
			movable_parent.particles.position = list(6, 12, 0)
			movable_parent.particles.drift = generator("vector", list(0, 0.4), list(0.8, -0.2))


/mob/living/silicon/robot/proc/toggle_smoke()
	set name = "Toggle smoke"
	set category = "AI Commands"

	if(particles)
		dissipate()
	else if (!stat && !robot_resting)
		do_jitter_animation(10)
		playsound(src, 'modular_skyrat/master_files/sound/effects/robot_smoke.ogg', 50)
		particles = new /particles/smoke/robot()

/mob/living/silicon/robot/proc/dissipate()
	particles.spawning = 0
	addtimer(CALLBACK(src, .proc/particles_qdel), 1.5 SECONDS)

/mob/living/silicon/robot/proc/particles_qdel()
	QDEL_NULL(particles)

/mob/living/silicon/robot/death()
	. = ..()
	if(GetComponent(/datum/component/robot_smoke))
		dissipate()

/mob/living/silicon/robot/robot_lay_down()
	. = ..()

	if(GetComponent(/datum/component/robot_smoke))
		if(robot_resting)
			dissipate()
		else
			return

// The smoke
/particles/smoke/robot
	spawning = 0.4
	lifespan = 1 SECONDS
	fade = 0.75 SECONDS
	position = list(5, 12, 0)
	velocity = list(0, 0.2, 0)
	friction = 0.35
	scale = 0.5
	grow = 0.1
	spin = generator("num", -20, 20)

// Another smoke effect
/obj/effect/temp_visual/mook_dust/robot
	icon = 'modular_skyrat/modules/altborgs/icons/tallborg/misc/tallrobot_effects.dmi'
	icon_state = "impact_cloud"
	color = "#a9a9a93c"

/obj/effect/temp_visual/mook_dust/robot/table
	color = "#ffffffc2"
	pixel_y = -8
	layer = ABOVE_MOB_LAYER

// 	Modular solution for alternative tipping visuals
/datum/component/tippable/set_tipped_status(mob/living/tipped_mob, new_status = FALSE)
	var/mob/living/silicon/robot/robot = tipped_mob

	is_tipped = new_status

	if(is_tipped)
		ADD_TRAIT(tipped_mob, TRAIT_IMMOBILIZED, TIPPED_OVER)
		if(R_TRAIT_UNIQUETIP in robot.model.model_features)
			robot.icon_state = "[robot.model.cyborg_base_icon]-tipped"
			robot.cut_overlays() // Cut eye-lights
			return

		tipped_mob.transform = turn(tipped_mob.transform, 180)

	else
		REMOVE_TRAIT(tipped_mob, TRAIT_IMMOBILIZED, TIPPED_OVER)
		if(R_TRAIT_UNIQUETIP in robot.model.model_features)
			robot.icon_state = "[robot.model.cyborg_base_icon]"
			robot.regenerate_icons() // Return eye-lights
			return

		tipped_mob.transform = turn(tipped_mob.transform, -180)
