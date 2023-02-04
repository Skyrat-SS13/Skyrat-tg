<<<<<<< HEAD
/client/proc/jumptoarea(area/A in get_sorted_areas())
	set name = "Jump to Area"
	set desc = "Area to jump to"
	set category = "Admin.Game"
	if(!src.holder)
		to_chat(src, "Only administrators may use this command.", confidential = TRUE)
		return
=======
ADMIN_VERB(game, jump_to_area, "Jump to Area", "Jump to the specified area", NONE, area/destination in world)
	var/turf/point
>>>>>>> fca90f5c78b (Redoes the admin verb define to require passing in an Admin Visible Name, and restores the usage of '-' for the verb bar when you want to call verbs from the command bar. Also cleans up and organizes the backend for drawing verbs to make it easier in the future for me to make it look better (#73214))

	if(!A)
		return

	var/list/turfs = list()
	for(var/turf/T in A)
		if(T.density)
			continue
		turfs.Add(T)

	if(length(turfs))
		var/turf/T = pick(turfs)
		usr.forceMove(T)
		log_admin("[key_name(usr)] jumped to [AREACOORD(T)]")
		message_admins("[key_name_admin(usr)] jumped to [AREACOORD(T)]")
		SSblackbox.record_feedback("tally", "admin_verb", 1, "Jump To Area") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	else
		to_chat(src, "Nowhere to jump to!", confidential = TRUE)
		return


<<<<<<< HEAD
/client/proc/jumptoturf(turf/T in world)
	set name = "Jump to Turf"
	set category = "Admin.Game"
	if(!src.holder)
		to_chat(src, "Only administrators may use this command.", confidential = TRUE)
=======
ADMIN_VERB(game, jump_to_turf, "Jump to Turf", "", NONE, turf/destination in world)
	usr.forceMove(destination)
	log_admin("[key_name(usr)] jumped to [AREACOORD(destination)]")
	key_name_admin("[key_name(usr)] jumped to [AREACOORD(destination)]")

ADMIN_VERB(game, jump_to_mob, "Jump to Mob", "", NONE, mob/destination)
	destination ||= tgui_input_list(usr, "Select a mob to teleport to you", "Admin Jump", GLOB.mob_list - usr)
	if(!destination)
>>>>>>> fca90f5c78b (Redoes the admin verb define to require passing in an Admin Visible Name, and restores the usage of '-' for the verb bar when you want to call verbs from the command bar. Also cleans up and organizes the backend for drawing verbs to make it easier in the future for me to make it look better (#73214))
		return

	log_admin("[key_name(usr)] jumped to [AREACOORD(T)]")
	message_admins("[key_name_admin(usr)] jumped to [AREACOORD(T)]")
	usr.forceMove(T)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Jump To Turf") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return

<<<<<<< HEAD
/client/proc/jumptomob(mob/M in GLOB.mob_list)
	set category = "Admin.Game"
	set name = "Jump to Mob"

	if(!src.holder)
		to_chat(src, "Only administrators may use this command.", confidential = TRUE)
=======
ADMIN_VERB(game, jump_to_coordinate, "Jump to Coordinate", "", NONE, x as num, y as num, z as num)
	if(x < 1 || y < 1 || z < 1 || x > world.maxx || y > world.maxy || z > world.maxz)
		to_chat(usr, span_warning("Invaild coordinates"))
>>>>>>> fca90f5c78b (Redoes the admin verb define to require passing in an Admin Visible Name, and restores the usage of '-' for the verb bar when you want to call verbs from the command bar. Also cleans up and organizes the backend for drawing verbs to make it easier in the future for me to make it look better (#73214))
		return

	log_admin("[key_name(usr)] jumped to [key_name(M)]")
	message_admins("[key_name_admin(usr)] jumped to [ADMIN_LOOKUPFLW(M)] at [AREACOORD(M)]")
	if(src.mob)
		var/mob/A = src.mob
		var/turf/T = get_turf(M)
		if(T && isturf(T))
			SSblackbox.record_feedback("tally", "admin_verb", 1, "Jump To Mob") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
			A.forceMove(M.loc)
		else
			to_chat(A, "This mob is not located in the game world.", confidential = TRUE)

<<<<<<< HEAD
/client/proc/jumptocoord(tx as num, ty as num, tz as num)
	set category = "Admin.Game"
	set name = "Jump to Coordinate"
=======
ADMIN_VERB(game, jump_to_player, "Jump to Player", "", NONE)
	var/list/players = list()
	for(var/client/player as anything in GLOB.clients)
		players[key_name(player)] = WEAKREF(player.mob)
>>>>>>> fca90f5c78b (Redoes the admin verb define to require passing in an Admin Visible Name, and restores the usage of '-' for the verb bar when you want to call verbs from the command bar. Also cleans up and organizes the backend for drawing verbs to make it easier in the future for me to make it look better (#73214))

	if (!holder)
		to_chat(src, "Only administrators may use this command.", confidential = TRUE)
		return

	if(src.mob)
		var/mob/A = src.mob
		var/turf/T = locate(tx,ty,tz)
		A.forceMove(T)
		SSblackbox.record_feedback("tally", "admin_verb", 1, "Jump To Coordiate") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	message_admins("[key_name_admin(usr)] jumped to coordinates [tx], [ty], [tz]")

<<<<<<< HEAD
/client/proc/jumptokey()
	set category = "Admin.Game"
	set name = "Jump to Key"

	if(!src.holder)
		to_chat(src, "Only administrators may use this command.", confidential = TRUE)
=======
ADMIN_VERB(game, get_mob, "Get Mob", "", NONE, mob/teleportee)
	teleportee ||= tgui_input_list(usr, "Select a mob to teleport to you", "Admin Jump", GLOB.mob_list - usr)
	if(!teleportee)
>>>>>>> fca90f5c78b (Redoes the admin verb define to require passing in an Admin Visible Name, and restores the usage of '-' for the verb bar when you want to call verbs from the command bar. Also cleans up and organizes the backend for drawing verbs to make it easier in the future for me to make it look better (#73214))
		return

	var/list/keys = list()
	for(var/mob/M in GLOB.player_list)
		keys += M.client
	var/client/selection = input("Please, select a player!", "Admin Jumping", null, null) as null|anything in sort_key(keys)
	if(!selection)
		to_chat(src, "No keys found.", confidential = TRUE)
		return
	var/mob/M = selection.mob
	log_admin("[key_name(usr)] jumped to [key_name(M)]")
	message_admins("[key_name_admin(usr)] jumped to [ADMIN_LOOKUPFLW(M)]")

	usr.forceMove(M.loc)

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Jump To Key") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/Getmob(mob/M in GLOB.mob_list - GLOB.dummy_mob_list)
	set category = "Admin.Game"
	set name = "Get Mob"
	set desc = "Mob to teleport"
	if(!src.holder)
		to_chat(src, "Only administrators may use this command.", confidential = TRUE)
		return

	var/atom/loc = get_turf(usr)
	M.admin_teleport(loc)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Get Mob") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!


/// Proc to hook user-enacted teleporting behavior and keep logging of the event.
/atom/movable/proc/admin_teleport(atom/new_location)
	if(isnull(new_location))
		log_admin("[key_name(usr)] teleported [key_name(src)] to nullspace")
		moveToNullspace()
	else
		var/turf/location = get_turf(new_location)
		log_admin("[key_name(usr)] teleported [key_name(src)] to [AREACOORD(location)]")
		forceMove(new_location)

/mob/admin_teleport(atom/new_location)
	var/turf/location = get_turf(new_location)
	var/msg = "[key_name_admin(usr)] teleported [ADMIN_LOOKUPFLW(src)] to [isnull(new_location) ? "nullspace" : ADMIN_VERBOSEJMP(location)]"
	message_admins(msg)
	admin_ticket_log(src, msg)
	return ..()

<<<<<<< HEAD
=======
ADMIN_VERB(game, get_player, "Get Player", "", NONE)
	var/list/players = list()
	for(var/client/player as anything in GLOB.clients)
		players[key_name(player)] = WEAKREF(player.mob)
>>>>>>> fca90f5c78b (Redoes the admin verb define to require passing in an Admin Visible Name, and restores the usage of '-' for the verb bar when you want to call verbs from the command bar. Also cleans up and organizes the backend for drawing verbs to make it easier in the future for me to make it look better (#73214))

/client/proc/Getkey()
	set category = "Admin.Game"
	set name = "Get Key"
	set desc = "Key to teleport"

	if(!src.holder)
		to_chat(src, "Only administrators may use this command.", confidential = TRUE)
		return

	var/list/keys = list()
	for(var/mob/M in GLOB.player_list)
		keys += M.client
	var/client/selection = input("Please, select a player!", "Admin Jumping", null, null) as null|anything in sort_key(keys)
	if(!selection)
		return
	var/mob/M = selection.mob

	if(!M)
		return
	log_admin("[key_name(usr)] teleported [key_name(M)]")
	var/msg = "[key_name_admin(usr)] teleported [ADMIN_LOOKUPFLW(M)]"
	message_admins(msg)
	admin_ticket_log(M, msg)
	if(M)
		M.forceMove(get_turf(usr))
		usr.forceMove(M.loc)
		SSblackbox.record_feedback("tally", "admin_verb", 1, "Get Key") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/sendmob(mob/jumper in sort_mobs())
	set category = "Admin.Game"
	set name = "Send Mob"
	if(!src.holder)
		to_chat(src, "Only administrators may use this command.", confidential = TRUE)
		return
	var/list/sorted_areas = get_sorted_areas()
	if(!length(sorted_areas))
		to_chat(src, "No areas found.", confidential = TRUE)
		return
	var/area/target_area = tgui_input_list(src, "Pick an area", "Send Mob", sorted_areas)
	if(isnull(target_area))
		return
	if(!istype(target_area))
		return
	var/list/turfs = get_area_turfs(target_area)
	if(length(turfs) && jumper.forceMove(pick(turfs)))
		log_admin("[key_name(usr)] teleported [key_name(jumper)] to [AREACOORD(jumper)]")
		var/msg = "[key_name_admin(usr)] teleported [ADMIN_LOOKUPFLW(jumper)] to [AREACOORD(jumper)]"
		message_admins(msg)
		admin_ticket_log(jumper, msg)
	else
		to_chat(src, "Failed to move mob to a valid location.", confidential = TRUE)
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Send Mob") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
