/mob/living/carbon/human/proc/adjust_arousal(arous = 0)
	if(stat >= DEAD || !client?.prefs?.read_preference(/datum/preference/toggle/erp))
		return

	var/arousal_flag = AROUSAL_NONE
	if(arousal >= AROUSAL_MEDIUM)
		arousal_flag = AROUSAL_FULL
	else if(arousal >= AROUSAL_LOW)
		arousal_flag = AROUSAL_PARTIAL

	if(arousal_status != arousal_flag) // Set organ arousal status
		arousal_status = arousal_flag
		if(istype(src, /mob/living/carbon/human))
			var/mob/living/carbon/human/target = src
			for(var/obj/item/organ/external/genital/target_genital in target.external_organs)
				if(!target_genital.aroused == AROUSAL_CANT)
					target_genital.aroused = arousal_status
					target_genital.update_sprite_suffix()
			target.update_body()

	arousal = clamp(arousal + abs(arous), 0, AROUSAL_LIMIT)

