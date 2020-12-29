/datum/emote/silicon/check_cooldown(mob/user, intentional)
	if(!intentional)
		return TRUE
	if(user.nextsoundemote > world.time)
		return FALSE
	user.nextsoundemote = world.time + cooldown
	return TRUE

/datum/emote/silicon/dwoop
	key = "dwoop"
	key_third_person = "dwoops"
	message = "chirps happily!"
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/dwoop.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/silicon/yes
	key = "yes"
	message = "emits an affirmative blip."
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/synth_yes.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/silicon/no
	key = "no"
	message = "emits a negative blip."
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/synth_no.ogg'
	cooldown = EMOTE_DELAY

//Let's also at least add a longer cooldown to the longer/louder/more irritating ones
/datum/emote/silicon/buzz
	cooldown = EMOTE_DELAY

/datum/emote/silicon/buzz2
	cooldown = EMOTE_DELAY

/datum/emote/silicon/sad
	cooldown = EMOTE_DELAY

/datum/emote/silicon/warn
	cooldown = EMOTE_DELAY
