/mob/living/carbon/help_shake_act(mob/living/carbon/M)
	. = ..()
	if(check_zone(M.zone_selected) == BODY_ZONE_HEAD && HAS_TRAIT(src, TRAIT_EXCITABLE))
		src.emote("wag")

	if(M.zone_selected == BODY_ZONE_PRECISE_MOUTH)
		M.visible_message( \
			"<span class='notice'>[M] boops [src]'s nose.</span>", \
			"<span class='notice'>You boop [src] on the nose.</span>", target = src,
			target_message = "<span class='notice'>[M] boops your nose.</span>")
		playsound(src, 'modular_skyrat/modules/emotes/sound/emotes/Nose_boop.ogg', 50, 0)
