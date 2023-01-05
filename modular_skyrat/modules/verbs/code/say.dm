/mob/living/say_mod(input, list/message_mods = list())
	. = ..()
	if(message_mods[MODE_SING])
		var/mutable_appearance/sing_overlay = mutable_appearance('modular_skyrat/master_files/icons/effects/overlay_effects.dmi', "jamming", ABOVE_MOB_LAYER)
		flick_overlay_static(sing_overlay, 3 SECONDS)

/mob/proc/get_top_level_mob()
	if(ismob(loc) && (loc != src))
		var/mob/M = loc
		return M.get_top_level_mob()
	return src
