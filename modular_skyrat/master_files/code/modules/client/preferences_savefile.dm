/datum/preferences/proc/load_character_skyrat(savefile/S)

	READ_FILE(S["loadout_list"], loadout_list)

	READ_FILE(S["languages"], languages)
	var/do_get_common_later = FALSE
	if(isnull(languages))
		do_get_common_later = TRUE
	languages = SANITIZE_LIST(languages)

	validate_languages()
	if(do_get_common_later)
		try_get_common_language()

	READ_FILE(S["augments"] , augments)
	READ_FILE(S["augment_limb_styles"] , augment_limb_styles)

	augments = SANITIZE_LIST(augments)
	//validating augments
	for(var/aug_slot in augments)
		var/datum/augment_item/aug = GLOB.augment_items[augments[aug_slot]]
		if(!aug)
			augments -= aug_slot
	augment_limb_styles = SANITIZE_LIST(augment_limb_styles)
	//validating limb styles
	for(var/key in augment_limb_styles)
		if(!GLOB.robotic_styles_list[key])
			augment_limb_styles -= key


/datum/preferences/proc/save_character_skyrat(savefile/S)

	WRITE_FILE(S["loadout_list"], loadout_list)
	WRITE_FILE(S["languages"] , languages)
	WRITE_FILE(S["augments"] , augments)
	WRITE_FILE(S["augment_limb_styles"] , augment_limb_styles)

