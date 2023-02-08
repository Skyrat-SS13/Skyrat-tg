#define INTERDICTION_LENS_RANGE 4
#define POWER_PER_PERSON 5
#define PASSIVE_POWER_USE 25

/obj/structure/destructible/clockwork/gear_base/interdiction_lens
	name = "interdiction lens"
	desc = "A mesmerizing light that flashes to a rhythm that you just can't stop tapping to."
	clockwork_desc = "A small device which will slow down nearby attackers and projectiles at a large power cost, both active and passive."
	icon_state = "interdiction_lens"
	anchored = TRUE
	break_message = span_warning("The interdiction lens breaks into multiple fragments, which gently float to the ground.")
	max_integrity = 150
	minimum_power = POWER_PER_PERSON
	/// If the lens has its "on" switch flipped. Does not mean it's on, necessarily (needs power and anchoring, too)
	var/enabled = FALSE
	/// If the lens is "on" and working.
	var/processing = FALSE
	/// If this ran out of power during process()
	var/insufficient_power = FALSE
	/// Part 1/2 of the interdictor. This portion acts as the monitor, sending calls to the 2nd part when it finds something.
	var/datum/proximity_monitor/advanced/dampening_field
	/// Part 2 of the interdictor. This one actually does the dampening, but requires the dampening_field to tell it what to dampen
	var/obj/item/borg/projectile_dampen/clockcult/internal_dampener


/obj/structure/destructible/clockwork/gear_base/interdiction_lens/Initialize(mapload)
	. = ..()
	internal_dampener = new


/obj/structure/destructible/clockwork/gear_base/interdiction_lens/Destroy()
	if(enabled)
		STOP_PROCESSING(SSobj, src)
	QDEL_NULL(dampening_field)
	QDEL_NULL(internal_dampener)
	return ..()


/obj/structure/destructible/clockwork/gear_base/interdiction_lens/attack_hand(mob/user)
	if(!IS_CLOCK(user))
		return ..()

	if(!anchored)
		balloon_alert(user, "not fastened!")
		return

	if(!update_power() && !enabled)
		balloon_alert(user, "not enough power!")
		return

	enabled = !enabled
	to_chat(user, span_brass("You flick the switch on [src], turning it [enabled ? "on" : "off"]!"))

	if(enabled)
		repowered()
		processing = TRUE
		START_PROCESSING(SSobj, src)

	else
		depowered()
		processing = FALSE
		STOP_PROCESSING(SSobj, src)


/obj/structure/destructible/clockwork/gear_base/interdiction_lens/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	if(!.)
		return

	if(anchored)
		return

	enabled = FALSE
	depowered()

	if(processing)
		processing = FALSE
		STOP_PROCESSING(SSobj, src)


/obj/structure/destructible/clockwork/gear_base/interdiction_lens/process(delta_time)
	if(!use_power(PASSIVE_POWER_USE))
		depowered()
		insufficient_power = TRUE
		return

	if(insufficient_power)
		insufficient_power = FALSE
		repowered()

	if(DT_PROB(5, delta_time))
		new /obj/effect/temp_visual/steam_release(get_turf(src))

	for(var/mob/living/living_mob in viewers(INTERDICTION_LENS_RANGE, src))
		if(!IS_CLOCK(living_mob) && use_power(POWER_PER_PERSON))
			living_mob.apply_status_effect(/datum/status_effect/interdiction)

	for(var/obj/vehicle/sealed/mecha/mech in range(INTERDICTION_LENS_RANGE, src))
		if(!use_power(POWER_PER_PERSON))
			continue

		mech.emp_act(EMP_HEAVY)
		do_sparks(mech, TRUE, mech)


/obj/structure/destructible/clockwork/gear_base/interdiction_lens/repowered()
	. = ..()
	icon_state = "interdiction_lens_active"
	flick("interdiction_lens_recharged", src)

	if(istype(dampening_field))
		QDEL_NULL(dampening_field)

	dampening_field = new(src, INTERDICTION_LENS_RANGE, TRUE, src)


/obj/structure/destructible/clockwork/gear_base/interdiction_lens/depowered()
	. = ..()
	icon_state = "interdiction_lens"
	flick("interdiction_lens_discharged", src)
	QDEL_NULL(dampening_field)


/obj/structure/destructible/clockwork/gear_base/interdiction_lens/free/use_power(amount)
	return


/obj/structure/destructible/clockwork/gear_base/interdiction_lens/free/check_power(amount)
	if(!LAZYLEN(transmission_sigils))
		return FALSE
	return TRUE


//Dampening field

/datum/proximity_monitor/advanced/projectile_dampener/peaceborg/clockwork

/datum/proximity_monitor/advanced/projectile_dampener/peaceborg/clockwork/setup_edge_turf(turf/target)
	edge_turfs |= target


/datum/proximity_monitor/advanced/projectile_dampener/peaceborg/clockwork/cleanup_edge_turf(turf/target)
	edge_turfs -= target


/datum/proximity_monitor/advanced/projectile_dampener/peaceborg/clockwork/capture_projectile(obj/projectile/fired_projectile, track_projectile = TRUE)
	if(fired_projectile in tracked)
		return

	if(isliving(fired_projectile.firer))
		var/mob/living/living_firer = fired_projectile.firer
		if(IS_CLOCK(living_firer))
			return

	var/obj/structure/destructible/clockwork/gear_base/interdiction_lens/host_lens = host

	host_lens.internal_dampener.dampen_projectile(fired_projectile, track_projectile)

	if(track_projectile)
		tracked += fired_projectile


/obj/item/borg/projectile_dampen/clockcult
	name = "internal clockcult projectile dampener"
	projectile_damage_coefficient = 0.75 // Only -25% damage instead of -50%


/obj/item/borg/projectile_dampen/clockcult/process_recharge()
	energy = maxenergy

#undef INTERDICTION_LENS_RANGE
#undef POWER_PER_PERSON
