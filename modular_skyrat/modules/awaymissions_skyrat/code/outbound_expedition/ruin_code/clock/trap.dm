//Thing that you stick on the floor
/obj/item/clockwork_trap_placer
	name = "trap"
	desc = "don't trust it"
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/outbound_expedition/clock_cult.dmi'
	w_class = WEIGHT_CLASS_HUGE
	/// What the trap placer produces on-use
	var/result_path = /obj/structure/destructible/clockwork_trap

/obj/item/clockwork_trap_placer/attack_self(mob/user)
	. = ..()
	for(var/obj/structure/destructible/clockwork_trap/placed_trap in get_turf(src))
		if(istype(placed_trap, type))
			to_chat(user, span_warning("That space is occupied!"))
			return
	to_chat(user, span_brass("You place [src], use a <b>clockwork slab</b> to link it to other traps."))
	var/obj/new_obj = new result_path(get_turf(src))
	new_obj.setDir(user.dir)
	qdel(src)

/obj/structure/destructible/clockwork_trap
	name = "Clockwork trap structure"
	desc = "monkey noises"
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/outbound_expedition/clock_cult.dmi'
	layer = LOW_OBJ_LAYER
	anchored = TRUE
	break_message = "<span class='warning'>The intricate looking device falls apart.</span>"
	/// What the structure produces when unwrenched
	var/unwrench_path

/obj/structure/destructible/clockwork_trap/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/on_entered,
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/destructible/clockwork_trap/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	balloon_alert(user, "unwrenching...")
	if(!do_after(user, 5 SECONDS, target = src))
		return
	balloon_alert(user, "unwrenched")
	new unwrench_path(get_turf(src))
	qdel(src)

/obj/structure/destructible/clockwork_trap/proc/on_entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	return

// trap itself

/obj/item/clockwork_trap_placer/skewer
	name = "brass skewer"
	desc = "A spiked, brass skewer attached to a steam powered extension mechanism."
	icon_state = "brass_skewer_extended"
	result_path = /obj/structure/destructible/clockwork_trap/skewer

/obj/structure/destructible/clockwork_trap/skewer
	name = "brass skewer"
	desc = "A spiked, brass skewer attached to a steam powered extension mechanism."
	icon_state = "brass_skewer"
	unwrench_path = /obj/item/clockwork_trap_placer/skewer
	buckle_lying = FALSE
	max_integrity = 40
	COOLDOWN_DECLARE(stab_cooldown)
	/// Is the skewer extended or not
	var/extended = FALSE
	/// Mutable overlay when someone gets stabbed
	var/mutable_appearance/stab_overlay


/obj/structure/destructible/clockwork_trap/skewer/on_entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	if(ismob(arrived))
		var/mob/arrived_mob = arrived
		if("clock" in arrived_mob.faction)
			return
	if(extended)
		retract()
	if(!COOLDOWN_FINISHED(src, stab_cooldown))
		return
	COOLDOWN_START(src, stab_cooldown, 10 SECONDS)
	extended = TRUE
	icon_state = "brass_skewer_extended"
	var/target_stabbed = FALSE
	density = TRUE
	for(var/mob/living/living_mob in get_turf(src))
		if(living_mob.incorporeal_move || (living_mob.movement_type & (FLYING|FLOATING)))
			continue
		if(!buckle_mob(living_mob, TRUE))
			continue
		target_stabbed = TRUE
		to_chat(living_mob, span_userdanger("You are impaled by [src]!"))
		living_mob.emote("scream")
		living_mob.apply_damage(25, BRUTE, BODY_ZONE_CHEST)
		if(ishuman(living_mob))
			var/mob/living/carbon/human/human_mob = living_mob
			human_mob.bleed(30)
	if(target_stabbed)
		if(!stab_overlay)
			stab_overlay = mutable_appearance('modular_skyrat/modules/awaymissions_skyrat/icons/outbound_expedition/clock_cult.dmi', "brass_skewer_pokeybit", layer=ABOVE_MOB_LAYER)
		add_overlay(stab_overlay)

/obj/structure/destructible/clockwork_trap/skewer/unbuckle_mob(mob/living/buckled_mob, force = FALSE, can_fall = TRUE)
	if(force)
		return ..()
	if(!buckled_mob.break_do_after_checks())
		return
	to_chat(buckled_mob, span_warning("You begin climbing out of [src]."))
	if(do_after(buckled_mob, 5 SECONDS, target = src))
		. = ..()
	else
		to_chat(buckled_mob, span_userdanger("You fail to detach yourself from [src]."))

/obj/structure/destructible/clockwork_trap/skewer/post_unbuckle_mob(mob/living/M)
	if(!has_buckled_mobs())
		cut_overlay(stab_overlay)

/obj/structure/destructible/clockwork_trap/skewer/proc/retract()
	extended = FALSE
	icon_state = "brass_skewer"
	density = FALSE
	cut_overlay(stab_overlay)
	for(var/mob/living/buckled_mob in buckled_mobs)
		unbuckle_mob(buckled_mob, TRUE)
