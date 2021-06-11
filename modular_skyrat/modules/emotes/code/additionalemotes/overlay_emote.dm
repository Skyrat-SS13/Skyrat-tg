/datum/emote
	var/overlay_emote = 'modular_skyrat/master_files/icons/effects/overlay_effects.dmi'

/datum/emote/living/sweatdrop
	key = "sweatdrop"
	key_third_person = "sweatdrops"

/datum/emote/living/sweatdrop/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	var/mutable_appearance/I = mutable_appearance(overlay_emote, "sweatdrop", ABOVE_MOB_LAYER)
	I.pixel_x = 10
	I.pixel_y = 10
	flick_overlay_static(I, user, 50)
	playsound(get_turf(user), 'modular_skyrat/modules/emotes/sound/emotes/sweatdrop.ogg', 35, TRUE)

/datum/emote/living/exclamate
	key = "exclamate"
	key_third_person = "exclamates"

/datum/emote/living/exclamate/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	var/mutable_appearance/I = mutable_appearance(overlay_emote, "exclamation", ABOVE_MOB_LAYER)
	I.pixel_x = 10
	I.pixel_y = 28
	flick_overlay_static(I, user, 50)
	playsound(get_turf(user), 'sound/machines/chime.ogg', 25, TRUE)


/datum/emote/living/realize
	key = "realize"
	key_third_person = "realizes"

/datum/emote/living/realize/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	var/mutable_appearance/I = mutable_appearance(overlay_emote, "realize", ABOVE_MOB_LAYER)
	I.pixel_y = 15
	flick_overlay_static(I, user, 50)
	playsound(get_turf(user), 'modular_skyrat/modules/emotes/sound/emotes/realize.ogg', 25, TRUE)

/datum/emote/living/annoyed
	key = "annoyed"
	key_third_person = "is annoyed"

/datum/emote/living/annoyed/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	var/mutable_appearance/I = mutable_appearance(overlay_emote, "annoyed", ABOVE_MOB_LAYER)
	I.pixel_x = 10
	I.pixel_y = 10
	flick_overlay_static(I, user, 50)
	playsound(get_turf(user), 'modular_skyrat/modules/emotes/sound/emotes/annoyed.ogg', 25, TRUE)

/datum/emote/living/blush
	key = "blush"
	key_third_person = "blushes"

/datum/emote/living/blush/run_emote(mob/living/carbon/human/user, params, type_override, intentional)
	. = ..()
	var/mutable_appearance/I = mutable_appearance(overlay_emote, "blush", ABOVE_MOB_LAYER)
	flick_overlay_static(I, user, 50)
	playsound(get_turf(user), 'modular_skyrat/modules/emotes/sound/emotes/blush.ogg', 25, TRUE)

/datum/emote/living/glasses
	key = "glasses"
	key_third_person = "glasses"
	message = "pushes up their glasses."

/datum/emote/living/glasses/run_emote(mob/living/carbon/human/user, params, type_override, intentional)
	. = ..()
	var/obj/O = user.get_item_by_slot(ITEM_SLOT_EYES)
	if(istype(O, /obj/item/clothing/glasses))
		var/mutable_appearance/I = mutable_appearance(overlay_emote, "glasses", ABOVE_MOB_LAYER)
		flick_overlay_static(I, user, 10)
	else
		return FALSE
