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
	maxHealth = 110
	health = 110
	obj_damage = 50
	harm_intent_damage = 15
	melee_damage_lower = 15
	melee_damage_upper = 15
	ranged = TRUE
	retreat_distance = 4
	minimum_distance = 4
	dodging = TRUE
	projectiletype = /obj/projectile/bullsquid
	projectilesound = 'modular_skyrat/master_files/sound/blackmesa/bullsquid/goo_attack3.ogg'
	melee_damage_upper = 18
	attack_sound = 'modular_skyrat/master_files/sound/blackmesa/bullsquid/attack1.ogg'
	gold_core_spawnable = HOSTILE_SPAWN
	alert_sounds = list(
		'modular_skyrat/master_files/sound/blackmesa/bullsquid/detect1.ogg',
		'modular_skyrat/master_files/sound/blackmesa/bullsquid/detect2.ogg',
		'modular_skyrat/master_files/sound/blackmesa/bullsquid/detect3.ogg'
	)

/obj/projectile/bullsquid
	name = "nasty ball of ooze"
	icon_state = "neurotoxin"
	damage = 5
	damage_type = BURN
	nodamage = FALSE
	knockdown = 20
	armor_flag = BIO
	impact_effect_type = /obj/effect/temp_visual/impact_effect/neurotoxin
	hitsound = 'modular_skyrat/master_files/sound/blackmesa/bullsquid/splat1.ogg'
	hitsound_wall = 'modular_skyrat/master_files/sound/blackmesa/bullsquid/splat1.ogg'

/obj/projectile/bullsquid/on_hit(atom/target, blocked, pierce_hit)
	new /obj/effect/decal/cleanable/greenglow(target.loc)
	return ..()

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
	maxHealth = 110
	health = 110
	obj_damage = 50
	harm_intent_damage = 10
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_sound = 'sound/weapons/bite.ogg'
	gold_core_spawnable = HOSTILE_SPAWN
	//Since those can survive on Xen, I'm pretty sure they can thrive on any atmosphere

	minbodytemp = 0
	maxbodytemp = 1500
	loot = list(/obj/item/stack/sheet/bluespace_crystal)
	alert_sounds = list(
		'modular_skyrat/master_files/sound/blackmesa/houndeye/he_alert1.ogg',
		'modular_skyrat/master_files/sound/blackmesa/houndeye/he_alert2.ogg',
		'modular_skyrat/master_files/sound/blackmesa/houndeye/he_alert3.ogg',
		'modular_skyrat/master_files/sound/blackmesa/houndeye/he_alert4.ogg',
		'modular_skyrat/master_files/sound/blackmesa/houndeye/he_alert5.ogg'
	)
	/// Charging ability
	var/datum/action/cooldown/mob_cooldown/charge/basic_charge/charge

/mob/living/simple_animal/hostile/blackmesa/xen/houndeye/Initialize(mapload)
	. = ..()
	charge = new /datum/action/cooldown/mob_cooldown/charge/basic_charge()
	charge.Grant(src)

/mob/living/simple_animal/hostile/blackmesa/xen/houndeye/Destroy()
	QDEL_NULL(charge)
	return ..()

/mob/living/simple_animal/hostile/blackmesa/xen/houndeye/OpenFire()
	if(client)
		return
	charge.Trigger(target)

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
	maxHealth = 100
	health = 100
	harm_intent_damage = 15
	melee_damage_lower = 17
	melee_damage_upper = 17
	attack_sound = 'sound/weapons/bite.ogg'
	gold_core_spawnable = HOSTILE_SPAWN
	loot = list(/obj/item/stack/sheet/bone)
	alert_sounds = list(
		'modular_skyrat/master_files/sound/blackmesa/headcrab/alert1.ogg'
	)
	var/is_zombie = FALSE
	var/mob/living/carbon/human/oldguy
	/// Charging ability
	var/datum/action/cooldown/mob_cooldown/charge/basic_charge/charge

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab/Initialize(mapload)
	. = ..()
	charge = new /datum/action/cooldown/mob_cooldown/charge/basic_charge()
	charge.Grant(src)

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab/Destroy()
	QDEL_NULL(charge)
	return ..()

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab/OpenFire()
	if(client)
		return
	charge.Trigger(target)

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
					to_chat(human_to_dunk, span_userdanger("[src] latches onto your head as it pierces your skull, instantly killing you!"))
					playsound(src, 'modular_skyrat/master_files/sound/blackmesa/headcrab/headbite.ogg', 100)
					human_to_dunk.death(FALSE)

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab/proc/zombify(mob/living/carbon/human/zombified_human)
	if(is_zombie)
		return FALSE
	is_zombie = TRUE
	if(zombified_human.wear_suit)
		var/obj/item/clothing/suit/armor/zombie_suit = zombified_human.wear_suit
		maxHealth += zombie_suit.armor.melee //That zombie's got armor, I want armor!
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
	zombified_human.hairstyle = null
	zombified_human.update_hair()
	zombified_human.forceMove(src)
	oldguy = zombified_human
	update_appearance()
	visible_message(span_warning("The corpse of [zombified_human.name] suddenly rises!"))
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
		cut_overlays()
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
	pixel_x = -64
	pixel_y = -64
	base_pixel_x = -64
	base_pixel_y = -64
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
	harm_intent_damage = 5
	melee_damage_lower = 30
	melee_damage_upper = 40
	attack_verb_continuous = "lathes"
	attack_verb_simple = "lathe"
	attack_sound = 'sound/weapons/punch1.ogg'
	status_flags = NONE
	del_on_death = TRUE
	loot = list(/obj/effect/gibspawner/xeno, /obj/item/stack/sheet/bluespace_crystal/fifty, /obj/item/key/gateway)

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
				playsound(src, pick(list('modular_skyrat/master_files/sound/blackmesa/nihilanth/nihilanth_pain01.ogg', 'modular_skyrat/master_files/sound/blackmesa/nihilanth/nihilanth_freeeemmaan01.ogg')), 100)
			if(1000 to 2999)
				playsound(src, pick(list('modular_skyrat/master_files/sound/blackmesa/nihilanth/nihilanth_youalldie01.ogg', 'modular_skyrat/master_files/sound/blackmesa/nihilanth/nihilanth_foryouhewaits01.ogg')), 100)
			if(3000 to 6000)
				playsound(src, pick(list('modular_skyrat/master_files/sound/blackmesa/nihilanth/nihilanth_whathavedone01.ogg', 'modular_skyrat/master_files/sound/blackmesa/nihilanth/nihilanth_deceiveyou01.ogg')), 100)
			else
				playsound(src, pick(list('modular_skyrat/master_files/sound/blackmesa/nihilanth/nihilanth_thetruth01.ogg', 'modular_skyrat/master_files/sound/blackmesa/nihilanth/nihilanth_iamthelast01.ogg')), 100)
	set_combat_mode(TRUE)

/mob/living/simple_animal/hostile/blackmesa/xen/nihilanth/death(gibbed)
	. = ..()
	alert_sound_to_playing('modular_skyrat/master_files/sound/blackmesa/nihilanth/nihilanth_death01.ogg')
	new /obj/effect/singularity_creation(loc)
	message_admins("[src] has been defeated, a spacetime cascade will occur in 10 seconds.")
	addtimer(CALLBACK(src, .proc/endgame_shit),  10 SECONDS)

/mob/living/simple_animal/hostile/blackmesa/xen/nihilanth/proc/endgame_shit()
	to_chat(world, span_danger("You feel as though a powerful force has been defeated..."))
	var/datum/round_event_control/resonance_cascade/event_to_start = new()
	event_to_start.runEvent()

/mob/living/simple_animal/hostile/blackmesa/xen/nihilanth/LoseAggro()
	. = ..()
	set_combat_mode(FALSE)

/datum/round_event_control/resonance_cascade
	name = "Portal Storm: Spacetime Cascade"
	typepath = /datum/round_event/portal_storm/resonance_cascade
	weight = 0
	max_occurrences = 0

/datum/round_event/portal_storm/resonance_cascade/announce(fake)
	set waitfor = 0
	sound_to_playing_players('modular_skyrat/master_files/sound/blackmesa/tc_12_portalsuck.ogg')
	sleep(40)
	priority_announce("GENERAL ALERT: Spacetime cascade detected; massive transdimentional rift inbound!", "Transdimentional Rift", ANNOUNCER_KLAXON)
	sleep(20)
	sound_to_playing_players('modular_skyrat/master_files/sound/blackmesa/tc_13_teleport.ogg')

/datum/round_event/portal_storm/resonance_cascade
	hostile_types = list(
		/mob/living/simple_animal/hostile/blackmesa/xen/bullsquid = 30,
		/mob/living/simple_animal/hostile/blackmesa/xen/houndeye = 30,
		/mob/living/simple_animal/hostile/blackmesa/xen/headcrab = 30
	)

///////////////////HECU SPAWNERS
/obj/effect/spawner/random/hecu_smg
	name = "HECU SMG drops"
	spawn_all_loot = FALSE
	loot = list(/obj/item/gun/ballistic/automatic/cfa_wildcat = 15,
				/obj/item/ammo_box/magazine/multi_sprite/cfa_wildcat = 25,
				/obj/item/clothing/mask/gas/hecu2 = 15,
				/obj/item/clothing/head/helmet = 15,
				/obj/item/clothing/suit/armor/vest = 15,
				/obj/item/clothing/shoes/combat = 15)

/obj/effect/spawner/random/hecu_deagle
	name = "HECU Deagle drops"
	spawn_all_loot = FALSE
	loot = list(/obj/item/gun/ballistic/automatic/pistol/deagle = 15,
				/obj/item/ammo_box/magazine/m50 = 25,
				/obj/item/clothing/mask/gas/hecu2 = 15,
				/obj/item/clothing/head/helmet = 15,
				/obj/item/clothing/suit/armor/vest = 15,
				/obj/item/clothing/shoes/combat = 15)

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
	loot = list(/obj/item/melee/baton)
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
	icon = 'modular_skyrat/master_files/icons/mob/blackmesa.dmi'
	icon_state = "security_guard_melee"
	icon_living = "security_guard_melee"
	icon_dead = "security_guard_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	speak_chance = 10
	speak = list("Hey, freeman! Over here!")
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
	faction = list(FACTION_BLACKMESA)
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = TRUE
	combat_mode = TRUE
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
	casingtype = /obj/item/ammo_casing/b9mm
	projectilesound = 'sound/weapons/gun/pistol/shot.ogg'
	loot = list(/obj/item/clothing/suit/armor/vest/blueshirt, /obj/item/gun/ballistic/automatic/pistol/g17/mesa)
	rapid_melee = 1

/mob/living/simple_animal/hostile/blackmesa/blackops
	name = "black operative"
	desc = "Why do we always have to clean up a mess the grunts can't handle?"
	icon = 'modular_skyrat/master_files/icons/mob/blackmesa.dmi'
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
		'modular_skyrat/master_files/sound/blackmesa/blackops/bo_alert01.ogg',
		'modular_skyrat/master_files/sound/blackmesa/blackops/bo_alert02.ogg',
		'modular_skyrat/master_files/sound/blackmesa/blackops/bo_alert03.ogg',
		'modular_skyrat/master_files/sound/blackmesa/blackops/bo_alert04.ogg',
		'modular_skyrat/master_files/sound/blackmesa/blackops/bo_alert05.ogg',
		'modular_skyrat/master_files/sound/blackmesa/blackops/bo_alert06.ogg',
		'modular_skyrat/master_files/sound/blackmesa/blackops/bo_alert07.ogg',
		'modular_skyrat/master_files/sound/blackmesa/blackops/bo_alert08.ogg'
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

/obj/projectile/bullet/a556/weak
	name = "surplus 5.56mm bullet"
	damage = 25
	armour_penetration = 10
	wound_bonus = -40

/obj/item/ammo_casing/a556/weak
	name = "5.56mm surplus bullet casing"
	desc = "A 5.56mm surplus bullet casing."
	projectile_type = /obj/projectile/bullet/a556/weak

#define MOB_PLACER_RANGE 16 // One more tile than the biggest viewrange we have.

/obj/effect/random_mob_placer
	name = "mob placer"
	icon = 'icons/effects/mapping_helpers.dmi'
	icon_state = "mobspawner"
	var/list/possible_mobs = list(/mob/living/simple_animal/hostile/blackmesa/xen/headcrab)

/obj/effect/random_mob_placer/Initialize(mapload)
	. = ..()
	for(var/turf/iterating_turf in range(MOB_PLACER_RANGE, src))
		RegisterSignal(iterating_turf, COMSIG_ATOM_ENTERED, .proc/trigger)

/obj/effect/random_mob_placer/proc/trigger(datum/source, atom/movable/entered_atom)
	SIGNAL_HANDLER
	if(!isliving(entered_atom))
		return
	var/mob/living/entered_mob = entered_atom

	if(!entered_mob.client)
		return

	var/mob/picked_mob = pick(possible_mobs)
	new picked_mob(loc)
	qdel(src)

#undef MOB_PLACER_RANGE

/obj/effect/random_mob_placer/xen
	possible_mobs = list(
		/mob/living/simple_animal/hostile/blackmesa/xen/headcrab,
		/mob/living/simple_animal/hostile/blackmesa/xen/houndeye,
		/mob/living/simple_animal/hostile/blackmesa/xen/bullsquid
	)
