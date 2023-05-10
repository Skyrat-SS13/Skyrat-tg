#define FIRE_DELAY 4

/obj/machinery/porta_turret/syndicate/nri_raider
	name = "anti-projectile turret"
	desc = "An automatic defense turret designed for point-defense, it's probably not that wise to try approaching it."
	scan_range = 9
	shot_delay = 3
	faction = list(FACTION_RAIDER)
	icon = 'modular_skyrat/modules/encounters/icons/turrets.dmi'
	icon_state = "gun_turret"
	base_icon_state = "gun_turret"
	max_integrity = 250
	stun_projectile = /obj/projectile/bullet/ciws
	lethal_projectile = /obj/projectile/bullet/ciws
	lethal_projectile_sound = 'modular_skyrat/modules/encounters/sounds/shell_out_tiny.ogg'
	stun_projectile_sound = 'modular_skyrat/modules/encounters/sounds/shell_out_tiny.ogg'

/obj/machinery/porta_turret/syndicate/nri_raider/target(atom/movable/target)
	if(target)
		setDir(get_dir(base, target))//even if you can't shoot, follow the target
		shootAt(target)
		addtimer(CALLBACK(src, PROC_REF(shootAt), target), FIRE_DELAY)
		addtimer(CALLBACK(src, PROC_REF(shootAt), target), FIRE_DELAY*2)
		addtimer(CALLBACK(src, PROC_REF(shootAt), target), FIRE_DELAY*3)
		return TRUE

/obj/projectile/bullet/ciws
	name = "anti-projectile salvo"
	icon_state = "guardian"
	damage = 30
	armour_penetration = 10
