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

/mob/living/simple_animal/hostile/blackmesa
	var/list/alert_sounds
	var/alert_cooldown = 3 SECONDS
	var/alert_cooldown_time

/mob/living/simple_animal/hostile/blackmesa/xen
	faction = list(FACTION_XEN)
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1500

/mob/living/simple_animal/hostile/blackmesa/Aggro()
	if(alert_sounds)
		if(!(world.time <= alert_cooldown_time))
			playsound(src, pick(alert_sounds), 70)
			alert_cooldown_time = world.time + alert_cooldown

/mob/living/simple_animal/hostile/blackmesa/xen/bullsquid
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
	emote_taunt = list("growls", "snarls", "grumbles")
	taunt_chance = 100
	turns_per_move = 7
	maxHealth = 75
	health = 75
	obj_damage = 50
	harm_intent_damage = 15
	melee_damage_lower = 12
	melee_damage_upper = 18
	attack_sound = 'modular_skyrat/master_files/sound/blackmesa/bullsquid/attack1.ogg'
	gold_core_spawnable = HOSTILE_SPAWN
	alert_sounds = list(
		'modular_skyrat/master_files/sound/blackmesa/bullsquid/detect1.ogg',
		'modular_skyrat/master_files/sound/blackmesa/bullsquid/detect2.ogg',
		'modular_skyrat/master_files/sound/blackmesa/bullsquid/detect3.ogg'
	)

/mob/living/simple_animal/hostile/blackmesa/xen/houndeye
	name = "houndeye"
	desc = "Some highly aggressive alien creature. Thrives in toxic environments."
	icon = 'modular_skyrat/master_files/icons/mob/blackmesa.dmi'
	icon_state = "houndeye"
	icon_living = "houndeye"
	icon_dead = "houndeye_dead"
	icon_gib = null
	mob_biotypes = list(MOB_ORGANIC, MOB_BEAST)
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	speak_chance = 1
	speak_emote = list("growls")
	speed = 1
	emote_taunt = list("growls", "snarls", "grumbles")
	taunt_chance = 100
	turns_per_move = 7
	maxHealth = 75
	health = 75
	obj_damage = 50
	harm_intent_damage = 10
	melee_damage_lower = 10
	melee_damage_upper = 14
	attack_sound = 'sound/weapons/bite.ogg'
	gold_core_spawnable = HOSTILE_SPAWN
	//Since those can survive on Xen, I'm pretty sure they can thrive on any atmosphere

	minbodytemp = 0
	maxbodytemp = 1500
	charger = TRUE
	loot = list(/obj/item/stack/sheet/bluespace_crystal)
	alert_sounds = list(
		'modular_skyrat/master_files/sound/blackmesa/houndeye/he_alert1.ogg',
		'modular_skyrat/master_files/sound/blackmesa/houndeye/he_alert2.ogg',
		'modular_skyrat/master_files/sound/blackmesa/houndeye/he_alert3.ogg',
		'modular_skyrat/master_files/sound/blackmesa/houndeye/he_alert4.ogg',
		'modular_skyrat/master_files/sound/blackmesa/houndeye/he_alert5.ogg'
	)

/mob/living/simple_animal/hostile/blackmesa/xen/houndeye/enter_charge(atom/target)
	playsound(src, pick(list(
		'modular_skyrat/master_files/sound/blackmesa/houndeye/charge3.ogg',
		'modular_skyrat/master_files/sound/blackmesa/houndeye/charge3.ogg',
		'modular_skyrat/master_files/sound/blackmesa/houndeye/charge3.ogg'
	)), 100)
	return ..()

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab
	name = "headcrab"
	desc = "Don't let it latch onto your hea-... hey, that's kinda cool."
	icon = 'modular_skyrat/master_files/icons/mob/blackmesa.dmi'
	icon_state = "headcrab"
	icon_living = "headcrab"
	icon_dead = "headcrab_dead"
	icon_gib = null
	mob_biotypes = list(MOB_ORGANIC, MOB_BEAST)
	speak_chance = 1
	speak_emote = list("growls")
	speed = 1
	emote_taunt = list("growls", "snarls", "grumbles")
	taunt_chance = 100
	turns_per_move = 7
	maxHealth = 40
	health = 40
	harm_intent_damage = 15
	melee_damage_lower = 10
	melee_damage_upper = 12
	attack_sound = 'sound/weapons/bite.ogg'
	gold_core_spawnable = HOSTILE_SPAWN
	charger = TRUE
	charge_frequency = 3 SECONDS
	loot = list(/obj/item/stack/sheet/bone)
	alert_sounds = list(
		'modular_skyrat/master_files/sound/blackmesa/headcrab/alert1.ogg'
	)
	var/is_zombie = FALSE
	var/mob/living/carbon/human/oldguy

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab/handle_charge_target(atom/target)
	playsound(src, pick(list(
		'modular_skyrat/master_files/sound/blackmesa/headcrab/attack1.ogg',
		'modular_skyrat/master_files/sound/blackmesa/headcrab/attack2.ogg',
		'modular_skyrat/master_files/sound/blackmesa/headcrab/attack3.ogg'
	)), 100)
	return ..()

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab/death(gibbed)
	. = ..()
	playsound(src, pick(list(
		'modular_skyrat/master_files/sound/blackmesa/headcrab/die1.ogg',
		'modular_skyrat/master_files/sound/blackmesa/headcrab/die2.ogg'
	)), 100)

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(hit_atom && stat != DEAD)
		if(ishuman(hit_atom))
			var/mob/living/carbon/human/human_to_dunk = hit_atom
			if(!human_to_dunk.get_item_by_slot(ITEM_SLOT_HEAD) && prob(50)) //Anything on de head stops the head hump
				if(zombify(human_to_dunk))
					to_chat(human_to_dunk, "<span class='userdanger'>[src] latches onto your head as it pierces your skull, instantly killing you!</span>")
					playsound(src, 'modular_skyrat/master_files/sound/blackmesa/headcrab/headbite.ogg', 100)
					human_to_dunk.death(FALSE)

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab/attack_ghost(mob/dead/observer/user)
	. = ..()
	if(.)
		return
	take_control(user)

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab/proc/take_control(mob/user)
	if(key || stat)
		return
	if(!is_zombie) //Only zombies can be controlled.
		return
	var/pod_ask = alert("Become a blob spore?", "Are you bulbous enough?", "Yes", "No")
	if(pod_ask == "No" || !src || QDELETED(src))
		return
	if(key)
		to_chat(user, "<span class='warning'>Someone else already took this spore!</span>")
		return
	key = user.key
	log_game("[key_name(src)] took control of [name].")

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab/proc/zombify(mob/living/carbon/human/H)
	if(is_zombie)
		return FALSE
	is_zombie = TRUE
	if(H.wear_suit)
		var/obj/item/clothing/suit/armor/A = H.wear_suit
		maxHealth += A.armor.melee //That zombie's got armor, I want armor!
	maxHealth += 40
	health = maxHealth
	name = "zombie"
	desc = "A shambling corpse animated by a headcrab!"
	mob_biotypes |= MOB_HUMANOID
	melee_damage_lower += 8
	melee_damage_upper += 11
	obj_damage = 21 //now that it has a corpse to puppet, it can properly attack structures
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	movement_type = GROUND
	icon_state = ""
	H.hairstyle = null
	H.update_hair()
	H.forceMove(src)
	oldguy = H
	update_appearance()
	visible_message("<span class='warning'>The corpse of [H.name] suddenly rises!</span>")
	charger = FALSE
	if(!key)
		notify_ghosts("\A [src] has been created in \the [get_area(src)].", source = src, action = NOTIFY_ORBIT, flashwindow = FALSE, header = "Headcrab Zombie Created")
	return TRUE

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab/death(gibbed)
	. = ..()
	if(oldguy)
		oldguy.forceMove(loc)
		oldguy = null
	if(is_zombie)
		if(prob(30))
			new /mob/living/simple_animal/hostile/blackmesa/xen/headcrab(loc) //OOOO it unlached!
			qdel(src)
			return
		dezombify()

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab/proc/dezombify()
	if(!is_zombie)
		return
	if(oldguy)
		oldguy.forceMove(loc)
		oldguy = null
	is_zombie = FALSE
	name = initial(name)
	desc = initial(desc)
	update_appearance()

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab/update_overlays()
	. = ..()
	if(is_zombie)
		copy_overlays(oldguy, TRUE)
		var/mutable_appearance/blob_head_overlay = mutable_appearance('modular_skyrat/master_files/icons/mob/blackmesa.dmi', "headcrab_zombie")
		add_overlay(blob_head_overlay)

/mob/living/simple_animal/hostile/blackmesa/xen/nihilanth
	name = "nihilanth"
	desc = "Holy shit."
	icon = 'modular_skyrat/master_files/icons/mob/nihilanth.dmi'
	icon_state = "nihilanth"
	icon_living = "nihilanth"
	base_pixel_x = -156
	pixel_x = -156
	base_pixel_y = -154
	speed = 3
	pixel_y = -154
	icon_dead = "bullsquid_dead"
	maxHealth = 10000
	health = 10000
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	projectilesound = 'sound/weapons/lasercannonfire.ogg'
	projectiletype = /obj/projectile/nihilanth
	ranged = TRUE
	rapid = 3
	alert_cooldown = 2 MINUTES
	harm_intent_damage = 5
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "lathes"
	attack_verb_simple = "lathe"
	attack_sound = 'sound/weapons/punch1.ogg'
	var/alert_everyone = TRUE

/obj/projectile/nihilanth
	name = "portal energy"
	icon_state = "seedling"
	damage = 20
	damage_type = BURN
	light_range = 2
	flag = ENERGY
	light_color = LIGHT_COLOR_YELLOW
	hitsound = 'sound/weapons/sear.ogg'
	hitsound_wall = 'sound/weapons/effects/searwall.ogg'
	nondirectional_sprite = TRUE

/mob/living/simple_animal/hostile/blackmesa/xen/nihilanth/Aggro()
	. = ..()
	if(alert_everyone)
		if(!(world.time <= alert_cooldown_time))
			alert_cooldown_time = world.time + alert_cooldown
			switch(health)
				if(0 to 999)
					alert_sound_to_playing(pick(list('modular_skyrat/master_files/sound/blackmesa/nihilanth/nihilanth_pain01.ogg', 'modular_skyrat/master_files/sound/blackmesa/nihilanth/nihilanth_freeeemmaan01.ogg')))
				if(1000 to 2999)
					alert_sound_to_playing(pick(list('modular_skyrat/master_files/sound/blackmesa/nihilanth/nihilanth_youalldie01.ogg', 'modular_skyrat/master_files/sound/blackmesa/nihilanth/nihilanth_foryouhewaits01.ogg')))
				if(3000 to 6000)
					alert_sound_to_playing(pick(list('modular_skyrat/master_files/sound/blackmesa/nihilanth/nihilanth_whathavedone01.ogg', 'modular_skyrat/master_files/sound/blackmesa/nihilanth/nihilanth_deceiveyou01.ogg')))
				else
					alert_sound_to_playing(pick(list('modular_skyrat/master_files/sound/blackmesa/nihilanth/nihilanth_thetruth01.ogg', 'modular_skyrat/master_files/sound/blackmesa/nihilanth/nihilanth_iamthelast01.ogg')))
	set_combat_mode(TRUE)

/mob/living/simple_animal/hostile/blackmesa/xen/nihilanth/death(gibbed)
	. = ..()
	alert_sound_to_playing('modular_skyrat/master_files/sound/blackmesa/nihilanth/nihilanth_death01.ogg')
	new /obj/effect/singularity_creation(loc)
	message_admins("[src] has been defeated, a resonance cascade will occur in 10 seconds.")
	addtimer(CALLBACK(src, .proc/endgame_shit),  10 SECONDS)

/mob/living/simple_animal/hostile/blackmesa/xen/nihilanth/LoseAggro()
	. = ..()
	set_combat_mode(FALSE)

/mob/living/simple_animal/hostile/blackmesa/xen/nihilanth/proc/endgame_shit()
	to_chat(world, "<span class='warning'>You feel as though a powerful force has been defeated...</span>")
	var/datum/round_event_control/resonance_cascade/event_to_start
	event_to_start.runEvent()

/datum/round_event_control/resonance_cascade
	name = "Portal Storm: Resonance Cascade"
	typepath = /datum/round_event/portal_storm/resonance_cascade
	weight = 0
	max_occurrences = 0

/datum/round_event/portal_storm/resonance_cascade
	hostile_types = list(
		/mob/living/simple_animal/hostile/blackmesa/xen/bullsquid = 8,
		/mob/living/simple_animal/hostile/blackmesa/xen/houndeye = 8,
		/mob/living/simple_animal/hostile/blackmesa/xen/houndeye = 8
	)

///////////////////HECU
/mob/living/simple_animal/hostile/blackmesa/hecu
	name = "HECU Grunt"
	desc = "I didn't sign on for this shit. Monsters, sure, but civilians? Who ordered this operation anyway?"
	icon = 'modular_skyrat/master_files/icons/mob/blackmesa.dmi'
	icon_state = "hecu_melee"
	icon_living = "hecu_melee"
	icon_dead = "hecu_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	speak_chance = 10
	speak = "Stop right there!"
	turns_per_move = 5
	speed = 0
	stat_attack = HARD_CRIT
	robust_searching = 1
	maxHealth = 100
	health = 100
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/weapons/punch1.ogg'
	combat_mode = TRUE
	loot = list(/obj/item/melee/classic_baton)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 7.5
	faction = list(FACTION_XEN)
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = 1
	dodging = TRUE
	rapid_melee = 2
	footstep_type = FOOTSTEP_MOB_SHOE
	alert_sounds = list(
		'modular_skyrat/master_files/sound/blackmesa/hecu/hg_alert01.ogg',
		'modular_skyrat/master_files/sound/blackmesa/hecu/hg_alert03.ogg',
		'modular_skyrat/master_files/sound/blackmesa/hecu/hg_alert04.ogg',
		'modular_skyrat/master_files/sound/blackmesa/hecu/hg_alert05.ogg',
		'modular_skyrat/master_files/sound/blackmesa/hecu/hg_alert06.ogg',
		'modular_skyrat/master_files/sound/blackmesa/hecu/hg_alert07.ogg',
		'modular_skyrat/master_files/sound/blackmesa/hecu/hg_alert08.ogg',
		'modular_skyrat/master_files/sound/blackmesa/hecu/hg_alert10.ogg'
	)

/mob/living/simple_animal/hostile/blackmesa/hecu/ranged
	ranged = TRUE
	retreat_distance = 5
	minimum_distance = 5
	icon_state = "hecu_ranged"
	icon_living = "hecu_ranged"
	casingtype = /obj/item/ammo_casing/a50ae
	projectilesound = 'sound/weapons/gun/pistol/shot.ogg'
	loot = list(/obj/effect/gibspawner/human, /obj/item/gun/ballistic/automatic/pistol/deagle)
	dodging = TRUE
	rapid_melee = 1

/mob/living/simple_animal/hostile/blackmesa/hecu/ranged/smg
	rapid = 3
	icon_state = "hecu_ranged_smg"
	icon_living = "hecu_ranged_smg"
	casingtype = /obj/item/ammo_casing/c45
	projectilesound = 'sound/weapons/gun/smg/shot.ogg'

/mob/living/simple_animal/hostile/blackmesa/sec
	name = "Security Guard"
	desc = "About that beer I owe'd ya!"
	icon = 'modular_skyrat/master_files/icons/mob/blackmesa.dmi'
	icon_state = "security_guard_melee"
	icon_living = "security_guard_melee"
	icon_dead = "security_guard_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	speak_chance = 10
	speak = "Hey, freeman! Over here!"
	turns_per_move = 5
	speed = 0
	stat_attack = HARD_CRIT
	robust_searching = 1
	maxHealth = 70
	health = 70
	harm_intent_damage = 5
	melee_damage_lower = 7
	melee_damage_upper = 7
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/weapons/punch1.ogg'
	combat_mode = TRUE
	loot = list(/obj/item/clothing/suit/armor/vest/blueshirt)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 7.5
	faction = list(FACTION_BLACKMESA)
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = TRUE
	dodging = TRUE
	rapid_melee = 2
	footstep_type = FOOTSTEP_MOB_SHOE
	alert_sounds = list(
		'modular_skyrat/master_files/sound/blackmesa/security_guard/annoyance01.ogg',
		'modular_skyrat/master_files/sound/blackmesa/security_guard/annoyance02.ogg',
		'modular_skyrat/master_files/sound/blackmesa/security_guard/annoyance02.ogg',
		'modular_skyrat/master_files/sound/blackmesa/security_guard/annoyance03.ogg',
		'modular_skyrat/master_files/sound/blackmesa/security_guard/annoyance04.ogg',
		'modular_skyrat/master_files/sound/blackmesa/security_guard/annoyance05.ogg',
		'modular_skyrat/master_files/sound/blackmesa/security_guard/annoyance06.ogg',
		'modular_skyrat/master_files/sound/blackmesa/security_guard/annoyance07.ogg',
		'modular_skyrat/master_files/sound/blackmesa/security_guard/annoyance08.ogg',
		'modular_skyrat/master_files/sound/blackmesa/security_guard/annoyance09.ogg',
		'modular_skyrat/master_files/sound/blackmesa/security_guard/annoyance10.ogg'
	)


/mob/living/simple_animal/hostile/blackmesa/sec/ranged
	ranged = TRUE
	retreat_distance = 5
	minimum_distance = 5
	icon_state = "security_guard_ranged"
	icon_living = "security_guard_ranged"
	casingtype = /obj/item/ammo_casing/c10mm
	projectilesound = 'sound/weapons/gun/pistol/shot.ogg'
	loot = list(/obj/item/clothing/suit/armor/vest/blueshirt, /obj/item/gun/ballistic/automatic/pistol/g17)
	dodging = TRUE
	rapid_melee = 1

/obj/machinery/porta_turret/black_mesa
	use_power = IDLE_POWER_USE
	req_access = list(ACCESS_CENT_GENERAL)
	faction = list(FACTION_XEN, FACTION_BLACKMESA, FACTION_HECU)
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

/obj/effect/random_mob_placer
	name = "mob placer"
	icon = 'icons/effects/mapping_helpers.dmi'
	icon_state = "mobspawner"
	var/list/possible_mobs

/obj/effect/random_mob_placer/Initialize(mapload)
	..()
	var/mob/picked_mob = pick(possible_mobs)
	new picked_mob(loc)
	return INITIALIZE_HINT_QDEL

/obj/effect/random_mob_placer/xen
	possible_mobs = list(
		/mob/living/simple_animal/hostile/blackmesa/xen/headcrab,
		/mob/living/simple_animal/hostile/blackmesa/xen/houndeye,
		/mob/living/simple_animal/hostile/blackmesa/xen/bullsquid
	)

