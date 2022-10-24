/obj/item/clockwork/trap_placer/skewer
	name = "brass skewer"
	desc = "A spiked, brass skewer attached to a steam powered extension mechanism."
	icon_state = "brass_skewer_extended"
	result_path = /obj/structure/destructible/clockwork/trap/skewer

/obj/structure/destructible/clockwork/trap/skewer
	name = "brass skewer"
	desc = "A spiked, brass skewer attached to a steam powered extension mechanism."
	icon_state = "brass_skewer"
	component_datum = /datum/component/clockwork_trap/skewer
	unwrench_path = /obj/item/clockwork/trap_placer/skewer
	buckle_lying = FALSE
	max_integrity = 40
	COOLDOWN_DECLARE(stab_cooldown)
	var/extended = FALSE
	var/mutable_appearance/stab_overlay

/obj/structure/destructible/clockwork/trap/skewer/proc/stab()
	if(extended)
		retract()
	if(!COOLDOWN_FINISHED(src, stab_cooldown))
		return
	COOLDOWN_START(src, stab_cooldown, 10 SECONDS)
	extended = TRUE
	icon_state = "[initial(icon_state)]_extended"
	var/target_stabbed = FALSE
	density = TRUE
	for(var/mob/living/M in get_turf(src))
		if(M.incorporeal_move || (M.movement_type & (FLOATING|FLYING)))
			continue
		if(buckle_mob(M, TRUE))
			target_stabbed = TRUE
			to_chat(M, span_userdanger("You are impaled by [src]!"))
			M.emote("scream")
			M.apply_damage(5, BRUTE, BODY_ZONE_CHEST)
			if(ishuman(M))
				var/mob/living/carbon/human/H = M
				if(!H.is_bleeding())
					H.bleed(30)
	if(target_stabbed)
		if(!stab_overlay)
			stab_overlay = mutable_appearance('modular_skyrat/modules/clock_cult/icons/clockwork_objects.dmi', "brass_skewer_pokeybit", layer=ABOVE_MOB_LAYER)
		add_overlay(stab_overlay)

/obj/structure/destructible/clockwork/trap/skewer/unbuckle_mob(mob/living/buckled_mob, force, can_fall)
	if(force)
		return ..()
	if(!buckled_mob.break_do_after_checks())
		return
	to_chat(buckled_mob, span_warning("You begin climbing out of [src]."))
	if(do_after(buckled_mob, 5 SECONDS, target = src))
		return ..()
	else
		to_chat(buckled_mob, span_userdanger("You fail to detach yourself from [src]."))

/obj/structure/destructible/clockwork/trap/skewer/post_unbuckle_mob(mob/living/M)
	if(!has_buckled_mobs())
		cut_overlay(stab_overlay)

/obj/structure/destructible/clockwork/trap/skewer/proc/retract()
	extended = FALSE
	icon_state = initial(icon_state)
	density = FALSE
	cut_overlay(stab_overlay)
	for(var/mob/living/M as anything in buckled_mobs)
		unbuckle_mob(M, TRUE)

/datum/component/clockwork_trap/skewer
	takes_input = TRUE

/datum/component/clockwork_trap/skewer/trigger()
	if(!..())
		return
	var/obj/structure/destructible/clockwork/trap/skewer/S = parent
	if(!istype(S))
		return
	INVOKE_ASYNC(S, /obj/structure/destructible/clockwork/trap/skewer.proc/stab)
