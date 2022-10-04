/// SKYRAT MODULE SKYRAT_XENO_REDO

#define RUNNER_BLUR_EFFECT "runner_evasion"

/mob/living/carbon/alien/humanoid/skyrat/runner
	name = "alien runner"
	desc = "A short alien with sleek red chitin, clearly abiding by the 'red ones go faster' theorem and almost always running on all fours."
	caste = "runner"
	maxHealth = 150
	health = 150
	icon_state = "alienrunner"
	/// Holds the evade ability to be granted to the runner later
	var/datum/action/cooldown/alien/skyrat/evade/evade_ability
	melee_damage_lower = 20
	melee_damage_upper = 25
	next_evolution = /mob/living/carbon/alien/humanoid/skyrat/ravager
	on_fire_pixel_y = 0

/mob/living/carbon/alien/humanoid/skyrat/runner/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/tackler, stamina_cost = 0, base_knockdown = 2, range = 10, speed = 2, skill_mod = 7, min_distance = 0)
	evade_ability = new /datum/action/cooldown/alien/skyrat/evade()
	evade_ability.Grant(src)

	add_movespeed_modifier(/datum/movespeed_modifier/alien_quick)

/mob/living/carbon/alien/humanoid/skyrat/runner/Destroy()
	QDEL_NULL(evade_ability)
	return ..()

/mob/living/carbon/alien/humanoid/skyrat/runner/create_internal_organs()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/small/tiny
	..()

/datum/action/cooldown/alien/skyrat/evade
	name = "Evade"
	desc = "Allows you to evade any projectile that would hit you for a few seconds."
	button_icon_state = "evade"
	plasma_cost = 50
	cooldown_time = 60 SECONDS
	/// If the evade ability is currently active or not
	var/evade_active = FALSE
	/// How long evasion should last
	var/evasion_duration = 10 SECONDS

/datum/action/cooldown/alien/skyrat/evade/Activate()
	. = ..()
	if(evade_active) //Can't evade while we're already evading.
		owner.balloon_alert(owner, "already evading")
		return FALSE

	owner.balloon_alert(owner, "evasive movements began")
	playsound(owner, 'modular_skyrat/modules/xenos_skyrat_redo/sound/alien_hiss.ogg', 100, TRUE, 8, 0.9)
	to_chat(owner, span_danger("We take evasive action, making us impossible to hit with projectiles for the next [evasion_duration/10] seconds."))
	addtimer(CALLBACK(src, .proc/evasion_deactivate), evasion_duration)
	evade_active = TRUE
	RegisterSignal(owner, COMSIG_PROJECTILE_ON_HIT, .proc/on_projectile_hit)
	return TRUE

/// Handles deactivation of the xeno evasion ability, mainly unregistering the signal and giving a balloon alert
/datum/action/cooldown/alien/skyrat/evade/proc/evasion_deactivate()
	evade_active = FALSE
	owner.balloon_alert(owner, "evasion ended")
	UnregisterSignal(owner, COMSIG_PROJECTILE_ON_HIT)

/// Handles if either BULLET_ACT_HIT or BULLET_ACT_FORCE_PIERCE happens to something using the xeno evade ability
/datum/action/cooldown/alien/skyrat/evade/proc/on_projectile_hit()
	if(owner.incapacitated(IGNORE_GRAB) || !isturf(owner.loc) || !evade_active)
		return BULLET_ACT_HIT

	owner.visible_message(span_danger("[owner] effortlessly dodges the projectile!"), span_userdanger("You dodge the projectile!"))
	playsound(get_turf(owner), pick('sound/weapons/bulletflyby.ogg', 'sound/weapons/bulletflyby2.ogg', 'sound/weapons/bulletflyby3.ogg'), 75, TRUE)
	owner.add_filter(RUNNER_BLUR_EFFECT, 2, gauss_blur_filter(5))
	addtimer(CALLBACK(owner, /atom.proc/remove_filter, RUNNER_BLUR_EFFECT), 0.5 SECONDS)
	return BULLET_ACT_FORCE_PIERCE

/mob/living/carbon/alien/humanoid/skyrat/runner/bullet_act(obj/projectile/P, def_zone, piercing_hit = FALSE)
	if(evade_ability)
		var/evade_result = evade_ability.on_projectile_hit()
		if(!(evade_result == BULLET_ACT_HIT))
			return evade_result
	. = ..()

#undef RUNNER_BLUR_EFFECT
