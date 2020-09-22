/datum/emote/living/quill
	key = "quill"
	key_third_person = "quills"
	message = "rustles their quills."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	restraint_check = FALSE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/quill/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	playsound(user, 'modular_skyrat/modules/emotes/sound/emotes/voxrustle.ogg', 50, 1, -1)

/datum/emote/living/scream/run_emote(mob/living/user, params) //I can't not port this shit, come on.
	if(user.nextsoundemote >= world.time || user.stat != CONSCIOUS)
		return
	var/sound
	var/miming = user.mind ? user.mind.miming : 0
	if(!user.is_muzzled() && !miming)
		user.nextsoundemote = world.time + 7
		if(issilicon(user))
			sound = 'modular_skyrat/modules/emotes/sound/voice/scream_silicon.ogg'
			if(iscyborg(user))
				var/mob/living/silicon/robot/S = user
				if(S.cell?.charge < 20)
					to_chat(S, "<span class='warning'>Scream module deactivated. Please recharge.</span>")
					return
				S.cell.use(200)
		if(ismonkey(user))
			sound = 'modular_skyrat/modules/emotes/sound/voice/scream_monkey.ogg'
		if(istype(user, /mob/living/simple_animal/hostile/gorilla))
			sound = 'sound/creatures/gorilla.ogg'
		if(ishuman(user))
			user.adjustOxyLoss(5)
			var/mob/living/carbon/human/H = user
			var/datum/species/userspecies = H.dna.species
			if(H)
				if(H.gender == FEMALE && length(userspecies.femalescreamsounds))
					sound = pick(userspecies.femalescreamsounds)
				else
					sound = pick(userspecies.screamsounds)
		if(isalien(user))
			sound = 'sound/voice/hiss6.ogg'
		/* TO DO - REINDEX SCREAMS
		LAZYINITLIST(user.alternate_screams)
		if(LAZYLEN(user.alternate_screams))
			sound = pick(user.alternate_screams)
		*/
		playsound(user.loc, sound, 50, 1, 4, 1.2)
		message = "screams!"
	else if(miming)
		message = "acts out a scream."
	else
		message = "makes a very loud noise."
	. = ..()

/datum/emote/living/cough/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	if (isvox(user))
		playsound(user, 'modular_skyrat/modules/emotes/sound/emotes/voxcough.ogg', 50, 1, -1)

/datum/emote/living/sneeze/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	if (isvox(user))
		playsound(user, 'modular_skyrat/modules/emotes/sound/emotes/voxsneeze.ogg', 50, 1, -1)

/datum/emote/living/peep
	key = "peep"
	key_third_person = "peeps like a bird"
	message = "peeps like a bird!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	restraint_check = FALSE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/peep/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	playsound(user, 'modular_skyrat/modules/emotes/sound/voice/peep_once.ogg', 50, 1, -1)

/datum/emote/living/peep2
	key = "peep2"
	key_third_person = "peeps twice like a bird"
	message = "peeps twice like a bird!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	restraint_check = FALSE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/peep2/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	playsound(user, 'modular_skyrat/modules/emotes/sound/voice/peep.ogg', 50, 1, -1)

/mob
	var/nextsoundemote = 1

//Disables the custom emote blacklist from TG that normally applies to slimes.
/datum/emote/living/custom
	mob_type_blacklist_typecache = list(/mob/living/brain)

/datum/emote/living/snap
	key = "snap"
	key_third_person = "snaps"
	message = "snaps their fingers."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	restraint_check = TRUE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/snap/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	playsound(user, 'modular_skyrat/modules/emotes/sound/voice/snap.ogg', 50, 1, -1)

/datum/emote/living/snap2
	key = "snap2"
	key_third_person = "snaps twice"
	message = "snaps twice."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	restraint_check = TRUE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/snap2/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	playsound(user, 'modular_skyrat/modules/emotes/sound/voice/snap2.ogg', 50, 1, -1)

/datum/emote/living/snap3
	key = "snap3"
	key_third_person = "snaps thrice"
	message = "snaps thrice."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	restraint_check = TRUE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/snap3/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	playsound(user, 'modular_skyrat/modules/emotes/sound/voice/snap3.ogg', 50, 1, -1)

/datum/emote/living/awoo
	key = "awoo"
	key_third_person = "lets out an awoo"
	message = "lets out an awoo!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	restraint_check = FALSE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/awoo/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	playsound(user, 'modular_skyrat/modules/emotes/sound/voice/awoo.ogg', 50, 1, -1)

/datum/emote/living/nya
	key = "nya"
	key_third_person = "lets out a nya"
	message = "lets out a nya!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	restraint_check = FALSE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/nya/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	playsound(user, 'modular_skyrat/modules/emotes/sound/voice/nya.ogg', 50, 1, -1)

/datum/emote/living/weh
	key = "weh"
	key_third_person = "lets out a weh"
	message = "lets out a weh!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	restraint_check = FALSE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/weh/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	playsound(user, 'modular_skyrat/modules/emotes/sound/voice/weh.ogg', 50, 1, -1)

/datum/emote/living/dab
	key = "dab"
	key_third_person = "suddenly hits a dab"
	message = "suddenly hits a dab!"
	emote_type = EMOTE_AUDIBLE
	restraint_check = TRUE

/datum/emote/living/mothsqueak
	key = "msqueak"
	key_third_person = "lets out a tiny squeak"
	message = "lets out a tiny squeak!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	restraint_check = FALSE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/mothsqueak/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	playsound(user, 'modular_skyrat/modules/emotes/sound/voice/mothsqueak.ogg', 50, 1, -1)

/datum/emote/living/merp
	key = "merp"
	key_third_person = "merps"
	message = "merps!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	restraint_check = FALSE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/merp/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	playsound(user, 'modular_skyrat/modules/emotes/sound/voice/merp.ogg', 50, 1, -1)

/datum/emote/living/bark
	key = "bark"
	key_third_person = "barks"
	message = "barks!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	restraint_check = FALSE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/bark/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	var/sound = pick('modular_skyrat/modules/emotes/sound/voice/bark1.ogg', 'modular_skyrat/modules/emotes/sound/voice/bark2.ogg')
	playsound(user, sound, 50, 1, -1)

/datum/emote/living/squish
	key = "squish"
	key_third_person = "squishes"
	message = "squishes!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	restraint_check = FALSE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/squish/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	var/sound = pick('modular_skyrat/modules/emotes/sound/voice/slime_squish.ogg')
	playsound(user, sound, 50, 1, -1)
