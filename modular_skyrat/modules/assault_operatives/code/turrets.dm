//TURRETS
/obj/machinery/porta_turret/assaultops
	use_power = IDLE_POWER_USE
	req_access = list(ACCESS_SYNDICATE)
	faction = list(ROLE_SYNDICATE)
	mode = TURRET_STUN
	max_integrity = 200
	base_icon_state = "syndie"
	stun_projectile = /obj/projectile/energy/electrode
	stun_projectile_sound = 'sound/weapons/taser.ogg'
	lethal_projectile = /obj/projectile/beam/laser/heavylaser
	lethal_projectile_sound = 'sound/weapons/lasercannonfire.ogg'

/obj/machinery/porta_turret/assaultops/assess_perp(mob/living/carbon/human/perp)
	return 10

/obj/machinery/porta_turret/assaultops/shuttle
	scan_range = 9
	lethal_projectile = /obj/projectile/bullet/a357
	lethal_projectile_sound = 'modular_skyrat/modules/aesthetics/guns/sound/sniperrifle.ogg'
	stun_projectile = /obj/projectile/energy/electrode
	stun_projectile_sound = 'sound/weapons/taser.ogg'
	max_integrity = 600
	armor = list(MELEE = 50, BULLET = 30, LASER = 30, ENERGY = 30, BOMB = 80, BIO = 0, FIRE = 90, ACID = 90)

/obj/machinery/porta_turret/assaultops/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_SELF | EMP_PROTECT_WIRES)


/obj/machinery/porta_turret/syndicate/assess_perp(mob/living/carbon/human/perp)
	return 10 //Syndicate turrets shoot everything not in their faction
