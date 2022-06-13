/datum/emote
	var/overlay_emote = 'modular_skyrat/master_files/icons/effects/overlay_effects.dmi'

/datum/emote/proc/get_toggle(mob/living/user)
	if(user.client)
		if(!user.client.prefs.read_preference(/datum/preference/toggle/do_emote_overlay))
			return FALSE
	return TRUE


/datum/emote/living/sweatdrop
	key = "sweatdrop"
	key_third_person = "sweatdrops"

/datum/emote/living/sweatdrop/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(isliving(user) && get_toggle(user))
		var/mutable_appearance/overlay = mutable_appearance(overlay_emote, "sweatdrop", ABOVE_MOB_LAYER)
		overlay.pixel_x = 10
		overlay.pixel_y = 10
		flick_overlay_static(overlay, user, 50)
		playsound(get_turf(user), 'modular_skyrat/modules/emotes/sound/emotes/sweatdrop.ogg', 25, TRUE)

/datum/emote/living/exclaim
	key = "exclaim"
	key_third_person = "exclaims"

/datum/emote/living/exclaim/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(isliving(user) && get_toggle(user))
		var/mutable_appearance/overlay = mutable_appearance(overlay_emote, "exclamation", ABOVE_MOB_LAYER)
		overlay.pixel_x = 10
		overlay.pixel_y = 28
		flick_overlay_static(overlay, user, 50)
		playsound(get_turf(user), 'sound/machines/chime.ogg', 25, TRUE)

/datum/emote/living/question
	key = "question"
	key_third_person = "questions"

/datum/emote/living/question/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(isliving(user) && get_toggle(user))
		var/mutable_appearance/overlay = mutable_appearance(overlay_emote, "question", ABOVE_MOB_LAYER)
		overlay.pixel_x = 10
		overlay.pixel_y = 28
		flick_overlay_static(overlay, user, 50)
		playsound(get_turf(user), 'modular_skyrat/modules/emotes/sound/emotes/question.ogg', 25, TRUE)


/datum/emote/living/realize
	key = "realize"
	key_third_person = "realizes"

/datum/emote/living/realize/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(isliving(user) && get_toggle(user))
		var/mutable_appearance/overlay = mutable_appearance(overlay_emote, "realize", ABOVE_MOB_LAYER)
		if(isteshari(user))
			overlay.pixel_y = 10
		else
			overlay.pixel_y = 15
		flick_overlay_static(overlay, user, 50)
		playsound(get_turf(user), 'modular_skyrat/modules/emotes/sound/emotes/realize.ogg', 25, TRUE)

/datum/emote/living/annoyed
	key = "annoyed"
	key_third_person = "is annoyed"

/datum/emote/living/annoyed/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(isliving(user) && get_toggle(user))
		var/mutable_appearance/overlay = mutable_appearance(overlay_emote, "annoyed", ABOVE_MOB_LAYER)
		overlay.pixel_x = 10
		overlay.pixel_y = 10
		flick_overlay_static(overlay, user, 50)
		playsound(get_turf(user), 'modular_skyrat/modules/emotes/sound/emotes/annoyed.ogg', 25, TRUE)


/datum/emote/living/glasses
	key = "glasses"
	key_third_person = "glasses"
	message = "pushes up their glasses."

/datum/emote/living/glasses/run_emote(mob/living/carbon/human/user, params, type_override, intentional)
	. = ..()
	var/obj/O = user.get_item_by_slot(ITEM_SLOT_EYES)
	if((istype(O, /obj/item/clothing/glasses)) && get_toggle(user))
		var/mutable_appearance/overlay = mutable_appearance(overlay_emote, "glasses", ABOVE_MOB_LAYER)
		if(isteshari(user))
			overlay.pixel_y = -5
		flick_overlay_static(overlay, user, 10)
	else
		return FALSE

//	These emotes hook into existing ones
/datum/emote/living/sigh
	key = "sigh"
	key_third_person = "sighs"

/datum/emote/living/sigh/run_emote(mob/living/carbon/human/user, params, type_override, intentional)
	. = ..()
	if(iscarbon(user) && get_toggle(user))
		var/mutable_appearance/overlay = mutable_appearance(overlay_emote, "sigh", ABOVE_MOB_LAYER)
		if(isteshari(user))
			overlay.pixel_y = -4

		flick_overlay_static(overlay, user, 50)
