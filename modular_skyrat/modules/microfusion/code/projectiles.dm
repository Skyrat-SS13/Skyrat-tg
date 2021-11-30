/obj/item/ammo_casing
	///What volume should the sound play at?
	var/fire_sound_volume = 50

/obj/item/ammo_casing/energy/laser/microfusion
	name = "microfusion energy lens"
	projectile_type = /obj/projectile/beam/laser/microfusion
	e_cost = 100 // 10 shots with a normal cell.
	select_name = "laser"
	fire_sound = 'modular_skyrat/modules/microfusion/sound/laser_1.ogg'
	fire_sound_volume = 100

/obj/projectile/beam/laser/microfusion
	name = "microfusion laser"
	icon = 'modular_skyrat/modules/microfusion/icons/projectiles.dmi'
	/// Do we set people alight on impact?
	var/superheated = FALSE
	/// If so, how much firestacks?
	var/fire_stacks = 0

/obj/projectile/beam/laser/microfusion/on_hit(atom/target, blocked)
	. = ..()
	if(superheated)
		if(isliving(target))
			var/mob/living/living
			living.fire_stacks += fire_stacks
			living.IgniteMob()
