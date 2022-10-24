#define MARAUDER_SHIELD_RECHARGE 600
#define MARAUDER_SHIELD_MAX 4

/mob/living/simple_animal/hostile/clockwork_marauder
	name = "clockwork marauder"
	desc = "A brass machine of destruction."
	icon = 'modular_skyrat/modules/clock_cult/icons/clockwork_mobs.dmi'
	icon_state = "clockwork_marauder"
	icon_dead = "broken_fragment"
	health = 180
	maxHealth = 180

	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = INFINITY
	movement_type = FLYING
	move_resist = MOVE_FORCE_OVERPOWERING
	mob_size = MOB_SIZE_LARGE
	pass_flags = PASSTABLE
	damage_coeff = list(BRUTE = 0.8, BURN = 0.8, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)

	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	chat_color = "#CAA25B"
	obj_damage = 80
	melee_damage_lower = 24
	melee_damage_upper = 24
	faction = list(FACTION_CLOCK)

	initial_language_holder = /datum/language_holder/clockmob

	loot = list(/obj/structure/fluff/clockwork/alloy_shards/large = 1, \
	/obj/structure/fluff/clockwork/alloy_shards/medium = 2, \
	/obj/structure/fluff/clockwork/alloy_shards/small = 3) //Parts left behind when a structure breaks

	/// How much health this shield has at most
	var/shield_health = MARAUDER_SHIELD_MAX

/mob/living/simple_animal/hostile/clockwork_marauder/Login()
	. = ..()
	to_chat(src, span_brass("You can block up to 4 attacks with your shield, however it requires a welder to be repaired.>"))

/mob/living/simple_animal/hostile/clockwork_marauder/death(gibbed)
	. = ..()
	// Potentially add visible message here
	qdel(src)

/mob/living/simple_animal/hostile/clockwork_marauder/attacked_by(obj/item/weapon, mob/living/user)
	if(istype(weapon, /obj/item/nullrod))
		apply_damage(15, BURN)
		if(shield_health)
			damage_shield()
		playsound(src, 'sound/hallucinations/veryfar_noise.ogg', 40, 1)
	if(weapon.tool_behaviour == TOOL_WELDER)
		welder_act(user, weapon)
		return
	return ..()

/mob/living/simple_animal/hostile/clockwork_marauder/bullet_act(obj/projectile/projectile)
	//Block Ranged Attacks
	if(shield_health)
		damage_shield()
		to_chat(src, span_warning("Your shield blocks the attack."))
		return BULLET_ACT_BLOCK
	return ..()

/mob/living/simple_animal/hostile/clockwork_marauder/proc/damage_shield()
	shield_health--
	playsound(src, 'sound/magic/clockwork/anima_fragment_attack.ogg', 60, TRUE)
	if(!shield_health)
		to_chat(src, span_userdanger("Your shield breaks!"))
		to_chat(src, span_brass("You require a welding tool to repair your damaged shield!"))

/mob/living/simple_animal/hostile/clockwork_marauder/welder_act(mob/living/user, obj/item/I)
	if(!do_after(user, 25, target = src))
		return TRUE
	health = min(health + 10, maxHealth)
	to_chat(user, span_notice("You repair some of [src]'s damage."))
	if(shield_health < MARAUDER_SHIELD_MAX)
		shield_health++
		playsound(src, 'sound/magic/charge.ogg', 60, TRUE)
	return TRUE

#undef MARAUDER_SHIELD_RECHARGE
#undef MARAUDER_SHIELD_MAX
