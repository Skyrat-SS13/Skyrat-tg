///// AREAS, None of these should need power or lighting. I'd sooner die than hand-light this entire map

/area/awaymission/mothership_astrum/halls
	name = "Mothership Astrum Hallways"
	icon_state = "away1"
	requires_power = FALSE

/area/awaymission/mothership_astrum/deck1
	name = "Mothership Astrum Combat Holodeck"
	icon_state = "away2"
	requires_power = FALSE

/area/awaymission/mothership_astrum/deck2
	name = "Mothership Astrum Recreation Holodeck"
	icon_state = "away3"
	requires_power = FALSE

/area/awaymission/mothership_astrum/deck3
	name = "Mothership Astrum Frozen Holodeck"
	icon_state = "away4"
	requires_power = FALSE

/area/awaymission/mothership_astrum/deck4
	name = "Mothership Astrum Xeno Studies Holodeck"
	icon_state = "away4"
	requires_power = FALSE

/area/awaymission/mothership_astrum/deck5
	name = "Mothership Astrum Beach Holodeck"
	icon_state = "away5"
	requires_power = FALSE

//Fluff Notes

//Simplemobs
//MELEE
/mob/living/simple_animal/hostile/abductor
	name = "Abductor Scientist"
	desc = "From the depths of space."
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/abductors.dmi'
	icon_state = "abductor_scientist"
	icon_living = "abductor_scientist"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	speak_chance = 0
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
	loot = list(/obj/effect/gibspawner/human)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 7.5
	faction = list(ROLE_ABDUCTOR)
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = 1
	dodging = TRUE
	rapid_melee = 2
	footstep_type = FOOTSTEP_MOB_SHOE

/mob/living/simple_animal/hostile/abductor/melee //dude with a melee weapon
	melee_damage_lower = 15
	melee_damage_upper = 15
	icon_state = "abductor_scientist_melee"
	icon_living = "abductor_scientist_melee"
	loot = list(/obj/effect/gibspawner/human)
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	status_flags = 0
	var/projectile_deflect_chance = 0

/mob/living/simple_animal/hostile/abductor/agent
	name = "Abductor Agent"
	melee_damage_lower = 15
	melee_damage_upper = 15
	icon_state = "abductor_agent"
	icon_living = "abductor_agent"
	maxHealth = 170
	health = 170

//RANGED

/mob/living/simple_animal/hostile/abductor/ranged
	name = "Abductor Scientist"
	ranged = 1
	retreat_distance = 5
	minimum_distance = 5
	icon_state = "abductor_scientist_gun"
	icon_living = "abductor_scientist_gun"
	maxHealth = 70
	health = 70
	projectiletype = /obj/projectile/beam/laser
	projectilesound = 'sound/weapons/laser.ogg'

/mob/living/simple_animal/hostile/abductor/ranged/agent
	name = "Abductor Combat Specialist"
	icon_state = "abductor_agent_combat_gun"
	icon_living = "abductor_agent_combat_gun"
	maxHealth = 170
	health = 170

//LOOT

/obj/item/crowbar/freeman
	name = "Blood Soaked Crowbar"
	desc = "A weapon wielded by an ancient physicist, the blood of hundreds seeps through this rod of iron and malice."
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/freeman.dmi'
	icon_state = "crowbar"
	force = 30
	throwforce = 35

// FUCK NANITES
/obj/machinery/scanner_gate/anti_nanite
	name = "Advanced Scanner Gate"
	desc = "This gate seems to be highly modified with odd markings."
	resistance_flags = INDESTRUCTIBLE
	use_power = NO_POWER_USE

/obj/machinery/scanner_gate/anti_nanite/perform_scan(mob/living/M)
	if(SEND_SIGNAL(M, COMSIG_HAS_NANITES))
		SEND_SIGNAL(M, COMSIG_NANITE_DELETE)
		to_chat(M, "<span class='warning'>You feel an electrical charge run throughout your entire body as your nanites are vaporized!</span>")

/obj/machinery/scanner_gate/anti_nanite
	name = "Advanced Scanner Gate"
	desc = "This gate seems to be highly modified with odd markings."
	resistance_flags = INDESTRUCTIBLE
	use_power = NO_POWER_USE
	flags_1 = NODECONSTRUCT_1

/obj/machinery/scanner_gate/anti_nanite/emag_act(mob/user)
	to_chat(user, "<span class='notice'>This gate has advanced security measures!</span>")
	return

/obj/machinery/scanner_gate/anti_nanite/attackby(obj/item/W, mob/user, params)
	return

/obj/machinery/scanner_gate/anti_nanite/examine(mob/user)
	return list("This gate seems to be highly modified with odd markings.")

//Elite Fauna (I AM STEALING SO MUCH CODE FOR THIS I AM SORRY)

/mob/living/simple_animal/hostile/asteroid/elite/pandora/abductor
	name = "Abductor Captain"
	desc = "The one you've come here for, finish this."
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/abductors.dmi'
	icon_state = "abductor_agent_combat"
	icon_living = "abductor_agent_combat"
	icon_aggro = "abductor_agent_combat"
	icon_dead = "pandora_dead"
	icon_gib = "syndicate_gib"
	health_doll_icon = "pandora"
	maxHealth = 1500
	health = 1500
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "attacked"
	attack_verb_simple = "attacks"
	attack_sound = 'sound/weapons/sonic_jackhammer.ogg'
	throw_message = "doesn't do anything to"
	speed = 3
	move_to_delay = 10
	mouse_opacity = MOUSE_OPACITY_ICON
	deathsound = 'sound/magic/repulse.ogg'
	deathmessage = "falls to their knees, before exploding into a ball of gore."
	
/mob/living/simple_animal/hostile/asteroid/elite/pandora/abductor/bullet_act(obj/projectile/P)
	apply_damage(P.damage, P.damage_type)
	return // no more reduction

/mob/living/simple_animal/hostile/asteroid/elite/pandora/abductor/death(gibbed)
	spawn_gibs()
	spawn_gibs()
	new /obj/item/key/gateway/home(src.loc)
	qdel(src)
