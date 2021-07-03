/datum/emote/silicon
	mob_type_allowed_typecache = list(/mob/living/silicon)
	emote_type = EMOTE_AUDIBLE

/datum/emote/silicon/boops
	key = "boops"
	key_third_person = "boops"
	message = "boops."

/datum/emote/silicon/buzzes
	key = "buzzes"
	key_third_person = "buzzes"
	message = "buzzes."
	message_param = "buzzes at %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/buzz-sigh.ogg'

/datum/emote/silicon/buzzes2
	key = "buzzes2"
	message = "buzzes twice."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/buzz-two.ogg'

/datum/emote/silicon/chimes
	key = "chimes"
	key_third_person = "chimes"
	message = "chimes."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/chime.ogg'

/datum/emote/silicon/honks
	key = "honks"
	key_third_person = "honks"
	message = "honks."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/items/bikehorn.ogg'

/datum/emote/silicon/pings
	key = "pings"
	key_third_person = "pings"
	message = "pings."
	message_param = "pings at %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/ping.ogg'

/datum/emote/silicon/sads
	key = "sads"
	message = "plays a sad trombone..."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/misc/sadtrombone.ogg'

/datum/emote/silicon/warns
	key = "warns"
	message = "blares an alarm!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/warning-buzzer.ogg'

/datum/emote/silicon/beep
	key = "beep"
	key_third_person = "beeps"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/twobeep.ogg'

/datum/emote/silicon/slowclap
	key = "slowclap"
	message = "activates their slow clap processor."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/slowclap.ogg'
