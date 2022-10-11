#define OPTION_READ "Read"
#define OPTION_CHAMELEON "Chameleon disguise"
#define OPTION_FORGE "Forge identity"

#define OPTION_AUTO "Automatic"
#define OPTION_CUSTOM "Custom"

#define OPTION_SHIFT_START_PHOTO "Use Shift-Start Photo"
#define OPTION_NEW_PHOTO "Generate a New One"

/obj/item/passport/chameleon
	special_desc_factions = FACTION_SYNDICATE
	special_desc = "This is a chameleon passport, able to change its details and look to your current identity. How convienient."

/obj/item/passport/chameleon/Initialize(mapload)
	. = ..()

/obj/item/passport/chameleon/attack_self(mob/user, modifiers)
	// Syndicate agents know how to use the chameleon feature, crew don't.
	// Also, fuck you to whoever made two different syndicate factions.
	if((FACTION_SYNDICATE in user.faction) || ("Syndicate" in user.faction))
		switch(tgui_input_list(user, "Select an action", "What do you want to do?", list(OPTION_READ, OPTION_CHAMELEON, OPTION_FORGE)))
			if(OPTION_READ)
				return ..()
			if(OPTION_CHAMELEON)
				return disguise_passport(user)
			if(OPTION_FORGE)
				return forge_passport(user)

	return ..()

/obj/item/passport/chameleon/proc/disguise_passport(mob/user)
	var/obj/item/passport/passport
	switch(tgui_alert(user, "Autodisguise based on current social background, or custom?", "Chameleon Disguise", list(OPTION_AUTO, OPTION_CUSTOM)))
		if(OPTION_AUTO)
			var/datum/background_info/social_background/social_background = holder_faction
			passport = initial(social_background.passport)
		if(OPTION_CUSTOM)
			var/obj/item/passport/choice = tgui_input_list(user, "Choose passport style!", "Chameleon Disguise", GLOB.valid_passport_disguises)
			if(!choice)
				return
			world.log << "[choice]"
			passport = GLOB.valid_passport_disguises[choice]

	if(!passport)
		return

	passport_name = initial(passport.passport_name)
	has_animation = initial(passport.has_animation)
	has_closed_state = initial(passport.has_closed_state)
	icon_state_base = initial(passport.icon_state_base)
	icon_state_ext = initial(passport.icon_state_ext)
	desc = initial(passport.desc)
	icon_state = "[icon_state_base]_[icon_state_ext]"
	update_label()

/obj/item/passport/chameleon/proc/forge_passport(mob/user)
	var/new_name
	var/new_age
	var/new_faction
	var/new_employment

	switch(tgui_alert(user, "Would you like the passport to automatically use your current identity, or a custom one?", "Chameleon Forging", list(OPTION_AUTO, OPTION_CUSTOM)))
		if(OPTION_AUTO)
			var/mob/living/carbon/human/human = user
			if(!istype(human))
				user.show_message(span_warning("You do not have a form that the scanner can recognise and autofill for!"))
				return

			new_name = human.real_name
			new_age = human.age
			new_faction = human.social_background
			new_employment = human.employment

		if(OPTION_CUSTOM)
			// It may be messy, but it's the fastest way of doing this that I could think of off the top of my head.
			new_name = tgui_input_text(user, "Input the name to use:", "Name Input", "Unknown", MAX_NAME_LEN)
			if(!new_name || length(new_name) < 1)
				user.show_message(span_warning("You must input a valid name!"))
				return

			new_age = tgui_input_number(user, "Input the age to use:", "Age Input", AGE_MINOR, AGE_MAX, AGE_MIN)
			if(!new_age)
				user.show_message(span_warning("You must input a valid age!"))
				return

			new_faction = tgui_input_list(user, "Input the social background to use:", "Social Background Input", GLOB.social_background_names)
			if(!new_faction)
				user.show_message(span_warning("You must input a valid social background!"))
				return
			var/datum/background_info/social_background/social_background = GLOB.social_background_name_to_instance[new_faction]
			if(!social_background)
				user.show_message(span_warning("You must input a valid social background!"))
				return
			new_faction = social_background.type

			new_employment = tgui_input_list(user, "Input the employment to use:", "Employment Input", GLOB.employment_names)
			if(!new_employment)
				user.show_message(span_warning("You must input a valid employment!"))
				return
			var/datum/background_info/employment/employment = GLOB.employment_name_to_instance[new_employment]
			if(!employment)
				user.show_message(span_warning("You must input a valid employment!"))
				return
			new_employment = employment.type

		else
			return

	switch(tgui_alert(user, "Use your shift-start photo, or generate a new one from your current appearance?", "Set Photo", list(OPTION_SHIFT_START_PHOTO, OPTION_NEW_PHOTO)))
		if(OPTION_SHIFT_START_PHOTO)
			if(!ishuman(user))
				user.show_message(span_warning("You do not have a form that the scanner can recognise and autofill for!"))
				return
			imprint_owner(new_name, new_age, new_faction, new_employment)
		if(OPTION_NEW_PHOTO)
			// I went out of my way to support you simplemobs.
			if(!ishuman(user))
				imprint_owner(new_name, new_age, new_faction, new_employment, icon(user.icon, user.icon_state, SOUTH, 0, FALSE))
				return

			var/icon/headshot_crop = get_flat_existing_human_icon(user, list(SOUTH))
			headshot_crop.Crop(HEADSHOT_CROP_DIMENSIONS)
			imprint_owner(new_name, new_age, new_faction, new_employment, headshot_crop)

#undef OPTION_READ
#undef OPTION_CHAMELEON
#undef OPTION_FORGE

#undef OPTION_AUTO
#undef OPTION_CUSTOM

#undef OPTION_SHIFT_START_PHOTO
#undef OPTION_NEW_PHOTO
