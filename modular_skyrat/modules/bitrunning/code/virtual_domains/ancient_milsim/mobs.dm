/mob/living/basic/trooper/cin_soldier
	name = "Coalition Operative"
	desc = "Death to SolFed."
	melee_damage_lower = 15
	melee_damage_upper = 20
	attack_verb_continuous = "cuts"
	attack_verb_simple = "cut"
	attack_sound = 'sound/weapons/blade1.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	faction = list(ROLE_SYNDICATE)
	loot = list(/obj/effect/mob_spawn/corpse/human/cin_soldier)
	mob_spawner = /obj/effect/mob_spawn/corpse/human/cin_soldier

/mob/living/basic/trooper/cin_soldier/melee
	r_hand = /obj/item/melee/energy/sword/saber/purple
	l_hand = /obj/item/shield/riot/pointman/hecu
	var/projectile_deflect_chance = 20

/mob/living/basic/trooper/cin_soldier/melee/bullet_act(obj/projectile/projectile)
	if(prob(projectile_deflect_chance))
		visible_message(span_danger("[src] blocks [projectile] with their shield!"))
		return BULLET_ACT_BLOCK
	return ..()

/mob/living/basic/trooper/cin_soldier/ranged
	melee_damage_lower = 5
	melee_damage_upper = 10
	ai_controller = /datum/ai_controller/basic_controller/trooper/ranged
	r_hand = /obj/item/gun/ballistic/automatic/nri_smg
	/// Type of bullet we use
	var/casingtype = /obj/item/ammo_casing/c9mm
	/// Sound to play when firing weapon
	var/projectilesound = 'sound/weapons/gun/smg/shot_alt.ogg'
	/// number of burst shots
	var/burst_shots = 2
	/// Time between taking shots
	var/ranged_cooldown = 1.5 SECONDS

/mob/living/basic/trooper/cin_soldier/ranged/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/ranged_attacks,\
		casing_type = casingtype,\
		projectile_sound = projectilesound,\
		cooldown_time = ranged_cooldown,\
		burst_shots = burst_shots,\
	)

/datum/modular_mob_segment/cin_mobs
	mobs = list(
		/mob/living/basic/trooper/cin_soldier/ranged,
		/mob/living/basic/trooper/cin_soldier/melee,
	)

/obj/effect/mob_spawn/corpse/human/cin_soldier
	name = "Coalition Operative"
	hairstyle = "Bald"
	facial_hairstyle = "Shaved"
	outfit = /datum/outfit/cin_soldier_corpse
