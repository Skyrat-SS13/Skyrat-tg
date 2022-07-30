/turf/open/space/no_travel
	icon_state = "bluespace"
	//invisibility = INVISIBILITY_ABSTRACT
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	explosion_block = INFINITY
	rad_insulation = RAD_FULL_INSULATION
	opacity = TRUE
	density = TRUE
	blocks_air = TRUE
	always_lit = TRUE
	bullet_bounce_sound = null
	turf_flags = NOJAUNT
	baseturfs = /turf/open/space/no_travel

/turf/open/space/no_travel/attack_ghost(mob/dead/observer/user)
	return FALSE

/turf/open/space/no_travel/rust_heretic_act()
	return FALSE

/turf/open/space/no_travel/acid_act(acidpwr, acid_volume, acid_id)
	return FALSE

/turf/open/space/no_travel/Melt()
	to_be_destroyed = FALSE
	return src

/turf/open/space/no_travel/singularity_act()
	return FALSE

/turf/open/space/no_travel/ScrapeAway(amount, flags)
	return src // :devilcat:

/turf/open/space/no_travel/bullet_act(obj/projectile/hitting_projectile, def_zone, piercing_hit)
	return BULLET_ACT_HIT

/turf/open/space/no_travel/Adjacent(atom/neighbor, atom/target, atom/movable/mover)
	return FALSE

/area/awaymission/outbound_expedition
	name = "Outbound Expediton"

/area/awaymission/outbound_expedition/dock
	name = "Vanguard Dock"
	requires_power = FALSE

/area/awaymission/outbound_expedition/shuttle
	name = "Vanguard Shuttle"
	icon_state = "awaycontent2"
