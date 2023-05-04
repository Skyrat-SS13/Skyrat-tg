// VERY IMPORTANT TO NOTE: Armor with batons is averaged across all limbs, meaning
// A helmet of melee 2 won't be as effective as a jumpsuit with melee 1.

#define TRANSLATE_EXTRA_SWING_ARMOR(armor) (1 - armor)

/// The default armor penetration of a baton in overcharge mode. Percentage-based.
#define BATON_OVERCHARGE_ARMOR_PENETRATION_PERCENT 0.85 // keep armor SOMEWHAT effective, at least 15%
/// The default armor penetration of a baton in overcharge mode. Flat. Needed to be above 1 to get the armor penetration message.
#define BATON_OVERCHARGE_ARMOR_PENETRATION_FLAT 0.1 // todo: make it so we only need the percentage
/// The volume of the extra sound played on overcharged baton impact, for extra "oomph" factor
#define BATON_OVERCHARGE_EXTRA_HITSOUND_VOLUME 20

// Police baton - very hard to not get knocked down by it, though its low attack rate limits its effectiveness
/obj/item/melee/baton
	/// The armor flag used when we use our stun function, AKA our left click.
	var/stun_armor_flag = MELEE
	/// The armor penetration used for our stun function. Flat.
	var/stun_armor_flat_penetration = 0
	/// The armor penetration used for our stun function. Percentage, 0 to 1 scale. but can go higher.
	var/stun_armor_percent_penetration = 0

	/// The amount of swings we will ideally cause a knockdown with. Affected by armor_for_extra_swing_needed_for_knockdown.
	/// Multiplied by our initial stun damage value to determine the stamina damage needed to knockdown.
	/// Set to 0 for guaranteed knockdown on every hit.
	var/swings_to_knockdown = 1
	/// If the target has stun_armor_flag armor equal or above this, it will take an extra swing to knock them down.
	/// The threshold for knockdown is multiplied by (1 - this), so be careful of the values you enter.
	/// Affected by stun_armor_penetration in the way you would assume. 50% pen = 50% effective armor.
	var/armor_for_extra_swing_needed_for_knockdown = 0.75

/obj/item/melee/baton/telescopic
	// todo: rebalance

// Contractor baton: Generally just really good, although it falters somewhat against armor in terms of stamina damage
// (knockdown is nearly always guaranteed)
/obj/item/melee/baton/telescopic/contractor_baton
	stamina_damage = 85 //todo: adjust
	swings_to_knockdown = 1
	armor_for_extra_swing_needed_for_knockdown = 0.45 //sufficient armor, like riot gear, grants a small resistance

/datum/action/item_action/stun_baton/toggle_overcharge
	name = "Toggle overcharge"
	desc = "Disable/Enable current limiters, switching between the standard armor-respecting mode \
	and an inefficient high-power mode, which boasts impressive armor penetration and easier knockdown but with extreme power cost/passive discharge."

// Stun baton - Trades off it's ability to instantly knockdown enemies with more stamina DPS than police/telebaton, though
// with the downside of having a cell and mediocre armor performance
// A alternate mode, overcharge, can be toggled, which massively increases anti-armor abilities + ease of knockdown while draining massive chunks of power
/obj/item/melee/baton/security
	power_use_amount = 0

	swings_to_knockdown = 2 // when not overcharged, you must swing twice to knockdown someone
	armor_for_extra_swing_needed_for_knockdown = 0.25 // remember: overcharge massively increases penetration

	/// Is this baton currently overcharged?
	var/overcharged = FALSE
	/// Is this baton currently in the process of charging into an overcharge? If true, disallows
	/// overcharge attempts.
	var/charging = FALSE
	/// How long this baton takes, in seconds, to go from charging to overcharged.
	var/overcharge_time = 2 SECONDS

	/// How much stun cost will be multiplied when a baton is overcharged.
	var/overcharge_cell_cost_mult = 9.7 // default cells have 10000 charge, and cell_hit_cost is 1000
	/// How much power will be deducted from an overcharged baton's cell every second. Flat.
	var/overcharge_passive_power_loss = 0
	/// The percent of a cell's maximum charge that will be lost for every second overcharge is active. 0-1.
	var/overcharge_passive_power_loss_percent = 0.007
	/// When overcharged, swings to knockdown will be reduced by this amount.
	var/overcharge_knockdown_swing_reduction = 1

	/// The sound the baton makes when a cell is inserted
	var/sound_cell_insert = 'sound/weapons/magin.ogg'
	/// The sound the baton makes when a cell is removed
	var/sound_cell_remove = 'sound/weapons/magout.ogg'

	/// If this baton can overcharge at all.
	var/can_overcharge = TRUE

	// Note: In testing, oddly enough, range and power seem to only work in increments of 0.5 and round down accordingly

	// A quite dim cyan light that expands from the user's tile to half a tile out
	/// The range of the light emitted when overcharge is active.
	var/overcharge_light_range = 1.6
	/// The power of the light emitted when overcharge is active.
	var/overcharge_light_power = 0.5
	/// The color of the light emitted when overcharge is active.
	var/overcharge_light_color = COLOR_CYAN

	// An extremely dim orange light that expands from the user's tile to half a tile out - impractial for lighting
	/// The range of the light emitted when overcharge is inactive.
	var/default_light_range = 1.5
	/// The power of the light emitted when overcharge is inactive.
	var/default_light_power = 0.005
	/// The color of the light emitted when overcharge is inactive.
	var/default_light_color = COLOR_ORANGE

	light_on = FALSE
	light_system = MOVABLE_LIGHT

// already less efficient as its cell cost is 2x the norm, no need to nerf
/obj/item/melee/baton/security/cattleprod

/obj/item/melee/baton/security/Initialize(mapload)
	. = ..()

	set_light_range_power_color(default_light_range, default_light_power, default_light_color)
	if (can_overcharge)
		add_item_action(/datum/action/item_action/stun_baton/toggle_overcharge)

/obj/item/melee/baton/security/ui_action_click(mob/user, actiontype)
	if (istype(actiontype, /datum/action/item_action/stun_baton/toggle_overcharge))
		if (!charging)
			if (active)
				toggle_overcharge(user)
			else
				balloon_alert(user, "inactive!")
		else
			balloon_alert(user, "already charging!")
		return

	return ..()

/**
 * Switches the overcharge state to the opposite of what it currently is.
 *
 * Args:
 * mob/user: The mob that initiated the toggle.
 *
 * Returns:
 * True if a state change occurs, false otherwise (was charging, no cell, not enough power, etc)
 */
/obj/item/melee/baton/security/proc/toggle_overcharge(mob/user)

	if (charging)
		return FALSE

	if (overcharged)
		disable_overcharge(user)
	else
		if (!cell)
			if (user)
				balloon_alert(user, "no cell!")
			return FALSE

		if (cell.charge < (cell_hit_cost * overcharge_cell_cost_mult))
			if (user)
				balloon_alert(user, "not enough power!")
			return FALSE

		if (user)
			user.balloon_alert_to_viewers("charging...")
		else
			balloon_alert_to_viewers("charging...")

		playsound(src, 'sound/weapons/flash.ogg', 110, TRUE, -1, frequency = 0.7) // very nice "charge-up" sound
		addtimer(CALLBACK(src, PROC_REF(enable_overcharge), user), overcharge_time)
		charging = TRUE

	return TRUE

/**
 * Enables overcharge, a high-power mode that massively increases armor penetration and knockdown ability at the cost of
 * extreme stun cell cost and passive power discharge.
 *
 * Often is called after a delay from toggle_overcharge.
 * This delay, coupled with the passive discharge, encourages users to only keep overcharge active
 * when absolutely necessary, and think stratetegically about when to use it.
 *
 * Plus, the high cell cost and discharge both incentivise users to upgrade their cell, which is always good.
 *
 * Args:
 * mob/user: The person that initiated the overcharge attempt. Nullable.
 */
/obj/item/melee/baton/security/proc/enable_overcharge(mob/user)

	if (!charging || overcharged)
		return FALSE

	charging = FALSE

	if (cell.charge < (cell_hit_cost * overcharge_cell_cost_mult))
		if (user)
			balloon_alert(user, "not enough power!")
		return FALSE

	if (user)
		user.balloon_alert_to_viewers("overcharged!")
	else
		balloon_alert_to_viewers("overcharged!")

	playsound(src, SFX_SPARKS, 120, TRUE, -1, frequency = 0.6)
	do_sparks(3, TRUE, src) // extra "oomph" factor, and also a good telegraph for it's activation

	stun_armor_percent_penetration = BATON_OVERCHARGE_ARMOR_PENETRATION_PERCENT
	stun_armor_flat_penetration = BATON_OVERCHARGE_ARMOR_PENETRATION_FLAT // mainly just to get the "your armor was penetrated" message

	cell_hit_cost *= overcharge_cell_cost_mult

	power_use_amount += get_overcharge_passive_discharge()

	swings_to_knockdown -= overcharge_knockdown_swing_reduction

	set_light_range_power_color(overcharge_light_range, overcharge_light_power, overcharge_light_color) // a glow helps with at-a-glance recognition

	add_atom_colour(COLOR_CYAN, ADMIN_COLOUR_PRIORITY) //recolor it so it becomes obvious at a glance the danger of this baton
	update_inhand_icon(user)

	START_PROCESSING(SSobj, src)

	overcharged = TRUE

/**
 * Disables the overcharge of the baton, returning it to the standard low-cost but low-antiarmor-effectiveness
 * baton we all know and love (hate).
 *
 * Args:
 * mob/user: The mob that disabled overcharge. Nullable.
 */
/obj/item/melee/baton/security/proc/disable_overcharge(mob/user)

	if (!overcharged)
		return FALSE

	if (user)
		user.balloon_alert_to_viewers("overcharge reset")
	else
		balloon_alert_to_viewers("overcharge reset")

	playsound(src, SFX_SPARKS, 110, TRUE, -1, frequency = 0.6)
	playsound(src, 'sound/effects/empulse.ogg', 80, TRUE, -1, frequency = 0.6)

	stun_armor_percent_penetration = initial(src.stun_armor_percent_penetration)
	stun_armor_flat_penetration = initial(src.stun_armor_flat_penetration)

	cell_hit_cost /= overcharge_cell_cost_mult

	power_use_amount -= get_overcharge_passive_discharge()

	swings_to_knockdown += overcharge_knockdown_swing_reduction

	set_light_range_power_color(default_light_range, default_light_power, default_light_color)

	remove_atom_colour(ADMIN_COLOUR_PRIORITY, COLOR_CYAN)
	update_inhand_icon(user)

	overcharged = FALSE
	STOP_PROCESSING(SSobj, src)

	return TRUE

/**
 * Returns:
 * 0 if no cell is installed, (((cell.maxcharge) * (overcharge_passive_power_loss_percent)) + overcharge_passive_power_loss) otherwise
 */
/obj/item/melee/baton/security/proc/get_overcharge_passive_discharge()
	return (cell ? ((cell.maxcharge) * (overcharge_passive_power_loss_percent)) + overcharge_passive_power_loss : 0)

/obj/item/melee/baton/security/deductcharge(deducted_charge)
	. = ..()

	if (overcharged && !.) // using the power check here prematurely disables overcharge, so lets not
		var/mob/user
		if (istype(loc, /mob))
			user = loc
			balloon_alert(user, "not enough power!")
		disable_overcharge(user)

/obj/item/melee/baton/security/baton_effect(mob/living/target, mob/living/user, modifiers, stun_override)
	. = ..()

	if (!.)
		return

	if (overcharged)
		do_sparks(3, TRUE, target)
		playsound(get_turf(src), 'sound/magic/mm_hit.ogg', BATON_OVERCHARGE_EXTRA_HITSOUND_VOLUME, TRUE, -1, frequency = 1.3)
		target.visible_message(span_danger("[user]'s [src.name] sparks violently as it's overcharged prongs penetrate [target]'s armor!"))

	// effects for extra "oomph" and also to make it just that more obvious how dangerous this baton is

/obj/item/melee/baton/security/attack_self(mob/user)

	if (charging && active)
		if (user)
			balloon_alert(user, "charging!")
		return FALSE

	. = ..()

	if (overcharged)
		if (!active)
			disable_overcharge(user) // inactive batons shouldnt be overcharged, since it would drain power while inactive
		else
			START_PROCESSING(SSobj, src) // sanity

	set_light_on(active)

/obj/item/melee/baton/security/attackby(obj/item/item, mob/user, params)

	if(istype(item, /obj/item/stock_parts/cell))
		var/obj/item/stock_parts/cell/new_cell = item

		// you may ask: why? well my dear reader, because if there was no cell addition delay there would be no
		// reason to care about the power usage as you can just screwdriver the cell out and pop a new one in!
		// sure with this you can use multiple batons, but a. theyre harder to come by
		// b. they still self-discharge when overcharged c. it still takes time to start an overcharge on those batons
		if (!cell && !(new_cell.maxcharge < cell_hit_cost)) //this all exists to delay adding a cell
			user.balloon_alert_to_viewers("replacing cell...")
			if (!do_after(user, 3 SECONDS, src))
				return FALSE

	. = ..()

	if (item == cell) // checks if the item has indeed been placed in our cell slot
		playsound(src, sound_cell_insert, 40)
		do_overcharge_power_check(user)

/obj/item/melee/baton/security/tryremovecell(mob/user)
	. = ..()

	if (.)
		playsound(src, sound_cell_remove, 40)
		set_light_on(active)

		do_overcharge_power_check(user)

/**
 * Checks if src.cell exists or has enough power to perform an overcharged attack.
 * If not, disables overcharge, with an optional message to whomever is holding the baton.
 * Only runs this check if overcharged == TRUE.
 *
 * Args:
 * mob/user: The holder of this baton. Nullable.
 * silent = FALSE: If true, no message will be given to user, assuming it exists.
 *
 * Returns:
 * src.overcharged after the checks have been done.
 */
/obj/item/melee/baton/security/proc/do_overcharge_power_check(mob/user, silent = FALSE)

	if (overcharged)
		if (!cell || (cell.charge < (cell_hit_cost)))
			if (!silent && istype(user))
				balloon_alert(user, "not enough power!")
			disable_overcharge(user)

	return overcharged

/obj/item/melee/baton/security/examine(mob/user)
	. = ..()

	if (overcharged)
		. += ""
		. += span_notice("This [name] is currently overcharged, significantly altering it's behavior. Examine closer to see specific stat changes.")

/obj/item/melee/baton/security/examine_more(mob/user)
	. = ..()

	if (overcharged)
		. += "Stun armor penetration increased by [span_blue("[BATON_OVERCHARGE_ARMOR_PENETRATION_PERCENT*100]%")] + [span_blue("[BATON_OVERCHARGE_ARMOR_PENETRATION_FLAT]")]"
		. += "Hits to knockdown reduced by [span_blue("[overcharge_knockdown_swing_reduction]")]"
		. += ""
		. += "Stun power usage increased by [span_red(("[overcharge_cell_cost_mult*100]%"))]"
		. += "Passively discharging [span_red("[overcharge_passive_power_loss]")] volts and [span_red("[overcharge_passive_power_loss_percent]%")] of the installed cell's capacity per second"
		// giving info to people that theyd have to find out through trial and error otherwise is a good thing imo

/obj/item/melee/baton/security/process(seconds_per_tick)
	deductcharge(power_use_amount * seconds_per_tick)

	if (istype(loc, /obj/machinery/recharger)) //prevent people from bypassing the delay by putting them in rechargers
		disable_overcharge()
	else
		do_overcharge_power_check(loc)

	if(!overcharged)
		STOP_PROCESSING(SSobj, src)
		return

// Override to make batons respect armor and respect knockdown resistance
/obj/item/melee/baton/baton_effect(mob/living/target, mob/living/user, modifiers, stun_override)
	var/trait_check = HAS_TRAIT(target, TRAIT_BATON_RESISTANCE)
	if(iscyborg(target))
		if(!affect_cyborg)
			return FALSE
		target.flash_act(affect_silicon = TRUE)
		target.Paralyze((isnull(stun_override) ? stun_time_cyborg : stun_override) * (trait_check ? 0.1 : 1))
		additional_effects_cyborg(target, user)
	else
		if(ishuman(target))
			var/mob/living/carbon/human/human_target = target
			if(prob(force_say_chance))
				human_target.force_say()
		target.apply_damage(stamina_damage, STAMINA, blocked = (target.run_armor_check(attack_flag = stun_armor_flag, armour_penetration = stun_armor_flat_penetration, weak_against_armour = src.weak_against_armour))*(1-stun_armor_percent_penetration))
		if(!trait_check)
			if (target.staminaloss > ((initial(src.stamina_damage) * swings_to_knockdown) * TRANSLATE_EXTRA_SWING_ARMOR(armor_for_extra_swing_needed_for_knockdown)))
				target.Knockdown((isnull(stun_override) ? knockdown_time : stun_override))
		additional_effects_non_cyborg(target, user)
	return TRUE

// Override to make stun batons respect knockdown resistance
/obj/item/melee/baton/security/apply_stun_effect_end(mob/living/target, cached_swings_to_knockdown)
	if(target.staminaloss > ((initial(stamina_damage) * cached_swings_to_knockdown) * TRANSLATE_EXTRA_SWING_ARMOR(armor_for_extra_swing_needed_for_knockdown)))
		var/trait_check = HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) //var since we check it in out to_chat as well as determine stun duration
		if(!target.IsKnockdown())
			to_chat(target, span_warning("Your muscles seize, making you collapse[trait_check ? ", but your body quickly recovers..." : "!"]"))

		if(!trait_check)
			target.Knockdown(knockdown_time)
/*
/obj/item/melee/baton/security/baton_attack(mob/living/target, mob/living/user, modifiers)
	if (charging)
		if (user)
			balloon_alert(user, "can't attack while charging!")
		return BATON_ATTACK_DONE

	return ..()
*/

/*
 * After a target is hit, we apply some status effects.
 * After a period of time, we then check to see what stun duration we give.
 */
/obj/item/melee/baton/security/additional_effects_non_cyborg(mob/living/target, mob/living/user)
	target.set_jitter_if_lower(40 SECONDS)
	// target.set_confusion_if_lower(10 SECONDS) // SKYRAT EDIT REMOVAL
	target.set_stutter_if_lower(16 SECONDS)

	SEND_SIGNAL(target, COMSIG_LIVING_MINOR_SHOCK)
	addtimer(CALLBACK(src, PROC_REF(apply_stun_effect_end), target, swings_to_knockdown), 2 SECONDS) // Modularized to add an arg

#undef BATON_OVERCHARGE_ARMOR_PENETRATION_PERCENT
#undef BATON_OVERCHARGE_ARMOR_PENETRATION_FLAT
#undef BATON_OVERCHARGE_EXTRA_HITSOUND_VOLUME
#undef TRANSLATE_EXTRA_SWING_ARMOR
