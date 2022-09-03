/mob/living/simple_animal/hostile/blackmesa/xen/nihilanth
	name = "nihilanth"
	desc = "Holy shit."
	icon = 'modular_skyrat/modules/black_mesa/icons/nihilanth.dmi'
	icon_state = "nihilanth"
	icon_living = "nihilanth"
	pixel_x = -32
	pixel_y = -32
	base_pixel_x = -32
	base_pixel_y = -32
	speed = 3
	bound_height = 64
	bound_width = 64
	icon_dead = "bullsquid_dead"
	maxHealth = 3000
	health = 3000
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	projectilesound = 'sound/weapons/lasercannonfire.ogg'
	projectiletype = /obj/projectile/nihilanth
	ranged = TRUE
	rapid = 3
	alert_cooldown = 2 MINUTES
	harm_intent_damage = 50
	melee_damage_lower = 30
	melee_damage_upper = 40
	attack_verb_continuous = "lathes"
	attack_verb_simple = "lathe"
	attack_sound = 'sound/weapons/punch1.ogg'
	status_flags = NONE
	del_on_death = TRUE
	wander = TRUE
	loot = list(/obj/effect/gibspawner/xeno, /obj/item/stack/sheet/bluespace_crystal/fifty, /obj/item/key/gateway, /obj/item/uber_teleporter)
	movement_type = FLYING
	///Resonance cascade's chance of spawning. Can be decreased by using Xen crystals on Nihilanth
	var/cascade_chance = 60

/obj/item/stack/sheet/bluespace_crystal/fifty
	amount = 50

/obj/projectile/nihilanth
	name = "portal energy"
	icon_state = "seedling"
	damage = 20
	damage_type = BURN
	light_range = 2
	armor_flag = ENERGY
	light_color = LIGHT_COLOR_YELLOW
	hitsound = 'sound/weapons/sear.ogg'
	hitsound_wall = 'sound/weapons/effects/searwall.ogg'
	nondirectional_sprite = TRUE

/mob/living/simple_animal/hostile/blackmesa/xen/nihilanth/Aggro()
	. = ..()
	if(!(world.time <= alert_cooldown_time))
		alert_cooldown_time = world.time + alert_cooldown
		switch(health)
			if(0 to 999)
				playsound(src, pick(list('modular_skyrat/modules/black_mesa/sound/mobs/nihilanth/nihilanth_pain01.ogg', 'modular_skyrat/modules/black_mesa/sound/mobs/nihilanth/nihilanth_freeeemmaan01.ogg')), 100)
			if(1000 to 2999)
				playsound(src, pick(list('modular_skyrat/modules/black_mesa/sound/mobs/nihilanth/nihilanth_youalldie01.ogg', 'modular_skyrat/modules/black_mesa/sound/mobs/nihilanth/nihilanth_foryouhewaits01.ogg')), 100)
			if(3000 to 6000)
				playsound(src, pick(list('modular_skyrat/modules/black_mesa/sound/mobs/nihilanth/nihilanth_whathavedone01.ogg', 'modular_skyrat/modules/black_mesa/sound/mobs/nihilanth/nihilanth_deceiveyou01.ogg')), 100)
			else
				playsound(src, pick(list('modular_skyrat/modules/black_mesa/sound/mobs/nihilanth/nihilanth_thetruth01.ogg', 'modular_skyrat/modules/black_mesa/sound/mobs/nihilanth/nihilanth_iamthelast01.ogg')), 100)
	set_combat_mode(TRUE)

/mob/living/simple_animal/hostile/blackmesa/xen/nihilanth/death(gibbed)
	. = ..()
	alert_sound_to_playing('modular_skyrat/modules/black_mesa/sound/mobs/nihilanth/nihilanth_death01.ogg')
	new /obj/effect/singularity_creation(loc)
	message_admins("[src] has been defeated, a spacetime cascade might occur in 30 seconds with a [cascade_chance]% chance.")
	addtimer(CALLBACK(src, .proc/endgame_shit),  30 SECONDS)

/mob/living/simple_animal/hostile/blackmesa/xen/nihilanth/proc/endgame_shit()
	to_chat(world, span_danger("You feel as though a powerful force has been defeated..."))
	if(prob(cascade_chance))
		var/datum/round_event_control/resonance_cascade/event_to_start = new()
		event_to_start.runEvent()

/mob/living/simple_animal/hostile/blackmesa/xen/nihilanth/LoseAggro()
	. = ..()
	set_combat_mode(FALSE)

/mob/living/simple_animal/hostile/blackmesa/xen/nihilanth/attackby(obj/item/W, mob/living/user, params)
	. = ..()
	if(istype(W, /obj/item/grenade/xen_crystal))
		if(cascade_chance == 0)
			balloon_alert(user, "link already weak!")
			return
		cascade_chance -= 15
		to_chat(user, span_warning("You can feel how its link between worlds weakens as the crystal disappears."))
		playsound(user, 'modular_skyrat/modules/black_mesa/sound/tc_13_teleport.ogg', 100)
		qdel(W)
		return
