/datum/emote/living/lewdmoan
	key = "lewdmoan"
	key_third_person = "lewdmoans"
	message = "moans lewdly!"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE
	vary = TRUE
	sound_volume = 35

/datum/emote/living/lewd/lewdmoan/get_sound(mob/living/carbon/user)
	if(!istype(user))
		return

	if(user.gender == MALE)
		return pick('modular_skyrat/modules/modular_items/lewd_items/sounds/final_m1.ogg',
					'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m2.ogg',
					'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m3.ogg',

		)
	else
		return pick('modular_skyrat/modules/modular_items/lewd_items/sounds/final_f1.ogg',
					'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f2.ogg',
					'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f3.ogg',
		)
