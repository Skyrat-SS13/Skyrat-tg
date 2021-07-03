// Hairbrushes

/obj/item/hairbrush
	name = "hairbrush"
	desc = "A small, circular brush with an ergonomic grip for efficient brush application."
	icon = 'modular_skyrat/modules/hairbrush/icons/obj/hairbrush.dmi'
	icon_state = "brush"
	inhand_icon_state = "inhand"
	lefthand_file = 'modular_skyrat/modules/hairbrush/icons/mob/inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/hairbrush/icons/mob/inhand_right.dmi'
	var/brush_speed = 3 SECONDS

/obj/item/hairbrush/attack(mob/target)
	if(target.stat == DEAD)
		to_chat(usr, span_warning("There isn't much point brushing someone who can't appreciate it!"))
		return
	brush(target)
	return COMPONENT_CANCEL_ATTACK_CHAIN

// Brushes someone, giving them a small mood boost
/obj/item/hairbrush/proc/brush(mob/living/target)
	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		var/obj/item/bodypart/head = human_target.get_bodypart(BODY_ZONE_HEAD)
		if(!head)
			to_chat(usr, span_warning("[human_target] has no head!"))
			return
		if(human_target.hairstyle == "Bald")
			target.visible_message(span_warning("[usr] scrapes the bristles uncomfortably over [human_target]'s scalp."), span_warning("You scrape the bristles uncomfortably over [target]'s scalp."))
			head.receive_damage(1)
			return
		if(human_target.is_mouth_covered(head_only = 1))
			to_chat(usr, span_warning("You can't brush [human_target]'s hair while [human_target.p_their()] head is covered!"))
			return
		if(!do_after(usr, brush_speed, target))
			return
		if(human_target == usr)
			target.visible_message(span_notice("[usr] brushes [usr.p_their()] hair!"), span_notice("You brush your hair."))
			SEND_SIGNAL(usr, COMSIG_ADD_MOOD_EVENT, "brushed", /datum/mood_event/brushed/self)
		else
			human_target.visible_message(span_notice("[usr] brushes [human_target]'s hair!"), span_notice("You brush [human_target]'s hair."))
			SEND_SIGNAL(human_target, COMSIG_ADD_MOOD_EVENT, "brushed", /datum/mood_event/brushed, usr)
	else if(istype(target, /mob/living/simple_animal/pet))
		if(!do_after(usr, brush_speed, target))
			return
		to_chat(usr, span_notice("[target] closes [target.p_their()] eyes as you brush [target.p_them()]!"))
		SEND_SIGNAL(usr, COMSIG_ADD_MOOD_EVENT, "brushed", /datum/mood_event/brushed/pet, target)
