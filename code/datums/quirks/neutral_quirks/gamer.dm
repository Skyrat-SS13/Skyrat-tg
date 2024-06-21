#define GAMING_WITHDRAWAL_TIME (15 MINUTES)
/datum/quirk/gamer
	name = "Gamer"
	desc = "You are a hardcore gamer, and you have a need to game. You love winning and hate losing. You only like gamer food."
	icon = FA_ICON_GAMEPAD
	value = 0
	gain_text = span_notice("You feel the sudden urge to game.")
	lose_text = span_notice("You've lost all interest in gaming.")
	medical_record_text = "Patient has a severe video game addiction."
	mob_trait = TRAIT_GAMER
	mail_goodies = list(/obj/item/toy/intento, /obj/item/clothing/head/fedora)
	/// Timer for gaming withdrawal to kick in
	var/gaming_withdrawal_timer = TIMER_ID_NULL

/datum/quirk/gamer/add(client/client_source)
	var/obj/item/organ/internal/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(tongue)
		// Gamer diet
		tongue.liked_foodtypes = JUNKFOOD
	RegisterSignal(quirk_holder, COMSIG_MOB_WON_VIDEOGAME, PROC_REF(won_game))
	RegisterSignal(quirk_holder, COMSIG_MOB_LOST_VIDEOGAME, PROC_REF(lost_game))
	RegisterSignal(quirk_holder, COMSIG_MOB_PLAYED_VIDEOGAME, PROC_REF(gamed))

/datum/quirk/gamer/add_unique(client/client_source)
	// The gamer starts off quelled
	gaming_withdrawal_timer = addtimer(CALLBACK(src, PROC_REF(enter_withdrawal)), GAMING_WITHDRAWAL_TIME, TIMER_STOPPABLE)

/datum/quirk/gamer/remove()
	var/obj/item/organ/internal/tongue/tongue = quirk_holder.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(tongue)
		tongue.liked_foodtypes = initial(tongue.liked_foodtypes)
	UnregisterSignal(quirk_holder, COMSIG_MOB_WON_VIDEOGAME)
	UnregisterSignal(quirk_holder, COMSIG_MOB_LOST_VIDEOGAME)
	UnregisterSignal(quirk_holder, COMSIG_MOB_PLAYED_VIDEOGAME)

/**
 * Gamer won a game
 *
 * Executed on the COMSIG_MOB_WON_VIDEOGAME signal
 * This signal should be called whenever a player has won a video game.
 * (E.g. Orion Trail)
 */
/datum/quirk/gamer/proc/won_game()
	SIGNAL_HANDLER
	// Epic gamer victory
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.add_mood_event("gamer_won", /datum/mood_event/gamer_won)

/**
 * Gamer lost a game
 *
 * Executed on the COMSIG_MOB_LOST_VIDEOGAME signal
 * This signal should be called whenever a player has lost a video game.
 * (E.g. Orion Trail)
 */
/datum/quirk/gamer/proc/lost_game()
	SIGNAL_HANDLER
	// Executed when a gamer has lost
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.add_mood_event("gamer_lost", /datum/mood_event/gamer_lost)
	// Executed asynchronously due to say()
	INVOKE_ASYNC(src, PROC_REF(gamer_moment))
/**
 * Gamer is playing a game
 *
 * Executed on the COMSIG_MOB_PLAYED_VIDEOGAME signal
 * This signal should be called whenever a player interacts with a video game.
 */
/datum/quirk/gamer/proc/gamed()
	SIGNAL_HANDLER

	var/mob/living/carbon/human/human_holder = quirk_holder
	// Remove withdrawal malus
	human_holder.clear_mood_event("gamer_withdrawal")
	// Reset withdrawal timer
	if (gaming_withdrawal_timer)
		deltimer(gaming_withdrawal_timer)
	gaming_withdrawal_timer = addtimer(CALLBACK(src, PROC_REF(enter_withdrawal)), GAMING_WITHDRAWAL_TIME, TIMER_STOPPABLE)


/datum/quirk/gamer/proc/gamer_moment()
	// It was a heated gamer moment...
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.say(";[pick("SHIT", "PISS", "FUCK", "CUNT", "COCKSUCKER", "MOTHERFUCKER")]!!", forced = name)

/datum/quirk/gamer/proc/enter_withdrawal()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.add_mood_event("gamer_withdrawal", /datum/mood_event/gamer_withdrawal)

#undef GAMING_WITHDRAWAL_TIME
