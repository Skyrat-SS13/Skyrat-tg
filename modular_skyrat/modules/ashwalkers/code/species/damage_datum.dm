/datum/status_effect/ashwalker_damage //tracks the damage dealt to this mob by ashwalkers
	id = "ashwalker_damage"
	duration = -1
	tick_interval = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null
	/// How much damage has been dealt to the mob
	var/total_damage = 0

/datum/status_effect/ashwalker_damage/proc/register_mob_damage(mob/living/target)
	RegisterSignal(target, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(calculate_total))

/datum/status_effect/ashwalker_damage/proc/calculate_total(datum/source, damage, damagetype, def_zone)
	SIGNAL_HANDLER

	if(!QDELETED(src))
		total_damage += damage
	UnregisterSignal(source, COMSIG_MOB_APPLY_DAMAGE)
