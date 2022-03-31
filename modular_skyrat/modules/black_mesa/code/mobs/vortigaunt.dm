/mob/living/simple_animal/hostile/blackmesa/xen/vortigaunt
	name = "vortigaunt"
	desc = "There is no distance between us. No false veils of time or space may intervene."
	icon = 'modular_skyrat/modules/black_mesa/icons/mobs.dmi'
	icon_state = "vortigaunt"
	icon_living = "vortigaunt"
	icon_dead = "vortigaunt_dead"
	icon_gib = null
	faction = list(FACTION_STATION, FACTION_NONE)
	mob_biotypes = list(MOB_ORGANIC, MOB_BEAST)
	speak_chance = 1
	speak_emote = list("galungs")
	speed = 1
	emote_taunt = list("galalungas", "galungas", "gungs")
	projectiletype = /obj/projectile/beam/emitter/hitscan
	projectilesound = 'modular_skyrat/modules/black_mesa/sound/mobs/vortigaunt/attack_shoot4.ogg'
	ranged_cooldown_time = 5 SECONDS
	ranged_message = "fires"
	taunt_chance = 100
	turns_per_move = 7
	maxHealth = 100
	health = 100
	speed = 3
	ranged = TRUE
	dodging = TRUE
	harm_intent_damage = 15
	melee_damage_lower = 10
	melee_damage_upper = 10
	retreat_distance = 5
	minimum_distance = 5
	attack_sound = 'sound/weapons/bite.ogg'
	gold_core_spawnable = FRIENDLY_SPAWN
	loot = list(/obj/item/stack/sheet/bone)
	alert_sounds = list(
		'modular_skyrat/modules/black_mesa/sound/mobs/vortigaunt/alert01.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/vortigaunt/alert01b.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/vortigaunt/alert02.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/vortigaunt/alert03.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/vortigaunt/alert04.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/vortigaunt/alert05.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/vortigaunt/alert06.ogg',
	)
	var/list/follow_sounds = list(
		'modular_skyrat/modules/black_mesa/sound/mobs/vortigaunt/village_argue01.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/vortigaunt/village_argue02.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/vortigaunt/village_argue03.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/vortigaunt/village_argue04.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/vortigaunt/village_argue05.ogg',
		'modular_skyrat/modules/black_mesa/sound/mobs/vortigaunt/village_argue05a.ogg',
	)
	/// The thing we are going to try and follow.
	var/datum/weakref/following
	/// The max distance we allow for following.
	var/max_follow_distance = 20

/mob/living/simple_animal/hostile/blackmesa/xen/vortigaunt/examine(mob/user)
	. = ..()
	. += "Right click to get them to follow you."

/mob/living/simple_animal/hostile/blackmesa/xen/vortigaunt/AltClick(mob/user)
	. = ..()
	if(!can_interact(user))
		return
	if(!isliving(user))
		return
	var/mob/living/living_user = user
	if(!faction_check(living_user.faction, faction))
		return
	set_following(living_user)

/mob/living/simple_animal/hostile/blackmesa/xen/vortigaunt/proc/set_following(mob/living/user)
	playsound(src, pick(follow_sounds), 100)
	if(following?.resolve())
		say("No longer following!")
		following = null
	else
		say("Following you!")
		following = WEAKREF(user)

/mob/living/simple_animal/hostile/blackmesa/xen/vortigaunt/Life()
	. = ..()
	var/user_to_follow = following?.resolve()
	if(!user_to_follow)
		return
	if(get_dist_euclidian(src, user_to_follow) > max_follow_distance)
		following = null
		return
	step_towards(src, user_to_follow)

