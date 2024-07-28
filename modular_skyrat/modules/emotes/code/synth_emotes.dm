/datum/emote/silicon
	cooldown = 2 SECONDS

/datum/emote/living/human/dwoop
    key = "dwoop"
    key_third_person = "dwoops"
    message = "chirps happily!"
    vary = TRUE
    sound = 'modular_skyrat/modules/emotes/sound/emotes/dwoop.ogg'
    allowed_species = list(/datum/species/synthetic)
    cooldown = 2 SECONDS

/datum/emote/silicon/yes
	key = "yes"
	message = "emits an affirmative blip."
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/synth_yes.ogg'

/datum/emote/silicon/no
	key = "no"
	message = "emits a negative blip."
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/synth_no.ogg'

/datum/emote/silicon/beep2
	key = "beep2"
	key_third_person = "beeps sharply"
	message = "beeps sharply."
	message_param = "beeps sharply at %t."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/twobeep.ogg'

/datum/emote/silicon/laughtrack
	key = "laughtrack"
	message = "plays a laughtrack."
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/items/sitcomlaugh2.ogg'
