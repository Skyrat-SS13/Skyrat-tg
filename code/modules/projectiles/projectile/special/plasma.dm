/obj/projectile/plasma
	name = "plasma blast"
	icon_state = "plasmacutter"
<<<<<<< HEAD
	damage_type = BRUTE
	damage = 15 //SKYRAT EDIT CHANGE - ORIGINAL: 5
=======
	damage_type = BURN
	damage = 5
>>>>>>> 8f59a6dbac1 (Fix plasma cutter or guns that burn not being able to ignite plasma  (#69584))
	range = 4
	dismemberment = 20
	impact_effect_type = /obj/effect/temp_visual/impact_effect/purple_laser
	var/mine_range = 3 //mines this many additional tiles of rock
	tracer_type = /obj/effect/projectile/tracer/plasma_cutter
	muzzle_type = /obj/effect/projectile/muzzle/plasma_cutter
	impact_type = /obj/effect/projectile/impact/plasma_cutter

	//SKYRAT EDIT ADDITION BEGIN
	var/pressure_decrease = 0.25
	var/pressure_decrease_active = FALSE
	//SKYRAT EDIT ADDITION END

//SKYRAT EDIT ADDITION BEGIN
/obj/projectile/plasma/Initialize()
	. = ..()
	if(!lavaland_equipment_pressure_check(get_turf(src)))
		name = "weakened [name]"
		damage = damage * pressure_decrease
		dismemberment = dismemberment * pressure_decrease
		pressure_decrease_active = TRUE
//SKYRAT EDIT END

/obj/projectile/plasma/on_hit(atom/target)
	. = ..()
	if(ismineralturf(target))
		var/turf/closed/mineral/M = target
		M.gets_drilled(firer, FALSE)
		if(mine_range)
			mine_range--
			range++
		if(range > 0)
			return BULLET_ACT_FORCE_PIERCE

/obj/projectile/plasma/adv
	damage = 25 //SKYRAT EDIT CHANGE - ORIGINAL: 7
	range = 5
	mine_range = 5

/obj/projectile/plasma/adv/mech
	damage = 45 //SKYRAT EDIT CHANGE - ORIGINAL: 10 - Seriously? Do you have no respect for dead space?
	range = 9
	mine_range = 5 //SKYRAT EDIT CHANGE - ORIGINAL: 3

/obj/projectile/plasma/turret
	//Between normal and advanced for damage, made a beam so not the turret does not destroy glass
	name = "plasma beam"
	damage = 24
	range = 7
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
