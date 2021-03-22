/datum/component/gun_hud
	var/atom/movable/screen/ammo_counter/hud

/datum/component/gun_hud/Initialize()
	. = ..()
	if(!istype(parent, /obj/item/gun/ballistic))
		return COMPONENT_INCOMPATIBLE
	var/obj/item/gun/ballistic = parent
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, .proc/wake_up)
	if(ismob(ballistic.loc))
		var/mob/user = ballistic.loc
		wake_up(src, user)

/datum/component/gun_hud/Destroy()
	turn_off()
	return ..()

/datum/component/gun_hud/proc/wake_up(datum/source, mob/user, slot)
	SIGNAL_HANDLER

	RegisterSignal(parent, list(COMSIG_PARENT_PREQDELETED, COMSIG_ITEM_DROPPED), .proc/turn_off)

	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.is_holding(parent))
			hud = H.hud_used.ammo_counter
			turn_on(user)
		else
			turn_off(user)

/datum/component/gun_hud/proc/turn_on(mob/user)
	SIGNAL_HANDLER

	RegisterSignal(parent, COMSIG_GUN_UPDATE_HUD, .proc/update_hud)

	hud.turn_on()

	update_hud(user)

/datum/component/gun_hud/proc/turn_off(mob/user)
	SIGNAL_HANDLER

	UnregisterSignal(parent, list(COMSIG_PARENT_PREQDELETED, COMSIG_ITEM_DROPPED, COMSIG_ITEM_EQUIPPED, COMSIG_GUN_UPDATE_HUD))

	hud.turn_off()

	hud = null

/datum/component/gun_hud/proc/update_hud(mob/user)
	if(!ishuman(user))
		turn_off()

	var/obj/item/gun/ballistic/pew = parent

	if(!pew.magazine)
		hud.set_hud(COLOR_RED, "oe", "te", "he", "no_mag")
		return

	if(!pew.get_ammo())
		hud.set_hud(COLOR_RED, "oe", "te", "he", "empty_flash")
		return

	if(pew.safety)
		hud.set_hud(COLOR_RED, "oe", "te", "he", "safe")
		return

	var/rounds = num2text(pew.get_ammo(TRUE))

	var/oth_o
	var/oth_t
	var/oth_h

	switch(length(rounds))
		if(1)
			oth_o = "o[rounds[1]]"
		if(2)
			oth_o = "o[rounds[2]]"
			oth_t = "t[rounds[1]]"
		if(3)
			oth_o = "o[rounds[3]]"
			oth_t = "t[rounds[2]]"
			oth_h = "h[rounds[1]]"
		else
			oth_o = "o9"
			oth_t = "t9"
			oth_h = "h9"

	hud.set_hud(COLOR_RED, oth_o, oth_t, oth_h, "auto")

/obj/item/gun/ballistic
	var/has_ammo_display = TRUE

/obj/item/gun/ballistic/ComponentInitialize()
	. = ..()
	if(has_ammo_display)
		AddComponent(/datum/component/gun_hud)

/obj/item/gun/ballistic/shoot_live_shot(mob/living/user, pointblank, atom/pbtarget, message)
	. = ..()
	SEND_SIGNAL(src, COMSIG_GUN_UPDATE_HUD, user)
