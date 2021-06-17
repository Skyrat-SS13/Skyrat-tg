GLOBAL_VAR_INIT(sentience_indicator_overlay, mutable_appearance('modular_skyrat/modules/indicators/icons/sentience_indicator.dmi', "default0", FLY_LAYER))

/mob/living/simple_animal/proc/set_sentience_indicator(sentient = FALSE)
	if(stat == DEAD)
		cut_overlay(GLOB.sentience_indicator_overlay) // Kill the indicator if a mob is dead.
		return
	if(!mind)
		cut_overlay(GLOB.sentience_indicator_overlay) // Early check to make sure no sentience indicators are thrown with mobs with no minds
		visible_message(span_notice("\The [src]'s eyes glaze over, and their expression returns to a resting position."))
		return
	if(sentient)
		add_overlay(GLOB.sentience_indicator_overlay)
		visible_message(span_notice("\The [src] blinks for a moment, looking around with some form of intelligence."))
	else
		cut_overlay(GLOB.sentience_indicator_overlay)
		visible_message(span_notice("\The [src]'s eyes glaze over, and their expression returns to a resting position."))


/mob/living/simple_animal/Login()
	..()
	set_sentience_indicator(TRUE)

/mob/living/simple_animal/Logout()
	..()
	set_sentience_indicator(FALSE)

/mob/living/simple_animal/death(gibbed)
	. = ..()
	set_sentience_indicator(FALSE)
