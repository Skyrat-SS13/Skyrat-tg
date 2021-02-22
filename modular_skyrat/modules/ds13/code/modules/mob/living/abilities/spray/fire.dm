/*-----------------------
	Fire Subtype

	Sprays a cone of flame, burning and igniting things it touches
-----------------------*/
/datum/extension/spray/flame
	base_type = /datum/extension/spray/flame
	var/temperature = T0C + 2600
	fx_type = /obj/effect/particle_system/spray/fire

/datum/extension/spray/flame/handle_extra_data(var/list/extra_data)
	.=..()
	src.temperature = extra_data["temperature"]


/datum/extension/spray/flame/Process()
	for (var/t in affected_turfs)
		var/turf/T = t

		for (var/atom/A in T)
			A.fire_act(null, temperature, null, 0.2)

		T.fire_act(null, temperature, null, 0.2)
	.=..()


/*-----------------------
	Blue fire
	Like fire, but more so
-----------------------*/
/datum/extension/spray/flame/blue
	temperature = T0C + 4000
	fx_type = /obj/effect/particle_system/spray/fire/blue

/***********************
	Spray visual effect
************************/
/*
	Particle System
	Sprays particles in a cone
*/
/obj/effect/particle_system/spray/fire
	particle_type = /obj/effect/particle/flame
	autostart = FALSE
	particles_per_tick = 2
	randpixel = 12
	base_offset = new /vector2(-16, -16)
	relative_offset = new /vector2(0, 24)


/obj/effect/particle/flame
	name = "spray"
	icon = 'icons/effects/effects64.dmi'
	icon_state = "flame_1"
	random_icons = list("flame_1", "flame_2", "flame_3")
	scale_x_start = 	0.65
	scale_y_start = 	0.65
	alpha_start	=	255

	scale_x_end = 	1.5
	scale_y_end = 	1.5
	alpha_end	=	255
	color = "#FFFFFF"
	lifespan	=	1.7 SECOND



/*
	Blue fire
*/
/obj/effect/particle_system/spray/fire/blue
	particle_type = /obj/effect/particle/flame/blue
	autostart = FALSE
	randpixel = 12
	particles_per_tick = 3


/obj/effect/particle/flame/blue
	name = "spray"
	icon = 'icons/effects/effects64.dmi'
	icon_state = "blueflame_1"
	random_icons = list("blueflame_1", "blueflame_2", "blueflame_3")
	scale_x_start = 	0.75
	scale_y_start = 	0.75
	alpha_start	=	255

	scale_x_end = 	1.6
	scale_y_end = 	1.6
	alpha_end	=	255
	color = "#FFFFFF"
	lifespan	=	1.4 SECOND



//Radial subtypes. Firing in an omnidirectional circle
/datum/extension/spray/flame/radial
	fx_type = /obj/effect/particle_system/spray/fire/radial

/obj/effect/particle_system/spray/fire/radial
	particles_per_tick = 12



/datum/extension/spray/flame/blue/radial
	fx_type = /obj/effect/particle_system/spray/fire/blue/radial

/obj/effect/particle_system/spray/fire/blue/radial
	particles_per_tick = 16