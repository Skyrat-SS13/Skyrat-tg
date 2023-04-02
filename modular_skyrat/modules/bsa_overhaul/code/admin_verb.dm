/client/proc/toggle_bsa()
	set category = "Admin.Fun"
	set name = "Toggle BSA Control"
	set desc = "Toggles the BSA control lock on and off."

	GLOB.bsa_unlock = !GLOB.bsa_unlock
	minor_announce("Bluespace Artillery firing protocols have been [GLOB.bsa_unlock? "unlocked" : "locked"]", "Weapons Systems Update:")

	message_admins("[ADMIN_LOOKUPFLW(usr)] [GLOB.bsa_unlock? "unlocked" : "locked"] BSA firing protocols.")
	log_admin("[key_name(usr)] [GLOB.bsa_unlock? "unlocked" : "locked"] BSA firing protocols.")
