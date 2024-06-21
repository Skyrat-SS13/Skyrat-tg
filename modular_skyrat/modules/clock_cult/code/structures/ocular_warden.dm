#define FIRE_DELAY (2 SECONDS)
#define FIRE_RANGE 4
#define BASE_DAMAGE 15
#define MINIMUM_DAMAGE 7.5
#define DAMAGE_FALLOFF 1
#define SHOOT_POWER_USE 5

/obj/structure/destructible/clockwork/gear_base/powered/ocular_warden
	name = "ocular warden"
	desc = "A wide, open eye that stares intently into your soul. It seems resistant to energy based weapons."
	clockwork_desc = "A defensive device that will fight any nearby intruders."
	break_message = span_warning("A black ooze leaks from the ocular warden as it slowly sinks to the ground.")
	icon_state = "ocular_warden"
	base_icon_state = "ocular_warden"
	max_integrity = 75
	armor_type = /datum/armor/clockwork_ocular_warden
	passive_consumption = 10
	minimum_power = SHOOT_POWER_USE
	can_unwrench = FALSE
	anchored = TRUE
	/// Cooldown between firing
	COOLDOWN_DECLARE(fire_cooldown)

/datum/armor/clockwork_ocular_warden
	melee = -50
	bullet = -20
	laser = 50
	energy = 50
	bomb = 20
	bio = 0

/obj/structure/destructible/clockwork/gear_base/powered/ocular_warden/process(seconds_per_tick)
	. = ..()
	if(!.)
		return

	if(!COOLDOWN_FINISHED(src, fire_cooldown))
		return

	//Check hostiles in range
	var/list/valid_targets = list()
	for(var/mob/living/potential_target in hearers(FIRE_RANGE, src))

		if(IS_CLOCK(potential_target) || potential_target.stat)
			continue

		valid_targets += potential_target

	if(!length(valid_targets))
		return

	if(!use_power(SHOOT_POWER_USE))
		return

	playsound(src, 'modular_skyrat/modules/clock_cult/sound/machinery/ocularwarden-target.ogg', 60, TRUE)

	var/mob/living/target = pick(valid_targets)
	if(!target)
		return

	dir = get_dir(get_turf(src), get_turf(target))

	// Apply 15 damage (- 1 for each tile away they are), or 7.5, whichever is larger
	target.apply_damage(max(BASE_DAMAGE - (get_dist(src, target) * DAMAGE_FALLOFF), MINIMUM_DAMAGE) * seconds_per_tick, BURN)

	new /obj/effect/temp_visual/ratvar/ocular_warden(get_turf(target))
	new /obj/effect/temp_visual/ratvar/ocular_warden(get_turf(src))

	playsound(target, pick('modular_skyrat/modules/clock_cult/sound/machinery/ocularwarden-dot1.ogg', 'modular_skyrat/modules/clock_cult/sound/machinery/ocularwarden-dot2.ogg'), 60, TRUE)

	COOLDOWN_START(src, fire_cooldown, FIRE_DELAY)

#undef FIRE_DELAY
#undef FIRE_RANGE
#undef BASE_DAMAGE
#undef MINIMUM_DAMAGE
#undef DAMAGE_FALLOFF
#undef SHOOT_POWER_USE
