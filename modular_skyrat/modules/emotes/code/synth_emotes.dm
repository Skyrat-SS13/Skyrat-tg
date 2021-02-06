/datum/emote/living/dwoop
	key = "dwoop"
	key_third_person = "dwoops"
	message = "chirps happily!"
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/dwoop.ogg'
	mob_type_allowed_typecache = list(/mob/living/carbon/human/species/synth, /mob/living/carbon/human/species/synthliz, /mob/living/carbon/human/species/ipc)
	cooldown = 2 SECONDS

/datum/emote/living/yes
	key = "yes"
	message = "emits an affirmative blip."
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/synth_yes.ogg'
	mob_type_allowed_typecache = list(/mob/living/carbon/human/species/synth, /mob/living/carbon/human/species/synthliz, /mob/living/carbon/human/species/ipc)
	cooldown = 2 SECONDS

/datum/emote/living/no
	key = "no"
	message = "emits a negative blip."
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/synth_no.ogg'
	mob_type_allowed_typecache = list(/mob/living/carbon/human/species/synth, /mob/living/carbon/human/species/synthliz, /mob/living/carbon/human/species/ipc)
	cooldown = 2 SECONDS

/datum/emote/living/boop
	key = "boop"
	key_third_person = "boops"
	message = "boops."
	mob_type_allowed_typecache = list(/mob/living/carbon/human/species/synth, /mob/living/carbon/human/species/synthliz, /mob/living/carbon/human/species/ipc)
	cooldown = 2 SECONDS

/datum/emote/living/buzz
	key = "buzz"
	key_third_person = "buzzes"
	message = "buzzes."
	message_param = "buzzes at %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/buzz-sigh.ogg'
	mob_type_allowed_typecache = list(/mob/living/carbon/human/species/synth, /mob/living/carbon/human/species/synthliz, /mob/living/carbon/human/species/ipc)
	cooldown = 2 SECONDS

/datum/emote/living/beep
	key = "beep"
	key_third_person = "beeps"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/twobeep.ogg'
	mob_type_allowed_typecache = list(/mob/living/carbon/human/species/synth, /mob/living/carbon/human/species/synthliz, /mob/living/carbon/human/species/ipc)
	cooldown = 2 SECONDS


/datum/emote/living/buzz2
	key = "buzz2"
	message = "buzzes twice."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/buzz-two.ogg'
	mob_type_allowed_typecache = list(/mob/living/carbon/human/species/synth, /mob/living/carbon/human/species/synthliz, /mob/living/carbon/human/species/ipc)
	cooldown = 2 SECONDS

/datum/emote/living/chime
	key = "chime"
	key_third_person = "chimes"
	message = "chimes."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/chime.ogg'
	mob_type_allowed_typecache = list(/mob/living/carbon/human/species/synth, /mob/living/carbon/human/species/synthliz, /mob/living/carbon/human/species/ipc)
	cooldown = 2 SECONDS

/datum/emote/living/honk
	key = "honk"
	key_third_person = "honks"
	message = "honks."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/items/bikehorn.ogg'
	mob_type_allowed_typecache = list(/mob/living/carbon/human/species/synth, /mob/living/carbon/human/species/synthliz, /mob/living/carbon/human/species/ipc)
	cooldown = 2 SECONDS

/datum/emote/living/ping
	key = "ping"
	key_third_person = "pings"
	message = "pings."
	message_param = "pings at %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/ping.ogg'
	mob_type_allowed_typecache = list(/mob/living/carbon/human/species/synth, /mob/living/carbon/human/species/synthliz, /mob/living/carbon/human/species/ipc)
	cooldown = 2 SECONDS

/datum/emote/living/sad
	key = "sad"
	message = "plays a sad trombone..."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/misc/sadtrombone.ogg'
	mob_type_allowed_typecache = list(/mob/living/carbon/human/species/synth, /mob/living/carbon/human/species/synthliz, /mob/living/carbon/human/species/ipc)
	cooldown = 2 SECONDS

/datum/emote/living/warn
	key = "warn"
	message = "blares an alarm!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/warning-buzzer.ogg'
	mob_type_allowed_typecache = list(/mob/living/carbon/human/species/synth, /mob/living/carbon/human/species/synthliz, /mob/living/carbon/human/species/ipc)
	cooldown = 2 SECONDS
