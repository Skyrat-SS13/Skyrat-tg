/datum/emote/living/human
	mob_type_allowed_typecache = list(/mob/living/carbon/human, /mob/living/silicon)

/datum/emote/living/human/dwoop
	key = "dwoop"
	key_third_person = "dwoops"
	message = "chirps happily!"
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/dwoop.ogg'
	silicon_allowed = TRUE
	allowed_species = list(/datum/species/robotic/ipc, /datum/species/robotic/synthliz, /datum/species/robotic/synthetic_human, /datum/species/robotic/synthetic_mammal)
	cooldown = 2 SECONDS

/datum/emote/living/human/yes
	key = "yes"
	message = "emits an affirmative blip."
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/synth_yes.ogg'
	silicon_allowed = TRUE
	allowed_species = list(/datum/species/robotic/ipc, /datum/species/robotic/synthliz, /datum/species/robotic/synthetic_human, /datum/species/robotic/synthetic_mammal)
	cooldown = 2 SECONDS

/datum/emote/living/human/no
	key = "no"
	message = "emits a negative blip."
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/synth_no.ogg'
	silicon_allowed = TRUE
	allowed_species = list(/datum/species/robotic/ipc, /datum/species/robotic/synthliz, /datum/species/robotic/synthetic_human, /datum/species/robotic/synthetic_mammal)
	cooldown = 2 SECONDS

/datum/emote/living/human/boop
	key = "boop"
	key_third_person = "boops"
	message = "boops."
	silicon_allowed = TRUE
	allowed_species = list(/datum/species/robotic/ipc, /datum/species/robotic/synthliz, /datum/species/robotic/synthetic_human, /datum/species/robotic/synthetic_mammal)
	cooldown = 2 SECONDS

/datum/emote/living/human/buzz
	key = "buzz"
	key_third_person = "buzzes"
	message = "buzzes."
	message_param = "buzzes at %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/buzz-sigh.ogg'
	silicon_allowed = TRUE
	allowed_species = list(/datum/species/robotic/ipc, /datum/species/robotic/synthliz, /datum/species/robotic/synthetic_human, /datum/species/robotic/synthetic_mammal)
	cooldown = 2 SECONDS

/datum/emote/living/human/beep
	key = "beep"
	key_third_person = "beeps"
	message = "beeps."
	message_param = "beeps at %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/twobeep.ogg'
	silicon_allowed = TRUE
	allowed_species = list(/datum/species/robotic/ipc, /datum/species/robotic/synthliz, /datum/species/robotic/synthetic_human, /datum/species/robotic/synthetic_mammal)
	cooldown = 2 SECONDS

/datum/emote/living/human/beep2
	key = "beep2"
	key_third_person = "beeps sharply"
	message = "beeps sharply."
	message_param = "beeps sharply at %t."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/twobeep.ogg'
	silicon_allowed = TRUE
	allowed_species = list(/datum/species/robotic/ipc, /datum/species/robotic/synthliz, /datum/species/robotic/synthetic_human, /datum/species/robotic/synthetic_mammal)
	cooldown = 2 SECONDS

/datum/emote/living/human/buzz2
	key = "buzz2"
	message = "buzzes twice."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/buzz-two.ogg'
	silicon_allowed = TRUE
	allowed_species = list(/datum/species/robotic/ipc, /datum/species/robotic/synthliz, /datum/species/robotic/synthetic_human, /datum/species/robotic/synthetic_mammal)
	cooldown = 2 SECONDS

/datum/emote/living/human/chime
	key = "chime"
	key_third_person = "chimes"
	message = "chimes."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/chime.ogg'
	silicon_allowed = TRUE
	allowed_species = list(/datum/species/robotic/ipc, /datum/species/robotic/synthliz, /datum/species/robotic/synthetic_human, /datum/species/robotic/synthetic_mammal)
	cooldown = 2 SECONDS

/datum/emote/living/human/honk
	key = "honk"
	key_third_person = "honks"
	message = "honks."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'sound/items/bikehorn.ogg'
	silicon_allowed = TRUE
	allowed_species = list(/datum/species/robotic/ipc, /datum/species/robotic/synthliz, /datum/species/robotic/synthetic_human, /datum/species/robotic/synthetic_mammal)
	cooldown = 2 SECONDS

/datum/emote/living/human/ping
	key = "ping"
	key_third_person = "pings"
	message = "pings."
	message_param = "pings at %t."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/ping.ogg'
	silicon_allowed = TRUE
	allowed_species = list(/datum/species/robotic/ipc, /datum/species/robotic/synthliz, /datum/species/robotic/synthetic_human, /datum/species/robotic/synthetic_mammal)
	cooldown = 2 SECONDS

/datum/emote/living/human/sad
	key = "sad"
	message = "plays a sad trombone..."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/misc/sadtrombone.ogg'
	silicon_allowed = TRUE
	allowed_species = list(/datum/species/robotic/ipc, /datum/species/robotic/synthliz, /datum/species/robotic/synthetic_human, /datum/species/robotic/synthetic_mammal)
	cooldown = 2 SECONDS

/datum/emote/living/human/warn
	key = "warn"
	message = "blares an alarm!"
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/warning-buzzer.ogg'
	silicon_allowed = TRUE
	allowed_species = list(/datum/species/robotic/ipc, /datum/species/robotic/synthliz, /datum/species/robotic/synthetic_human, /datum/species/robotic/synthetic_mammal)
	cooldown = 2 SECONDS

/datum/emote/living/human/slowclaps
	key = "slowclap"
	message = "activates their slow clap processor."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/machines/slowclap.ogg'
	silicon_allowed = TRUE
	allowed_species = list(/datum/species/robotic/ipc, /datum/species/robotic/synthliz, /datum/species/robotic/synthetic_human, /datum/species/robotic/synthetic_mammal)
	cooldown = 2 SECONDS
