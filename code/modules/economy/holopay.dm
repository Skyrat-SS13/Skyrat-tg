/obj/structure/holopay
	name = "holographic pay stand"
	desc = "an unregistered pay stand"
	icon = 'icons/obj/economy.dmi'
	icon_state = "card_scanner"
	alpha = 150
	anchored = TRUE
	armor_type = /datum/armor/structure_holopay
	max_integrity = 15
	layer = FLY_LAYER
	/// ID linked to the holopay
	var/obj/item/card/id/linked_card
	/// Max range at which the hologram can be projected before it deletes
	var/max_holo_range = 4
	/// The holopay shop icon displayed in the UI
	var/shop_logo = "donate"
	/// Replaces the "pay whatever" functionality with a set amount when non-zero.
	var/force_fee = 0

/datum/armor/structure_holopay
	bullet = 50
	laser = 50
	energy = 50
	fire = 20
	acid = 20

/obj/structure/holopay/examine(mob/user)
	. = ..()
	if(force_fee)
		. += span_boldnotice("This holopay forces a payment of <b>[force_fee]</b> credit\s per swipe instead of a variable amount.")

/obj/structure/holopay/Initialize(mapload)
	. = ..()
	register_context()

/obj/structure/holopay/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()

	if(isidcard(held_item))
		context[SCREENTIP_CONTEXT_LMB] = "Pay"
		var/obj/item/card/id/held_id = held_item
		if(held_id.my_store && held_id.my_store == src)
			context[SCREENTIP_CONTEXT_RMB] = "Dissipate pay stand"
		return CONTEXTUAL_SCREENTIP_SET

	else if(istype(held_item, /obj/item/holochip))
		context[SCREENTIP_CONTEXT_LMB] = "Pay"
		return CONTEXTUAL_SCREENTIP_SET

/obj/structure/holopay/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!user.combat_mode)
		ui_interact(user)
		return .
	user.do_attack_animation(src, ATTACK_EFFECT_PUNCH)
	user.changeNext_move(CLICK_CD_MELEE)
	take_damage(5, BRUTE, MELEE, 1)

/obj/structure/holopay/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			playsound(loc, 'sound/weapons/egloves.ogg', 80, TRUE)
		if(BURN)
			playsound(loc, 'sound/weapons/egloves.ogg', 80, TRUE)

/obj/structure/holopay/atom_deconstruct(dissambled = TRUE)
	dissipate()

/obj/structure/holopay/Destroy()
	linked_card?.my_store = null
	linked_card = null
	return ..()

/obj/structure/holopay/attackby(obj/item/held_item, mob/item_holder, params)
	var/mob/living/user = item_holder
	if(!isliving(user))
		return ..()
	/// Users can pay with an ID to skip the UI
	if(isidcard(held_item))
		if(force_fee && tgui_alert(item_holder, "This holopay has a [force_fee] cr fee. Confirm?", "Holopay Fee", list("Pay", "Cancel")) != "Pay")
			return TRUE
		process_payment(user)
		return TRUE
	/// Users can also pay by holochip
	if(istype(held_item, /obj/item/holochip))
		/// Account checks
		var/obj/item/holochip/chip = held_item
		if(!chip.credits)
			balloon_alert(user, "holochip is empty")
			to_chat(user, span_warning("There doesn't seem to be any credits here."))
			return FALSE
		/// Charges force fee or uses pay what you want
		var/cash_deposit = force_fee || tgui_input_number(user, "How much? (Max: [chip.credits])", "Patronage", max_value = chip.credits)
		/// Exit sanity checks
		if(!cash_deposit)
			return TRUE
		if(QDELETED(held_item) || QDELETED(user) || QDELETED(src) || !user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
			return FALSE
		if(!chip.spend(cash_deposit, FALSE))
			balloon_alert(user, "insufficient credits")
			to_chat(user, span_warning("You don't have enough credits to pay with this chip."))
			return FALSE
		/// Success: Alert buyer
		alert_buyer(user, cash_deposit)
		return TRUE
	/// Throws errors if they try to use space cash
	if(istype(held_item, /obj/item/stack/spacecash))
		to_chat(user, "What is this, the 2000s? We only take card here.")
		return TRUE
	if(istype(held_item, /obj/item/coin))
		to_chat(user, "What is this, the 1800s? We only take card here.")
		return TRUE
	return ..()

/obj/structure/holopay/attackby_secondary(obj/item/weapon, mob/user, params)
	/// Can kill it by right-clicking with ID because it seems useful and intuitive, to me, at least
	if(!isidcard(weapon))
		return ..()
	var/obj/item/card/id/attacking_id = weapon
	if(!attacking_id.my_store || attacking_id.my_store != src)
		return ..()
	dissipate()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/holopay/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	if(.)
		return FALSE
	var/mob/living/interactor = user
	if(isliving(interactor) && interactor.combat_mode)
		return FALSE
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "HoloPay")
		ui.open()

/obj/structure/holopay/ui_status(mob/user, datum/ui_state/state)
	. = ..()
	if(!in_range(user, src) && !isobserver(user))
		return UI_CLOSE

/obj/structure/holopay/ui_static_data(mob/user)
	. = list()
	.["available_logos"] = linked_card.available_logos
	.["description"] = desc
	.["max_fee"] = linked_card.holopay_max_fee
	.["owner"] = linked_card.registered_account?.account_holder || null
	.["shop_logo"] = shop_logo

/obj/structure/holopay/ui_data(mob/user)
	. = list()
	.["force_fee"] = force_fee
	.["name"] = name
	if(!isliving(user))
		return .
	var/mob/living/card_holder = user
	var/obj/item/card/id/id_card = card_holder.get_idcard(TRUE)
	var/datum/bank_account/account = id_card?.registered_account || null
	if(account)
		.["user"] = list()
		.["user"]["name"] = account.account_holder
		.["user"]["balance"] = account.account_balance

/obj/structure/holopay/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return FALSE
	switch(action)
		if("done")
			ui.send_full_update()
			return TRUE
		if("fee")
			linked_card.set_holopay_fee(params["amount"])
			force_fee = linked_card.holopay_fee
		if("logo")
			linked_card.set_holopay_logo(params["logo"])
			shop_logo = linked_card.holopay_logo
		if("pay")
			ui.close()
			process_payment(usr)
			return TRUE
		if("rename")
			linked_card.set_holopay_name(params["name"])
			name = linked_card.holopay_name
	return FALSE

/**
 * Links the source card to the holopay. Begins checking if its in range.
 *
 * Parameters:
 * * turf/target - The tile to project the holopay onto
 * * obj/item/card/id/card - The card to link to the holopay
 * Returns:
 * * TRUE - the card was linked
 */
/obj/structure/holopay/proc/assign_card(turf/target, obj/item/card/id/card)
	linked_card = card
	desc = "Pays directly into [card.registered_account.account_holder]'s bank account."
	force_fee = card.holopay_fee
	shop_logo = card.holopay_logo
	name = card.holopay_name
	add_atom_colour("#77abff", FIXED_COLOUR_PRIORITY)
	set_light(2)
	visible_message(span_notice("A holographic pay stand appears."))
	/// Start checking if the source projection is in range
	track(linked_card)
	return TRUE

/obj/structure/holopay/proc/track(atom/movable/thing)
	RegisterSignal(thing, COMSIG_MOVABLE_MOVED, PROC_REF(handle_move))
	var/list/locations = get_nested_locs(thing, include_turf = FALSE)
	for(var/atom/movable/location in locations)
		RegisterSignal(location, COMSIG_MOVABLE_MOVED, PROC_REF(handle_move))

/obj/structure/holopay/proc/untrack(atom/movable/thing)
	UnregisterSignal(thing, COMSIG_MOVABLE_MOVED)
	var/list/locations = get_nested_locs(thing, include_turf = FALSE)
	for(var/atom/movable/location in locations)
		UnregisterSignal(location, COMSIG_MOVABLE_MOVED)

/**
 * A periodic check to see if the projecting card is nearby.
 * Deletes the holopay if not.
 */
/obj/structure/holopay/proc/handle_move(atom/movable/source, atom/old_loc, dir, forced, list/old_locs)
	if(ismovable(old_loc))
		untrack(old_loc)
	if(!IN_GIVEN_RANGE(src, linked_card, max_holo_range))
		dissipate()
		return
	if(ismovable(source.loc))
		track(source.loc)

/**
 * Creates holopay vanishing effects.
 * Deletes the holopay thereafter.
 */
/obj/structure/holopay/proc/dissipate()
	playsound(loc, 'sound/effects/empulse.ogg', 40, TRUE)
	visible_message(span_notice("The pay stand vanishes."))
	qdel(src)

/**
 * Initiates a transaction between accounts.
 *
 * Parameters:
 * * mob/living/user - The user who initiated the transaction.
 * Returns:
 * * TRUE - transaction was successful
 */
/obj/structure/holopay/proc/process_payment(mob/living/user)
	/// Account checks
	var/obj/item/card/id/id_card
	id_card = user.get_idcard(TRUE)
	if(isnull(id_card) || id_card.can_be_used_in_payment(user))
		balloon_alert(user, "invalid account")
		to_chat(user, span_warning("You don't have a valid account."))
		return FALSE
	var/datum/bank_account/payee = id_card.registered_account
	if(payee == linked_card?.registered_account)
		balloon_alert(user, "invalid transaction")
		to_chat(user, span_warning("You can't pay yourself."))
		return FALSE
	/// If the user has enough money, ask them the amount or charge the force fee
	var/amount = force_fee || tgui_input_number(user, "How much? (Max: [payee.account_balance])", "Patronage", max_value = payee.account_balance)
	/// Exit checks in case the user cancelled or entered an invalid amount
	if(!amount || QDELETED(user) || QDELETED(src) || !user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
		return FALSE
	if(!payee.adjust_money(-amount, "Holopay: [capitalize(name)]"))
		balloon_alert(user, "insufficient credits")
		to_chat(user, span_warning("You don't have the money to pay for this."))
		return FALSE
	/// Success: Alert the buyer
	alert_buyer(user, amount)
	return TRUE

/**
 * Alerts the owner of the transaction.
 *
 * Parameters:
 * * payee - The user who initiated the transaction.
 * * amount - The amount of money that was paid.
 * Returns:
 * * TRUE - alert was successful.
 */
/obj/structure/holopay/proc/alert_buyer(payee, amount)
	/// Pay the owner
	linked_card.registered_account.adjust_money(amount, "Holopay: [name]")
	/// Make alerts
	linked_card.registered_account.bank_card_talk("[payee] has deposited [amount] cr at your holographic pay stand.")
	say("Thank you for your patronage, [payee]!")
	playsound(src, 'sound/effects/cashregister.ogg', 20, TRUE)
	/// Log the event
	log_econ("[amount] credits were transferred from [payee]'s transaction to [linked_card.registered_account.account_holder]")
	SSblackbox.record_feedback("amount", "credits_transferred", amount)
	return TRUE
