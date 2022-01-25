//*
//DEBUFFS - status effects that in some way hinder or remove the player's function.
//*

//MOBILE STASIS - same as regular stasis with the immobilization/hands-blocking traits taken off. Non-modular change has it set to also be checked by IS_IN_STASIS(mob).
/datum/status_effect/grouped/stasis_mobile
	id = "stasis"
	duration = -1
	tick_interval = 10
	alert_type = /atom/movable/screen/alert/status_effect/stasis
	var/last_dead_time

/datum/status_effect/grouped/stasis_mobile/proc/update_time_of_death()
	if(last_dead_time)
		var/delta = world.time - last_dead_time
		var/new_timeofdeath = owner.timeofdeath + delta
		owner.timeofdeath = new_timeofdeath
		owner.tod = station_time_timestamp(wtime=new_timeofdeath)
		last_dead_time = null
	if(owner.stat == DEAD)
		last_dead_time = world.time

/datum/status_effect/grouped/stasis_mobile/on_creation(mob/living/new_owner, set_duration)
	. = ..()
	if(.)
		update_time_of_death()
		owner.reagents?.end_metabolization(owner, FALSE)

/datum/status_effect/grouped/stasis_mobile/on_apply()
	. = ..()
	if(!.)
		return
	ADD_TRAIT(owner, TRAIT_NUMBED, TRAIT_STATUS_EFFECT(id)) //Skyrat-specific numbing trait for surgery
	owner.throw_alert("stasis numbed", /atom/movable/screen/alert/numbed)
	owner.add_filter("stasis_status_ripple", 2, list("type" = "ripple", "flags" = WAVE_BOUNDED, "radius" = 0, "size" = 2))
	var/filter = owner.get_filter("stasis_status_ripple")
	animate(filter, radius = 32, time = 15, size = 0, loop = -1)


/datum/status_effect/grouped/stasis_mobile/tick()
	update_time_of_death()
	if(owner.stat >= UNCONSCIOUS)
		owner.Sleeping(15 SECONDS)

/datum/status_effect/grouped/stasis_mobile/on_remove()
	if(HAS_TRAIT(owner, TRAIT_NUMBED))
		REMOVE_TRAIT(owner, TRAIT_NUMBED, TRAIT_STATUS_EFFECT(id))
		owner.clear_alert("stasis numbed")
	owner.remove_filter("stasis_status_ripple")
	update_time_of_death()
	return ..()

/atom/movable/screen/alert/status_effect/stasis_mobile
	name = "Stasis"
	desc = "Most of your biological functions have halted. You could live forever this way, but it's pretty boring."
	icon_state = "stasis"
