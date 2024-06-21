#define ACTIVATION_COST (0.3 * STANDARD_CELL_CHARGE)
#define ACTIVATION_UP_KEEP (0.025 * STANDARD_CELL_RATE)

/obj/item/borg_chameleon
	name = "cyborg chameleon projector"
	icon = 'icons/obj/devices/syndie_gadget.dmi'
	icon_state = "shield0"
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = NOBLUDGEON
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	var/friendlyName
	var/savedName
	var/active = FALSE
	var/disguise = "engineer"
	var/mob/listeningTo
	var/static/list/signalCache = list( // list here all signals that should break the camouflage
			COMSIG_ATOM_ATTACKBY,
			COMSIG_ATOM_ATTACK_HAND,
			COMSIG_MOVABLE_IMPACT_ZONE,
			COMSIG_ATOM_BULLET_ACT,
			COMSIG_ATOM_EX_ACT,
			COMSIG_ATOM_FIRE_ACT,
			COMSIG_ATOM_EMP_ACT,
			)
	var/mob/living/silicon/robot/user // needed for process()
	var/animation_playing = FALSE

/obj/item/borg_chameleon/Initialize(mapload)
	. = ..()
	friendlyName = pick(GLOB.ai_names)

/obj/item/borg_chameleon/Destroy()
	listeningTo = null
	return ..()

/obj/item/borg_chameleon/dropped(mob/user)
	. = ..()
	disrupt(user)

/obj/item/borg_chameleon/equipped(mob/user)
	. = ..()
	disrupt(user)

/obj/item/borg_chameleon/attack_self(mob/living/silicon/robot/user)
	if (user && user.cell && user.cell.charge >  ACTIVATION_COST)
		if (isturf(user.loc))
			toggle(user)
		else
			to_chat(user, span_warning("You can't use [src] while inside something!"))
	else
		to_chat(user, span_warning("You need at least [display_energy(ACTIVATION_COST)] of charge in your cell to use [src]!"))

/obj/item/borg_chameleon/proc/toggle(mob/living/silicon/robot/user)
	if(active)
		playsound(src, 'sound/effects/pop.ogg', 100, TRUE, -6)
		to_chat(user, span_notice("You deactivate \the [src]."))
		deactivate(user)
	else
		if(animation_playing)
			to_chat(user, span_notice("\the [src] is recharging."))
			return
		animation_playing = TRUE
		to_chat(user, span_notice("You activate \the [src]."))
		playsound(src, 'sound/effects/seedling_chargeup.ogg', 100, TRUE, -6)
		apply_wibbly_filters(user)
		if (do_after(user, 5 SECONDS, target = user, hidden = TRUE) && user.cell.use(ACTIVATION_COST))
			playsound(src, 'sound/effects/bamf.ogg', 100, TRUE, -6)
			to_chat(user, span_notice("You are now disguised as the Nanotrasen engineering borg \"[friendlyName]\"."))
			activate(user)
		else
			to_chat(user, span_warning("The chameleon field fizzles."))
			do_sparks(3, FALSE, user)
		remove_wibbly_filters(user)
		animation_playing = FALSE

/obj/item/borg_chameleon/process(seconds_per_tick)
	if (user)
		if (!user.cell || !user.cell.use(ACTIVATION_UP_KEEP * seconds_per_tick))
			disrupt(user)
	else
		return PROCESS_KILL

/obj/item/borg_chameleon/proc/activate(mob/living/silicon/robot/user)
	START_PROCESSING(SSobj, src)
	src.user = user
	savedName = user.name
	user.name = friendlyName
	user.model.cyborg_base_icon = disguise
	user.model.name = capitalize(disguise)
	user.bubble_icon = "robot"
	active = TRUE
	user.update_icons()

	if(listeningTo == user)
		return
	if(listeningTo)
		UnregisterSignal(listeningTo, signalCache)
	RegisterSignals(user, signalCache, PROC_REF(disrupt))
	listeningTo = user

/obj/item/borg_chameleon/proc/deactivate(mob/living/silicon/robot/user)
	STOP_PROCESSING(SSobj, src)
	if(listeningTo)
		UnregisterSignal(listeningTo, signalCache)
		listeningTo = null
	do_sparks(5, FALSE, user)
	user.name = savedName
	user.model.cyborg_base_icon = initial(user.model.cyborg_base_icon)
	user.model.name = initial(user.model.name)
	user.bubble_icon = "syndibot"
	active = FALSE
	user.update_icons()
	src.user = user

/obj/item/borg_chameleon/proc/disrupt(mob/living/silicon/robot/user)
	SIGNAL_HANDLER
	if(active)
		to_chat(user, span_danger("Your chameleon field deactivates."))
		deactivate(user)

#undef ACTIVATION_COST
#undef ACTIVATION_UP_KEEP
