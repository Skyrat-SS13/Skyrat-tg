/datum/emote
/// If we should check a preference for this emote
var/pref_to_check

/datum/emote/living/lewd
	pref_to_check = /datum/preference/toggle/erp/sounds

// Can we play this emote to viewers?
/datum/emote/proc/pref_check_emote(mob/user)
	return TRUE

/datum/emote/living/lewd/pref_check_emote(mob/user)
	. = ..()
	if(!user.client?.prefs.read_preference(/datum/preference/toggle/erp))
		return FALSE

/datum/emote/living/lewd/can_run_emote(mob/living/carbon/user, status_check = TRUE, intentional)
	return ..() && user.client?.prefs?.read_preference(/datum/preference/toggle/erp)

/datum/emote/living/lewd/lewdmoan
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
