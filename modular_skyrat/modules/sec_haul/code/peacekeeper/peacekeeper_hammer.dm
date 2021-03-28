/obj/item/melee/hammer
	name = "D-4 Tactical hammer"
	desc = "A metallic-plastic composite breaching hammer, looks like a whack with this would severly harm or tire someone."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	icon_state = "peacekeeper_baton"
	inhand_icon_state = "peacekeeper_baton"
	worn_icon_state = "classic_baton"
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/baton/peacekeeper_baton_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/baton/peacekeeper_baton_righthand.dmi'
	var/breaching_delay = 2 SECONDS
	var/breaching_target = null
	var/breaching
	var/registered = FALSE
	var/list/breachers = list()
	slot_flags = ITEM_SLOT_BELT
	force = 15
	throwforce = 35
	wound_bonus = 30
	bare_wound_bonus = 40
	block_chance = 45
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("whacks","breaches","bulldozes")
	attack_verb_simple = list("breaches","hammers","whacks","slaps","annhilates")

/obj/item/melee/hammer/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(attack_type == PROJECTILE_ATTACK)
		final_block_chance = 15 // Less likely to parry a fucking bullet
	return ..()

/obj/item/melee/hammer/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	user.changeNext_move(6 SECONDS)
	if(istype(target, /obj/machinery/door))
		to_chat(user, text = "You prepare to forcefully strike the door")
		if(!registered)
			RegisterSignal(user, COMSIG_MOVABLE_MOVED, .proc/remove_track, FALSE)
			RegisterSignal(target, COMSIG_BREACHING, .proc/try_breaching, TRUE)
			registered = TRUE
		if(!(breachers.Find(user, 1, 0)))
			breachers += user
		SEND_SIGNAL(target, COMSIG_BREACHING, user, breachers)
		breaching_target = target
	if(iscarbon(target))
		var/mob/living/carbon/H = target
		H.KnockToFloor(FALSE, FALSE, 2 SECONDS)
		H.apply_damage_type(30, STAMINA)
		H.throw_at(get_step_away(H, user), 1, 1, user, TRUE)

/obj/item/melee/hammer/proc/remove_track()
	SIGNAL_HANDLER
	registered = FALSE
	breaching = FALSE
	UnregisterSignal(breaching_target, COMSIG_BREACHING)
	breaching_target = null
	for(var/breacher in breachers)
		if(get_turf(src) == get_turf(breacher))
			UnregisterSignal(breacher, COMSIG_MOVABLE_MOVED)
			to_chat(breacher, text = "You relax , and don't prepare to strike the door anymore")
		breachers -= breacher

/obj/item/melee/hammer/proc/try_breaching(obj/target, mob/living/carbon/human/user, list/fellow_breachers)
	SIGNAL_HANDLER
	if(breaching)
		return FALSE
	for(var/fellow_breacher in fellow_breachers)
		if(fellow_breacher != user)
			breachers += fellow_breacher
	if(breachers.len < 2)
		return FALSE
	if(!(user.Adjacent(target)))
		remove_track()
		return NONE
	for(var/breacher in breachers)
		INVOKE_ASYNC(src, /obj/item/melee/hammer.proc/breaching_loop , breacher, target)
		to_chat(breacher , text = "You begin forcefully smashing the [target]")
	SEND_SIGNAL(target, COMSIG_BREACHING, user, breachers)

/obj/item/melee/hammer/proc/breaching_loop(mob/living/user, obj/target)
	breaching = TRUE
	if(user.stat)
		remove_track()
		return FALSE
	if(!target)
		remove_track()
		return NONE
	if(target.obj_integrity < 1)
		do_smoke(3, target.loc)
		qdel(target)
		for(var/breacher in breachers)
			breachers -= breacher
		remove_track()
	if(!(user.Adjacent(target)))
		remove_track()
		return NONE
	if(do_after(user, breaching_delay))
		target.obj_integrity -= force*2.5
		playsound(target, 'sound/effects/hit_kick.ogg', 70)
		visible_message("[user] smashes the [target] forcefully with the [src]")
		user.do_attack_animation(target, used_item = src)
		breaching_loop(user, target)
		return TRUE
	remove_track()
