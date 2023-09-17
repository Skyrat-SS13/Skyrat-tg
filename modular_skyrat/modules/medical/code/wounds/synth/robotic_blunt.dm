/// If a incoming attack is blunt, we increase the daze amount by this amount
#define BLUNT_ATTACK_DAZE_MULT 1.5

/// Cost of an RCD to quickly fix our broken superstructure
#define ROBOTIC_T3_BLUNT_WOUND_RCD_COST 25
#define ROBOTIC_T3_BLUNT_WOUND_RCD_SILO_COST ROBOTIC_T3_BLUNT_WOUND_RCD_COST / 4

#define ROBOTIC_WOUND_DETERMINATION_MOVEMENT_EFFECT_MOD 0.5
#define ROBOTIC_WOUND_DETERMINATION_HIT_DAZE_MULT ROBOTIC_WOUND_DETERMINATION_MOVEMENT_EFFECT_MOD
#define ROBOTIC_WOUND_DETERMINATION_HIT_STAGGER_MULT 0.5

#define ROBOTIC_BLUNT_GRASPED_MOVEMENT_MULT 0.7

#define ROBOTIC_BLUNT_CROWBAR_SHOCK_DAMAGE 20
#define ROBOTIC_BLUNT_CROWBAR_BRUTE_DAMAGE 20

/// Gloves must be above or at this threshold to cause the user to not be burnt apon trying to mold metal.
#define ROBOTIC_BLUNT_MOLD_METAL_HEAT_RESISTANCE_THRESHOLD 1000 // less than the black gloves max resist

/datum/wound/blunt/robotic
	name = "Robotic Blunt (Screws and bolts) Wound"
	wound_flags = (ACCEPTS_GAUZE|SPLINT_OVERLAY|CAN_BE_GRASPED)

	default_scar_file = METAL_SCAR_FILE

	/// If we suffer severe head booboos, we can get brain traumas tied to them
	var/datum/brain_trauma/active_trauma
	/// What brain trauma group, if any, we can draw from for head wounds
	var/brain_trauma_group
	/// If we deal brain traumas, when is the next one due?
	var/next_trauma_cycle
	/// How long do we wait +/- 20% for the next trauma?
	var/trauma_cycle_cooldown

	/// The ratio stagger score will be multiplied against for determining the final chance of moving away from the attacker.
	var/stagger_movement_chance_ratio = 1
	/// The ratio stagger score will be multiplied against for determining the amount of pixelshifting we will do when we are hit.
	var/stagger_shake_shift_ratio = 0.05

	/// The ratio of stagger score to shake duration during a stagger() call
	var/stagger_score_to_shake_duration_ratio = 0.1

	/// In the stagger aftershock, the stagger score will be multiplied against for determining the chance of dropping held items.
	var/stagger_drop_chance_ratio = 1.25
	/// In the stagger aftershock, the stagger score will be multiplied aginst for determining the chance of falling over.
	var/stagger_fall_chance_ratio = 1

	/// In the stagger aftershock, the stagger score will be multiplied against for determining how long we are knocked down for.
	var/stagger_aftershock_knockdown_ratio = 0.5
	/// In the stagger after shock, the stagger score will be multiplied against this (if caused by movement) for determining how long we are knocked down for.
	var/stagger_aftershock_knockdown_movement_ratio = 0.1

	/// If the victim stops moving before the aftershock, aftershock effects will be multiplied against this.
	var/aftershock_stopped_moving_score_mult = 0.1

	/// The ratio damage applied will be multiplied against for determining our stagger score.
	var/chest_attacked_stagger_mult = 2.5
	/// The minimum score an attack must do to trigger a stagger.
	var/chest_attacked_stagger_minimum_score = 5
	/// The ratio of damage to stagger chance on hit.
	var/chest_attacked_stagger_chance_ratio = 2

	/// The base score given to stagger() when we successfully stagger on a move.
	var/base_movement_stagger_score = 30
	/// The base chance of moving to trigger stagger().
	var/chest_movement_stagger_chance = 1

	/// The base duration of a stagger()'s sprite shaking.
	var/base_stagger_shake_duration = 1.5 SECONDS
	/// The base duration of a stagger()'s sprite shaking if caused by movement.
	var/base_stagger_movement_shake_duration = 1.5 SECONDS

	/// The ratio of stagger score to camera shake chance.
	var/stagger_camera_shake_chance_ratio = 0.75
	/// The base duration of a stagger's aftershock's camerashake.
	var/base_aftershock_camera_shake_duration = 1.5 SECONDS
	/// The base strength of a stagger's aftershock's camerashake.
	var/base_aftershock_camera_shake_strength = 0.5

	/// The amount of x and y pixels we will be shaken around by during a movement stagger.
	var/movement_stagger_shift = 1

	/// If we are currently oscillating. If true, we cannot stagger().
	var/oscillating = FALSE

	/// % chance for hitting our limb to fix something.
	var/percussive_maintenance_repair_chance = 10
	/// Damage must be under this to proc percussive maintenance.
	var/percussive_maintenance_damage_max = 7
	/// Damage must be over this to proc percussive maintenance.
	var/percussive_maintenance_damage_min = 0

	/// The time, in world time, that we will be allowed to do another movement shake. Useful because it lets us prioritize attacked shakes over movement shakes.
	var/time_til_next_movement_shake_allowed = 0

	/// The percent our limb must get to max possible damage by burn damage alone to count as malleable if it has no T2 burn wound.
	var/limb_burn_percent_to_max_threshold_for_malleable = 0.8 // must be 75% to max damage by burn damage alone

	/// The last time our victim has moved. Used for determining if we should increase or decrease the chance of having stagger aftershock.
	var/last_time_victim_moved = 0

	processes = TRUE

/datum/wound_pregen_data/blunt_metal
	abstract = TRUE

	required_limb_biostate = BIO_METAL

	wound_series = WOUND_SERIES_METAL_BLUNT_BASIC
	required_wounding_types = list(WOUND_BLUNT)

/datum/wound_pregen_data/blunt_metal/generate_scar_priorities()
	return list("[BIO_METAL]")

/datum/wound/blunt/robotic/set_victim(new_victim)
	if (victim)
		UnregisterSignal(victim, COMSIG_MOVABLE_MOVED)
		UnregisterSignal(victim, COMSIG_MOB_AFTER_APPLY_DAMAGE)
	if (new_victim)
		RegisterSignal(new_victim, COMSIG_MOVABLE_MOVED, PROC_REF(victim_moved))
		RegisterSignal(new_victim, COMSIG_MOB_AFTER_APPLY_DAMAGE, PROC_REF(victim_attacked))

	return ..()

/datum/wound/blunt/robotic/get_limb_examine_description()
	return span_warning("This limb looks loosely held together.")

/datum/wound/blunt/robotic/get_xadone_progress_to_qdel()
	return INFINITY

/datum/wound/blunt/robotic/wound_injury(datum/wound/old_wound, attack_direction)
	. = ..()

	// hook into gaining/losing gauze so crit bone wounds can re-enable/disable depending if they're slung or not
	if(limb.body_zone == BODY_ZONE_HEAD && brain_trauma_group)
		processes = TRUE
		active_trauma = victim.gain_trauma_type(brain_trauma_group, TRAUMA_RESILIENCE_WOUND)
		next_trauma_cycle = world.time + (rand(100-WOUND_BONE_HEAD_TIME_VARIANCE, 100+WOUND_BONE_HEAD_TIME_VARIANCE) * 0.01 * trauma_cycle_cooldown)

	if(limb.held_index && victim.get_item_for_held_index(limb.held_index) && (disabling || prob(30 * severity)))
		var/obj/item/I = victim.get_item_for_held_index(limb.held_index)
		if(istype(I, /obj/item/offhand))
			I = victim.get_inactive_held_item()

		if(I && victim.dropItemToGround(I))
			victim.visible_message(span_danger("[victim] drops [I] in shock!"), span_warning("<b>The force on your [limb.plaintext_zone] causes you to drop [I]!</b>"), vision_distance=COMBAT_MESSAGE_RANGE)

/datum/wound/blunt/robotic/remove_wound(ignore_limb, replaced)
	. = ..()

	QDEL_NULL(active_trauma)

/datum/wound/blunt/robotic/handle_process(seconds_per_tick, times_fired)
	. = ..()

	if (!victim || IS_IN_STASIS(victim))
		return

	if (limb.body_zone == BODY_ZONE_HEAD && brain_trauma_group && world.time > next_trauma_cycle)
		if (active_trauma)
			QDEL_NULL(active_trauma)
		else
			active_trauma = victim.gain_trauma_type(brain_trauma_group, TRAUMA_RESILIENCE_WOUND)
		next_trauma_cycle = world.time + (rand(100-WOUND_BONE_HEAD_TIME_VARIANCE, 100+WOUND_BONE_HEAD_TIME_VARIANCE) * 0.01 * trauma_cycle_cooldown)

/// If true, allows our superstructure to be modified if we are T3. RCDs can always fix our superstructure.
/datum/wound/blunt/robotic/proc/limb_malleable()
	if (!isnull(get_overheat_wound()))
		return TRUE
	var/burn_damage_to_max = (limb.burn_dam / limb.max_damage) // only exists for the weird case where it cant get a overheat wound
	if (burn_damage_to_max >= limb_burn_percent_to_max_threshold_for_malleable)
		return TRUE
	return FALSE

/// If we have one, returns a robotic overheat wound of severe severity or higher. Null otherwise.
/datum/wound/blunt/robotic/proc/get_overheat_wound()
	RETURN_TYPE(/datum/wound/burn/robotic/overheat)
	for (var/datum/wound/found_wound as anything in limb.wounds)
		var/datum/wound_pregen_data/pregen_data = found_wound.get_pregen_data()
		if (pregen_data.wound_series == WOUND_SERIES_METAL_BURN_OVERHEAT && found_wound.severity >= WOUND_SEVERITY_SEVERE) // meh solution but whateva
			return found_wound
	return null

/datum/wound/blunt/robotic/proc/victim_attacked(datum/source, damage, damagetype, def_zone, blocked, wound_bonus, bare_wound_bonus, sharpness, attack_direction, attacking_item)
	SIGNAL_HANDLER

	if (def_zone != limb.body_zone) // use this proc since receive damage can also be called for like, chems and shit
		return

	if(!victim)
		return

	var/effective_damage = (damage - blocked)

	var/obj/item/stack/gauze = limb.current_gauze
	if (gauze)
		effective_damage *= gauze.splint_factor

	switch (limb.body_zone)

		if (BODY_ZONE_CHEST)
			var/oscillation_mult = 1
			if (victim.body_position == LYING_DOWN)
				oscillation_mult *= 0.5
			var/oscillation_damage = effective_damage
			var/stagger_damage = oscillation_damage * chest_attacked_stagger_mult
			if (victim.has_status_effect(/datum/status_effect/determined))
				oscillation_damage *= ROBOTIC_WOUND_DETERMINATION_HIT_STAGGER_MULT
			if ((stagger_damage >= chest_attacked_stagger_minimum_score) && prob(oscillation_damage * chest_attacked_stagger_chance_ratio))
				stagger(stagger_damage, attack_direction, attacking_item, shift = stagger_damage * stagger_shake_shift_ratio)

	if (!uses_percussive_maintenance() || damage < percussive_maintenance_damage_min || damage > percussive_maintenance_damage_max || damagetype != BRUTE || sharpness)
		return
	var/success_chance_mult = 1
	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		success_chance_mult *= 1.5
	var/mob/living/user
	if (isatom(attacking_item))
		var/atom/attacking_atom = attacking_item
		user = attacking_atom.loc // nullable

		if (istype(user))
			if (HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD))
				success_chance_mult *= 1.5

		if (user != victim)
			success_chance_mult *= 2.5 // encourages people to get other people to beat the shit out of their limbs
	if (prob(percussive_maintenance_repair_chance * success_chance_mult))
		handle_percussive_maintenance_success(attacking_item, user)
	else
		handle_percussive_maintenance_failure(attacking_item, user)

/datum/wound/blunt/robotic/proc/stagger(stagger_score, attack_direction, obj/item/attacking_item, from_movement, shake_duration = base_stagger_shake_duration, shift, knockdown_ratio = stagger_aftershock_knockdown_ratio)
	if (oscillating)
		return

	if (!attack_direction)
		attack_direction = get_dir(victim, attacking_item)

	var/self_message = "Your [limb.plaintext_zone] oscillates"
	var/message = "[victim]'s [limb.plaintext_zone] oscillates"
	if (attacking_item)
		message += " from the impact"
	else if (from_movement)
		message += " from the movement"
	message += "!"
	self_message += "! You might be able to avoid an aftershock by stopping and waiting..."

	if (attack_direction && prob(stagger_score * stagger_movement_chance_ratio))
		to_chat(victim, span_warning("The force of the blow sends you reeling!"))
		var/turf/target_loc = get_step(victim, attack_direction)
		victim.Move(target_loc)

	victim.visible_message(span_warning(message), ignored_mobs = victim)
	to_chat(victim, span_warning(self_message))
	victim.balloon_alert(victim, "oscillation! stop moving")

	victim.Shake(pixelshiftx = shift, pixelshifty = shift, duration = shake_duration)
	var/aftershock_delay = (shake_duration / 1.35)
	var/knockdown_time = stagger_score * knockdown_ratio
	addtimer(CALLBACK(src, PROC_REF(aftershock), stagger_score, attack_direction, attacking_item, world.time, knockdown_time), aftershock_delay)
	oscillating = TRUE

/datum/wound/blunt/robotic/proc/aftershock(stagger_score, attack_direction, obj/item/attacking_item, stagger_starting_time, knockdown_time)
	if (!still_exists())
		return FALSE
	var/message = "The oscillations from your [limb.plaintext_zone] spread, "
	var/limb_message = "causing "
	var/limb_affected

	var/stopped_moving_grace_threshold = (world.time - ((world.time - stagger_starting_time) / 3)) // higher divisor = later grace period = more forgiving
	var/victim_stopped_moving = (last_time_victim_moved <= stopped_moving_grace_threshold)
	if (victim_stopped_moving)
		stagger_score *= aftershock_stopped_moving_score_mult

	if (prob(stagger_score * stagger_drop_chance_ratio))
		limb_message += "your <b>hands</b>"
		victim.drop_all_held_items()
		limb_affected = TRUE

	if (prob(stagger_score * stagger_fall_chance_ratio))
		if (limb_affected)
			limb_message += " and "
		limb_message += "your <b>legs</b>"
		victim.Knockdown(knockdown_time)
		limb_affected = TRUE

	if (prob(stagger_score * stagger_camera_shake_chance_ratio))
		if (limb_affected)
			limb_message += " and "
		limb_message += "your <b>head</b>"
		shake_camera(victim, base_aftershock_camera_shake_duration, base_aftershock_camera_shake_strength)
		limb_affected = TRUE

	if (limb_affected)
		message += "[limb_message] to shake uncontrollably!"
	else
		message += "but pass harmlessly"
		if (victim_stopped_moving)
			message += " thanks to your stillness"
		message += "."

	to_chat(victim, span_danger(message))
	victim.balloon_alert(victim, "oscillation over")

	oscillating = FALSE

/// Called when percussive maintenance succeeds at its random roll.
/datum/wound/blunt/robotic/proc/handle_percussive_maintenance_success(attacking_item, mob/living/user)
	victim.visible_message(span_green("[victim]'s [limb.plaintext_zone] rattles from the impact, but looks a lot more secure!"), \
		span_green("Your [limb.plaintext_zone] rattles into place!"))
	remove_wound()

/// Called when percussive maintenance faisl at its random roll.
/datum/wound/blunt/robotic/proc/handle_percussive_maintenance_failure(attacking_item, mob/living/user)
	to_chat(victim, span_warning("Your [limb.plaintext_zone] rattles around, but you don't sense any sign of improvement."))

/datum/wound/blunt/robotic/proc/victim_moved(datum/source, atom/old_loc, dir, forced, list/old_locs)
	SIGNAL_HANDLER

	var/overall_mult = 1

	var/obj/item/stack/gauze = limb.current_gauze
	if (gauze)
		overall_mult *= gauze.splint_factor
	if (!victim.has_gravity(get_turf(victim)))
		overall_mult *= 0.5
	else if (victim.body_position == LYING_DOWN || (!forced && victim.move_intent == MOVE_INTENT_WALK))
		overall_mult *= 0.25
	if (victim.has_status_effect(/datum/status_effect/determined))
		overall_mult *= ROBOTIC_WOUND_DETERMINATION_MOVEMENT_EFFECT_MOD
	if (limb.grasped_by)
		overall_mult *= ROBOTIC_BLUNT_GRASPED_MOVEMENT_MULT

	overall_mult *= get_buckled_movement_consequence_mult(victim.buckled)

	if (limb.body_zone == BODY_ZONE_CHEST)
		if (prob(chest_movement_stagger_chance * overall_mult))
			stagger(base_movement_stagger_score, shake_duration = base_stagger_movement_shake_duration, from_movement = TRUE, shift = movement_stagger_shift, knockdown_ratio = stagger_aftershock_knockdown_movement_ratio)

	last_time_victim_moved = world.time

/// Merely a wrapper proc for adjust_disgust that sends a to_chat.
/datum/wound/blunt/robotic/proc/shake_organs_for_nausea(score, max)
	victim.adjust_disgust(score, max)
	to_chat(victim, span_warning("You feel a wave of nausea as your [limb.plaintext_zone]'s internals jostle..."))

/// Returns a multiplier to our movement effects based on what our victim is buckled to.
/datum/wound/blunt/robotic/proc/get_buckled_movement_consequence_mult(atom/movable/buckled_to)
	if (!buckled_to)
		return 1

	if (istype(buckled_to, /obj/structure/bed/medical))
		return 0.05
	else
		return 0.5

/// If this wound can be treated in its current state by just hitting it with a low force object. Exists for conditional logic, e.g. "Should we respond
/// to percussive maintenance right now?". Critical blunt uses this to only react when the limb is malleable and superstructure is broken.
/datum/wound/blunt/robotic/proc/uses_percussive_maintenance()
	return FALSE

/datum/wound/blunt/robotic/moderate
	name = "Loosened Screws"
	desc = "Various semi-external fastening instruments have loosened, causing components to jostle, inhibiting limb control."
	treat_text = "Recommend topical re-fastening of instruments with a screwdriver, though percussive maintenance via low-force bludgeoning may suffice - \
	albiet at risk of worsening the injury."
	examine_desc = "appears to be loosely secured"
	occur_text = "jostles awkwardly and seems to slightly unfasten"
	severity = WOUND_SEVERITY_MODERATE

	simple_treat_text = "<b>Bandaging</b> the wound will reduce the impact until it's <b>screws are secured</b> - which is <b>faster</b> if done by \
	<b>someone else</b>, a <b>roboticist</b>, an <b>engineer</b>, or with a <b>diagnostic HUD</b>."
	homemade_treat_text = "In a pinch, <b>percussive maintenance</b> can reset the screws - the chance of which is increased if done by <b>someone else</b> or \
	with a <b>diagnostic HUD</b>!"

	status_effect_type = /datum/status_effect/wound/blunt/robotic/moderate
	treatable_tools = list(TOOL_SCREWDRIVER)

	interaction_efficiency_penalty = 1.2
	limp_slowdown = 2.5
	limp_chance = 30
	threshold_penalty = 20

	can_scar = FALSE

	a_or_from = "from"

/datum/wound_pregen_data/blunt_metal/loose_screws
	abstract = FALSE

	wound_path_to_generate = /datum/wound/blunt/robotic/moderate
	viable_zones = list(BODY_ZONE_CHEST, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)

	threshold_minimum = 30

/datum/wound/blunt/robotic/moderate/uses_percussive_maintenance()
	return TRUE

/datum/wound/blunt/robotic/moderate/treat(obj/item/I, mob/user)
	if (I.tool_behaviour == TOOL_SCREWDRIVER)
		fasten_screws(I, user)
		return TRUE

	return ..()

/datum/wound/blunt/robotic/moderate/proc/fasten_screws(obj/item/screwdriver_tool, mob/user)
	if (!screwdriver_tool.tool_start_check())
		return

	var/delay_mult = 1

	if (user == victim)
		delay_mult *= 3

	if (HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD))
		delay_mult *= 0.5

	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= 0.5

	var/their_or_other = (user == victim ? "[user.p_their()]]" : "[user]'s")
	var/your_or_other = (user == victim ? "your" : "[user]'s")
	victim.visible_message(span_notice("[user] begins fastening the screws of [their_or_other] [limb.plaintext_zone]..."), \
		span_notice("You begin fastening the screws of [your_or_other] [limb.plaintext_zone]..."))

	if (!screwdriver_tool.use_tool(target = victim, user = user, delay = (10 SECONDS * delay_mult), volume = 50, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return

	victim.visible_message(span_green("[user] finishes fastening [their_or_other] [limb.plaintext_zone]!"), \
		span_green("You finish fastening [your_or_other] [limb.plaintext_zone]!"))

	remove_wound()

/// Placeholder documentation
/datum/wound/blunt/robotic/secures_internals
	/// Our current counter for gel + gauze regeneration
	var/regen_time_elapsed = 0 SECONDS
	/// Time needed for gel to secure internals.
	var/regen_time_needed = 30 SECONDS

	/// If we have used bone gel to secure internals.
	var/gelled = FALSE
	/// Total brute damage taken over the span of [regen_time_needed] deciseconds when we gel our limb.
	var/gel_damage = 10 // brute in total

	/// If we are ready to begin screwdrivering or gelling our limb.
	var/ready_to_secure_internals = FALSE
	/// If our external plating has been torn open and we can access our internals without a tool
	var/crowbarred_open = FALSE
	/// If internals are secured, and we are ready to weld our limb closed and end the wound
	var/ready_to_resolder = TRUE

/datum/wound/blunt/robotic/secures_internals/handle_process(seconds_per_tick, times_fired)
	. = ..()

	if (!victim || IS_IN_STASIS(victim))
		return

	if (gelled)
		regen_time_elapsed += ((seconds_per_tick SECONDS) / 2)
		if(victim.body_position == LYING_DOWN)
			if(SPT_PROB(30, seconds_per_tick))
				regen_time_elapsed += 1 SECONDS
			if(victim.IsSleeping() && SPT_PROB(30, seconds_per_tick))
				regen_time_elapsed += 1 SECONDS

		var/effective_damage = ((gel_damage / (regen_time_needed / 10)) * seconds_per_tick)
		var/obj/item/stack/gauze = limb.current_gauze
		if (gauze)
			effective_damage *= gauze.splint_factor
		limb.receive_damage(effective_damage, wound_bonus = CANT_WOUND, damage_source = src)
		if(effective_damage && prob(33))
			var/gauze_text = (gauze?.splint_factor ? ", although the [gauze] helps to prevent some of the leakage" : "")
			to_chat(victim, span_danger("Your [limb.plaintext_zone] sizzles as some gel leaks and warps the exterior metal[gauze_text]..."))

		if(regen_time_elapsed > regen_time_needed)
			if(!victim || !limb)
				qdel(src)
				return
			to_chat(victim, span_green("The gel within your [limb.plaintext_zone] has fully hardened, allowing you to re-solder it!"))
			gelled = FALSE
			ready_to_resolder = TRUE
			ready_to_secure_internals = FALSE
			set_disabling(FALSE)

/datum/wound/blunt/robotic/secures_internals/modify_desc_before_span(desc)
	. = ..()

	var/use_exclamation = FALSE

	if (!limb.current_gauze) // gauze covers it up
		if (crowbarred_open)
			. += ", [span_notice("and is violently torn open, internals visible to the outside")]"
			use_exclamation = TRUE
		if (gelled)
			. += ", [span_notice("with fizzling blue surgical gel leaking out of the cracks")]"
			use_exclamation = TRUE
		if (use_exclamation)
			. += "!"

/datum/wound/blunt/robotic/secures_internals/get_scanner_description(mob/user)
	. = ..()

	var/to_add = get_wound_status()
	if (!isnull(to_add))
		. += "\nWound status: [to_add]"

/datum/wound/blunt/robotic/secures_internals/get_simple_scanner_description(mob/user)
	. = ..()

	var/to_add = get_wound_status()
	if (!isnull(to_add))
		. += "\nWound status: [to_add]"

/datum/wound/blunt/robotic/secures_internals/proc/get_wound_status(mob/user)
	if (crowbarred_open)
		. += "The limb has been torn open, allowing ease of access to internal components, but also disabling it. "
	if (gelled)
		. += "Bone gel has been applied, causing progressive corrosion of the metal, but eventually securing the internals. "

/datum/wound/blunt/robotic/secures_internals/item_can_treat(obj/item/potential_treater, mob/user)
	if (potential_treater.tool_behaviour == TOOL_WELDER || potential_treater.tool_behaviour == TOOL_CAUTERY)
		if (ready_to_resolder)
			return TRUE

	if (ready_to_secure_internals)
		if (item_can_secure_internals(potential_treater))
			return TRUE

	return ..()

/datum/wound/blunt/robotic/secures_internals/treat(obj/item/item, mob/user)
	if (ready_to_secure_internals)
		if (istype(item, /obj/item/stack/medical/bone_gel))
			return apply_gel(item, user)
		else if (!crowbarred_open && item.tool_behaviour == TOOL_CROWBAR)
			return crowbar_open(item, user)
		else if (item_can_secure_internals(item))
			return secure_internals_normally(item, user)
	else if (ready_to_resolder && (item.tool_behaviour == TOOL_WELDER) || (item.tool_behaviour == TOOL_CAUTERY))
		return resolder(item, user)

	return ..()

/// Returns TRUE if the item can be used in our 1st step (2nd if T3) of repairs.
/datum/wound/blunt/robotic/secures_internals/proc/item_can_secure_internals(obj/item/potential_treater)
	return (potential_treater.tool_behaviour == TOOL_SCREWDRIVER || potential_treater.tool_behaviour == TOOL_WRENCH || istype(potential_treater, /obj/item/stack/medical/bone_gel))

// Can crowbar the limb to tear it open, inconsistant without shock protection, but massively increases the chance of normally securing internals
/datum/wound/blunt/robotic/secures_internals/proc/crowbar_open(obj/item/crowbarring_item, mob/living/user)
	if (!crowbarring_item.tool_start_check())
		return TRUE

	var/delay_mult = 1
	if (user == victim)
		delay_mult *= 2

	if (HAS_TRAIT(user, TRAIT_KNOW_ROBO_WIRES))
		delay_mult *= 0.5
	if (HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		delay_mult *= 0.5
	if (HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD))
		delay_mult *= 0.5
	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= 0.5

	var/their_or_other = (user == victim ? "their" : "[user]'s")
	var/your_or_other = (user == victim ? "your" : "[user]'s")

	var/self_message = span_warning("You start prying open [your_or_other] [limb.plaintext_zone] with [crowbarring_item]...")

	user?.visible_message(span_bolddanger("[user] starts prying open [their_or_other] [limb.plaintext_zone] with [crowbarring_item]!"), self_message, ignored_mobs = list(victim))

	var/victim_message
	if (user != victim) // this exists so we can do a userdanger
		victim_message = span_userdanger("[user] starts prying open your [limb.plaintext_zone] with [crowbarring_item]!")
	else
		victim_message = self_message
	to_chat(victim, victim_message)

	playsound(get_turf(crowbarring_item), 'sound/machines/airlock_alien_prying.ogg', 30, TRUE)
	if (!crowbarring_item.use_tool(target = victim, user = user, delay = (7 SECONDS * delay_mult), volume = 50, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	var/limb_can_shock = (victim.stat != DEAD && limb.biological_state & BIO_WIRED)
	var/stunned = FALSE

	var/message

	if (user && limb_can_shock)
		var/electrocute_flags = (SHOCK_KNOCKDOWN|SHOCK_NO_HUMAN_ANIM|SHOCK_SUPPRESS_MESSAGE)
		var/stun_chance = 100

		if (HAS_TRAIT(user, TRAIT_SHOCKIMMUNE))
			stun_chance = 0

		else if (iscarbon(user)) // doesnt matter if we're shock immune, its set to 0 anyway
			var/mob/living/carbon/carbon_user = user
			if (carbon_user.gloves)
				stun_chance *= carbon_user.gloves.siemens_coefficient

			if (ishuman(user))
				var/mob/living/carbon/human/human_user = user
				stun_chance *= human_user.physiology.siemens_coeff
			stun_chance *= carbon_user.dna.species.siemens_coeff

		if (stun_chance && prob(stun_chance))
			electrocute_flags &= ~SHOCK_KNOCKDOWN
			electrocute_flags &= ~SHOCK_NO_HUMAN_ANIM
			stunned = TRUE

			message = span_boldwarning("[user] is shocked by [their_or_other] [limb.plaintext_zone], [user.p_their()] crowbar slipping as [user.p_they()] briefly convulse!")
			self_message = span_userdanger("You are shocked by [your_or_other] [limb.plaintext_zone], causing your crowbar to slip out!")
			if (user != victim)
				victim_message = span_userdanger("[user] is shocked by your [limb.plaintext_zone] in [user.p_their()] efforts to tear it open!")

		var/shock_damage = ROBOTIC_BLUNT_CROWBAR_SHOCK_DAMAGE
		if (limb.current_gauze)
			shock_damage *= limb.current_gauze.splint_factor // always good to let gauze do something
		user.electrocute_act(shock_damage, limb, flags = electrocute_flags)

	if (!stunned)
		var/other_shock_text = ""
		var/self_shock_text = ""
		if (!limb_can_shock)
			other_shock_text = ", and is striken by golden bolts of electricity"
			self_shock_text = ", but are immediately beset apon by the electricity contained within"
		message = span_boldwarning("[user] tears open [their_or_other] [limb.plaintext_zone] with [user.p_their()] crowbar[other_shock_text]!")
		self_message = span_warning("You tear open [your_or_other] [limb.plaintext_zone] with your crowbar[self_shock_text]!")
		if (user != victim)
			victim_message = span_userdanger("Your [limb.plaintext_zone] fragments and splinters as [user] tears it open with [user.p_their()] crowbar!")

		playsound(get_turf(crowbarring_item), 'sound/effects/bang.ogg', 35, TRUE) // we did it!
		to_chat(user, span_green("You've torn [your_or_other] [limb.plaintext_zone] open, heavily damaging it but making it a lot easier to screwdriver the internals!"))
		var/damage = ROBOTIC_BLUNT_CROWBAR_BRUTE_DAMAGE
		if (limb_essential()) // cant be disabled
			damage *= 2
		limb.receive_damage(brute = ROBOTIC_BLUNT_CROWBAR_BRUTE_DAMAGE, wound_bonus = CANT_WOUND, damage_source = crowbarring_item)
		set_torn_open(TRUE)

	if (user == victim)
		victim_message = self_message

	user.visible_message(message, self_message, ignored_mobs = list(victim))
	to_chat(victim, victim_message)
	return TRUE

/datum/wound/blunt/robotic/secures_internals/proc/set_torn_open(torn_open_state)
	// if we arent disabling but we were torn open, OR if we arent disabling by default
	var/should_update_disabling = ((!disabling && torn_open_state) || !initial(disabling))

	crowbarred_open = torn_open_state
	if (should_update_disabling)
		set_disabling(torn_open_state)

/// The primary way to secure internals, with a screwdriver/wrench, very hard to do by yourself
/datum/wound/blunt/robotic/secures_internals/proc/secure_internals_normally(obj/item/securing_item, mob/user)
	if (!securing_item.tool_start_check())
		return TRUE

	var/chance = 10
	var/delay_mult = 1

	if (user == victim)
		if (!crowbarred_open)
			chance *= 0.2
		delay_mult *= 2

	if (crowbarred_open)
		chance *= 4 // even self-tends get a high chance of success if torn open!
	if (HAS_TRAIT(user, TRAIT_KNOW_ROBO_WIRES))
		chance *= 15 // almost guaranteed if its not self surgery
		delay_mult *= 0.5
	if (HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		chance *= 8
		delay_mult *= 0.85
	if (HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD))
		chance *= 3
	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		chance *= 2
		delay_mult *= 0.8

	var/confused = (chance < 25) // generate chance beforehand, so we can use this var

	var/their_or_other = (user == victim ? "their" : "[user]'s")
	var/your_or_other = (user == victim ? "your" : "[user]'s")
	user?.visible_message(span_notice("[user] begins the delicate operation of securing the internals of [their_or_other] [limb.plaintext_zone]..."), \
		span_notice("You begin the delicate operation of securing the internals of [your_or_other] [limb.plaintext_zone]..."))
	if (confused)
		to_chat(user, span_warning("You are confused by the layout of [your_or_other] [limb.plaintext_zone]! A diagnostic hud would help, as would knowing robo/engi wires! You could also tear the limb open with a crowbar..."))

	if (!securing_item.use_tool(target = victim, user = user, delay = (10 SECONDS * delay_mult), volume = 50, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	if (prob(chance))
		user?.visible_message(span_green("[user] finishes securing the internals of [their_or_other] [limb.plaintext_zone]!"), \
			span_green("You finish securing the internals of [your_or_other] [limb.plaintext_zone]!"))
		to_chat(user, span_green("[capitalize(your_or_other)] [limb.plaintext_zone]'s internals are now secure! Your next step is to weld/cauterize it."))
		ready_to_secure_internals = FALSE
		ready_to_resolder = TRUE
	else
		user?.visible_message(span_danger("[user] screws up and accidentally damages [their_or_other] [limb.plaintext_zone]!"))
		limb.receive_damage(brute = 5, damage_source = securing_item, wound_bonus = CANT_WOUND)

	return TRUE

// If we dont want to use a wrench/screwdriver, we can just use bone gel
/datum/wound/blunt/robotic/secures_internals/proc/apply_gel(obj/item/stack/medical/bone_gel/gel, mob/user)
	if (gelled)
		to_chat(user, span_warning("[user == victim ? "Your" : "[victim]'s"] [limb.plaintext_zone] is already filled with bone gel!"))
		return TRUE

	var/delay_mult = 1
	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= 0.75

	user.visible_message(span_danger("[user] begins hastily applying [gel] to [victim]'s [limb.plaintext_zone]..."), span_warning("You begin hastily applying [gel] to [user == victim ? "your" : "[victim]'s"] [limb.plaintext_zone], disregarding the acidic effect it seems to have on the metal..."))

	if (!do_after(user, (base_treat_time * 2 * (user == victim ? 1.5 : 1)) * delay_mult, target = victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	gel.use(1)
	if(user != victim)
		user.visible_message(span_notice("[user] finishes applying [gel] to [victim]'s [limb.plaintext_zone], emitting a fizzing noise!"), span_notice("You finish applying [gel] to [victim]'s [limb.plaintext_zone]!"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user] finishes applying [gel] to your [limb.plaintext_zone], and you can hear the sizzling of the metal..."))
	else
		victim.visible_message(span_notice("[victim] finishes applying [gel] to [victim.p_their()] [limb.plaintext_zone], emitting a funny fizzing sound!"), span_notice("You finish applying [gel] to your [limb.plaintext_zone], and you can hear the sizzling of the metal..."))

	gelled = TRUE
	set_disabling(TRUE)
	processes = TRUE
	return TRUE

// The final step - T2 and T3 end at this
/datum/wound/blunt/robotic/secures_internals/proc/resolder(obj/item/welding_item, mob/user)
	if (!welding_item.tool_start_check())
		return TRUE

	var/their_or_other = (user == victim ? "their" : "[user]'s")
	var/your_or_other = (user == victim ? "your" : "[user]'s")
	victim.visible_message(span_notice("[user] begins re-soldering [their_or_other] [limb.plaintext_zone]..."), \
		span_notice("You begin re-soldering [your_or_other] [limb.plaintext_zone]..."))

	var/delay_mult = 1
	if (welding_item.tool_behaviour == TOOL_CAUTERY)
		delay_mult *= 3
	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= 0.75

	if (!welding_item.use_tool(target = victim, user = user, delay = 7 SECONDS * delay_mult, volume = 50,  extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	victim.visible_message(span_green("[user] finishes re-soldering [their_or_other] [limb.plaintext_zone]!"), \
		span_notice("You finish re-soldering [your_or_other] [limb.plaintext_zone]!"))
	remove_wound()
	return TRUE

/datum/wound/blunt/robotic/secures_internals/severe
	name = "Detached Fastenings"
	desc = "Various fastening devices are extremely loose and solder has disconnected at multiple points, causing significant jostling of internal components and \
	noticable limb dysfunction."
	treat_text = "Fastening of bolts and screws by a qualified technician (though bone gel may suffice in the absence of one) followed by re-soldering."
	examine_desc = "jostles with every move, solder visibly broken"
	occur_text = "visibly cracks open, solder flying everywhere"
	severity = WOUND_SEVERITY_SEVERE

	simple_treat_text = "<b>If on the <b>chest</b>, <b>walk</b>, <b>grasp it</b>, <b>splint</b>, <b>rest</b> or <b>buckle yourself</b> to something to reduce movement effects. \
	Afterwards, get <b>someone else</b>, ideally a <b>robo/engi</b> to <b>screwdriver/wrench</b> it, and then <b>re-solder it</b>!"
	homemade_treat_text = "If <b>unable to screw/wrench</b>, <b>bone gel</b> can, over time, secure inner components at risk of <b>corrossion</b>. \
	Alternatively, <b>crowbar</b> the limb open to expose the internals - this will make it <b>easier</b> to re-secure them, but has a <b>high risk</b> of <b>shocking</b> you, \
	so use insulated gloves. This will <b>cripple the limb</b>, so use it only as a last resort!"

	wound_flags = (ACCEPTS_GAUZE|MANGLES_EXTERIOR|SPLINT_OVERLAY|CAN_BE_GRASPED)
	treatable_by = list(/obj/item/stack/medical/bone_gel)
	status_effect_type = /datum/status_effect/wound/blunt/robotic/severe
	treatable_tools = list(TOOL_WELDER, TOOL_CROWBAR)

	interaction_efficiency_penalty = 2
	limp_slowdown = 6
	limp_chance = 60

	brain_trauma_group = BRAIN_TRAUMA_MILD
	trauma_cycle_cooldown = 1.5 MINUTES

	threshold_penalty = 40

	base_movement_stagger_score = 40

	chest_attacked_stagger_chance_ratio = 5
	chest_attacked_stagger_mult = 3

	chest_movement_stagger_chance = 3

	stagger_aftershock_knockdown_ratio = 0.3
	stagger_aftershock_knockdown_movement_ratio = 0.2

	a_or_from = "from"

	ready_to_secure_internals = TRUE
	ready_to_resolder = FALSE

	scar_keyword = "bluntsevere"

/datum/wound_pregen_data/blunt_metal/fastenings
	abstract = FALSE

	wound_path_to_generate = /datum/wound/blunt/robotic/secures_internals/severe

	threshold_minimum = 65

/datum/wound/blunt/robotic/secures_internals/critical
	name = "Collapsed Superstructure"
	desc = "The superstructure has totally collapsed in one or more locations, causing extreme internal oscillation with every move and massive limb dysfunction"
	treat_text = "Reforming of superstructure via either RCD or manual molding, followed by typical treatment of loosened internals. \
				To manually mold, the limb must be aggressively grabbed and welded held to it to make it malleable (though attacking it til thermal overload may be adequate) \
				followed by firmly grasping and molding the limb with heat-resistant gloves."
	occur_text = "caves in on itself, damaged solder and shrapnel flying out in a miniature explosion"
	examine_desc = "has caved in, with internal components visible through gaps in the metal"
	severity = WOUND_SEVERITY_CRITICAL

	disabling = TRUE

	simple_treat_text = "If on the <b>chest</b>, <b>walk</b>, <b>grasp it</b>, <b>splint</b>, <b>rest</b> or <b>buckle yourself</b> to something to reduce movement effects. \
	Afterwards, get someone, ideally a <b>robo/engi</b> to <b>firmly grasp</b> the limb and hold a <b>welder</b> to it. Then, have them <b>use their hands</b> to <b>mold the metal</b> - \
	careful though, it's <b>hot</b>! An <b>RCD</b> can skip all this, but is hard to come by. Afterwards, have them <b>screw/wrench</b> and then <b>re-solder</b> the limb!"

	homemade_treat_text = "The metal can be made <b>malleable</b> by repeated application of a welder, to a <b>severe burn</b>. Afterwards, a <b>plunger</b> can reset the metal, \
	as can <b>percussive maintenance</b>. After the metal is reset, if <b>unable to screw/wrench</b>, <b>bone gel</b> can, over time, secure inner components at risk of <b>corrossion</b>. \
	Alternatively, <b>crowbar</b> the limb open to expose the internals - this will make it <b>easier</b> to re-secure them, but has a <b>high risk</b> of <b>shocking</b> you, \
	so use insulated gloves. This will <b>cripple the limb</b>, so use it only as a last resort!"

	interaction_efficiency_penalty = 2.8
	limp_slowdown = 8
	limp_chance = 80
	threshold_penalty = 60

	brain_trauma_group = BRAIN_TRAUMA_SEVERE
	trauma_cycle_cooldown = 2.5 MINUTES

	scar_keyword = "bluntcritical"

	status_effect_type = /datum/status_effect/wound/blunt/robotic/critical

	sound_effect = 'sound/effects/wounds/crack2.ogg'

	wound_flags = (ACCEPTS_GAUZE|MANGLES_EXTERIOR|SPLINT_OVERLAY|CAN_BE_GRASPED)
	treatable_by = list(/obj/item/stack/medical/bone_gel)
	status_effect_type = /datum/status_effect/wound/blunt/robotic/critical
	treatable_tools = list(TOOL_WELDER, TOOL_CROWBAR)

	base_movement_stagger_score = 55

	base_aftershock_camera_shake_duration = 1.75 SECONDS
	base_aftershock_camera_shake_strength = 1

	chest_attacked_stagger_chance_ratio = 6.5
	chest_attacked_stagger_mult = 4

	chest_movement_stagger_chance = 14

	aftershock_stopped_moving_score_mult = 0.3

	stagger_aftershock_knockdown_ratio = 0.5
	stagger_aftershock_knockdown_movement_ratio = 0.3

	percussive_maintenance_repair_chance = 3
	percussive_maintenance_damage_max = 6

	regen_time_needed = 60 SECONDS
	gel_damage = 20

	ready_to_secure_internals = FALSE
	ready_to_resolder = FALSE

	a_or_from = "a"

	/// Has the first stage of our treatment been completed? E.g. RCDed, manually molded...
	var/superstructure_remedied = FALSE

/datum/wound_pregen_data/blunt_metal/superstructure
	abstract = FALSE

	wound_path_to_generate = /datum/wound/blunt/robotic/secures_internals/critical

	threshold_minimum = 125

/datum/wound/blunt/robotic/secures_internals/critical/apply_wound(obj/item/bodypart/L, silent, datum/wound/old_wound, smited, attack_direction, wound_source)
	var/turf/limb_turf = get_turf(L)
	if (limb_turf)
		new /obj/effect/decal/cleanable/oil(limb_turf)
	var/turf/next_turf = get_step(limb_turf, REVERSE_DIR(attack_direction))
	if (next_turf)
		new /obj/effect/decal/cleanable/oil(next_turf)

	return ..()

/datum/wound/blunt/robotic/secures_internals/critical/item_can_treat(obj/item/potential_treater)
	if (!superstructure_remedied)
		if (istype(potential_treater, /obj/item/construction/rcd))
			return TRUE
		if (limb_malleable() && istype(potential_treater, /obj/item/plunger))
			return TRUE
	return ..()

/datum/wound/blunt/robotic/secures_internals/critical/check_grab_treatments(obj/item/potential_treater, mob/user)
	if (potential_treater.tool_behaviour == TOOL_WELDER && (!superstructure_remedied && !limb_malleable()))
		return TRUE
	return ..()

/datum/wound/blunt/robotic/secures_internals/critical/treat(obj/item/item, mob/user)
	if (!superstructure_remedied)
		if (istype(item, /obj/item/construction/rcd))
			return rcd_superstructure(item, user)
		if (uses_percussive_maintenance() && istype(item, /obj/item/plunger))
			return plunge(item, user)
		if (item.tool_behaviour == TOOL_WELDER && !limb_malleable() && isliving(victim.pulledby))
			var/mob/living/living_puller = victim.pulledby
			if (living_puller.grab_state >= GRAB_AGGRESSIVE) // only let other people do this
				return heat_metal(item, user)
	return ..()

/datum/wound/blunt/robotic/secures_internals/critical/try_handling(mob/living/carbon/human/user)
	if(user.pulling != victim || user.zone_selected != limb.body_zone)
		return FALSE

	if (superstructure_remedied || !limb_malleable())
		return FALSE

	if(user.grab_state < GRAB_AGGRESSIVE)
		to_chat(user, span_warning("You must have [victim] in an aggressive grab to manipulate [victim.p_their()] [lowertext(name)]!"))
		return TRUE

	user.visible_message(span_danger("[user] begins softly pressing against [victim]'s collapsed [limb.plaintext_zone]..."), span_notice("You begin softly pressing against [victim]'s collapsed [limb.plaintext_zone]..."), ignored_mobs=victim)
	to_chat(victim, span_userdanger("[user] begins softly pressing against your collapsed [limb.plaintext_zone]!"))

	var/delay_mult = 1
	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= 0.75

	if(!do_after(user, 8 SECONDS, target = victim, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return
	mold_metal(user)
	return TRUE

// Once our superstructure is heated (T2 robotic burn or 125% burn damage) we can aggro grab and start pushing the metal around
/datum/wound/blunt/robotic/secures_internals/critical/proc/mold_metal(mob/living/carbon/human/user)
	var/chance = 60

	if (HAS_TRAIT(user, TRAIT_KNOW_ROBO_WIRES))
		chance *= 3
	if (HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		chance *= 3
	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		chance *= 2

	var/their_or_other = (user == victim ? "their" : "[user]'s")
	var/your_or_other = (user == victim ? "your" : "[victim]'s")

	if ((user != victim && user.combat_mode))
		user.visible_message(span_bolddanger("[user] molds [their_or_other] [limb.plaintext_zone] into a really silly shape! What a goofball!"), \
			span_danger("You maliciously mold [victim]'s [limb.plaintext_zone] into a weird shape, damaging it in the process!"), ignored_mobs = victim)
		to_chat(victim, span_userdanger("[user] molds your [limb.plaintext_zone] into a weird shape, damaging it in the process!"))

		limb.receive_damage(brute = 30, wound_bonus = CANT_WOUND, damage_source = user)
	else if (prob(chance))
		user.visible_message(span_green("[user] carefully molds [their_or_other] [limb.plaintext_zone] into the proper shape!"), \
			span_green("You carefully mold [victim]'s [limb.plaintext_zone] into the proper shape!"), ignored_mobs = victim)
		to_chat(victim, span_green("[user] carefully molds your [limb.plaintext_zone] into the proper shape!"))
		to_chat(user, span_green("[capitalize(your_or_other)] [limb.plaintext_zone] has been molded into the proper shape! Your next step is to use a screwdriver/wrench to secure your internals."))
		set_superstructure_status(TRUE)
	else
		user.visible_message(span_danger("[user] accidentally molds [their_or_other] [limb.plaintext_zone] into the wrong shape!"), \
			span_danger("You accidentally mold [your_or_other] [limb.plaintext_zone] into the wrong shape!"), ignored_mobs = victim)
		to_chat(victim, span_userdanger("[user] accidentally molds your [limb.plaintext_zone] into the wrong shape!"))

		limb.receive_damage(brute = 5, damage_source = user, wound_bonus = CANT_WOUND)


	var/sufficiently_insulated_gloves = FALSE
	var/obj/item/clothing/gloves/worn_gloves = user.gloves
	if ((worn_gloves?.heat_protection & HANDS) && worn_gloves?.max_heat_protection_temperature && worn_gloves.max_heat_protection_temperature >= ROBOTIC_BLUNT_MOLD_METAL_HEAT_RESISTANCE_THRESHOLD)
		sufficiently_insulated_gloves = TRUE

	if (sufficiently_insulated_gloves || HAS_TRAIT(user, TRAIT_RESISTHEAT) || HAS_TRAIT(user, TRAIT_RESISTHEATHANDS))
		return

	to_chat(user, span_danger("You burn your hand on [victim]'s [limb.plaintext_zone]!"))
	var/obj/item/bodypart/affecting = user.get_bodypart("[(user.active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
	affecting?.receive_damage(burn = 5, damage_source = limb)

// T2 burn wounds are required to mold metal, which finished the first step of treatment. Aggrograb someone and use a welder on them for a guaranteed wound with no damage
/datum/wound/blunt/robotic/secures_internals/critical/proc/heat_metal(obj/item/welder, mob/living/user)
	if (!welder.tool_use_check())
		return TRUE

	var/their_or_other = (user == victim ? "[user.p_their()]" : "[user]'s")
	var/your_or_other = (user == victim ? "your" : "[victim]'s")

	user?.visible_message(span_danger("[user] carefully holds [welder] to [their_or_other] [limb.plaintext_zone], slowly heating it..."), \
		span_warning("You carefully hold [welder] to [your_or_other] [limb.plaintext_zone], slowly heating it..."), ignored_mobs = victim)

	var/delay_mult = 1
	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= 0.75

	if (!welder.use_tool(target = victim, user = user, delay = 10 SECONDS * delay_mult, volume = 50, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	var/wound_path = /datum/wound/burn/robotic/overheat/severe
	if (user != victim && user.combat_mode)
		//wound_path = /datum/wound/burn/robotic/overheat/critical
		user.visible_message(span_danger("[user] heats [victim]'s [limb.plaintext_zone] aggressively, overheating it far beyond the necessary point!"), \
			span_danger("You heat [victim]'s [limb.plaintext_zone] aggressively, overheating it far beyond the necessary point!"), ignored_mobs = victim)
		to_chat(victim, span_userdanger("[user] heats your [limb.plaintext_zone] aggressively, overheating it far beyond the necessary point!"))
		limb.receive_damage(burn = 20, damage_source = welder)

	var/datum/wound/burn/robotic/overheat/overheat_wound = new wound_path
	overheat_wound.apply_wound(limb, wound_source = welder)

	to_chat(user, span_green("[capitalize(your_or_other)] [limb.plaintext_zone] is now heated, allowing it to be molded! Your next step is to have someone physically reset the superstructure with their hands."))
	return TRUE

// An RCD can be used on a T3 wound to finish its 1st treatment step with little risk and no burn wound
/datum/wound/blunt/robotic/secures_internals/critical/proc/rcd_superstructure(obj/item/construction/rcd/treating_rcd, mob/user)
	if (!treating_rcd.tool_use_check())
		return TRUE

	var/has_enough_matter = (treating_rcd.get_matter(user) > ROBOTIC_T3_BLUNT_WOUND_RCD_COST)
	var/silo_has_enough_materials = (treating_rcd.get_silo_iron() > ROBOTIC_T3_BLUNT_WOUND_RCD_SILO_COST)

	if (!silo_has_enough_materials && has_enough_matter)
		return TRUE

	var/their_or_other = (user == victim ? "[user.p_their()]" : "[victim]'s")
	var/your_or_other = (user == victim ? "your" : "[victim]'s")

	var/base_time = 10 SECONDS
	var/delay_mult = 1
	if (victim == user)
		delay_mult *= 3 // real slow
	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= 0.75
	if (HAS_TRAIT(user, TRAIT_KNOW_ROBO_WIRES))
		delay_mult *= 3
	if (HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		delay_mult *= 0.5
	if (HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD))
		delay_mult *= 0.5

	var/final_time = (base_time * delay_mult)
	var/misused = (final_time > base_time) // if we damage the limb when we're done

	if (user)
		var/misused_text = (misused ? "<b>unsteadily</b> " : "")

		var/message = "[user]'s RCD whirs to life as it begins [misused_text]replacing the damaged superstructure of [their_or_other] [limb.plaintext_zone]..."
		var/self_message = "Your RCD whirs to life as it begins [misused_text]replacing the damaged superstructure of [your_or_other] [limb.plaintext_zone]..."

		if (misused) // warning span if misused, notice span otherwise
			message = span_danger(message)
			self_message = span_danger(self_message)
		else
			message = span_notice(message)
			self_message = span_notice(self_message)

		user.visible_message(message, self_message)

	if (!treating_rcd.use_tool(target = victim, user = user, delay = final_time, volume = 50, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE
	playsound(get_turf(treating_rcd), 'sound/machines/ping.ogg', 75) // celebration! we did it
	set_superstructure_status(TRUE)

	var/use_amount = (silo_has_enough_materials ? ROBOTIC_T3_BLUNT_WOUND_RCD_SILO_COST : ROBOTIC_T3_BLUNT_WOUND_RCD_COST)
	treating_rcd.useResource(use_amount, user)

	if (user)
		var/misused_text = (misused ? ", though it replaced a bit more than it should've..." : "!")
		var/message = "[user]'s RCD lets out a small ping as it finishes replacing the superstructure of [their_or_other] [limb.plaintext_zone][misused_text]"
		var/self_message = "Your RCD lets out a small ping as it finishes replacing the superstructure of [your_or_other] [limb.plaintext_zone][misused_text]"
		if (misused)
			message = span_danger(message)
			self_message = span_danger(self_message)
		else
			message = span_green(message)
			self_message = span_green(self_message)

		user.visible_message(message, self_message)
		if (misused)
			limb.receive_damage(brute = 10, damage_source = treating_rcd, wound_bonus = CANT_WOUND)
		// the double message is fine here, since the first message also tells you if you fucked up and did some damage
		to_chat(user, span_green("The superstructure has been reformed! Your next step is to secure the internals via a screwdriver/wrench."))
	return TRUE

// A bit goofy but practical - you can use a plunger on a mallable limb instead of molding it or hitting it
// Far less punishing than other forms of ghetto self-tending but a lot less "proper" meaning you get worse bonuses from diag hud and such
// The "superior" ghetto self-tend compared to percussive maintenance
/datum/wound/blunt/robotic/secures_internals/critical/proc/plunge(obj/item/plunger/treating_plunger, mob/user)
	if (!treating_plunger.tool_use_check())
		return TRUE

	var/their_or_other = (user == victim ? "[user.p_their()]" : "[victim]'s")
	var/your_or_other = (user == victim ? "your" : "[victim]'s")
	user?.visible_message(span_notice("[user] begins plunging at the dents on [their_or_other] [limb.plaintext_zone] with [treating_plunger]..."), \
		span_green("You begin plunging at the dents on [your_or_other] [limb.plaintext_zone] with [treating_plunger]..."))

	var/delay_mult = 1
	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		delay_mult *= 0.75

	delay_mult /= treating_plunger.plunge_mod

	if (!treating_plunger.use_tool(target = victim, user = user, delay = 8 SECONDS * delay_mult, volume = 50, extra_checks = CALLBACK(src, PROC_REF(still_exists))))
		return TRUE

	var/success_chance = 80
	if (victim == user)
		success_chance *= 0.6

	if (HAS_TRAIT(user, TRAIT_KNOW_ROBO_WIRES))
		success_chance *= 1.25
	if (HAS_TRAIT(user, TRAIT_KNOW_ENGI_WIRES))
		success_chance *= 1.1
	if (HAS_TRAIT(user, TRAIT_DIAGNOSTIC_HUD))
		success_chance *= 1.25
	if (HAS_TRAIT(src, TRAIT_WOUND_SCANNED))
		success_chance *= 1.5

	if (prob(success_chance))
		user?.visible_message(span_green("[victim]'s [limb.plaintext_zone] lets out a sharp POP as [treating_plunger] forces it into its normal position!"), \
			span_green("[victim]'s [limb.plaintext_zone] lets out a sharp POP as your [treating_plunger] forces it into its normal position!"))
		to_chat(user, span_green("[capitalize(your_or_other)] [limb.plaintext_zone]'s structure has been reset to it's proper position! Your next step is to secure it with a screwdriver/wrench, though bone gel would also work."))
		set_superstructure_status(TRUE)
	else
		user?.visible_message(span_danger("[victim]'s [limb.plaintext_zone] splinters from [treating_plunger]'s plunging!"), \
			span_danger("[capitalize(your_or_other)] [limb.plaintext_zone] splinters from your [treating_plunger]'s plunging!"))
		limb.receive_damage(brute = 5, damage_source = treating_plunger)

	return TRUE

/datum/wound/blunt/robotic/secures_internals/critical/handle_percussive_maintenance_success(attacking_item, mob/living/user)
	var/your_or_other = (user == victim ? "your" : "[user]'s")
	victim.visible_message(span_green("[victim]'s [limb.plaintext_zone] gets smashed into a proper shape!"), \
		span_green("Your [limb.plaintext_zone] gets smashed into a proper shape!"))

	var/user_message = "[capitalize(your_or_other)] [limb.plaintext_zone]'s superstructure has been reset! Your next step is to screwdriver/wrench the internals, \
	though if you're desparate enough to use percussive maintenance, you might want to either use a crowbar or bone gel..."
	to_chat(user, span_green(user_message))

	set_superstructure_status(TRUE)

/datum/wound/blunt/robotic/secures_internals/critical/handle_percussive_maintenance_failure(attacking_item, mob/living/user)
	to_chat(victim, span_danger("Your [limb.plaintext_zone] only deforms more from the impact..."))
	limb.receive_damage(brute = 1, damage_source = attacking_item, wound_bonus = CANT_WOUND)

/datum/wound/blunt/robotic/secures_internals/critical/uses_percussive_maintenance()
	return (!superstructure_remedied && limb_malleable())

/datum/wound/blunt/robotic/secures_internals/critical/proc/set_superstructure_status(remedied)
	superstructure_remedied = remedied
	ready_to_secure_internals = remedied

#undef BLUNT_ATTACK_DAZE_MULT

#undef ROBOTIC_T3_BLUNT_WOUND_RCD_COST
#undef ROBOTIC_T3_BLUNT_WOUND_RCD_SILO_COST

#undef ROBOTIC_WOUND_DETERMINATION_MOVEMENT_EFFECT_MOD
#undef ROBOTIC_WOUND_DETERMINATION_HIT_DAZE_MULT
#undef ROBOTIC_WOUND_DETERMINATION_HIT_STAGGER_MULT
#undef ROBOTIC_BLUNT_CROWBAR_SHOCK_DAMAGE
#undef ROBOTIC_BLUNT_CROWBAR_BRUTE_DAMAGE

#undef ROBOTIC_BLUNT_GRASPED_MOVEMENT_MULT

#undef ROBOTIC_BLUNT_MOLD_METAL_HEAT_RESISTANCE_THRESHOLD
