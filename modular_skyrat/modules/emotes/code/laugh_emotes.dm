/datum/emote/living/laugh
	mob_type_allowed_typecache = list(/mob/living/carbon/human, /mob/living/silicon/pai)

// This sucks and is not how we should be allowing pais to use these emotes
// for humans use selected_laugh, otherwise default to the species-specific laughs.
/datum/emote/living/laugh/get_sound(mob/living/user)
	var/mob/living/carbon/human/human_user = user
	if(!istype(human_user)) // pais
		return

	if(isnull(human_user.selected_laugh)) //For things that don't have a selected laugh(npcs)
		return ..()

	if(human_user.gender == MALE || !LAZYLEN(human_user.selected_laugh.female_laughsounds))
		return pick(human_user.selected_laugh.male_laughsounds)
	else
		return pick(human_user.selected_laugh.female_laughsounds)

// human laugh - for males use tg audio females use our version
/datum/species/human/get_laugh_sound(mob/living/carbon/human/human)
	if(!ishuman(human))
		return
	if(human.gender == FEMALE)
		return pick(
				'modular_skyrat/modules/emotes/sound/emotes/female/female_giggle_1.ogg',
				'modular_skyrat/modules/emotes/sound/emotes/female/female_giggle_2.ogg',

		)
	return pick(
		'sound/voice/human/manlaugh1.ogg',
		'sound/voice/human/manlaugh2.ogg',
	)
