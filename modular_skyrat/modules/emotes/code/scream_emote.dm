/datum/emote/living/scream
	vary = TRUE
	mob_type_blacklist_typecache = list(/mob/living/carbon/human, /mob/living/basic/slime, /mob/living/brain) //Humans get specialized scream.

/datum/emote/living/scream/get_sound(mob/living/user)
	if(user.is_muzzled())
		return
	if(issilicon(user))
		var/mob/living/silicon/silicon_user = user
		var/datum/scream_type/selected_scream = silicon_user.selected_scream
		if(isnull(selected_scream))
			return 'modular_skyrat/modules/emotes/sound/voice/scream_silicon.ogg'
		if(user.gender == FEMALE && LAZYLEN(selected_scream.female_screamsounds))
			return pick(selected_scream.female_screamsounds)
		else
			return pick(selected_scream.male_screamsounds)
	if(issilicon(user))
		return 'modular_skyrat/modules/emotes/sound/voice/scream_silicon.ogg'
	if(ismonkey(user))
		return 'modular_skyrat/modules/emotes/sound/voice/scream_monkey.ogg'
	if(istype(user, /mob/living/basic/gorilla))
		return 'sound/creatures/gorilla.ogg'
	if(isalien(user))
		return 'sound/voice/hiss6.ogg'

/datum/emote/living/scream/can_run_emote(mob/living/user, status_check, intentional)
	if(iscyborg(user))
		var/mob/living/silicon/robot/robot_user = user

		if(robot_user.cell?.charge < STANDARD_CELL_CHARGE * 0.2)
			to_chat(robot_user , span_warning("Scream module deactivated. Please recharge."))
			return FALSE
		robot_user.cell.use(STANDARD_CELL_CHARGE * 0.2)
	return ..()

/datum/emote/living/carbon/human/scream
	only_forced_audio = FALSE

/datum/emote/living/carbon/human/scream/get_sound(mob/living/carbon/human/user)
	if(!istype(user))
		return
	if(user.is_muzzled())
		return
	if(isnull(user.selected_scream) || (LAZYLEN(user.selected_scream.male_screamsounds) && LAZYLEN(user.selected_scream.female_screamsounds))) //For things that don't have a selected scream(npcs)
		if(prob(1))
			return 'sound/voice/human/wilhelm_scream.ogg'
		return user.dna.species.get_scream_sound(user)
	if(user.gender == FEMALE && LAZYLEN(user.selected_scream.female_screamsounds))
		return pick(user.selected_scream.female_screamsounds)
	else
		return pick(user.selected_scream.male_screamsounds)
