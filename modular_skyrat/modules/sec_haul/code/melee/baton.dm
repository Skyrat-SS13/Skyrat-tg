// VERY IMPORTANT TO NOTE: Armor with batons is averaged across all limbs, meaning
// A helmet of melee 2 won't be as effective as a jumpsuit with melee 1.

#define TRANSLATE_EXTRA_SWING_ARMOR(armor) (1 - armor)

/// The default armor penetration of a baton in overcharge mode. Percentage-based.
#define BATON_OVERCHARGE_ARMOR_PENETRATION_PERCENT 0.85 // keep armor SOMEWHAT effective, at least 15%
/// The default armor penetration of a baton in overcharge mode. Flat. Needed to be above 1 to get the armor penetration message.
#define BATON_OVERCHARGE_ARMOR_PENETRATION_FLAT 0.1 // todo: make it so we only need the percentage
/// The volume of the extra sound played on overcharged baton impact, for extra "oomph" factor
#define BATON_OVERCHARGE_EXTRA_HITSOUND_VOLUME 20

/// How long it takes for a user to replace a cell in a baton.
#define BATON_CELL_REPLACE_TIME 3 SECONDS

// Police baton - very hard to not get knocked down by it, though its low attack rate limits its effectiveness
/obj/item/melee/baton
	/// The armor flag used when we use our stun function, AKA our left click.
	var/stun_armor_flag = MELEE
	/// The armor penetration used for our stun function. Flat.
	var/stun_armor_flat_penetration = 0
	/// The armor penetration used for our stun function. Percentage, 0 to 1 scale. but can go higher.
	var/stun_armor_percent_penetration = 0

	/// The amount of swings we will ideally cause a knockdown with. Affected by extra_swing_til_knockdown_armor_thresh.
	/// Multiplied by our initial stun damage value to determine the stamina damage needed to knockdown.
	/// Set to 0 for guaranteed knockdown on every hit.
	var/swings_to_knockdown = 1
	/// If the target has stun_armor_flag armor equal or above this, it will take an extra swing to knock them down.
	/// The threshold for knockdown is multiplied by (1 - this), so be careful of the values you enter.
	/// Affected by stun_armor_penetration in the way you would assume. 50% pen = 50% effective armor.
	var/extra_swing_til_knockdown_armor_thresh = 0.75

/obj/item/melee/baton/add_weapon_description()
	AddElement(/datum/element/weapon_description, attached_proc = PROC_REF(add_baton_notes))

/// Adds baton-specific combat info notes to the combat info text bit.
/obj/item/melee/baton/proc/add_baton_notes()
	RETURN_TYPE(/list)

	var/list/notes = list()

	notes += ""
	notes += "Stun mode:"
	notes += "Has [span_blue("[stun_armor_flat_penetration]")] + [span_blue("[stun_armor_percent_penetration*100]")]% armor penetration, respecting [span_blue("[stun_armor_flag]")] armor"
	notes += "Takes [span_blue("~[swings_to_knockdown]")] hits to induce a knockdown on an unarmored opponent"
	notes += "[span_blue("~[extra_swing_til_knockdown_armor_thresh*100]%")] [stun_armor_flag] armor to delay knockdown by one hit"

	return notes

/obj/item/melee/baton/telescopic
	// todo: rebalance

// Contractor baton: Generally just really good, although it falters somewhat against armor in terms of stamina damage
// (knockdown is nearly always guaranteed)
/obj/item/melee/baton/telescopic/contractor_baton
	stamina_damage = 80 //todo: adjust
	swings_to_knockdown = 1
	extra_swing_til_knockdown_armor_thresh = 0.45 //sufficient armor, like riot gear, grants a small resistance

/datum/action/item_action/stun_baton/toggle_overcharge
	name = "Toggle overcharge"
	desc = "Disable/Enable current limiters, switching between the standard armor-respecting mode \
	and an inefficient high-power mode, which boasts impressive armor penetration and easier knockdown but with extreme power cost/passive discharge. \
	This can be easily triggered by using the default keybind: Shift + F"

/datum/action/item_action/stun_baton/toggle_overcharge/GiveAction(mob/viewer)
	. = ..()

	RegisterSignal(viewer, COMSIG_KB_BATON_OVERCHARGE, PROC_REF(Trigger))

/datum/action/item_action/stun_baton/toggle_overcharge/HideFrom(mob/viewer)
	. = ..()

	UnregisterSignal(viewer, COMSIG_KB_BATON_OVERCHARGE)

// Stun baton - Trades off it's ability to instantly knockdown enemies with more stamina DPS than police/telebaton, though
// with the downside of having a cell and mediocre armor performance
// A alternate mode, overcharge, can be toggled, which massively increases anti-armor abilities + ease of knockdown while draining massive chunks of power
/obj/item/melee/baton/security
	power_use_amount = 0

	swings_to_knockdown = 1 // when not overcharged, you must swing ONCE to knockdown someone -- but nearly any armor prevents it
	extra_swing_til_knockdown_armor_thresh = 0.1 // remember: overcharge massively increases penetration

	/// Is this baton currently overcharged?
	var/overcharged = FALSE
	/// Is this baton currently in the process of charging into an overcharge? If true, disallows
	/// overcharge attempts.
	var/charging = FALSE
	/// How long this baton takes, in seconds, to go from charging to overcharged.
	var/overcharge_time = 1.75 SECONDS

	/// How much stun cost will be multiplied when a baton is overcharged.
	var/overcharge_cell_cost_mult = 9.2 // always intended to give base batons at least 1 overcharge and some breathing room for discharge
	/// How much power will be deducted from an overcharged baton's cell every second. Flat.
	var/overcharge_passive_power_loss = 0
	/// The percent of a cell's maximum charge that will be lost for every second overcharge is active. 0-1, multiplied by 100.
	var/overcharge_passive_power_loss_percent = 0.0037 //.37%
	/// When overcharged, swings to knockdown will be reduced by this amount.
	var/overcharge_knockdown_swing_reduction = 0

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

	/// The amount of time it takes for us to run our knockdown check after we hit someone.
	var/knockdown_delay = 2 SECONDS

	/// The timestamp of the moment we stopped being handled, e.g. we were dropped on the floor or put in a bag
	var/unhandled_start
	/// If the unhandled start var exeeds world.time by this amount, overcharge will be disabled
	var/unhandled_threshold_for_disable = 4 SECONDS

	light_on = FALSE
	light_system = MOVABLE_LIGHT

/obj/item/melee/baton/security/loaded
	preload_cell_type = /obj/item/stock_parts/cell/baton

/// This cell is useful because it lets us control the amount of power a roundstart baton can have without worrying about
/// the actual overcharge balance concerns of having a renewable power source so easily available
/// + it prevents people from looting the batons for the cells due to the discharge
/obj/item/stock_parts/cell/baton
	name = "stun baton cell"
	desc = "The standard cell given to all stun batons. Nearly unrechargable, only installable in stun batons, but has a high capacity for a very low manufacturing price."
	custom_materials = list(/datum/material/iron=HALF_SHEET_MATERIAL_AMOUNT, /datum/material/titanium=SMALL_MATERIAL_AMOUNT, /datum/material/glass=SMALL_MATERIAL_AMOUNT*0.8) //recycle!
	maxcharge = 32000 // basically a worse hypercell (sorta)
	chargerate = 300 // SUFFER.

/obj/item/stock_parts/cell/baton/pre_attack(atom/A, mob/living/user, params)
	if (!istype(A, /obj/item/melee/baton/security) && !istype(A, /obj/machinery/autolathe)) //maybe remove this check if the charge rate is low enough it doesnt matter?
		if (user)
			balloon_alert(user, "can only be installed in batons!")
		return TRUE //stops the attack chain

	return ..()

/obj/item/melee/baton/security/loaded/bluespace
	preload_cell_type = /obj/item/stock_parts/cell/bluespace

/obj/item/melee/baton/security/loaded/infinite
	preload_cell_type = /obj/item/stock_parts/cell/infinite

// already less efficient as its cell cost is 2x the norm, no need to nerf
/obj/item/melee/baton/security/cattleprod

// same story as the cattleprod
/obj/item/melee/baton/security/boomerang

// This baton is fine, it doesnt even use half the rules batons use so the changes dont affect it much
/obj/item/melee/baton/abductor

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

/obj/item/melee/baton/security/add_baton_notes()
	. = ..()

	. += ""
	. += "Overcharge changes:"
	. += "Stun armor penetration increased by [span_blue("[BATON_OVERCHARGE_ARMOR_PENETRATION_PERCENT*100]%")] + [span_blue("[BATON_OVERCHARGE_ARMOR_PENETRATION_FLAT]")]"
	. += "Hits to knockdown reduced by [span_blue("[overcharge_knockdown_swing_reduction]")]"
	. += ""
	. += "Stun power usage increased by [span_red(("[overcharge_cell_cost_mult*100]%"))]"
	. += "Passively discharges [span_red("[overcharge_passive_power_loss]")] volts and [span_red("[overcharge_passive_power_loss_percent*100]%")] of the installed cell's capacity per second"
	// giving info to people that theyd have to find out through trial and error otherwise is a good thing imo

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

	if (!charging)
		return FALSE

	charging = FALSE

	if (overcharged)
		return FALSE

	if (!istype(loc, /mob/living/carbon))
		balloon_alert_to_viewers("unhandled! pick it up!")
		return FALSE

	if (cell.charge < (cell_hit_cost * overcharge_cell_cost_mult))
		if (user)
			balloon_alert(user, "not enough power!")
		return FALSE

	if (user)
		user.balloon_alert_to_viewers("overcharged!")
	else
		balloon_alert_to_viewers("overcharged!")

	playsound(src, SFX_SPARKS, 120, TRUE, -1, frequency = 0.6)
	do_sparks(rand(3, 5), FALSE, src) // extra "oomph" factor, and also a good telegraph for it's activation

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

	if (cell && cell.rigged) // :)
		cell.explode()

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

	handled()

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
		do_sparks(rand(3, 5), FALSE, target)
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
			if (!do_after(user, BATON_CELL_REPLACE_TIME, src))
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

	disable_if_unhandled() //best if we use it here, since process is a tad inconsistant

	if (overcharged)
		if (!cell || (cell.charge < (cell_hit_cost)))
			if (!silent && istype(user))
				balloon_alert(user, "not enough power!")
			disable_overcharge(user)

	return overcharged

/obj/item/melee/baton/security/examine(mob/user)
	. = ..()

	. += "This [name] is [span_blue("overcharge capable")]. See the [span_green("action button")] in the top left of your screen (You can clickdrag it for more convenient use)."

	if (overcharged)
		. += ""
		. += span_notice("This [name] is currently overcharged, significantly altering it's behavior. See it's combat stats label for more information.")

	if (cell && istype(cell, /obj/item/stock_parts/cell/baton))
		. += span_warning("The installed cell has an extremely slow recharge rate. Upgrade it when able.")

/obj/item/melee/baton/security/process(seconds_per_tick)
	deductcharge(power_use_amount * seconds_per_tick)

	do_unhandled_check() // prevents hoarding entirely - you must have it in your hands, back, belt, whatever slot, but nowhere else
	do_overcharge_power_check(loc)

	if(!overcharged)
		STOP_PROCESSING(SSobj, src)
		return

/obj/item/melee/baton/security/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change)
	. = ..()

	if (old_loc == loc)
		return
	do_unhandled_check()

/obj/item/melee/baton/security/proc/do_unhandled_check()
	if (overcharged)
		if (!istype(loc, /mob/living/carbon))
			unhandled()
		else
			handled()

/obj/item/melee/baton/security/proc/handled()
	unhandled_start = null

/// Useful because if someone gets stunned and drops their baton we dont always want them to have to redo the chargeup
/obj/item/melee/baton/security/proc/unhandled()
	if (!unhandled_start)
		unhandled_start = world.time
	disable_if_unhandled()

/obj/item/melee/baton/security/proc/disable_if_unhandled()
	if (unhandled_start == null) // straight nullcheck since this is a nullable numerical variable
		return
	var/difference = world.time - unhandled_start
	if (difference >= unhandled_threshold_for_disable)
		disable_overcharge()

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
			if (target.staminaloss > ((initial(src.stamina_damage) * swings_to_knockdown) * TRANSLATE_EXTRA_SWING_ARMOR(extra_swing_til_knockdown_armor_thresh)))
				target.Knockdown((isnull(stun_override) ? knockdown_time : stun_override))
		additional_effects_non_cyborg(target, user)
	return TRUE

// Override to make stun batons respect knockdown resistance
// cached_stamina_damage exists to make knockdown possible if using stamina drugs
/obj/item/melee/baton/security/apply_stun_effect_end(mob/living/target, cached_swings_to_knockdown, cached_stamina_damage)
	var/staminaloss = max(target.staminaloss, cached_stamina_damage)
	if(staminaloss > ((initial(stamina_damage) * cached_swings_to_knockdown) * TRANSLATE_EXTRA_SWING_ARMOR(extra_swing_til_knockdown_armor_thresh)))
		var/trait_check = HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) //var since we check it in out to_chat as well as determine stun duration
		if(!target.IsKnockdown())
			to_chat(target, span_warning("Your muscles seize, making you collapse[trait_check ? ", but your body quickly recovers..." : "!"]"))

		if(!trait_check)
			target.Knockdown(knockdown_time)

/*/obj/item/melee/baton/security/baton_attack(mob/living/target, mob/living/user, modifiers)
	if (charging)
		if (user)
			balloon_alert(user, "can't attack while charging!")
		return BATON_ATTACK_DONE
	return ..()*/

/*
 * After a target is hit, we apply some status effects.
 * After a period of time, we then check to see what stun duration we give.
 */
/obj/item/melee/baton/security/additional_effects_non_cyborg(mob/living/target, mob/living/user)
	target.set_jitter_if_lower(40 SECONDS)
	// target.set_confusion_if_lower(10 SECONDS) // SKYRAT EDIT REMOVAL
	target.set_stutter_if_lower(16 SECONDS)

	SEND_SIGNAL(target, COMSIG_LIVING_MINOR_SHOCK) //this happens after the stam damage is applied thank fuck
	addtimer(CALLBACK(src, PROC_REF(apply_stun_effect_end), target, swings_to_knockdown, target.staminaloss), knockdown_delay) // Modularized to add args

#undef BATON_OVERCHARGE_ARMOR_PENETRATION_PERCENT
#undef BATON_OVERCHARGE_ARMOR_PENETRATION_FLAT
#undef BATON_OVERCHARGE_EXTRA_HITSOUND_VOLUME
#undef TRANSLATE_EXTRA_SWING_ARMOR
#undef BATON_CELL_REPLACE_TIME
