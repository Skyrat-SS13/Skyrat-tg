/datum/preferences/proc/load_character_skyrat(savefile/S)
	READ_FILE(S["loadout_list"], loadout_list)

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


	READ_FILE(S["features"], features)
	READ_FILE(S["mutant_bodyparts"], mutant_bodyparts)
	READ_FILE(S["body_markings"], body_markings)
	READ_FILE(S["mismatched_customization"], mismatched_customization)
	READ_FILE(S["allow_advanced_colors"], allow_advanced_colors)

	READ_FILE(S["general_record"], general_record)
	READ_FILE(S["security_record"], security_record)
	READ_FILE(S["medical_record"], medical_record)
	READ_FILE(S["background_info"], background_info)
	READ_FILE(S["exploitable_info"], exploitable_info)

	READ_FILE(S["alt_job_titles"], alt_job_titles)

	general_record = sanitize_text(general_record)
	security_record = sanitize_text(security_record)
	medical_record = sanitize_text(medical_record)
	background_info = sanitize_text(background_info)
	exploitable_info = sanitize_text(exploitable_info)
	loadout_list = sanitize_loadout_list(update_loadout_list(loadout_list))

	READ_FILE(S["languages"] , languages)
	languages = SANITIZE_LIST(languages)

/datum/preferences/proc/save_character_skyrat(savefile/S)

	WRITE_FILE(S["loadout_list"], loadout_list)
	WRITE_FILE(S["augments"] , augments)
	WRITE_FILE(S["augment_limb_styles"] , augment_limb_styles)
	WRITE_FILE(S["features"] , features)
	WRITE_FILE(S["mutant_bodyparts"] , mutant_bodyparts)
	WRITE_FILE(S["body_markings"] , body_markings)

	WRITE_FILE(S["mismatched_customization"], mismatched_customization)
	WRITE_FILE(S["allow_advanced_colors"], allow_advanced_colors)

	WRITE_FILE(S["general_record"] , general_record)
	WRITE_FILE(S["security_record"] , security_record)
	WRITE_FILE(S["medical_record"] , medical_record)
	WRITE_FILE(S["background_info"] , background_info)
	WRITE_FILE(S["exploitable_info"] , exploitable_info)
	WRITE_FILE(S["alt_job_titles"], alt_job_titles)
	WRITE_FILE(S["languages"] , languages)

