/obj/item/hhmirror/syndie
	name = "Handheld Mirror"
	desc = "A handheld mirror that allows you to change your looks. Reminds you of old times for some reason..."
	icon = 'modular_skyrat/master_files/icons/obj/hhmirror.dmi'
	icon_state = "hhmirror"
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "A mirror manufactured by the Syndicate containing barber-nanites that can alter your hair on the spot." // Skyrat edit

/obj/item/hhmirror/attack_self(mob/user)
	. = ..()
	if(.)
		return
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
			//see code/modules/mob/dead/new_player/preferences.dm at approx line 545 for comments!
			//this is largely copypasted from there.

			//handle facial hair (if necessary)
		if(H.gender != FEMALE)
			var/new_style = input(user, "Select a facial hair style", "Grooming")  as null|anything in GLOB.facial_hairstyles_list
			if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
				return	//no tele-grooming
			if(new_style)
				H.facial_hairstyle = new_style
		else
			//H.facial_hairstyle = "Shaved"
			var/new_style = input(user, "Select a facial hair style", "Grooming")  as null|anything in GLOB.facial_hairstyles_list
			if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
				return	//no tele-grooming
			if(new_style)
				H.facial_hairstyle = new_style

			//handle normal hair
		var/new_style = input(user, "Select a hair style", "Grooming")  as null|anything in GLOB.hairstyles_list
		if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
			return	//no tele-grooming
		if(new_style)
			H.hairstyle = new_style

		H.update_hair()
