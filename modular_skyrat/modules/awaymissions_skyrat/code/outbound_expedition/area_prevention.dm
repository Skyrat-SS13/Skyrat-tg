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

/turf/open/space/no_travel/see_through
	opacity = FALSE
	mouse_opacity = MOUSE_OPACITY_ICON

/area/space/outbound_space
	icon_state = "space_near" // replace later

/area/awaymission/outbound_expedition
	name = "Outbound Expedition"

/area/awaymission/outbound_expedition/dock
	name = "Vanguard Dock"
	requires_power = FALSE

/area/awaymission/outbound_expedition/shuttle
	name = "Vanguard Shuttle"
	icon_state = "awaycontent2"

/area/awaymission/outbound_expedition/ruin
	name = "Outbound Ruin"
	icon_state = "awaycontent3"

/area/awaymission/outbound_expedition/ruin/scrapper
	name = "Scrapper Zone"
	icon_state = "awaycontent4"

/area/awaymission/outbound_expedition/ruin/raider
	name = "Raider Shuttle"
	icon_state = "awaycontent5"

/area/awaymission/outbound_expedition/ruin/prison
	name = "Prison Shuttle"
	icon_state = "awaycontent6"

/area/awaymission/outbound_expedition/ruin/survival
	name = "Survival Shelter"
	icon_state = "awaycontent7"

/area/awaymission/outbound_expedition/ruin/clock
	name = "Clock Cult Ruin"
	icon_state = "awaycontent8"

/area/awaymission/outbound_expedition/ruin/blood
	name = "Blood Cult Ruin"
	icon_state = "awaycontent9"

/area/awaymission/outbound_expedition/ruin/syndicate_frigate
	name = "Syndicate Frigate"
	icon_state = "awaycontent10"

/area/awaymission/outbound_expedition/ruin/holdout
	name = "Holdout AI Core"
	icon_state = "awaycontent11"

/area/awaymission/outbound_expedition/ruin/old_shipyard
	name = "Old Shipyard"
	icon_state = "awaycontent12"

/area/awaymission/outbound_expedition/ruin/radar_station
	name = "Deep-Space Radar Station"
	icon_state = "awaycontent13"

/area/awaymission/outbound_expedition/ruin/gateway_ruin
	name = "Ruined Gateway"
	icon_state = "awaycontent14"

/area/awaymission/outbound_expedition/ruin/sg_reviver
	name = "Ruined SolGov Facility"
	icon_state = "awaycontent15"

/area/awaymission/outbound_expedition/ruin/synd_firestorm
	name = "S.D.D.G. Firestorm"
	icon_state = "awaycontent16"
