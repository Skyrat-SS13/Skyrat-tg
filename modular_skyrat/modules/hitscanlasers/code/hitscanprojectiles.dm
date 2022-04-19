//Parents to branch out off
/obj/effect/projectile/muzzle/hitscan
	name = "muzzle flash"
	icon = 'modular_skyrat/modules/hitscanlasers/icons/projectiles.dmi'

/obj/effect/projectile/tracer/hitscan
	name = "beam"
	icon = 'modular_skyrat/modules/hitscanlasers/icons/projectiles.dmi'

/obj/effect/projectile/impact/hitscan
	name = "beam impact"
	icon = 'modular_skyrat/modules/hitscanlasers/icons/projectiles.dmi'

//Begin new types

/obj/effect/projectile/muzzle/hitscan/laser
	icon_state = "muzzle_laser"

/obj/effect/projectile/tracer/hitscan/laser
	name = "laser"
	icon_state = "beam"

/obj/effect/projectile/impact/hitscan/laser
	name = "laser impact"
	icon_state = "impact_laser"

/obj/effect/projectile/muzzle/hitscan/heavy_laser
	icon_state = "muzzle_beam_heavy"

/obj/effect/projectile/tracer/hitscan/heavy_laser
	name = "heavy laser"
	icon_state = "beam_heavy"

/obj/effect/projectile/impact/hitscan/heavy_laser
	name = "heavy laser impact"
	icon_state = "impact_beam_heavy"

/obj/effect/projectile/muzzle/hitscan/hellfire
	icon_state = "muzzle_stun"

/obj/effect/projectile/tracer/hitscan/hellfire
	name = "hellfire laser"
	icon_state = "stun"

/obj/effect/projectile/impact/hitscan/hellfire
	name = "hellfire laser impact"
	icon_state = "impact_stun"

/obj/effect/projectile/muzzle/hitscan/xray
	icon_state = "muzzle_xray"

/obj/effect/projectile/tracer/hitscan/xray
	name = "\improper X-ray laser"
	icon_state = "xray"

/obj/effect/projectile/impact/hitscan/xray
	name = "\improper X-ray laser impact"
	icon_state = "impact_xray"
