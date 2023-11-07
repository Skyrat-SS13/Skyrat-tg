/datum/emote/living/scream
	message = "screams!"
	mob_type_blacklist_typecache = list(/mob/living/simple_animal/slime, /mob/living/brain)
	vary = TRUE

/datum/emote/living/scream/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(!user.is_muzzled() && !HAS_MIND_TRAIT(user, TRAIT_MIMING))
		var/sound = get_sound(user, TRUE)
		playsound(user.loc, sound, sound_volume, vary, 4, 1.2)

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
	if(istype(user, /mob/living/basic/gorilla))
		return 'sound/creatures/gorilla.ogg'
	if(isalien(user))
		return 'sound/voice/hiss6.ogg'
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(isnull(H.selected_scream)) //For things that don't have a selected scream(npcs)
			var/datum/species/userspecies = H.dna.species
			if(user.gender == MALE || !LAZYLEN(userspecies.femalescreamsounds))
				if(prob(1))
					return 'sound/voice/human/wilhelm_scream.ogg'
				return pick(userspecies.screamsounds)
			else
				return pick(userspecies.femalescreamsounds)
		if(user.gender == MALE || !LAZYLEN(H.selected_scream.female_screamsounds))
			return pick(H.selected_scream.male_screamsounds)
		else
			return pick(H.selected_scream.female_screamsounds)

/datum/emote/living/scream/can_run_emote(mob/living/user, status_check, intentional)
	if(iscyborg(user))
		var/mob/living/silicon/robot/R = user

		if(R.cell?.charge < 200)
			to_chat(R, span_warning("Scream module deactivated. Please recharge."))
			return FALSE
		R.cell.use(200)
	return ..()
