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

/obj/effect/baseturf_helper/black_mesa_xen
	name = "xen baseturf editor"
	baseturf = /turf/open/water/xen_acid

/turf/closed/indestructible/rock/xen
	name = "strange wall"
	color = "#ac3b06"
	baseturfs = /turf/closed/indestructible/rock/xen

/turf/open/misc/xen
	name = "strange weeds"
	desc = "It feels soft to the touch, like a carpet... only... wet."
	icon = 'modular_skyrat/modules/black_mesa/icons/xen_turfs.dmi'
	icon_state = "xen_turf"
	baseturfs = /turf/open/misc/xen
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	planetary_atmos = TRUE

/turf/open/water/beach/xen
	desc = "It's mirky and filled with strange organisms."
	name = "xen water"
	icon = 'modular_skyrat/modules/black_mesa/icons/xen_turfs.dmi'
	baseturfs = /turf/open/water/beach/xen
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/open/misc/beach/coastline_t/xen
	desc = "It's mirky and filled with strange organisms."
	name = "xen water"
	icon = 'modular_skyrat/modules/black_mesa/icons/xen_turfs.dmi'
	baseturfs = /turf/open/misc/beach/coastline_t/xen
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/open/misc/beach/coastline_t/sandwater_inner/xen
	desc = "It's mirky and filled with strange organisms."
	name = "xen water"
	icon = 'modular_skyrat/modules/black_mesa/icons/xen_turfs.dmi'
	baseturfs = /turf/open/misc/beach/coastline_t/sandwater_inner/xen
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/open/misc/beach/coastline_b/xen
	name = "xen water"
	desc = "It's mirky and filled with strange organisms."
	icon = 'modular_skyrat/modules/black_mesa/icons/xen_turfs.dmi'
	baseturfs = /turf/open/misc/beach/coastline_b/xen
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/open/misc/dirt/planet/xen
	name = "strange path"
	color = "#ee5f1c"
	baseturfs = /turf/open/misc/dirt/planet/xen
	planetary_atmos = TRUE

/turf/open/water/xen_acid
	baseturfs = /turf/open/water/xen_acid
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
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

/turf/open/water/electric
	name = "electric water"
	baseturfs = /turf/open/water/electric
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	color = COLOR_TEAL
	light_range = 2
	light_color = COLOR_TEAL

/turf/open/water/electric/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(isliving(arrived))
		var/mob/living/unlucky_mob = arrived
		unlucky_mob.Stun(1.5 SECONDS)
		unlucky_mob.Knockdown(10 SECONDS)
		unlucky_mob.adjustFireLoss(15)
		var/datum/effect_system/lightning_spread/s = new /datum/effect_system/lightning_spread
		s.set_up(5, 1, unlucky_mob.loc)
		s.start()
		unlucky_mob.visible_message(span_danger("[unlucky_mob.name] is shocked by [src]!"), \
		span_userdanger("You feel a powerful shock course through your body!"), \
		span_hear("You hear a heavy electrical crack!"))
		playsound(unlucky_mob, SFX_SPARKS, 100, TRUE)
