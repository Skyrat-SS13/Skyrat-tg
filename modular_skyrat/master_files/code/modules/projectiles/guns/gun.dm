/obj/item/gun
	icon = 'modular_skyrat/modules/fixing_missing_icons/ballistic.dmi' // skyrat edit

<<<<<<< HEAD
=======
	var/gun_flags = NONE
	var/fire_sound = 'sound/weapons/gun/pistol/shot.ogg'
	var/vary_fire_sound = TRUE
	var/fire_sound_volume = 50
	var/dry_fire_sound = 'sound/weapons/gun/general/dry_fire.ogg'
	var/suppressed = null // whether or not a message is displayed when fired
	var/can_suppress = FALSE
	var/suppressed_sound = 'sound/weapons/gun/general/heavy_shot_suppressed.ogg'
	var/suppressed_volume = 60
	var/can_unsuppress = TRUE
	var/recoil = 0 // boom boom shake the room
	var/clumsy_check = TRUE
	var/obj/item/ammo_casing/chambered = null
	trigger_guard = TRIGGER_GUARD_NORMAL // trigger guard on the weapon, hulks can't fire them with their big meaty fingers
	var/sawn_desc = null // description change if weapon is sawn-off
	var/sawn_off = FALSE
	var/burst_size = 1 // how large a burst is
	var/fire_delay = 0 // rate of fire for burst firing and semi auto
	var/firing_burst = 0 // Prevent the weapon from firing again while already firing
	var/semicd = 0 // cooldown handler
	var/weapon_weight = WEAPON_LIGHT
	var/dual_wield_spread = 24 // additional spread when dual wielding
	///Can we hold up our target with this? Default to yes
	var/can_hold_up = TRUE

	/// Just 'slightly' snowflakey way to modify projectile damage for projectiles fired from this gun.
	var/projectile_damage_multiplier = 1

	var/spread = 0 // Spread induced by the gun itself.
	var/randomspread = 1 // Set to 0 for shotguns. This is used for weapons that don't fire all their bullets at once.

	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'

	var/obj/item/firing_pin/pin = /obj/item/firing_pin // standard firing pin for most guns

	var/pinless = FALSE

	var/can_bayonet = FALSE // if a bayonet can be added or removed if it already has one.
>>>>>>> origin/master
	var/bayonet_state = "bayonet"
	var/bayonet_icon = 'icons/obj/weapons/guns/bayonets.dmi'

	var/safety = FALSE /// Internal variable for keeping track whether the safety is on or off
	var/has_gun_safety = FALSE /// Whether the gun actually has a gun safety
	var/datum/action/item_action/toggle_safety/toggle_safety_action

	var/datum/action/item_action/toggle_firemode/firemode_action
	/// Current fire selection, can choose between burst, single, and full auto.
	var/fire_select = SELECT_SEMI_AUTOMATIC
	var/fire_select_index = 1
	/// What modes does this weapon have? Put SELECT_FULLY_AUTOMATIC in here to enable fully automatic behaviours.
	var/list/fire_select_modes = list(SELECT_SEMI_AUTOMATIC)
	/// if i`1t has an icon for a selector switch indicating current firemode.
	var/selector_switch_icon = FALSE
	/// Bitflags for the company that produces the gun, do not give more than one company.
	var/company_flag

/datum/action/item_action/toggle_safety
	name = "Toggle Safety"
	icon_icon = 'modular_skyrat/modules/gunsafety/icons/actions.dmi'
	button_icon_state = "safety_on"

/obj/item/gun/ui_action_click(mob/user, actiontype)
	if(istype(actiontype, /datum/action/item_action/toggle_firemode))
		fire_select()
	else if(istype(actiontype, toggle_safety_action))
		toggle_safety(user)
	else
		..()

/obj/item/gun/Initialize(mapload)
	. = ..()

	if(has_gun_safety)
		safety = TRUE
		toggle_safety_action = new(src)
		add_item_action(toggle_safety_action)

	if(burst_size > 1 && !(SELECT_BURST_SHOT in fire_select_modes))
		fire_select_modes.Add(SELECT_BURST_SHOT)
	else if(burst_size <= 1 && (SELECT_BURST_SHOT in fire_select_modes))
		fire_select_modes.Remove(SELECT_BURST_SHOT)

	burst_size = 1

	sort_list(fire_select_modes, GLOBAL_PROC_REF(cmp_numeric_asc))

	if(fire_select_modes.len > 1)
		firemode_action = new(src)
		firemode_action.button_icon_state = "fireselect_[fire_select]"
		firemode_action.UpdateButtons()
		add_item_action(firemode_action)

	if(SELECT_FULLY_AUTOMATIC in fire_select_modes)
		AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/Destroy()
	if(toggle_safety_action)
		QDEL_NULL(toggle_safety_action)
	if(firemode_action)
		QDEL_NULL(firemode_action)
	return ..()

/obj/item/gun/examine(mob/user)
	. = ..()
	if(has_gun_safety)
		. += "<span>The safety is [safety ? "<font color='#00ff15'>ON</font>" : "<font color='#ff0000'>OFF</font>"].</span>"

	switch(company_flag)
		if(COMPANY_CANTALAN)
			. += "<br>It has <b>[span_purple("Cantalan Federal Arms")]</b> etched into the grip."
		if(COMPANY_ARMADYNE)
			. += "<br>It has <b>[span_red("Armadyne Corporation")]</b> etched into the barrel."
		if(COMPANY_SCARBOROUGH)
			. += "<br>It has <b>[span_orange("Scarborough Arms")]</b> stamped onto the grip."
		if(COMPANY_DONK)
			. += "<br>It has a <b>[span_green("Donk Corporation")]</b> label visible in the plastic."
		if(COMPANY_BOLT)
			. += "<br>It has <b>[span_yellow("Bolt Fabrications")]</b> stamped onto the reciever."
		if(COMPANY_OLDARMS)
			. += "<br>It has <b><i>[span_red("Armadyne Oldarms")]</i></b> etched into the barrel."
		if(COMPANY_IZHEVSK)
			. += "<br>It has <b>[span_brown("Izhevsk Coalition")]</b> cut in above the magwell."
		if(COMPANY_NANOTRASEN)
			. += "<br>It has <b>[span_blue("Nanotrasen Armories")]</b> etched into the reciever."
		if(COMPANY_ALLSTAR)
			. += "<br>It has <b>[span_red("Allstar Lasers Inc.")]</b> stamped on the front grip."
		if(COMPANY_MICRON)
			. += "<br>It has <b>[span_cyan("Micron Control Sys.")]</b> cut in above the cell slot."
		if(COMPANY_INTERDYNE)
			. += "<br>It has <b>[span_cyan("Interdyne Pharmaceuticals")]</b> stamped onto the barrel."
		if(COMPANY_ABDUCTOR)
			. += "<br>It has <b>[span_abductor("✌︎︎♌︎︎♎︎︎◆︎︎♍︎︎⧫︎︎❄︎♏︎♍︎♒︎")]</b> engraved into the photon accelerator."
		if(COMPANY_REMOVED)
			. += "<br>It has had <b>[span_grey("all identifying marks scrubbed off")].</b>"

/obj/item/gun/proc/fire_select()
	var/mob/living/carbon/human/user = usr

	var/max_mode = fire_select_modes.len

	if(max_mode <= 1)
		balloon_alert(user, "only one firemode!")
		return

	fire_select_index = 1 + fire_select_index % max_mode // Magic math to cycle through this shit!

	fire_select = fire_select_modes[fire_select_index]

	switch(fire_select)
		if(SELECT_SEMI_AUTOMATIC)
			burst_size = 1
			fire_delay = 0
			SEND_SIGNAL(src, COMSIG_GUN_AUTOFIRE_DESELECTED, user)
			balloon_alert(user, "semi-automatic")
		if(SELECT_BURST_SHOT)
			burst_size = initial(burst_size)
			fire_delay = initial(fire_delay)
			SEND_SIGNAL(src, COMSIG_GUN_AUTOFIRE_DESELECTED, user)
			balloon_alert(user, "[burst_size]-round burst")
		if(SELECT_FULLY_AUTOMATIC)
			burst_size = 1
			SEND_SIGNAL(src, COMSIG_GUN_AUTOFIRE_SELECTED, user)
			balloon_alert(user, "automatic")

	playsound(user, 'sound/weapons/empty.ogg', 100, TRUE)
	update_appearance()
	firemode_action.button_icon_state = "fireselect_[fire_select]"
	firemode_action.UpdateButtons()
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
	return TRUE

/obj/item/gun/shoot_live_shot(mob/living/user, pointblank = 0, atom/pbtarget = null, message = 1)
	. = ..()
	if(user.resting)
		user.Immobilize(20, TRUE)

/obj/item/gun/can_trigger_gun(mob/living/user)
	. = ..()
	if(has_gun_safety && safety)
		balloon_alert(user, "safety on!")
		return FALSE

/obj/item/gun/proc/toggle_safety(mob/user, override)
	if(!has_gun_safety)
		return
	if(override)
		if(override == "off")
			safety = FALSE
		else
			safety = TRUE
	else
		safety = !safety
	toggle_safety_action.button_icon_state = "safety_[safety ? "on" : "off"]"
	toggle_safety_action.UpdateButtons()
	playsound(src, 'sound/weapons/empty.ogg', 100, TRUE)
	user.visible_message(
		span_notice("[user] toggles [src]'s safety [safety ? "<font color='#00ff15'>ON</font>" : "<font color='#ff0000'>OFF</font>"]."),
		span_notice("You toggle [src]'s safety [safety ? "<font color='#00ff15'>ON</font>" : "<font color='#ff0000'>OFF</font>"].")
	)
	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)

/obj/item/gun/screwdriver_act(mob/living/user, obj/item/tool)
	. = ..()
	if(pin && user.is_holding(src))
		if(!pin.can_remove)
			balloon_alert(user, "pin can't be removed!")
			return

/obj/item/gun/welder_act(mob/living/user, obj/item/tool)
	. = ..()
	if(!pin.can_remove)
		balloon_alert(user, "pin can't be removed!")
		return

/obj/item/gun/wirecutter_act(mob/living/user, obj/item/tool)
	. = ..()
	if(!pin.can_remove)
		balloon_alert(user, "pin can't be removed!")
		return

/obj/item/gun/update_overlays()
	. = ..()

	if(bayonet)
		var/mutable_appearance/knife_overlay
		var/state = bayonet_state
		if(bayonet.icon_state in icon_states(bayonet_icon)) // Snowflake state?
			state = bayonet.icon_state
		knife_overlay = mutable_appearance(bayonet_icon, state)
		knife_overlay.pixel_x = knife_x_offset
		knife_overlay.pixel_y = knife_y_offset
		. += knife_overlay

/obj/item/gun/emag_act(mob/user, obj/item/card/emag/emag_card)
	. = ..()
	if(!pin.can_remove)
		balloon_alert(user, "firing pin shorted!")
		pin.can_remove = TRUE
		if(!(pin.obj_flags & EMAGGED))
			pin.obj_flags |= EMAGGED
