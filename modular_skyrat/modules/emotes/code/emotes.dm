
#define EMOTE_DELAY 2 SECONDS //To prevent spam emotes.

/mob
	var/nextsoundemote = 1 //Time at which the next emote can be played

//GLOBAL cooldown pool that is shared with all emotes instead of each seperately
/* UNITTEST CHECK -- DO NOT MERGE WITH THIS
/datum/emote/check_cooldown(mob/user, intentional)
	if(!intentional)
		return TRUE
	if(user.nextsoundemote > world.time)
		return FALSE
	user.nextsoundemote = world.time + cooldown
	return TRUE
*/

//Disables the custom emote blacklist from TG that normally applies to slimes.
/datum/emote/living/custom
	mob_type_blacklist_typecache = list(/mob/living/brain)

/datum/emote/living/quill
	key = "quill"
	key_third_person = "quills"
	message = "rustles their quills."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/voxrustle.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/scream
	message = "screams!"
	mob_type_blacklist_typecache = list(/mob/living/simple_animal/slime, /mob/living/brain)
	cooldown = EMOTE_DELAY

/datum/emote/living/scream/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(!user.is_muzzled() && !(user.mind && user.mind.miming))
		if(ishuman(user))
			user.adjustOxyLoss(5)
		var/sound = get_sound(user, TRUE)
		playsound(user.loc, sound, 50, 1, 4, 1.2)

/datum/emote/living/scream/select_message_type(mob/user, intentional)
	if(!intentional && isanimal(user))
		return "makes a loud and pained whimper."
	if(user.is_muzzled())
		return "makes a very loud noise."
	. = ..()

/datum/emote/living/scream/get_sound(mob/living/user, override = FALSE)
	if(!override)
		return
	if(iscyborg(user))
		return 'modular_skyrat/modules/emotes/sound/voice/scream_silicon.ogg'
	if(ismonkey(user))
		return 'modular_skyrat/modules/emotes/sound/voice/scream_monkey.ogg'
	if(istype(user, /mob/living/simple_animal/hostile/gorilla))
		return 'sound/creatures/gorilla.ogg'
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		var/datum/species/userspecies = H.dna.species
		if(H)
			if(H.gender == FEMALE && length(userspecies.femalescreamsounds))
				return pick(userspecies.femalescreamsounds)
			else
				return pick(userspecies.screamsounds)
	if(isalien(user))
		return 'sound/voice/hiss6.ogg'
	return

/datum/emote/living/scream/can_run_emote(mob/living/user, status_check, intentional)
	. = ..()
	if(iscyborg(user))
		var/mob/living/silicon/robot/R = user
		if(R.cell?.charge < 200)
			to_chat(R, "<span class='warning'>Scream module deactivated. Please recharge.</span>")
			return FALSE
		R.cell.use(200)

/datum/emote/living/cough
	cooldown = EMOTE_DELAY

/datum/emote/living/cough/get_sound(mob/living/user)
	if(iscarbon(user) && user.gender == FEMALE)
		return pick('modular_skyrat/modules/emotes/sound/emotes/female/female_cough_1.ogg',
					'modular_skyrat/modules/emotes/sound/emotes/female/female_cough_2.ogg',
					'modular_skyrat/modules/emotes/sound/emotes/female/female_cough_3.ogg')
	if(isvox(user))
		return 'modular_skyrat/modules/emotes/sound/emotes/voxcough.ogg'
	return pick('modular_skyrat/modules/emotes/sound/emotes/male/male_cough_1.ogg',
				'modular_skyrat/modules/emotes/sound/emotes/male/male_cough_2.ogg',
				'modular_skyrat/modules/emotes/sound/emotes/male/male_cough_3.ogg')

/datum/emote/living/sneeze
	cooldown = EMOTE_DELAY

/datum/emote/living/sneeze/get_sound(mob/living/user)
	if(iscarbon(user) && user.gender == FEMALE)
		return 'modular_skyrat/modules/emotes/sound/emotes/female/female_sneeze.ogg'
	if(isvox(user))
		return 'modular_skyrat/modules/emotes/sound/emotes/voxsneeze.ogg'
	return 'modular_skyrat/modules/emotes/sound/emotes/male/male_sneeze.ogg'

/datum/emote/living/peep
	key = "peep"
	key_third_person = "peeps"
	message = "peeps like a bird!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/peep_once.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/peep2
	key = "peep2"
	key_third_person = "peeps twice"
	message = "peeps twice like a bird!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/peep.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/snap
	key = "snap"
	key_third_person = "snaps"
	message = "snaps their fingers."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	hands_use_check = TRUE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/snap.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/snap2
	key = "snap2"
	key_third_person = "snaps twice"
	message = "snaps twice."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	hands_use_check = TRUE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/snap2.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/snap3
	key = "snap3"
	key_third_person = "snaps thrice"
	message = "snaps thrice."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	hands_use_check = TRUE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/snap3.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/awoo
	key = "awoo"
	key_third_person = "awoos"
	message = "lets out an awoo!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/awoo.ogg'

/datum/emote/living/nya
	key = "nya"
	key_third_person = "nyas"
	message = "lets out a nya!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/nya.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/weh
	key = "weh"
	key_third_person = "wehs"
	message = "lets out a weh!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/weh.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/dab
	key = "dab"
	key_third_person = "dabs"
	message = "suddenly hits a dab!"
	emote_type = EMOTE_AUDIBLE
	hands_use_check = TRUE
	cooldown = EMOTE_DELAY

/datum/emote/living/mothsqueak
	key = "msqueak"
	key_third_person = "lets out a tiny squeak"
	message = "lets out a tiny squeak!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/mothsqueak.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/merp
	key = "merp"
	key_third_person = "merps"
	message = "merps!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/merp.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/bark
	key = "bark"
	key_third_person = "barks"
	message = "barks!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/bark2.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/squish
	key = "squish"
	key_third_person = "squishes"
	message = "squishes!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/slime_squish.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/meow
	key = "meow"
	key_third_person = "meows"
	message = "meows!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/meow.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/hiss
	key = "hiss"
	key_third_person = "hisses"
	message = "hisses!"
	emote_type = EMOTE_AUDIBLE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/hiss.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/chitter
	key = "chitter"
	key_third_person = "chitters"
	message = "chitters!"
	emote_type = EMOTE_AUDIBLE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/mothchitter.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/sigh/get_sound(mob/living/user)
	if(iscarbon(user) && user.gender == FEMALE)
		return 'modular_skyrat/modules/emotes/sound/emotes/female/female_sigh.ogg'
	return 'modular_skyrat/modules/emotes/sound/emotes/male/male_sigh.ogg'


/datum/emote/living/sniff/get_sound(mob/living/user)
	if(iscarbon(user) && user.gender == FEMALE)
		return 'modular_skyrat/modules/emotes/sound/emotes/female/female_sniff.ogg'
	return 'modular_skyrat/modules/emotes/sound/emotes/male/male_sniff.ogg'


/datum/emote/living/gasp/get_sound(mob/living/user)
	if(iscarbon(user) && user.gender == FEMALE)
		return pick('modular_skyrat/modules/emotes/sound/emotes/female/gasp_f1.ogg',
					'modular_skyrat/modules/emotes/sound/emotes/female/gasp_f2.ogg',
					'modular_skyrat/modules/emotes/sound/emotes/female/gasp_f3.ogg',
					'modular_skyrat/modules/emotes/sound/emotes/female/gasp_f4.ogg',
					'modular_skyrat/modules/emotes/sound/emotes/female/gasp_f5.ogg',
					'modular_skyrat/modules/emotes/sound/emotes/female/gasp_f6.ogg')
	return pick('modular_skyrat/modules/emotes/sound/emotes/male/gasp_m1.ogg',
				'modular_skyrat/modules/emotes/sound/emotes/male/gasp_m2.ogg',
				'modular_skyrat/modules/emotes/sound/emotes/male/gasp_m3.ogg',
				'modular_skyrat/modules/emotes/sound/emotes/male/gasp_m4.ogg',
				'modular_skyrat/modules/emotes/sound/emotes/male/gasp_m5.ogg',
				'modular_skyrat/modules/emotes/sound/emotes/male/gasp_m6.ogg')


/datum/emote/living/snore
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/snore.ogg'
	cooldown = EMOTE_DELAY

/*
/datum/emote/living/burp/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	var/sound = 'modular_skyrat/modules/emotes/sound/emotes/male/burp_m.ogg'
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(C.gender == FEMALE)
			sound = 'modular_skyrat/modules/emotes/sound/emotes/female/burp_f.ogg'
	playsound(user, sound, 50, 1, -1)
*/
/datum/emote/living/burp
	vary = TRUE
	cooldown = EMOTE_DELAY

/datum/emote/living/burp/get_sound(mob/living/user)
	if(iscarbon(user) && user.gender == FEMALE)
		return 'modular_skyrat/modules/emotes/sound/emotes/female/burp_f.ogg'
	return 'modular_skyrat/modules/emotes/sound/emotes/male/burp_m.ogg'

/datum/emote/living/clap
	key = "clap"
	key_third_person = "claps"
	message = "claps."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	hands_use_check = TRUE
	vary = TRUE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)
	cooldown = EMOTE_DELAY

/datum/emote/living/clap/get_sound(mob/living/user)
	return pick('modular_skyrat/modules/emotes/sound/emotes/clap1.ogg',
				'modular_skyrat/modules/emotes/sound/emotes/clap2.ogg',
				'modular_skyrat/modules/emotes/sound/emotes/clap3.ogg',
				'modular_skyrat/modules/emotes/sound/emotes/clap4.ogg')

/datum/emote/living/clap/can_run_emote(mob/living/carbon/user, status_check = TRUE , intentional)
	if(user.usable_hands < 2)
		return FALSE
	return ..()

/datum/emote/living/clap1
	key = "clap1"
	key_third_person = "claps once"
	message = "claps once."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	hands_use_check = TRUE
	vary = TRUE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)
	cooldown = EMOTE_DELAY

/datum/emote/living/clap1/get_sound(mob/living/user)
	return pick('modular_skyrat/modules/emotes/sound/emotes/claponce1.ogg',
				'modular_skyrat/modules/emotes/sound/emotes/claponce2.ogg')

/datum/emote/living/clap1/can_run_emote(mob/living/carbon/user, status_check = TRUE , intentional)
	if(user.usable_hands < 2)
		return FALSE
	return ..()

/datum/emote/living/laugh
	key = "laugh"
	key_third_person = "laughs"
	message = "laughs."
	message_mime = "laughs silently!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)
	cooldown = EMOTE_DELAY

/datum/emote/living/laugh/get_sound(mob/living/user)
	var/mob/living/carbon/H = user
	if(iscarbon(user) && H.gender == FEMALE)
		//var/mob/living/carbon/C = user
		return pick('modular_skyrat/modules/emotes/sound/emotes/female/female_giggle_1.ogg',
					'modular_skyrat/modules/emotes/sound/emotes/female/female_giggle_2.ogg')
	if(H.dna.species.id == "moth")
		return 'modular_skyrat/modules/emotes/sound/emotes/mothlaugh.ogg'
	return pick('sound/voice/human/manlaugh1.ogg',
				'sound/voice/human/manlaugh2.ogg')

/datum/emote/living/headtilt
	key = "tilt"
	key_third_person = "tilts"
	message = "tilts their head."
	message_AI = "tilts the image on their display."
	cooldown = EMOTE_DELAY

/datum/emote/living/beeps
	key = "beeps"
	key_third_person = "beeps"
	message = "beeps."
	message_param = "beeps at %t."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/emotes/twobeep.ogg'
	cooldown = EMOTE_DELAY

// Avian revolution
/datum/emote/living/bawk
	key = "bawk"
	key_third_person = "bawks"
	message = "bawks like a chicken."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/bawk.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/caw
	key = "caw"
	key_third_person = "caws"
	message = "caws!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/caw.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/caw2
	key = "caw2"
	key_third_person = "caws twice"
	message = "caws twice!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/caw2.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/whistle
	key = "whistle"
	key_third_person = "whistles"
	message = "whistles."
	emote_type = EMOTE_AUDIBLE
	cooldown = EMOTE_DELAY

/datum/emote/living/blep
	key = "blep"
	key_third_person = "bleps"
	message = "bleps their tongue out. Blep."
	message_AI = "shows an image of a random blepping animal. Blep."
	message_robot = "bleps their robo-tongue out. Blep."
	cooldown = EMOTE_DELAY

/datum/emote/living/bork
	key = "bork"
	key_third_person = "borks"
	message = "lets out a bork."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/bork.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/hoot
	key = "hoot"
	key_third_person = "hoots"
	message = "hoots!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/hoot.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/growl
	key = "growl"
	key_third_person = "growls"
	message = "lets out a growl."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/growl.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/woof
	key = "woof"
	key_third_person = "woofs"
	message = "lets out a woof."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/woof.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/baa
	key = "baa"
	key_third_person = "baas"
	message = "lets out a baa."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/baa.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/baa2
	key = "baa2"
	key_third_person = "baas"
	message = "bleats."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/baa2.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/wurble
	key = "wurble"
	key_third_person = "wurbles"
	message = "lets out a wurble."
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/wurble.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/awoo2
	key = "awoo2"
	key_third_person = "awoos"
	message = "lets out an awoo!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/long_awoo.ogg'
	cooldown = 3 SECONDS

/datum/emote/living/rattle
	key = "rattle"
	key_third_person = "rattles"
	message = "rattles!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = TRUE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/rattle.ogg'
	cooldown = EMOTE_DELAY

/datum/emote/living/cackle
	key = "cackle"
	key_third_person = "cackles"
	message = "cackles hysterically!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_skyrat/modules/emotes/sound/voice/cackle_yeen.ogg'
	cooldown = EMOTE_DELAY

// No more monkey screeching ear rape
/datum/emote/living/carbon/screech/get_sound(mob/living/user)
	return

/mob/living/proc/do_ass_slap_animation(atom/slapped)
	do_attack_animation(slapped, no_effect=TRUE)
	var/image/gloveimg = image('icons/effects/effects.dmi', slapped, "slapglove", slapped.layer + 0.1)
	gloveimg.pixel_y = -5
	gloveimg.pixel_x = 0
	flick_overlay(gloveimg, GLOB.clients, 10)

	// And animate the attack!
	animate(gloveimg, alpha = 175, transform = matrix() * 0.75, pixel_x = 0, pixel_y = -5, pixel_z = 0, time = 3)
	animate(time = 1)
	animate(alpha = 0, time = 3, easing = CIRCULAR_EASING|EASE_OUT)
