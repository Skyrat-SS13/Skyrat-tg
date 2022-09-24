/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie
	name = "headcrab zombie"
	desc = "This unlucky person has had a headcrab latch onto their head. Ouch."
	icon = 'modular_skyrat/modules/black_mesa/icons/mobs.dmi'
	icon_state = "zombie"
	icon_living = "zombie"
	maxHealth = 110
	health = 110
	icon_gib = null
	icon_dead = "zombie_dead"
	speak_chance = 1
	speak_emote = list("growls")
	speed = 1
	emote_taunt = list("growls", "snarls", "grumbles")
	taunt_chance = 100
	melee_damage_lower = 21
	melee_damage_upper = 21
	attack_sound = 'modular_skyrat/modules/black_mesa/sound/mobs/zombies/claw_strike.ogg'
	gold_core_spawnable = HOSTILE_SPAWN
	alert_cooldown_time = 8 SECONDS
	alert_sounds = list(
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/alert1.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/alert2.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/alert3.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/alert4.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/alert5.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/alert6.ogg',
	)

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/death(gibbed)
	new /obj/effect/gibspawner/human(get_turf(src))
	return ..()

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/scientist
	name = "zombified scientist"
	desc = "Even after death, I still have to wear this horrible tie!"
	icon_state = "scientist_zombie"
	icon_living = "scientist_zombie"


/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/guard
	name = "zombified guard"
	desc = "About that brain I owed ya!"
	icon_state = "security_zombie"
	icon_living = "security_zombie"
	maxHealth = 140 // Armor!
	health = 140

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/hecu
	name = "zombified marine"
	desc = "MY. ASS. IS. DEAD."
	icon_state = "hecu_zombie"
	icon_living = "hecu_zombie"
	maxHealth = 190 // More armor!
	health = 190

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/hev
	name = "zombified hazardous environment specialist"
	desc = "User death... surpassed."
	icon_state = "hev_zombie"
	icon_living = "hev_zombie"
	maxHealth = 250
	health = 250
	alert_sounds = list(
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv1.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv2.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv3.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv4.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv5.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv6.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv7.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv8.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv9.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv10.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv11.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv12.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv13.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/zombies/hzv14.ogg',
	)




