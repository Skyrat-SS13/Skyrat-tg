/obj/item/ammo_casing
	///What volume should the sound play at?
	var/fire_sound_volume = 50

/obj/item/ammo_casing/energy/laser/microfusion
	name = "microfusion energy lens"
	projectile_type = /obj/projectile/beam/laser/microfusion
	e_cost = 100 // 12 shots with a normal cell.
	select_name = "laser"
	fire_sound = 'modular_skyrat/modules/microfusion/sound/laser_1.ogg'
	fire_sound_volume = 100

/obj/item/ammo_casing/proc/refresh_shot()
	loaded_projectile = new projectile_type(src, src)

/obj/projectile/beam/laser/microfusion
	name = "microfusion laser"
	icon = 'modular_skyrat/modules/microfusion/icons/projectiles.dmi'
	damage = 20

/obj/projectile/beam/microfusion_disabler
	name = "microfusion disabler laser"
	icon = 'modular_skyrat/modules/microfusion/icons/projectiles.dmi'
	icon_state = "disabler"
	damage = 41
	damage_type = STAMINA
	armor_flag = ENERGY
	hitsound = 'sound/weapons/tap.ogg'
	eyeblur = 0
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = LIGHT_COLOR_BLUE
	tracer_type = /obj/effect/projectile/tracer/disabler
	muzzle_type = /obj/effect/projectile/muzzle/disabler
	impact_type = /obj/effect/projectile/impact/disabler

/obj/projectile/beam/laser/microfusion/superheated
	name = "superheated microfusion laser"
	icon_state = "laser_greyscale"
	damage = 15 //Trading damage for fire stacks
	color = LIGHT_COLOR_FIRE
	light_color = LIGHT_COLOR_FIRE
	tracer_type = /obj/effect/projectile/tracer/hitscan/hellfire
	muzzle_type = /obj/effect/projectile/muzzle/hitscan/hellfire
	impact_type = /obj/effect/projectile/impact/hitscan/hellfire

/obj/projectile/beam/laser/microfusion/superheated/on_hit(atom/target, blocked)
	. = ..()
	if(isliving(target))
		var/mob/living/living = target
		living.fire_stacks += 2
		living.IgniteMob()

/obj/projectile/beam/laser/microfusion/hellfire
	name = "hellfire microfusion laser"
	icon_state = "laser_greyscale"
	wound_bonus = 0
	damage = 25 // Basically a hellfire beam
	speed = 0.6
	color = LIGHT_COLOR_FLARE
	light_color = LIGHT_COLOR_FLARE
	tracer_type = /obj/effect/projectile/tracer/hitscan/hellfire
	muzzle_type = /obj/effect/projectile/muzzle/hitscan/hellfire
	impact_type = /obj/effect/projectile/impact/hitscan/hellfire

/obj/projectile/beam/laser/microfusion/scatter
	name = "scatter microfusion laser"
	damage = 30 // This damage is split into pellet amount

/obj/projectile/beam/laser/microfusion/scattermax
	name = "scatter microfusion laser"
	damage = 45 // This damage is split into pellet amount

/obj/projectile/beam/laser/microfusion/repeater
	name = "scatter microfusion laser"
	damage = 15 // No more a x2 damage buff

/obj/projectile/beam/laser/microfusion/penetrator
	name = "scatter microfusion laser"
	damage = 15
	armour_penetration = 50

/obj/projectile/beam/laser/microfusion/lance
	name = "lance microfusion laser"
	damage = 40 // Were turning the gun into a heavylaser
	tracer_type = /obj/effect/projectile/tracer/hitscan/heavy_laser
	muzzle_type = /obj/effect/projectile/muzzle/hitscan/heavy_laser
	impact_type = /obj/effect/projectile/impact/hitscan/heavy_laser
