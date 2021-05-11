/area/awaymission/black_mesa
	name = "Black Mesa Inside"

/area/awaymission/black_mesa/outside
	name = "Black Mesa Outside"
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED

/obj/structure/fluff/server_rack
	name = "Server Rack"
	desc = "A server rack with lots of cables coming out."
	density = TRUE
	icon = 'icons/obj/machines/research.dmi'
	icon_state = "nanite_cloud_controller"

/mob/living/simple_animal/hostile/xen
	faction = list(FACTION_XEN)

/mob/living/simple_animal/hostile/xen/bullsquid
	name = "bullsquid"
	desc = "Some highly aggressive alien creature. Thrives in toxic environments."
	icon = 'modular_skyrat/master_files/icons/mob/blackmesa.dmi'
	icon_state = "bullsquid"
	icon_living = "bullsquid"
	icon_dead = "bullsquid_dead"
	icon_gib = null
	mob_biotypes = list(MOB_ORGANIC, MOB_BEAST)
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	speak_chance = 1
	speak_emote = list("growls")
	speed = 1
	turns_per_move = 7
	maxHealth = 75
	health = 75
	obj_damage = 50
	harm_intent_damage = 15
	melee_damage_lower = 12
	melee_damage_upper = 18
	attack_sound = 'sound/weapons/bite.ogg'
	gold_core_spawnable = HOSTILE_SPAWN
	//Since those can survive on Xen, I'm pretty sure they can thrive on any atmosphere
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1500
	loot = list()

/mob/living/simple_animal/hostile/xen/bullsquid/FindTarget()
	. = ..()
	if(.)
		emote("me", 1, "growls at [.]!")

/obj/machinery/porta_turret/black_mesa
	use_power = IDLE_POWER_USE
	req_access = list(ACCESS_CENT_GENERAL)
	faction = list(FACTION_XEN)
	mode = TURRET_LETHAL
	uses_stored = FALSE
	max_integrity = 100
	base_icon_state = "syndie"
	lethal_projectile = /obj/projectile/beam/xray
	lethal_projectile_sound = 'sound/weapons/laser.ogg'

/obj/machinery/porta_turret/black_mesa/assess_perp(mob/living/carbon/human/perp)
	return 10

/obj/machinery/porta_turret/black_mesa/setup(obj/item/gun/turret_gun)
	return

/obj/machinery/porta_turret/black_mesa/heavy
	name = "Heavy Defence Turret"
	max_integrity = 200
	lethal_projectile = /obj/projectile/beam/laser/heavylaser
	lethal_projectile_sound = 'sound/weapons/lasercannonfire.ogg'

/mob/living/simple_animal/hostile/xen/nihilanth
	name = "nihilanth"
	desc = "Holy shit."
	icon = 'modular_skyrat/master_files/icons/mob/nihilanth.dmi'
	icon_state = "nihilanth"
	icon_living = "nihilanth"
	base_pixel_x = -156
	base_pixel_y = -154
	pixel_x = -156
	pixel_y = -154
	icon_dead = "bullsquid_dead"
	maxHealth = 10000
	health = 10000
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	projectilesound = 'sound/weapons/lasercannonfire.ogg'
	projectiletype = /obj/projectile/seedling
	ranged = TRUE
	rapid = 3

/mob/living/simple_animal/hostile/xen/nihilanth/Aggro()
	. = ..()
	set_combat_mode(TRUE)

/mob/living/simple_animal/hostile/xen/nihilanth/LoseAggro()
	. = ..()
	set_combat_mode(FALSE)
