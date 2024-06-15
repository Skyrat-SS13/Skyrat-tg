/obj/item/chameleon
	name = "chameleon projector"
	icon = 'icons/obj/devices/syndie_gadget.dmi'
	icon_state = "shield0"
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = NOBLUDGEON
	slot_flags = ITEM_SLOT_BELT
	inhand_icon_state = "electronic"
	worn_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	var/can_use = 1
	var/obj/effect/dummy/chameleon/active_dummy = null
	var/saved_appearance = null

/obj/item/chameleon/Initialize(mapload)
	. = ..()
	var/obj/item/cigbutt/butt = /obj/item/cigbutt
	saved_appearance = initial(butt.appearance)

/obj/item/chameleon/dropped()
	..()
	disrupt()

/obj/item/chameleon/equipped()
	..()
	disrupt()

/obj/item/chameleon/attack_self(mob/user)
	if (isturf(user.loc) || istype(user.loc, /obj/structure) || active_dummy)
		toggle(user)
	else
		to_chat(user, span_warning("You can't use [src] while inside something!"))

/obj/item/chameleon/interact_with_atom(atom/target, mob/living/user, list/modifiers)
	if(!check_sprite(target))
		return ITEM_INTERACT_BLOCKING
	if(active_dummy)//I now present you the blackli(f)st
		return ITEM_INTERACT_BLOCKING
	if(isturf(target))
		return ITEM_INTERACT_BLOCKING
	if(ismob(target))
		return ITEM_INTERACT_BLOCKING
	if(istype(target, /obj/structure/falsewall))
		return ITEM_INTERACT_BLOCKING
	if(target.alpha != 255)
		return ITEM_INTERACT_BLOCKING
	if(target.invisibility != 0)
		return ITEM_INTERACT_BLOCKING
	if(iseffect(target) && !istype(target, /obj/effect/decal)) //be a footprint
		return ITEM_INTERACT_BLOCKING
	make_copy(target, user)
	return ITEM_INTERACT_SUCCESS

/obj/item/chameleon/proc/make_copy(atom/target, mob/user)
	playsound(get_turf(src), 'sound/weapons/flash.ogg', 100, TRUE, -6)
	to_chat(user, span_notice("Scanned [target]."))
	var/obj/temp = new /obj()
	temp.appearance = target.appearance
	temp.layer = initial(target.layer) // scanning things in your inventory
	SET_PLANE_EXPLICIT(temp, initial(plane), src)
	saved_appearance = temp.appearance

/obj/item/chameleon/proc/check_sprite(atom/target)
	if(target.icon_state in icon_states(target.icon))
		return TRUE
	return FALSE

/obj/item/chameleon/proc/toggle(mob/user)
	if(!can_use || !saved_appearance)
		return
	if(active_dummy)
		eject_all()
		playsound(get_turf(src), 'sound/effects/pop.ogg', 100, TRUE, -6)
		qdel(active_dummy)
		active_dummy = null
		to_chat(user, span_notice("You deactivate \the [src]."))
		new /obj/effect/temp_visual/emp/pulse(get_turf(src))
	else
		playsound(get_turf(src), 'sound/effects/pop.ogg', 100, TRUE, -6)
		var/obj/effect/dummy/chameleon/C = new/obj/effect/dummy/chameleon(user.drop_location())
		C.activate(user, saved_appearance, src)
		to_chat(user, span_notice("You activate \the [src]."))
		new /obj/effect/temp_visual/emp/pulse(get_turf(src))
	user.cancel_camera()

/obj/item/chameleon/proc/disrupt(delete_dummy = 1)
	if(active_dummy)
		for(var/mob/M in active_dummy)
			to_chat(M, span_danger("Your chameleon projector deactivates."))
		var/datum/effect_system/spark_spread/spark_system = new /datum/effect_system/spark_spread
		spark_system.set_up(5, 0, src)
		spark_system.attach(src)
		spark_system.start()
		eject_all()
		if(delete_dummy)
			qdel(active_dummy)
		active_dummy = null
		can_use = FALSE
		addtimer(VARSET_CALLBACK(src, can_use, TRUE), 5 SECONDS)

/obj/item/chameleon/proc/eject_all()
	for(var/atom/movable/A in active_dummy)
		A.forceMove(active_dummy.loc)
		if(ismob(A))
			var/mob/M = A
			M.reset_perspective(null)

/obj/effect/dummy/chameleon
	name = ""
	desc = ""
	density = FALSE
	var/can_move = 0
	var/obj/item/chameleon/master = null

/obj/effect/dummy/chameleon/proc/activate(mob/M, saved_appearance, obj/item/chameleon/C)
	appearance = saved_appearance
	if(istype(M.buckled, /obj/vehicle))
		var/obj/vehicle/V = M.buckled
		V.unbuckle_mob(M, force = TRUE)
	M.forceMove(src)
	master = C
	master.active_dummy = src

/obj/effect/dummy/chameleon/attackby()
	master.disrupt()

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/effect/dummy/chameleon/attack_hand(mob/user, list/modifiers)
	master.disrupt()

/obj/effect/dummy/chameleon/attack_animal(mob/user, list/modifiers)
	master.disrupt()

/obj/effect/dummy/chameleon/attack_alien(mob/user, list/modifiers)
	master.disrupt()

/obj/effect/dummy/chameleon/ex_act(S, T)
	master.disrupt()
	return TRUE

/obj/effect/dummy/chameleon/bullet_act()
	. = ..()
	master.disrupt()

/obj/effect/dummy/chameleon/relaymove(mob/living/user, direction)
	if(!isturf(loc) || isspaceturf(loc) || !direction)
		return //No magical movement! Trust me, this bad boy can do things like leap out of pipes if you're not careful

	if(can_move < world.time)
		var/amount
		switch(user.bodytemperature)
			if(300 to INFINITY)
				amount = 10
			if(295 to 300)
				amount = 13
			if(280 to 295)
				amount = 16
			if(260 to 280)
				amount = 20
			else
				amount = 25

		can_move = world.time + amount
		try_step_multiz(direction)
	return

/obj/effect/dummy/chameleon/Destroy()
	if(master)
		master.disrupt(0)
		master = null
	return ..()
