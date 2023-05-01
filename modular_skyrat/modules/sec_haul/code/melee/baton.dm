// Dev notes
// If knockdown resist is given to all for the first hit basic cells will need to be able to overcharge for at least one hit
// Would create a tradeoff of "Do I want to expend my entire baton on this one hit, or just go for it normally"

// Other batons need some loving to let them work against armor better (but not really exceed the stun baton)
// Thinking: Make one of the other batons (police/tele) have good knockdown on first hit but only okay armor pen
// Or both? It would be best if they were distinct but who knows honestly first-hit knockdown is really strong,
// and both primarily serve as self-defense for a job (police baton is easily acquirable though)
// They dont need the capability to stamcrit through armor

// Contractor baton definitely needs a nerf, should respect armor more and just get a damage decrease
// Alternatively, just make it act like a stronger perma-overcharged baton?

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
	stamina_damage = 95 //todo: adjust
	swings_to_knockdown = 1
	armor_for_extra_swing_needed_for_knockdown = 0.45 //sufficient armor, like riot gear, grants a small resistance

/datum/action/item_action/stun_baton/toggle_overcharge
	name = "Toggle overcharge"
	desc = "Disable/Enable current limiters, switching between the standard armor-respecting mode \
	and an inefficient high-power mode, which boasts impressive armor penetration but with extreme power cost/passive discharge."

// Stun baton - Trades off it's ability to instantly knockdown enemies with more stamina DPS than police/telebaton, though
// with the downside of having a cell and mediocre armor performance
// A alternate mode, overcharge, can be toggled, which massively increases anti-armor abilities while draining massive chunks of power
/obj/item/melee/baton/security
	swings_to_knockdown = 2 // when not overcharged, you must swing twice to knockdown someone
	armor_for_extra_swing_needed_for_knockdown = 0.25 // remember: overcharge massively increases penetration

	/// Is this baton currently overcharged, granting armor penetration at the cost of extra cell usage?
	var/overcharged = FALSE
	/// Is this baton currently in the process of charging into an overcharge? If true, disallows
	/// overcharge attempts. 
	var/charging = FALSE
	/// How long this baton takes, in seconds, to go from charging to overcharged.
	var/overcharge_time = 1.5 SECONDS

	/// How much stun cost will be multiplied when a baton is overcharged.
	var/overcharge_cell_cost_mult = 9.3 // default cells have 10000 charge, and cell_hit_cost is 1000
	/// How much power will be deducted from an overcharged baton's cell every process tick.
	var/overcharge_passive_power_loss = 400

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

/obj/item/melee/baton/security/cattleprod/Initialize(mapload)
	. = ..()

	overcharge_cell_cost_mult *= 2 // i wanna nerf overcharge on prods but im not totally sure how
	// maybe increase the armor penetration but dump the entire cell?

/obj/item/melee/baton/security/Initialize(mapload)
	. = ..()

	set_light_range_power_color(default_light_range, default_light_power, default_light_color)
	add_item_action(/datum/action/item_action/stun_baton/toggle_overcharge)

/obj/item/melee/baton/security/ui_action_click(mob/user, actiontype)
	if (istype(actiontype, /datum/action/item_action/stun_baton/toggle_overcharge))
		if (!charging)
			toggle_overcharge(user)
			return

	return ..()

/// Switches the overcharge state to the opposite of what it currently is.
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

		playsound(src, 'sound/weapons/flash.ogg', 110, TRUE, -1, frequency = 0.7)
		addtimer(CALLBACK(src, PROC_REF(enable_overcharge), user), overcharge_time)
		charging = TRUE

	return TRUE

/**
 * Enables overcharge, a high-power mode that massively increases armor penetration at the cost of
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

	power_use_amount = overcharge_passive_power_loss

	set_light_range_power_color(overcharge_light_range, overcharge_light_power, overcharge_light_color)

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

	power_use_amount = initial(src.power_use_amount)

	set_light_range_power_color(default_light_range, default_light_power, default_light_color)

	remove_atom_colour(ADMIN_COLOUR_PRIORITY, COLOR_CYAN)
	update_inhand_icon(user)

	overcharged = FALSE
	STOP_PROCESSING(SSobj, src)

	return TRUE

/obj/item/melee/baton/security/deductcharge(deducted_charge)
	. = ..()

	if (overcharged && !.) // using the power check here prematurely disables overcharge, so lets nots
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
	. = ..()

	if (overcharged) // sanity
		START_PROCESSING(SSobj, src)

	if (!active && overcharged) // inactive batons shouldnt be overcharged, since it would drain power while inactive otherwise
		disable_overcharge(user)

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
			if (!silent && user)
				balloon_alert(user, "not enough power!")
			disable_overcharge(user)

	return overcharged

/obj/item/melee/baton/security/examine(mob/user)
	. = ..()

	if (overcharged)
		. += span_blue("This [name] is overcharged, granting it greatly enhanced armor penetration at the cost of extreme energy cost and passive discharge.")
		. += "Stun power usage multiplied by [span_red(overcharge_cell_cost_mult*100)]%"
		. += "Passively discharging [span_red(overcharge_passive_power_loss)] volts per second"
		// giving info to people that theyd have to find out through trial and error otherwise is a good thing imo

/obj/item/melee/baton/security/process(seconds_per_tick)
	deductcharge(power_use_amount)

	if (istype(loc, /obj/machinery/recharger)) //prevent people from bypassing the delay by putting them in rechargers
		disable_overcharge()

	do_overcharge_power_check()

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
/obj/item/melee/baton/security/apply_stun_effect_end(mob/living/target)
	if(target.staminaloss > ((initial(stamina_damage) * swings_to_knockdown) * TRANSLATE_EXTRA_SWING_ARMOR(armor_for_extra_swing_needed_for_knockdown)))
		var/trait_check = HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) //var since we check it in out to_chat as well as determine stun duration
		if(!target.IsKnockdown())
			to_chat(target, span_warning("Your muscles seize, making you collapse[trait_check ? ", but your body quickly recovers..." : "!"]"))

		if(!trait_check)
			target.Knockdown(knockdown_time)

#undef BATON_OVERCHARGE_ARMOR_PENETRATION_PERCENT
#undef BATON_OVERCHARGE_ARMOR_PENETRATION_FLAT
#undef BATON_OVERCHARGE_EXTRA_HITSOUND_VOLUME
#undef TRANSLATE_EXTRA_SWING_ARMOR
