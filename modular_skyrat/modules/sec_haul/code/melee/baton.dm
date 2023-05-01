// VERY IMPORTANT TO NOTE: Armor with batons is averaged across all limbs, meaning
// A helmet of melee 2 won't be as effective as a jumpsuit with melee 1.

/obj/item/melee/baton
	/// The armor flag used when we use our stun function, AKA our left click.
	var/stun_armor_flag = MELEE
	/// The armor penetration used for our stun function. Flat.
	var/stun_armor_flat_penetration = 0
	/// The armor penetration used for our stun function. Percentage, 0 to 1 scale. but can go higher.
	var/stun_armor_percent_penetration = 0

/datum/action/item_action/stun_baton/toggle_overcharge
	name = "Toggle overcharge"

#define SECURITY_BATON_OVERCHARGE_CELL_COST_MULT 10
#define BATON_OVERCHARGE_ARMOR_PENETRATION_PERCENT 0.85 // keep armor SOMEWHAT effective
#define BATON_OVERCHARGE_ARMOR_PENETRATION_FLAT 0.1 // todo: make it so we only need the percentage

/obj/item/melee/baton/security
	var/overcharged = FALSE
	var/charging = FALSE
	var/overcharge_time = 1.5 SECONDS

	var/overcharge_stun_volume = 20
	var/overcharge_cell_cost_mult = 10.1 // default batons cant overcharge, get a better cell
	var/overcharge_passive_power_loss = 100

	/// The sound the baton makes when a cell is inserted
	var/sound_cell_insert = 'sound/weapons/magin.ogg'
	/// The sound the baton makes when a cell is removed
	var/sound_cell_remove = 'sound/weapons/magout.ogg'

	var/can_overcharge = TRUE

	var/overcharge_light_range = 1.6
	var/overcharge_light_power = 0.5
	var/overcharge_light_color = COLOR_CYAN

	var/default_light_range = 1.5
	var/default_light_power = 0.005
	var/default_light_color = COLOR_ORANGE

	light_on = FALSE
	light_system = MOVABLE_LIGH

/obj/item/melee/baton/security/cattleprod/Initialize(mapload)
	. = ..()

	overcharge_cell_cost_mult *= 2

/obj/item/melee/baton/security/Initialize(mapload)
	. = ..()

	set_light_range_power_color(default_light_range, default_light_power, default_light_color)
	add_item_action(/datum/action/item_action/stun_baton/toggle_overcharge)

/obj/item/melee/baton/security/ui_action_click(mob/user, actiontype)
	if(istype(actiontype, /datum/action/item_action/stun_baton/toggle_overcharge))
		if (!charging)
			toggle_overcharge(user)
			return

	return ..()

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
	do_sparks(3, TRUE, src)

	stun_armor_percent_penetration = BATON_OVERCHARGE_ARMOR_PENETRATION_PERCENT
	stun_armor_flat_penetration = BATON_OVERCHARGE_ARMOR_PENETRATION_FLAT // mainly just to get the "your armor was penetrated" message

	cell_hit_cost *= overcharge_cell_cost_mult

	power_use_amount = overcharge_passive_power_loss

	set_light_range_power_color(overcharge_light_range, overcharge_light_power, overcharge_light_color)

	add_atom_colour(COLOR_CYAN, ADMIN_COLOUR_PRIORITY)
	update_inhand_icon(user)

	if (active)
		START_PROCESSING(SSobj, src)

	overcharged = TRUE

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

	if (overcharged && !.)
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
		playsound(get_turf(src), 'sound/magic/mm_hit.ogg', overcharge_stun_volume, TRUE, -1, frequency = 1.3)
		target.visible_message(span_danger("[user]'s [src.name] sparks violently as it's overcharged prongs penetrate [target]'s armor!"))

/obj/item/melee/baton/security/attack_self(mob/user)
	. = ..()

	if (active)
		if (overcharged)
			START_PROCESSING(SSobj, src)
	else
		STOP_PROCESSING(SSobj, src)

	set_light_on(active)

/obj/item/melee/baton/security/attackby(obj/item/item, mob/user, params)

	if(istype(item, /obj/item/stock_parts/cell))
		var/obj/item/stock_parts/cell/new_cell = item

		if (!cell && !(new_cell.maxcharge < cell_hit_cost)) //this all exists to delay adding a cell
			user.balloon_alert_to_viewers("replacing cell...")
			if (!do_after(user, 3 SECONDS, src))
				return FALSE

	. = ..()

	if (item == cell)
		playsound(src, sound_cell_insert, 40)

/obj/item/melee/baton/security/tryremovecell(mob/user)
	. = ..()

	if (.)
		playsound(src, sound_cell_remove, 40)

		if (overcharged)
			if (user)
				balloon_alert(user, "not enough power!")
			disable_overcharge(user)

		set_light_on(active)

/obj/item/melee/baton/security/examine(mob/user)
	. = ..()

	if (overcharged)
		. += span_blue("This [name] is overcharged, granting it greatly enhanced armor penetration at the cost of extreme energy cost and passive discharge.")

/obj/item/melee/baton/security/process(seconds_per_tick)
	deductcharge(power_use_amount)

	if(!active || !overcharged)
		STOP_PROCESSING(SSobj, src)

	if (overcharged && (!cell || (cell.charge < (cell_hit_cost))))
		var/mob/user
		if (istype(loc, /mob))
			user = loc
			balloon_alert(user, "not enough power!")
		disable_overcharge(user)

// Override to make batons respect armor
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
			target.Knockdown((isnull(stun_override) ? knockdown_time : stun_override))
		additional_effects_non_cyborg(target, user)
	return TRUE
