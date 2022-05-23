/*
*	HECU
*/

/mob/living/simple_animal/hostile/blackmesa/hecu
	name = "HECU Grunt"
	desc = "I didn't sign on for this shit. Monsters, sure, but civilians? Who ordered this operation anyway?"
	icon = 'modular_skyrat/modules/black_mesa/icons/mobs.dmi'
	icon_state = "hecu_melee"
	icon_living = "hecu_melee"
	icon_dead = "hecu_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	speak_chance = 10
	speak = list("Stop right there!")
	turns_per_move = 5
	speed = 0
	stat_attack = HARD_CRIT
	robust_searching = 1
	maxHealth = 150
	health = 150
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/weapons/punch1.ogg'
	combat_mode = TRUE
	loot = list(/obj/effect/gibspawner/human, /obj/item/melee/baton)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 7.5
	faction = list(FACTION_HECU)
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = 1
	dodging = TRUE
	rapid_melee = 2
	footstep_type = FOOTSTEP_MOB_SHOE
	alert_sounds = list(
		'modular_skyrat/modules/black_mesa/sound/mobs/hecu/hg_alert01.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/hecu/hg_alert03.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/hecu/hg_alert04.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/hecu/hg_alert05.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/hecu/hg_alert06.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/hecu/hg_alert07.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/hecu/hg_alert08.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/hecu/hg_alert10.ogg'
	)


/mob/living/simple_animal/hostile/blackmesa/hecu/ranged
	ranged = TRUE
	retreat_distance = 5
	minimum_distance = 5
	icon_state = "hecu_ranged"
	icon_living = "hecu_ranged"
	casingtype = /obj/item/ammo_casing/a50ae
	projectilesound = 'sound/weapons/gun/pistol/shot.ogg'
	loot = list(/obj/effect/gibspawner/human, /obj/effect/spawner/random/hecu_deagle)
	dodging = TRUE
	rapid_melee = 1

/mob/living/simple_animal/hostile/blackmesa/hecu/ranged/smg
	rapid = 3
	icon_state = "hecu_ranged_smg"
	icon_living = "hecu_ranged_smg"
	casingtype = /obj/item/ammo_casing/c32
	projectilesound = 'sound/weapons/gun/smg/shot.ogg'
	loot = list(/obj/effect/gibspawner/human, /obj/effect/spawner/random/hecu_smg)

/mob/living/simple_animal/hostile/blackmesa/sec
	name = "Security Guard"
	desc = "About that beer I owe'd ya!"
	icon = 'modular_skyrat/modules/black_mesa/icons/mobs.dmi'
	icon_state = "security_guard_melee"
	icon_living = "security_guard_melee"
	icon_dead = "security_guard_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	turns_per_move = 5
	speed = 0
	stat_attack = HARD_CRIT
	robust_searching = 1
	maxHealth = 100
	health = 100
	harm_intent_damage = 5
	melee_damage_lower = 7
	melee_damage_upper = 7
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/weapons/punch1.ogg'
	loot = list(/obj/effect/gibspawner/human, /obj/item/clothing/suit/armor/vest/blueshirt)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 7.5
	faction = list(FACTION_STATION, "neutral")
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = TRUE
	combat_mode = TRUE
	dodging = TRUE
	rapid_melee = 2
	footstep_type = FOOTSTEP_MOB_SHOE
	alert_sounds = list(
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/annoyance01.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/annoyance02.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/annoyance02.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/annoyance03.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/annoyance04.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/annoyance05.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/annoyance06.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/annoyance07.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/annoyance08.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/annoyance09.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/annoyance10.ogg'
	)
	var/list/follow_sounds = list(
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/leadon01.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/leadon02.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/leadon03.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/leadtheway01.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/leadtheway02.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/leadtheway03.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/leadtheway04.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/leadtheway05.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/leadtheway06.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/leadtheway07.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/leadtheway08.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/letsgo01.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/letsgo02.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/letsgo03.ogg',
		)
	var/list/unfollow_sounds = list(
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/holddownspot01.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/holddownspot02.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/holddownspot03.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/holddownspot04.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/holddownspot05.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/illstayhere01.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/illstayhere02.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/illstayhere03.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/imstickinghere01.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/imstickinghere02.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/imstickinghere03.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/imstickinghere04.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/security_guard/imstickinghere05.ogg',
	)
	var/follow_speed = 2
	var/follow_distance = 2

/mob/living/simple_animal/hostile/blackmesa/sec/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/follow, follow_sounds, unfollow_sounds, follow_distance, follow_speed)


/mob/living/simple_animal/hostile/blackmesa/sec/ranged
	ranged = TRUE
	retreat_distance = 5
	minimum_distance = 5
	icon_state = "security_guard_ranged"
	icon_living = "security_guard_ranged"
	casingtype = /obj/item/ammo_casing/b9mm
	projectilesound = 'sound/weapons/gun/pistol/shot.ogg'
	loot = list(/obj/effect/gibspawner/human, /obj/item/clothing/suit/armor/vest/blueshirt, /obj/item/gun/ballistic/automatic/pistol/g17/mesa)
	rapid_melee = 1

/mob/living/simple_animal/hostile/blackmesa/blackops
	name = "black operative"
	desc = "Why do we always have to clean up a mess the grunts can't handle?"
	icon = 'modular_skyrat/modules/black_mesa/icons/mobs.dmi'
	icon_state = "blackops"
	icon_living = "blackops"
	icon_dead = "blackops"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	speak_chance = 10
	speak = list("Got a visual!")
	turns_per_move = 5
	speed = 0
	stat_attack = HARD_CRIT
	robust_searching = 1
	maxHealth = 200
	health = 200
	harm_intent_damage = 25
	melee_damage_lower = 30
	melee_damage_upper = 30
	attack_verb_continuous = "strikes"
	attack_verb_simple = "strikes"
	attack_sound = 'sound/effects/woodhit.ogg'
	combat_mode = TRUE
	loot = list(/obj/effect/gibspawner/human)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 7.5
	faction = list(FACTION_BLACKOPS)
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = 1
	dodging = TRUE
	rapid_melee = 2
	footstep_type = FOOTSTEP_MOB_SHOE
	alert_sounds = list(
		'modular_skyrat/modules/black_mesa/sound/mobs/blackops/bo_alert01.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/blackops/bo_alert02.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/blackops/bo_alert03.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/blackops/bo_alert04.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/blackops/bo_alert05.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/blackops/bo_alert06.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/blackops/bo_alert07.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/blackops/bo_alert08.ogg'
	)


/mob/living/simple_animal/hostile/blackmesa/blackops/ranged
	ranged = TRUE
	rapid = 2
	retreat_distance = 5
	minimum_distance = 5
	icon_state = "blackops_ranged"
	icon_living = "blackops_ranged"
	casingtype = /obj/item/ammo_casing/a556/weak
	projectilesound = 'modular_skyrat/modules/gunsgalore/sound/guns/fire/m16_fire.ogg'
	attack_sound = 'sound/weapons/punch1.ogg'
	loot = list(/obj/effect/gibspawner/human, /obj/item/ammo_box/magazine/m16)
	rapid_melee = 1
