/turf/closed/mineral/black_mesa
	turf_type = /turf/open/misc/ironsand/black_mesa
	baseturfs = /turf/open/misc/ironsand/black_mesa
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

//Floors that no longer lead into space (innovative!)
/turf/open/misc/ironsand/black_mesa
	baseturfs = /turf/open/misc/ironsand/black_mesa
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE

/obj/effect/baseturf_helper/black_mesa
	name = "black mesa sand baseturf editor"
	baseturf = /turf/open/misc/ironsand/black_mesa

/turf/closed/indestructible/rock/xen
	name = "strange wall"
	color = "#ac3b06"

/turf/open/misc/xen
	name = "strange weeds"
	desc = "It feels soft to the touch, like a carpet... only... wet."
	icon = 'modular_skyrat/modules/black_mesa/icons/xen_turfs.dmi'
	icon_state = "xen_turf"
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS

/turf/open/water/beach/xen
	desc = "It's mirky and filled with strange organisms."
	name = "xen water"
	icon = 'modular_skyrat/modules/black_mesa/icons/xen_turfs.dmi'
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/misc/beach/coastline_t/xen
	desc = "It's mirky and filled with strange organisms."
	name = "xen water"
	icon = 'modular_skyrat/modules/black_mesa/icons/xen_turfs.dmi'
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/misc/beach/coastline_t/sandwater_inner/xen
	desc = "It's mirky and filled with strange organisms."
	name = "xen water"
	icon = 'modular_skyrat/modules/black_mesa/icons/xen_turfs.dmi'
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/misc/beach/coastline_b/xen
	name = "xen water"
	desc = "It's mirky and filled with strange organisms."
	icon = 'modular_skyrat/modules/black_mesa/icons/xen_turfs.dmi'
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/misc/dirt/planet/xen
	name = "strange path"
	color = "#ee5f1c"

/turf/open/water/xen_acid
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	color = COLOR_VIBRANT_LIME
	light_range = 2
	light_color = COLOR_VIBRANT_LIME
	/// How much damage we deal if a mob enters us.
	var/acid_damage = 30

/turf/open/water/xen_acid/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(isliving(arrived) && !istype(arrived, /mob/living/simple_animal/hostile/blackmesa/xen/bullsquid)) // Bull squid territory!
		var/mob/living/unlucky_mob = arrived
		unlucky_mob.adjustFireLoss(acid_damage)
		playsound(unlucky_mob, 'sound/weapons/sear.ogg', 100, TRUE)
