/// Gives us a milker
/datum/emote/living/carbon/milker
	key = "milk"
	key_third_person = "milks"
	hands_use_check = TRUE
	cooldown = 3 SECONDS

/// Check4prefs
/datum/emote/living/carbon/milker/can_run_emote(mob/living/carbon/user, status_check = TRUE, intentional)
	if(!iscarbon(user) || user.usable_hands < 1)
		return FALSE
	if(!user.client || !user.client.prefs.read_preference(/datum/preference/toggle/master_erp_preferences))
		return FALSE
	if(!user.client || !user.client.prefs.read_preference(/datum/preference/toggle/erp/sex_toy)) // I guess its a sextoy!
		return FALSE
	return ..()

/datum/emote/living/carbon/milker/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return
	var/obj/item/milker/milk_hand = new(user)
	if(user.put_in_hands(milk_hand))
		to_chat(user, span_notice("You ready your milking hand."))
	else
		qdel(milk_hand)
		to_chat(user, span_warning("You're incapable of milking anything in your current state."))
