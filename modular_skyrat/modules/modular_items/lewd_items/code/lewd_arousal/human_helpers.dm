

/mob/living/carbon/human/proc/adjustArousal(arous = 0)
	if(stat != DEAD && client?.prefs?.read_preference(/datum/preference/toggle/erp))
		arousal += arous

		var/arousal_flag = AROUSAL_NONE
		if(arousal >= AROUSAL_MEDIUM)
			arousal_flag = AROUSAL_FULL
		else if(arousal >= AROUSAL_LOW)
			arousal_flag = AROUSAL_PARTIAL

		if(arousal_status != arousal_flag) // Set organ arousal status
			arousal_status = arousal_flag
			if(istype(src, /mob/living/carbon/human))
				var/mob/living/carbon/human/target = src
				for(var/i = 1, i <= target.external_organs.len, i++)
					if(istype(target.external_organs[i], /obj/item/organ/external/genital))
						var/obj/item/organ/external/genital/target_genital = target.external_organs[i]
						if(!target_genital.aroused == AROUSAL_CANT)
							target_genital.aroused = arousal_status
							target_genital.update_sprite_suffix()
				target.update_body()
	else
		arousal -= abs(arous)

		arousal = min(max(arousal, 0), 100)

