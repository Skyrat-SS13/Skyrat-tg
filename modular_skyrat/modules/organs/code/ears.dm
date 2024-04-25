/obj/item/organ/internal/ears/teshari
	name = "teshari ears"
	desc = "A set of four long rabbit-like ears, a Teshari's main tool while hunting. Naturally extremely sensitive to loud sounds."
	damage_multiplier = 1.5
	actions_types = list(/datum/action/cooldown/spell/teshari_hearing)

/obj/item/organ/internal/ears/teshari/on_mob_remove(mob/living/carbon/ear_owner)
	. = ..()
	REMOVE_TRAIT(ear_owner, TRAIT_GOOD_HEARING, ORGAN_TRAIT)

/datum/action/cooldown/spell/teshari_hearing
	name = "Toggle Sensitive Hearing"
	desc = "Perk up your ears to listen for quiet sounds, useful for picking up whispering."
	button_icon = 'modular_skyrat/master_files/icons/hud/actions.dmi'
	button_icon_state = "echolocation_off"
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"

	cooldown_time = 1 SECONDS
	spell_requirements = NONE

/datum/action/cooldown/spell/teshari_hearing/proc/update_button_state(new_state) //This makes it so that the button icon changes dynamically based on ears being up or not.
	button_icon_state = new_state
	owner.update_action_buttons()

/datum/action/cooldown/spell/teshari_hearing/Remove(mob/living/remove_from)
	REMOVE_TRAIT(remove_from, TRAIT_GOOD_HEARING, ORGAN_TRAIT)
	remove_from.update_sight()
	return ..()

/datum/action/cooldown/spell/teshari_hearing/cast(list/targets, mob/living/carbon/human/user = usr)
	. = ..()

	if(HAS_TRAIT(user, TRAIT_GOOD_HEARING))
		teshari_hearing_deactivate(user)
		return

	user.apply_status_effect(/datum/status_effect/teshari_hearing)
	user.visible_message(span_notice("[user], pricks up [user.p_their()] four ears, each twitching intently!"), span_notice("You perk up all four of your ears, hunting for even the quietest sounds."))
	update_button_state("echolocation_on")

	var/obj/item/organ/internal/ears/ears = user.get_organ_slot(ORGAN_SLOT_EARS)
	if(ears)
		ears.damage_multiplier = 3

/datum/action/cooldown/spell/teshari_hearing/proc/teshari_hearing_deactivate(mob/living/carbon/human/user) //Called when you activate it again after casting the ability-- turning them off, so to say.
	if(!HAS_TRAIT_FROM(user, TRAIT_GOOD_HEARING, ORGAN_TRAIT))
		return

	user.remove_status_effect(/datum/status_effect/teshari_hearing)
	user.visible_message(span_notice("[user] drops [user.p_their()] ears down a bit, no longer listening as closely."), span_notice("You drop your ears down, no longer paying close attention."))
	update_button_state("echolocation_off")

	var/obj/item/organ/internal/ears/ears = user.get_organ_slot(ORGAN_SLOT_EARS)
	if(ears)
		ears.damage_multiplier = 1.5

/datum/status_effect/teshari_hearing
	id = "teshari_hearing"
	alert_type = null
	status_type = STATUS_EFFECT_UNIQUE

/datum/status_effect/teshari_hearing/on_apply()
	ADD_TRAIT(owner, TRAIT_GOOD_HEARING, ORGAN_TRAIT)
	return ..()

/datum/status_effect/teshari_hearing/on_remove()
	REMOVE_TRAIT(owner, TRAIT_GOOD_HEARING, ORGAN_TRAIT)
	return ..()

/datum/status_effect/teshari_hearing/get_examine_text()
	return span_notice("[owner.p_They()] [owner.p_have()] [owner.p_their()] ears perked up, listening closely to whisper-quiet sounds.")
