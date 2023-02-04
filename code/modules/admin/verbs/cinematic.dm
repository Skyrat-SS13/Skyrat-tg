<<<<<<< HEAD
/client/proc/cinematic()
	set name = "Cinematic"
	set category = "Admin.Fun"
	set desc = "Shows a cinematic." // Intended for testing but I thought it might be nice for events on the rare occasion Feel free to comment it out if it's not wanted.
	set hidden = TRUE

	if(!SSticker)
=======
ADMIN_VERB(fun, show_cinematic, "Show Cinematic", "Shows a cinematic", R_FUN)
	if(!SSticker.initialized)
		to_chat(usr, span_warning("Wait for the game to finish loading!"))
>>>>>>> fca90f5c78b (Redoes the admin verb define to require passing in an Admin Visible Name, and restores the usage of '-' for the verb bar when you want to call verbs from the command bar. Also cleans up and organizes the backend for drawing verbs to make it easier in the future for me to make it look better (#73214))
		return

	var/datum/cinematic/choice = tgui_input_list(usr, "Chose a cinematic to play to everyone in the server.", "Choose Cinematic", sort_list(subtypesof(/datum/cinematic), GLOBAL_PROC_REF(cmp_typepaths_asc)))
	if(!choice || !ispath(choice, /datum/cinematic))
		return

	play_cinematic(choice, world)
