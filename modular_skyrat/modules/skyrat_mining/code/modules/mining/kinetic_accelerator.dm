//Kinetic accelerator charging meme bugfix
/obj/item/gun/energy/kinetic_accelerator/
	var/chargetimer = null

/obj/item/gun/energy/kinetic_accelerator/reload()
	if(ismob(loc) || isturf(loc)) //Kinetic accelerators won't charge inside objects. Period.
		cell.give(cell.maxcharge)
		if(!suppressed)
			playsound(src.loc, 'sound/weapons/kenetic_reload.ogg', 60, 1)
		else
			to_chat(loc, "<span class='warning'>[src] silently charges up.</span>")
		update_icon()
		overheat = FALSE
	else //this is a terrible solution, but it ensures that it wont be stuck on dischaged if it fails to reload in an obj
		if(chargetimer)
			deltimer(chargetimer)
		chargetimer = addtimer(CALLBACK(src, .proc/reload), overheat_time * 2, TIMER_STOPPABLE)

//BDM pka
/obj/item/gun/energy/kinetic_accelerator/premiumka/bdminer
	name = "bloody accelerator"
	desc = "A modded premium kinetic accelerator with an increased mod capacity as well as lesser cooldown."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/guns/energy.dmi'
	icon_state = "bdpka"
	inhand_icon_state = "kineticgun"
	overheat_time = 14.5
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/premium/bdminer)
	max_mod_capacity = 125

/obj/item/gun/energy/kinetic_accelerator/premiumka/bdminer/attackby(obj/item/I, mob/user) //Intelligent solutions didn't work, i had to shitcode.
	if(istype(I, /obj/item/borg/upgrade/modkit))
		var/obj/item/borg/upgrade/modkit/MK = I
		switch(MK.type)
			if(/obj/item/borg/upgrade/modkit/chassis_mod)
				to_chat(user, "<span class='userdanger'>This modkit is unsuitable for [src]!</span>")
				return FALSE
			if(/obj/item/borg/upgrade/modkit/chassis_mod/orange)
				to_chat(user, "<span class='userdanger'>This modkit is unsuitable for [src]!</span>")
				return FALSE
			if(/obj/item/borg/upgrade/modkit/tracer)
				to_chat(user, "<span class='userdanger'>This modkit is unsuitable for [src]!</span>")
				return FALSE
			if(/obj/item/borg/upgrade/modkit/tracer/adjustable)
				to_chat(user, "<span class='userdanger'>This modkit is unsuitable for [src]!</span>")
				return FALSE
		MK.install(src, user)
	else
		..()

/obj/item/borg/upgrade/modkit/attackby(obj/item/A, mob/user)
	if(istype(A, /obj/item/gun/energy/kinetic_accelerator))
		if(istype(A, /obj/item/gun/energy/kinetic_accelerator/premiumka/bdminer)) //Read above.
			var/obj/item/borg/upgrade/modkit/MK = src
			switch(MK.type)
				if(/obj/item/borg/upgrade/modkit/chassis_mod)
					to_chat(user, "<span class='userdanger'>This modkit is unsuitable for [A]!</span>")
					return FALSE
				if(/obj/item/borg/upgrade/modkit/chassis_mod/orange)
					to_chat(user, "<span class='userdanger'>This modkit is unsuitable for [A]!</span>")
					return FALSE
				if(/obj/item/borg/upgrade/modkit/tracer)
					to_chat(user, "<span class='userdanger'>This modkit is unsuitable for [A]!</span>")
					return FALSE
				if(/obj/item/borg/upgrade/modkit/tracer/adjustable)
					to_chat(user, "<span class='userdanger'>This modkit is unsuitable for [A]!</span>")
					return FALSE
		install(A, user)
	else
		..()

/obj/item/gun/energy/kinetic_accelerator/nopenalty
	desc = "A self recharging, ranged mining tool that does increased damage in low pressure. This one feels a bit heavier than usual."
	ammo_type = list(/obj/projectile/kinetic/nopenalty)

/obj/projectile/kinetic/nopenalty

/obj/projectile/kinetic/nopenalty/prehit(atom/target)
	if(kinetic_gun)
		var/list/mods = kinetic_gun.get_modkits()
		for(var/obj/item/borg/upgrade/modkit/M in mods)
			M.projectile_prehit(src, target, kinetic_gun)
	return TRUE

/obj/projectile/kinetic/nopenalty/strike_thing(atom/target)
	var/turf/target_turf = get_turf(target)
	if(!target_turf)
		target_turf = get_turf(src)
	if(kinetic_gun) //hopefully whoever shot this was not very, very unfortunate.
		var/list/mods = kinetic_gun.get_modkits()
		for(var/obj/item/borg/upgrade/modkit/M in mods)
			M.projectile_strike_predamage(src, target_turf, target, kinetic_gun)
		for(var/obj/item/borg/upgrade/modkit/M in mods)
			M.projectile_strike(src, target_turf, target, kinetic_gun)

/obj/item/ammo_casing/energy/kinetic/premium/bdminer
	projectile_type = /obj/projectile/kinetic/premium/bdminer

/obj/projectile/kinetic/premium/bdminer
	name = "bloody kinetic force"
	icon_state = "ka_tracer"
	color = "#FF0000"
	damage = 50
	damage_type = BRUTE
	flag = "bomb"
	range = 4
	log_override = TRUE

//Rapid KA
/obj/item/gun/energy/kinetic_accelerator/premiumka/rapid
	name = "Rapid accelerator"
	desc = "A Kinetic Accelerator featuring an overclocked charger and a smaller pressure tank."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/guns/energy.dmi'
	icon_state = "rapidka"
	inhand_icon_state = "kineticgun"
	can_flashlight = 0
	overheat_time = 12
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/premium/rapid)
	can_bayonet = FALSE
	max_mod_capacity = 80

/obj/item/ammo_casing/energy/kinetic/premium/rapid
	projectile_type = /obj/projectile/kinetic/premium/rapid

/obj/projectile/kinetic/premium/rapid
	name = "Rapid kinetic force"
	damage = 25
	damage_type = BRUTE
	flag = "bomb"
	range = 4
	log_override = TRUE


//Heavy KA
/obj/item/gun/energy/kinetic_accelerator/premiumka/heavy
	name = "Heavy accelerator"
	desc = "A rather bulky Kinetic Accelerator capable of splitting large groups of rocks and hurting those near its impact"
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/guns/energy.dmi'
	icon_state = "heavyka"
	inhand_icon_state = "kineticgun"
	flight_x_offset = 12
	flight_y_offset = 11
	overheat_time = 22
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/premium/heavy)
	max_mod_capacity = 80
	knife_x_offset = 15
	knife_y_offset = 8

/obj/item/gun/energy/kinetic_accelerator/premiumka/heavy/Initialize()
	. = ..()
	var/obj/item/borg/upgrade/modkit/aoe/heavy/initial_kit = new /obj/item/borg/upgrade/modkit/aoe/heavy(src)
	initial_kit.install(src)

/obj/item/ammo_casing/energy/kinetic/premium/heavy
	projectile_type = /obj/projectile/kinetic/premium/heavy

/obj/projectile/kinetic/premium/heavy
	name = "Heavy kinetic force"
	damage = 65
	damage_type = BRUTE
	flag = "bomb"
	range = 3
	log_override = TRUE

//Precise KA
/obj/item/gun/energy/kinetic_accelerator/premiumka/precise
	name = "Precise accelerator"
	desc = "A modified Accelerator. This one has been zeroed in with a choked down barrel to give a longer range"
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/guns/energy.dmi'
	icon_state = "preciseka"
	inhand_icon_state = "kineticgun"
	flight_x_offset = 16
	flight_y_offset = 13
	overheat_time = 18
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/premium/precise)
	max_mod_capacity = 80
	knife_x_offset = 21
	knife_y_offset = 13

/obj/item/ammo_casing/energy/kinetic/premium/precise
	projectile_type = /obj/projectile/kinetic/premium/precise

/obj/projectile/kinetic/premium/precise
	name = "Precise kinetic force"
	damage = 45
	damage_type = BRUTE
	flag = "bomb"
	range = 6
	log_override = TRUE

//Modular KA
/obj/item/gun/energy/kinetic_accelerator/premiumka/modular
	name = "Modular accelerator"
	desc = "A rather bare-bones kinetic accelerator capable of forming to one's preferences."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/guns/energy.dmi'
	icon_state = "modularka"
	inhand_icon_state = "kineticgun"
	flight_x_offset = 15
	flight_y_offset = 21
	overheat_time = 30
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/premium/modular)
	max_mod_capacity = 180
	knife_x_offset = 14
	knife_y_offset = 14

/obj/item/ammo_casing/energy/kinetic/premium/modular
	projectile_type = /obj/projectile/kinetic/premium/modular

/obj/projectile/kinetic/premium/modular
	name = "Modular kinetic force"
	damage = 25
	damage_type = BRUTE
	flag = "bomb"
	range = 4
	log_override = TRUE

//BYOKA
/obj/item/gun/energy/kinetic_accelerator/premiumka/byoka
	name = "Custom accelerator"
	desc = "You're not sure how it's made, but it is truly a kinetic accelerator fit for a clown. Its handle smells faintly of bananas."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/guns/energy.dmi'
	icon_state = "byoka"
	inhand_icon_state = "kineticgun"
	overheat_time = 27
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/premium/byoka)
	max_mod_capacity = 300

/obj/item/ammo_casing/energy/kinetic/premium/byoka
	projectile_type = /obj/projectile/kinetic/premium/byoka

/obj/projectile/kinetic/premium/byoka
	name = "Odd kinetic force"
	damage = 0
	damage_type = BRUTE
	flag = "bomb"
	range = 1
	log_override = TRUE

//Ashen KA
/obj/item/gun/energy/kinetic_accelerator/premiumka/ashenka
	name = "Ashen accelerator"
	desc = "A kinetic accelerator of a bygone era, its design emits an aura of dread and malice. Holding it makes you want to hunt..."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/guns/energy.dmi'
	icon_state = "ashenka"
	inhand_icon_state = "kineticgun"
	can_flashlight = 0
	overheat_time = 13.5
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/premium/ashen)
	can_bayonet = FALSE
	max_mod_capacity = 100

/obj/item/ammo_casing/energy/kinetic/premium/ashen
	projectile_type = /obj/projectile/kinetic/premium/ashen

/obj/projectile/kinetic/premium/ashen
	name = "harsh kinetic force"
	damage = 60
	damage_type = BRUTE
	flag = "bomb"
	range = 5
	log_override = TRUE

//Megafauna & other unique modkits
//drake
/obj/item/borg/upgrade/modkit/knockback
	name = "knockback modification kit"
	desc = "Makes your shots deal knockback."
	cost = 25
	modifier = 1
	var/burndam = 5

/obj/item/borg/upgrade/modkit/knockback/projectile_strike(obj/projectile/kinetic/K, turf/target_turf, atom/target, obj/item/gun/energy/kinetic_accelerator/KA)
	..()
	var/mob/living/simple_animal/T = target
	if(T.stat != DEAD)
		playsound(T, 'sound/magic/fireball.ogg', 20, 1)
		new /obj/effect/temp_visual/fire(T.loc)
		step(target, get_dir(K, T))
		T.adjustFireLoss(burndam)

//hierophant

//warning: spaghetti (and copypasted) code ahead.

/obj/item/borg/upgrade/modkit/wall
	name = "wall modification kit"
	desc = "Makes a wall on impact on a living being."
	cost = 40
	var/cooldown = 0
	var/cdmultiplier = 2.25

/obj/item/borg/upgrade/modkit/wall/projectile_prehit(obj/projectile/kinetic/K, atom/target, obj/item/gun/energy/kinetic_accelerator/KA)
	..()
	for(var/turf/T in getline(KA.loc, target.loc))
		new /obj/effect/temp_visual/hierophant/squares(T)
	if(istype(target, /mob/living))
		new /obj/effect/temp_visual/hierophant/telegraph/teleport(target.loc)
	if(istype(target, /mob/living/simple_animal) && ( world.time > cooldown))
		var/mob/living/F = K.firer
		var/dir_to_target = get_dir(F, target)
		var/turf/T = get_step(get_turf(F), dir_to_target)
		var/obj/effect/temp_visual/hierophant/wall/crusher/W = new /obj/effect/temp_visual/hierophant/wall/crusher(T, F) //a wall only you can pass!
		cooldown = world.time + (W.duration * cdmultiplier)
		var/turf/otherT = get_step(T, turn(F.dir, 90))
		if(otherT)
			new /obj/effect/temp_visual/hierophant/wall/crusher(otherT, F)
		otherT = get_step(T, turn(F.dir, -90))
		if(otherT)
			new /obj/effect/temp_visual/hierophant/wall/crusher(otherT, F)

//colossus

//essentially a penalty-less version of the rapid repeater

/obj/item/borg/upgrade/modkit/bolter
	name = "death bolt modification kit"
	desc = "Makes your shots reload faster if you hit a mob or mineral."
	cost = 50
	modifier = 0.4

/obj/item/borg/upgrade/modkit/bolter/modify_projectile(obj/projectile/kinetic/K)
	..()
	K.name = "kinetic bolt"
	K.icon_state = "chronobolt"

/obj/item/borg/upgrade/modkit/bolter/projectile_strike_predamage(obj/projectile/kinetic/K, turf/target_turf, atom/target, obj/item/gun/energy/kinetic_accelerator/KA)
	..()
	var/valid_repeat = FALSE
	if(isliving(target))
		var/mob/living/L = target
		if(L.stat != DEAD)
			valid_repeat = TRUE
	if(ismineralturf(target_turf))
		valid_repeat = TRUE
	if(valid_repeat)
		KA.overheat = FALSE
		KA.attempt_reload(KA.overheat_time * src.modifier)

//legion
/mob/living/simple_animal/hostile/asteroid/hivelordbrood/explosivelegion
	name = "explosive legion skull"
	desc = "Oh no."
	icon = 'icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "legion_head"
	icon_living = "legion_head"
	icon_aggro = "legion_head"
	icon_dead = "legion_head"
	icon_gib = "syndicate_gib"
	friendly_verb_continuous = "buzzes near"
	friendly_verb_simple = "buzz near"
	vision_range = 10
	maxHealth = 5
	health = 5
	harm_intent_damage = 20
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	speak_emote = list("echoes")
	attack_sound = 'sound/weapons/pierce.ogg'
	throw_message = "is shrugged off by"
	pass_flags = PASSTABLE
	del_on_death = TRUE
	stat_attack = CONSCIOUS
	robust_searching = 1
	var/can_infest_dead = FALSE
	faction = list("explosive")

/mob/living/simple_animal/hostile/asteroid/hivelordbrood/explosivelegion/death()
	explosion(src.loc, 0, 0, 1, 2, 0, FALSE, 2)
	src.visible_message("<span class='danger'>The [src] explodes!</span>")
	..()

/obj/item/borg/upgrade/modkit/skull
	name = "skull launcher modification kit"
	desc = "Makes your shots create an explosive legion skull on impact. Can backfire."
	cost = 50

/obj/item/borg/upgrade/modkit/skull/projectile_strike(obj/projectile/kinetic/K, turf/target_turf, atom/target, obj/item/gun/energy/kinetic_accelerator/KA)
	..()
	if(isliving(target))
		if(istype(target, /mob/living/simple_animal))
			var/mob/living/simple_animal/hostile/asteroid/hivelordbrood/explosivelegion/L = new(get_step(target, target.dir))
			L.GiveTarget(target)

//blood drunk miner
/obj/item/borg/upgrade/modkit/lifesteal/miner
	name = "resonant lifesteal crystal"
	desc = "Causes kinetic accelerator shots to heal the firer on striking a living target."
	modifier = 4
	cost = 30
	denied_type = /obj/item/borg/upgrade/modkit/lifesteal/miner
	maximum_of_type = 2

//drakeling
/obj/item/borg/upgrade/modkit/fire
	name = "flamethrower modification kit"
	desc = "Makes your kinetic shots deal a mild amount of burn damage, along with spewing flames."
	modifier = 10
	cost = 25

/obj/item/borg/upgrade/modkit/fire/projectile_prehit(obj/projectile/kinetic/K, atom/target, obj/item/gun/energy/kinetic_accelerator/KA)
	..()
	playsound(K.firer, 'sound/magic/fireball.ogg', 20, 1)
	var/list/hitlist = list()
	for(var/turf/T in getline(KA.loc, target.loc) - get_turf(K.firer))
		new /obj/effect/hotspot(T)
		T.hotspot_expose(700,50,1)
		for(var/mob/living/L in T.contents)
			if(L in hitlist || (L == K.firer))
				break
			else
				hitlist += L
				L.adjustFireLoss(src.modifier)
				to_chat(L, "<span class='userdanger'>You're hit by [KA]'s fire breath!</span>")
//king goat
/obj/item/borg/upgrade/modkit/cooldown/cooler
	name = "cooler modification kit"
	desc = "Makes your kinetic accelerator shoot much faster, at the cost of 10 damage."
	modifier = 5
	cost = 35

/obj/item/borg/upgrade/modkit/cooldown/cooler/modify_projectile(obj/projectile/kinetic/K)
	K.damage -= (modifier *2)

//rogue process
/obj/item/borg/upgrade/modkit/plasma
	name = "plasma modification kit"
	desc = "Makes your accelerator also shoot a burst of plasma."
	modifier = 10
	cost = 35

/obj/item/borg/upgrade/modkit/plasma/projectile_prehit(obj/projectile/kinetic/K, atom/target, obj/item/gun/energy/kinetic_accelerator/KA)
	playsound(KA, 'sound/weapons/laser.ogg', 100, TRUE)
	var/turf/startloc = K.loc
	var/obj/projectile/P = new /obj/projectile/plasma/adv(startloc)
	P.starting = startloc
	P.firer = K.firer
	P.fired_from = KA
	P.yo = target.y - startloc.y
	P.xo = target.x - startloc.x
	P.original = target
	P.preparePixelProjectile(target, src)
	P.fire()

//gladiator
/obj/item/borg/upgrade/modkit/shielding
	name = "shielding modification kit"
	desc = "Makes your kinetic accelerator block <b>15%</b> of all attacks while held."
	modifier = 15
	cost = 30

/obj/item/borg/upgrade/modkit/shielding/install(obj/item/gun/energy/kinetic_accelerator/KA, mob/user)
	. = ..()
	KA.block_chance += modifier

/obj/item/borg/upgrade/modkit/shielding/uninstall(obj/item/gun/energy/kinetic_accelerator/KA, forcemove)
	. = ..()
	KA.block_chance -= modifier

//10mm modkit (currently broken, only the 10mm pka works)
/obj/item/gun/energy/kinetic_accelerator/tenmm
	desc = "A self recharging, ranged mining tool that does increased damage in low pressure. This one feels a bit heavier than usual."
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/etenmm)

/obj/item/borg/upgrade/modkit/tenmm
	name = "10mm modification kit"
	desc = "Makes your accelerator shoot 10mm bullets instead of kinetic shots."
	cost = 50

/obj/item/borg/upgrade/modkit/tenmm/install(obj/item/gun/energy/kinetic_accelerator/KA, mob/user)
	..()
	KA.ammo_type[1] = /obj/item/ammo_casing/energy/kinetic/etenmm
	var/obj/item/ammo_casing/energy/kinetic/etenmm/C = KA.ammo_type[1]
	KA.chambered = C

/obj/item/borg/upgrade/modkit/tenmm/uninstall(obj/item/gun/energy/kinetic_accelerator/KA, mob/user)
	..()
	KA.ammo_type[1] = initial(KA.ammo_type[1])
	var/obj/item/ammo_casing/energy/kinetic/C = KA.ammo_type[1]
	KA.chambered = C

/obj/item/ammo_casing/energy/kinetic/etenmm
	projectile_type = /obj/projectile/kinetic/etenmm
	select_name = "kinetic 10mm"
	fire_sound = 'sound/weapons/gun/pistol/shot.ogg'

/obj/projectile/kinetic/etenmm
	name = "kinetic 10mm"
	damage = 30
	damage_type = BRUTE
	range = 50
	color = "#FFFFFF"
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "bullet"

/obj/projectile/kinetic/etenmm/prehit(atom/target)
	if(kinetic_gun)
		var/list/mods = kinetic_gun.get_modkits()
		for(var/obj/item/borg/upgrade/modkit/M in mods)
			M.projectile_prehit(src, target, kinetic_gun)
	return TRUE

/obj/projectile/kinetic/etenmm/strike_thing(atom/target)
	var/turf/target_turf = get_turf(target)
	if(!target_turf)
		target_turf = get_turf(src)
	if(kinetic_gun) //hopefully whoever shot this was not very, very unfortunate.
		var/list/mods = kinetic_gun.get_modkits()
		for(var/obj/item/borg/upgrade/modkit/M in mods)
			M.projectile_strike_predamage(src, target_turf, target, kinetic_gun)
		for(var/obj/item/borg/upgrade/modkit/M in mods)
			M.projectile_strike(src, target_turf, target, kinetic_gun)

//sif
/obj/item/borg/upgrade/modkit/critical
	name = "critical modification kit"
	desc = "Makes your kinetic accelerator have a <b>20%</b> chance to critically wound your target."
	modifier = 20
	var/multiplier = 2
	cost = 30

/obj/item/borg/upgrade/modkit/critical/modify_projectile(obj/projectile/kinetic/K)
	. = ..()
	if(prob(modifier))
		K.damage *= multiplier
		K.name = "critical [K.name]"

//This is Messy fucking code to get something to work... trust me, I wish i was good enough of a coder to not rely on this
//AoE blasts (Unremovable)
/obj/item/borg/upgrade/modkit/aoe/heavy
	name = "mining explosion"
	desc = "Causes the Heavy KA to work properly. If you have this, Report it to ZenithEevee on Discord."
	denied_type = /obj/item/borg/upgrade/modkit/aoe
	turf_aoe = TRUE
	modifier = 0.33
	cost = 0

/obj/item/borg/upgrade/modkit/aoe/heavy/install(obj/item/gun/energy/kinetic_accelerator/KA)
	KA.modkits += src
	return TRUE

/obj/item/borg/upgrade/modkit/aoe/heavy/uninstall(obj/item/gun/energy/kinetic_accelerator/KA)
	return FALSE

/obj/item/borg/upgrade/modkit/aoe/heavy/modify_projectile(obj/projectile/kinetic/K)
	K.name = "heavy kinetic explosion"