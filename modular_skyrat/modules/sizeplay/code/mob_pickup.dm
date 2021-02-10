#define COOLDOWN_INTERACT_WITH_HELD_MOB	interact_held_mob

/mob/living/carbon
	 COOLDOWN_DECLARE(COOLDOWN_INTERACT_WITH_HELD_MOB)

/mob/living/proc/can_be_picked_up(mob/living/carbon/human/picker)
	. = TRUE

	//Hope it will be generic enough. Pocket corgis here I go.
	//Also you can pick up small mobs like mice and stuff without making them tiny.
	var/relative_size = ((picker.mob_size+1) * picker.body_size_multiplier) / ((mob_size+1) * body_size_multiplier)
	if(relative_size < CONFIG_GET(number/mob_pickup_relative_size))
		return FALSE


//Generic system for picking up mobs.
//Based on the drone pickup code.
//Let's drop wearing people on your head for time being, might re-implement later.

/mob/living/Initialize()
	. = ..()
	if(CONFIG_GET(flag/mob_pickup))
		RegisterSignal(src, COMSIG_LIVING_GET_PULLED, .proc/attempt_pickup)

/mob/living/proc/attempt_pickup(atom/source, mob/living/puller)
	SIGNAL_HANDLER

	if(!iscarbon(puller))
		return
	var/mob/living/carbon/picker = puller
	if(!can_be_picked_up(picker))
		return
	if(picker.get_active_held_item())
		to_chat(picker, "<span class='warning'>Your hands are full!</span>")
		return
	if(buckled)
		to_chat(picker, "<span class='warning'>[src] is buckled to [buckled] and cannot be picked up!</span>")
		return

	INVOKE_ASYNC(src, .proc/start_pickup, puller)

/mob/living/proc/start_pickup(mob/living/carbon/human/picker)
	visible_message("<span class='warning'>[picker] starts picking up [src].</span>", "<span class='userdanger'>[picker] starts picking you up!</span>")
	if(!do_after(picker, 20, target = src))
		return

	if(picker.grab_state > GRAB_PASSIVE)
		return

	visible_message("<span class='warning'>[picker] picks up [src]!</span>", "<span class='userdanger'>[picker] picks you up!</span>")
	to_chat(picker, "<span class='notice'>You pick [src] up.</span>")
	var/obj/item/mob_holder/MH = new(get_turf(src), src)
	picker.put_in_hands(MH)
	Stun(10)

/obj/item/mob_holder
	name = "bugged mob"
	desc = "You shouldn't be seeing this."
	w_class = WEIGHT_CLASS_SMALL
	icon = null
	icon_state = ""
	slot_flags = NONE
	var/mob/living/held_mob
	var/destroying = FALSE

/obj/item/mob_holder/Initialize(mapload, mob/living/M)
	deposit(M)
	. = ..()

/obj/item/mob_holder/Destroy()
	destroying = TRUE
	if(held_mob)
		release(FALSE)
	return ..()

/obj/item/mob_holder/proc/deposit(mob/living/L)
	if(!istype(L))
		return FALSE
	L.setDir(SOUTH)
	update_visuals(L)
	held_mob = L
	L.forceMove(src)
	name = L.name
	desc = L.desc
	return TRUE

/obj/item/mob_holder/proc/update_visuals(mob/living/L)
	appearance = L.appearance
	transform = L.transform.Scale(1/L.body_size_multiplier)

/obj/item/mob_holder/attack_self(mob/living/carbon/user)
	. = ..()
	if(COOLDOWN_FINISHED(user, COOLDOWN_INTERACT_WITH_HELD_MOB))
		if(user.combat_mode)
			to_chat(held_mob, "<span class='userdanger'>[user] crushes you in \his grip.</span>")
			user.visible_message("<span class='warning'>[user] squeezes [held_mob] in \his grip.</span>")
			held_mob.apply_damage(damage = 20, damagetype = BRUTE, spread_damage = TRUE, wound_bonus = 10)
		else
			held_mob.attack_hand(user)
		COOLDOWN_START(user, COOLDOWN_INTERACT_WITH_HELD_MOB, 15)

/obj/item/mob_holder/proc/release(del_on_release = TRUE, display_messages = TRUE)
	if(!held_mob)
		if(del_on_release && !destroying)
			qdel(src)
		return FALSE
	if(isliving(loc))
		var/mob/living/L = loc
		if(display_messages)
			to_chat(L, "<span class='warning'>[held_mob] slips out of your grip!</span>")
		L.dropItemToGround(src)
	held_mob.forceMove(get_turf(held_mob))
	held_mob.reset_perspective()
	held_mob.setDir(SOUTH)
	held_mob = null
	if(del_on_release && !destroying)
		qdel(src)
	return TRUE

/obj/item/mob_holder/examine(mob/user)
	if(held_mob)
		return held_mob.examine(user)
	else
		. = ..()

/obj/item/mob_holder/examine_more(mob/user)
	if(held_mob)
		return held_mob.examine_more(user)
	else
		. = ..()

/obj/item/mob_holder/relaymove(mob/living/user, direction)
	release()

/obj/item/mob_holder/container_resist_act()
	release()

/obj/item/mob_holder/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(..())
		release()

/obj/item/mob_holder/dropped()
	. = ..()
	release()
