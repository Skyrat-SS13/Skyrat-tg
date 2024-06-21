ADMIN_VERB(toggle_bsa, R_ADMIN, "Toggle BSA Control", "Toggles the BSA control lock on and off.", ADMIN_CATEGORY_FUN)
	GLOB.bsa_unlock = !GLOB.bsa_unlock
	minor_announce("Bluespace Artillery firing protocols have been [GLOB.bsa_unlock? "unlocked" : "locked"]", "Weapons Systems Update:")

	message_admins("[ADMIN_LOOKUPFLW(usr)] [GLOB.bsa_unlock? "unlocked" : "locked"] BSA firing protocols.")
	log_admin("[key_name(user)] [GLOB.bsa_unlock? "unlocked" : "locked"] BSA firing protocols.")
