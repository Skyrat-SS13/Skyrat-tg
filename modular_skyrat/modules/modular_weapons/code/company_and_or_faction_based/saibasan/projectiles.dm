// Red kill lasers for the big gun

/obj/item/ammo_casing/energy/cybersun_big_kill
	projectile_type = /obj/projectile/beam/cybersun_laser
	e_cost = LASER_SHOTS(20, STANDARD_CELL_CHARGE * 2)
	select_name = "Kill"
	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/laser_firing/laser.ogg'

/obj/projectile/beam/cybersun_laser
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/saibasan/projectiles.dmi'
	icon_state = "kill_large"
	damage = 20
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	light_color = COLOR_SOFT_RED
	wound_falloff_tile = 1

// Speedy sniper lasers for the big gun

/obj/item/ammo_casing/energy/cybersun_big_sniper
	projectile_type = /obj/projectile/beam/cybersun_laser/marksman
	e_cost = LASER_SHOTS(10, STANDARD_CELL_CHARGE * 2)
	select_name = "Marksman"
	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/laser_firing/vaporize.ogg'

/obj/projectile/beam/cybersun_laser/marksman
	icon_state = "sniper"
	damage = 50
	impact_effect_type = /obj/effect/temp_visual/impact_effect/yellow_laser
	speed = 0.4
	light_range = 2
	light_color = COLOR_VERY_SOFT_YELLOW
	wound_falloff_tile = 0.1

// Disabler machinegun for the big gun

/obj/item/ammo_casing/energy/cybersun_big_disabler
	projectile_type = /obj/projectile/beam/cybersun_laser/disable
	e_cost = LASER_SHOTS(20, STANDARD_CELL_CHARGE * 2)
	select_name = "Disable"
	harmful = FALSE

/obj/projectile/beam/cybersun_laser/disable
	icon_state = "disable_large"
	damage = 0
	stamina = 20
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = COLOR_BRIGHT_BLUE
	stamina_falloff_tile = 0.25

// Plasma burst grenade for the big gun

/obj/item/ammo_casing/energy/cybersun_big_launcher
	projectile_type = /obj/projectile/beam/cybersun_laser/granata
	e_cost = LASER_SHOTS(5, STANDARD_CELL_CHARGE * 2)
	select_name = "Launcher"

/obj/projectile/beam/cybersun_laser/granata
	name = "plasma grenade"
	icon_state = "grenade"
	damage = 50
	speed = 2
	range = 6
	impact_effect_type = /obj/effect/temp_visual/impact_effect/green_laser
	light_color = COLOR_PALE_GREEN
	pass_flags = PASSTABLE | PASSGRILLE // His ass does NOT pass through glass!
	/// What type of casing should we put inside the bullet to act as shrapnel later
	var/casing_to_spawn = /obj/item/grenade/c980payload/plasma_grenade

/obj/projectile/beam/cybersun_laser/granata/on_hit(atom/target, blocked = 0, pierce_hit)
	..()
	fuse_activation(target)
	return BULLET_ACT_HIT

/obj/projectile/beam/cybersun_laser/granata/on_range()
	fuse_activation(get_turf(src))
	return ..()

/// Called when the projectile reaches its max range, or hits something
/obj/projectile/beam/cybersun_laser/granata/proc/fuse_activation(atom/target)
	var/obj/item/grenade/shrapnel_maker = new casing_to_spawn(get_turf(target))
	shrapnel_maker.detonate()
	playsound(src, 'modular_skyrat/modules/modular_weapons/sounds/grenade_burst.ogg', 50, TRUE, -3)
	qdel(shrapnel_maker)

/obj/projectile/beam/cybersun_laser/granata_shrapnel
	name = "plasma globule"
	icon_state = "flare"
	damage = 10
	speed = 2.5
	bare_wound_bonus = 55 // Lasers have a wound bonus of 40, this is a bit higher
	wound_bonus = -50 // However we do not very much against armor
	range = 2
	pass_flags = PASSTABLE | PASSGRILLE // His ass does NOT pass through glass!
	weak_against_armour = TRUE
	impact_effect_type = /obj/effect/temp_visual/impact_effect/green_laser
	light_color = COLOR_PALE_GREEN
	damage_falloff_tile = 3

/obj/item/grenade/c980payload/plasma_grenade
	shrapnel_type = /obj/projectile/beam/cybersun_laser/granata_shrapnel
	shrapnel_radius = 3

// Shotgun casing for the big gun

/obj/item/ammo_casing/energy/cybersun_big_shotgun
	projectile_type = /obj/projectile/beam/cybersun_laser/granata_shrapnel/shotgun_pellet
	e_cost = LASER_SHOTS(10, STANDARD_CELL_CHARGE * 2)
	pellets = 5
	variance = 30
	select_name = "Shotgun"
	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/laser_firing/melt.ogg'

/obj/projectile/beam/cybersun_laser/granata_shrapnel/shotgun_pellet
	icon_state = "because_it_doesnt_miss"
	damage = 10
	impact_effect_type = /obj/effect/temp_visual/impact_effect/purple_laser
	speed = 0.8
	light_color = COLOR_SCIENCE_PINK
	range = 9
	damage_falloff_tile = 0.5

// Hellfire lasers for the little guy

/obj/item/ammo_casing/energy/cybersun_small_hellfire
	projectile_type = /obj/projectile/beam/cybersun_laser/hellfire
	e_cost = LASER_SHOTS(10, STANDARD_CELL_CHARGE)
	select_name = "Incinerate"
	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/laser_firing/incinerate.ogg'

/obj/projectile/beam/cybersun_laser/hellfire
	icon_state = "hellfire"
	damage = 30
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	speed = 0.6
	wound_bonus = 0
	light_color = COLOR_SOFT_RED

// Bounce disabler lasers for the little guy

/obj/item/ammo_casing/energy/cybersun_small_disabler
	projectile_type = /obj/projectile/beam/cybersun_laser/disable_bounce
	e_cost = LASER_SHOTS(10, STANDARD_CELL_CHARGE)
	select_name = "Disable"
	harmful = FALSE

/obj/projectile/beam/cybersun_laser/disable_bounce
	icon_state = "disable_bounce"
	damage = 0
	stamina = 30
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = COLOR_BRIGHT_BLUE
	ricochet_auto_aim_angle = 30
	ricochet_auto_aim_range = 5
	ricochets_max = 2
	ricochet_incidence_leeway = 100
	ricochet_chance = 130
	ricochet_decay_damage = 0.8

/obj/projectile/beam/cybersun_laser/disable_bounce/check_ricochet_flag(atom/reflecting_atom)
	if((reflecting_atom.flags_ricochet & RICOCHET_HARD) || (reflecting_atom.flags_ricochet & RICOCHET_SHINY))
		return TRUE
	return FALSE

// Flare launcher

/obj/item/ammo_casing/energy/cybersun_small_launcher
	projectile_type = /obj/projectile/beam/cybersun_laser/flare
	e_cost = LASER_SHOTS(5, STANDARD_CELL_CHARGE)
	select_name = "Flare"

/obj/projectile/beam/cybersun_laser/flare
	name = "plasma flare"
	icon_state = "flare"
	damage = 30
	speed = 2
	range = 6
	impact_effect_type = /obj/effect/temp_visual/impact_effect/green_laser
	light_color = COLOR_PALE_GREEN
	pass_flags = PASSTABLE | PASSGRILLE // His ass does NOT pass through glass!
	/// How many firestacks the bullet should impart upon a target when impacting
	var/firestacks_to_give = 2
	/// What we spawn when we range out
	var/obj/illumination_flare = /obj/item/flashlight/flare/plasma_projectile

/obj/projectile/beam/cybersun_laser/flare/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/gaslighter = target
		gaslighter.adjust_fire_stacks(firestacks_to_give)
		gaslighter.ignite_mob()
	else
		new illumination_flare(get_turf(target))

/obj/projectile/beam/cybersun_laser/flare/on_range()
	new illumination_flare(get_turf(src))
	return ..()

/obj/item/flashlight/flare/plasma_projectile
	name = "plasma flare"
	desc = "A burning glob of green plasma, makes an effective temporary lighting source."
	light_range = 4
	anchored = TRUE
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/saibasan/projectiles.dmi'
	icon_state = "flare_burn"
	light_color = COLOR_PALE_GREEN
	light_power = 2

/obj/item/flashlight/flare/plasma_projectile/Initialize(mapload)
	. = ..()
	if(randomize_fuel)
		fuel = rand(3 MINUTES, 5 MINUTES)
	ignition()

/obj/item/flashlight/flare/plasma_projectile/turn_off()
	. = ..()
	qdel(src)

// Shotgun casing for the small gun

/obj/item/ammo_casing/energy/cybersun_small_shotgun
	projectile_type = /obj/projectile/beam/cybersun_laser/granata_shrapnel/shotgun_pellet
	e_cost = LASER_SHOTS(10, STANDARD_CELL_CHARGE)
	pellets = 3
	variance = 15
	select_name = "Shotgun"
	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/laser_firing/melt.ogg'

// Dummy casing that does nothing but have a projectile that looks like a sword

/obj/item/ammo_casing/energy/cybersun_small_blade
	projectile_type = /obj/projectile/beam/cybersun_laser/blade
	select_name = "Blade"

/obj/projectile/beam/cybersun_laser/blade
	icon_state = "blade"
