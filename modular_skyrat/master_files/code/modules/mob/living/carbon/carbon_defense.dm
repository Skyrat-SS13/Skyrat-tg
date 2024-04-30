#define PERSONAL_SPACE_DAMAGE 2
#define ASS_SLAP_EXTRA_RANGE -1

// Emotes
/mob/living/carbon/disarm(mob/living/carbon/target)
	if(zone_selected == BODY_ZONE_PRECISE_MOUTH)
		var/target_on_help_and_unarmed = !target.combat_mode && !target.get_active_held_item()
		if(target_on_help_and_unarmed || HAS_TRAIT(target, TRAIT_RESTRAINED))
			do_slap_animation(target)
			playsound(target.loc, 'sound/weapons/slap.ogg', 50, TRUE, -1)
			visible_message("<span class='danger'>[src] slaps [target] in the face!</span>",
				"<span class='notice'>You slap [target] in the face! </span>",\
			"You hear a slap.")
			target.unwag_tail()
			return
	if(zone_selected == BODY_ZONE_PRECISE_GROIN && target.dir == src.dir)
		if(HAS_TRAIT(target, TRAIT_PERSONALSPACE) && (target.stat != UNCONSCIOUS) && (!target.handcuffed)) //You need to be conscious and uncuffed to use Personal Space
			if(target.combat_mode && (!HAS_TRAIT(target, TRAIT_PACIFISM))) //Being pacified prevents violent counters
				var/obj/item/bodypart/affecting = src.get_bodypart(BODY_ZONE_HEAD)
				if(affecting?.receive_damage(PERSONAL_SPACE_DAMAGE))
					src.update_damage_overlays()
				visible_message(span_danger("[src] tried slapping [target]'s ass, but they were slapped instead!"),
				span_danger("You tried slapping [target]'s ass, but they hit you back, ouch!"),
				"You hear a slap.", ignored_mobs = list(target))
				playsound(target.loc, 'sound/effects/snap.ogg', 50, TRUE, ASS_SLAP_EXTRA_RANGE)
				to_chat(target, span_danger("[src] tried slapping your ass, but you hit them back!"))
				return
			else
				visible_message(span_danger("[src] tried slapping [target]'s ass, but they were blocked!"),
				span_danger("You tried slapping [target]'s ass, but they blocked you!"),
				"You hear a slap.", ignored_mobs = list(target))
				playsound(target.loc, 'sound/weapons/thudswoosh.ogg', 50, TRUE, ASS_SLAP_EXTRA_RANGE)
				to_chat(target, span_danger("[src] tried slapping your ass, but you blocked them!"))
				return
		else
			do_ass_slap_animation(target)
			playsound(target.loc, 'sound/weapons/slap.ogg', 50, TRUE, ASS_SLAP_EXTRA_RANGE)
			visible_message("<span class='danger'>[src] slaps [target] right on the ass!</span>",\
				"<span class='notice'>You slap [target] on the ass, how satisfying.</span>",\
				"You hear a slap.", ignored_mobs = list(target))
			to_chat(target, "<span class='danger'>[src] slaps your ass!")
			return
	return ..()

#undef PERSONAL_SPACE_DAMAGE
#undef ASS_SLAP_EXTRA_RANGE
