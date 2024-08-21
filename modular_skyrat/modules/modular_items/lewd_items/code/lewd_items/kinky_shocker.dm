/obj/item/kinky_shocker
	name = "kinky shocker"
	desc = "A small toy that can weakly shock someone."
	icon_state = "shocker_off"
	base_icon_state = "shocker"
	inhand_icon_state = "shocker_off"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	w_class = WEIGHT_CLASS_TINY
	/// If the shocker is on or not
	var/shocker_on = FALSE
	/// Typecasted var that holds the cell placed in the shocker
	var/obj/item/stock_parts/power_store/cell/cell
	/// A type of what cell should be put in the shocker on initialize
	var/preload_cell_type = /obj/item/stock_parts/power_store/cell
	/// What it should cost the cell to use the shocker once
	var/cell_hit_cost = STANDARD_CELL_CHARGE * 0.015
	/// If the user should be able to remove the cell or not
	var/can_remove_cell = TRUE
	/// The custom part of the string that is displayed on activation of the shocker
	var/activate_sound = "sparks"

/obj/item/kinky_shocker/get_cell()
	return cell

/obj/item/kinky_shocker/Initialize(mapload)
	. = ..()
	update_icon_state()
	update_icon()
	if(!preload_cell_type)
		return
	if(!ispath(preload_cell_type, /obj/item/stock_parts/power_store/cell))
		log_mapping("[src] at [AREACOORD(src)] had an invalid preload_cell_type: [preload_cell_type].")
	else
		cell = new preload_cell_type(src)
/// Deduct an amount of charge from the cell
/obj/item/kinky_shocker/proc/deductcharge(chrgdeductamt)
	if(!cell)
		return
	//Note this value returned is significant, as it will determine
	//if a stun is applied or not
	. = cell.use(chrgdeductamt)
	if(shocker_on && cell.charge < cell_hit_cost)
		//we're below minimum, turn off
		shocker_on = FALSE
		update_appearance()
		play_lewd_sound(src, activate_sound, 75, TRUE, -1)

/obj/item/kinky_shocker/examine(mob/user)
	. = ..()
	if(cell)
		. += span_notice("\The [src] is [round(cell.percent())]% charged.")
	else
		. += span_warning("\The [src] does not have a power source installed.")

/obj/item/kinky_shocker/attackby(obj/item/stock_parts/power_store/cell/powercell, mob/user, params)
	if(!istype(powercell))
		return ..()
	if(cell)
		to_chat(user, span_warning("[src] already has a cell!"))
	else
		if(powercell.maxcharge < cell_hit_cost)
			to_chat(user, span_notice("[src] requires a higher capacity cell."))
			return
		if(!user.transferItemToLoc(powercell, src))
			return
		cell = powercell
		to_chat(user, span_notice("You install a cell in [src]."))
		update_appearance()

/obj/item/kinky_shocker/click_alt(mob/user)
	tryremovecell(user)
	return CLICK_ACTION_SUCCESS

/obj/item/kinky_shocker/proc/tryremovecell(mob/user)
	if(!(cell && can_remove_cell))
		return
	cell.update_appearance()
	cell.forceMove(get_turf(src))
	cell = null
	to_chat(user, span_notice("You remove the cell from [src]."))
	shocker_on = FALSE
	update_appearance()
	return CLICK_ACTION_SUCCESS

/obj/item/kinky_shocker/attack_self(mob/user)
	toggle_shocker(user)

/obj/item/kinky_shocker/proc/toggle_shocker(mob/user)
	if(cell && cell.charge >= cell_hit_cost)
		shocker_on = !shocker_on
		to_chat(user, span_notice("You turn the shocker [shocker_on? "on. Buzz!" : "off."]"))
		play_lewd_sound(user, shocker_on ? 'sound/weapons/magin.ogg' : 'sound/weapons/magout.ogg', 40, TRUE)
	else
		shocker_on = FALSE
		if(!cell)
			to_chat(user, span_warning("[src] does not have a power source!"))
		else
			to_chat(user, span_warning("[src] is out of charge."))
	update_appearance()
	add_fingerprint(user)

/obj/item/kinky_shocker/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[shocker_on? "on" : "off"]"
	inhand_icon_state = "[base_icon_state]_[shocker_on? "on" : "off"]"

/obj/item/kinky_shocker/attack(mob/living/target, mob/living/user)
	. = ..()
	var/mob/living/carbon/human/carbon_target = target
	if(!carbon_target && !iscyborg(target))
		return
	if(target.stat == DEAD)
		return

	if(!shocker_on)
		to_chat(user, span_danger("[src] must be enabled before use!"))
		return

	if(!target.check_erp_prefs(/datum/preference/toggle/erp/sex_toy, user, src))
		to_chat(user, span_danger("[target] doesn't want you to do that."))
		return

	var/message = ""
	switch(user.zone_selected) //to let code know what part of body we gonna tickle
		if(BODY_ZONE_PRECISE_GROIN)
			var/obj/item/organ/external/genital/penis = target.get_organ_slot(ORGAN_SLOT_PENIS)
			var/obj/item/organ/external/genital/vagina = target.get_organ_slot(ORGAN_SLOT_VAGINA)
			var/penis_message = (user == target) ? pick("leans [src] against [target.p_their()] penis, letting it shock [target.p_them()]. Ouch...",
					"shocks [target.p_their()] penis with [src]") \
				: pick("uses [src] to shock [target]'s penis",
					"shocks [target]'s penis with [src]",
					"leans [src] against [target]'s penis, turning it on")

			var/vagina_message = (user == target) ? pick("leans [src] against [target.p_their()] vagina, letting it shock [target.p_them()]. Ouch...",
					"shocks [target.p_their()] pussy with [src]") \
				: pick("uses [src] to shock [target]'s vagina",
					"shocks [target]'s pussy with [src]",
					"leans [src] against [target]'s vagina, turning it on")

			if(penis?.is_exposed() && vagina?.is_exposed())
				message = pick(penis_message, vagina_message)
			else if(vagina?.is_exposed())
				message = vagina_message
			else if(penis?.is_exposed())
				message = penis_message
			else if(carbon_target?.is_bottomless())
				message = (user == target) ? pick("leans [src] against [target.p_their()] belly, letting it shock [target.p_them()]. Ouch...",
						"shocks [target.p_their()] tummy with [src]") \
					: pick("uses [src] to shock [target]'s belly",
						"shocks [target]'s tummy with [src]",
						"leans [src] against [target]'s belly, turning it on")
			else if(iscyborg(target))
				message = (user == target) ? pick("leans [src] against [target.p_their()] synthetic genitals, letting it shock [target.p_them()]. Ouch...",
						"shocks [target.p_their()] tummy with [src]") \
					: pick("uses [src] to shock [target]'s synthetic genitals",
						"shocks [target]'s tummy with [src]",
						"leans [src] against [target]'s synthetic genitals, turning it on")
			else
				to_chat(user, span_danger("Looks like [target]'s groin is covered!"))
				return

		if(BODY_ZONE_CHEST)
			var/obj/item/organ/external/genital/breasts = target.get_organ_slot(ORGAN_SLOT_BREASTS)
			if(breasts?.is_exposed())
				message = (user == target) ? pick("leans [src] against [target.p_their()] breasts, letting it shock [target.p_them()].",
						"shocks [target.p_their()] tits with [src]") \
					: pick("uses [src] to shock [target]'s breasts",
						"shocks [target]'s nipples with [src]",
						"leans [src] against [target]'s tits, turning it on")
			else if(carbon_target?.is_topless() || iscyborg(target))
				message = (user == target) ? pick("leans [src] against [target.p_their()] chest, letting it shock [target.p_them()].",
						"shocks [target.p_their()] nipples with [src]") \
					: pick("uses [src] to shock [target]'s chest",
						"shocks [target]'s nipples with [src]",
						"leans [src] against [target]'s chest, turning it on")
			else
				to_chat(user, span_danger("Looks like [target]'s chest is covered!"))
				return

		if(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM)
			if(!carbon_target?.has_arms())
				to_chat(user, span_danger("Looks like [target] doesn't have any arms!"))
				return
			if(!carbon_target?.is_hands_uncovered())
				to_chat(user, span_danger("Looks like [target]'s arms are covered!"))
				return
			var/arm = user.zone_selected == BODY_ZONE_L_ARM ? "left arm" : "right arm"
			message = (user == target) ? pick("leans [src] against [target.p_their()] [arm], letting it shock [target.p_them()].",
					"shocks [target.p_their()] arm with [src]") \
				: pick("uses [src] to shock [target]'s [arm]",
					"shocks [target]'s [arm] with [src]",
					"leans [src] against [target]'s [arm], turning it on")

		if(BODY_ZONE_HEAD)
			if(!carbon_target?.is_head_uncovered())
				to_chat(user, span_danger("Looks like [target]'s head is covered!"))
				return
			message = (user == target) ? pick("leans [src] against [target.p_their()] head, letting it shock [target.p_them()]. Ouch! Why would [target.p_they()] do that?!",
					"shocks [target.p_their()] head with [src]") \
				: pick("uses [src] to shock [target]'s head",
					"shocks [target]'s neck with [src]",
					"leans [src] against [target]'s neck, turning it on")

		if(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
			if(!carbon_target?.has_feet())
				to_chat(user, span_danger("Looks like [target] doesn't have any legs!"))
				return
			if(!carbon_target?.is_barefoot())
				to_chat(user, span_danger("Looks like [target]'s toes are covered!"))
				return
			var/leg = user.zone_selected == BODY_ZONE_L_LEG ? "left leg" : "right leg"
			message = (user == target) ? pick("leans [src] against [target.p_their()] [leg], letting it shock [target.p_them()].",
					"shocks [target.p_their()] leg with [src]") \
				: pick("uses [src] to shock [target]'s [leg]",
					"shocks [target]'s [user.zone_selected == BODY_ZONE_L_LEG ? "left foot" : "right foot"] with [src]",
					"leans [src] against [target]'s [leg], turning it on")
		else
			to_chat(user, span_danger("You can't shock [target] there!"))
			return

	user.visible_message(span_purple("[user] [message]!"))
	play_lewd_sound(loc, 'sound/weapons/taserhit.ogg', 70, 1, -1)
	deductcharge(cell_hit_cost)
	if(prob(80))
		target.try_lewd_autoemote(pick("twitch", "twitch_s", "shiver", "scream"))
	target.do_jitter_animation()
	target.adjustStaminaLoss(3)
	target.adjust_pain(9)
	target.adjust_stutter(30 SECONDS)
