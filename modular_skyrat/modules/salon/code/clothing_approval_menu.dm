/client/proc/clothing_approval_queue() //Creates a verb for admins to open up the ui
	set name = "Clothing Approval Queue"
	set desc = "Allows admins to approve clothing items"
	set category = "Admin.Game"
	if(!CONFIG_GET(flag/enable_clothing_approval_queue))
		to_chat(usr, "Clothing approval queue is disabled!")
		return // approval queue is disabled
	var/datum/clothing_approval_queue/tgui = new(usr)//create the datum
	tgui.ui_interact(usr)//datum has a tgui component, here we open the window

/datum/clothing_approval_queue
	var/client/holder //client of whoever is using this datum
	var/mob/living/carbon/human/dummy
	var/atom/movable/screen/dummy_screen
	var/datum/tailor_clothing/clothing_datum

/datum/clothing_approval_queue/New(user)//user can either be a client or a mob due to byondcode(tm)
	if (istype(user, /client))
		var/client/user_client = user
		holder = user_client //if its a client, assign it to holder
	else
		var/mob/user_mob = user
		holder = user_mob.client //if its a mob, assign the mob's client to holder
	if(LAZYLEN(SSclothing_database.clothing_awaiting_approval))
		clothing_datum = SSclothing_database.clothing_awaiting_approval[SSclothing_database.clothing_awaiting_approval.len]
	else
		return
	dummy_screen = new
	dummy_screen.name = "screen"
	dummy_screen.assigned_map = "clothing_queue_[REF(src)]_map"
	dummy_screen.del_on_map_removal = FALSE
	dummy_screen.screen_loc = "[dummy_screen.assigned_map]:1,1"
	load_next_pattern()

/datum/clothing_approval_queue/ui_state(mob/user)
	return GLOB.admin_state

/datum/clothing_approval_queue/ui_close(mob/user)
	user.client.clear_map(dummy_screen.assigned_map)
	qdel(dummy)
	qdel(dummy_screen)
	qdel(src)
	..()

/datum/clothing_approval_queue/ui_interact(mob/user, datum/tgui/ui)
	if(!clothing_datum)
		to_chat(user, "No clothing awaiting approval!")
		if(ui)
			ui.close()
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		user.client.register_map_obj(dummy_screen)
		ui = new(user, src, "ClothingApprovalQueue")
		ui.open()

/datum/clothing_approval_queue/ui_data(mob/user)
	var/list/data = list()
	data["pattern_data"] = clothing_datum.get_list()
	data["assigned_map"] = dummy_screen.assigned_map
	return data

/datum/clothing_approval_queue/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("approve_pattern")
			clothing_datum.approve_pattern()
			load_next_pattern()
			. = TRUE
		if("deny_pattern")
			clothing_datum.ban_pattern()
			load_next_pattern()
			. = TRUE
		if("rotate")
			dummy.dir = turn(dummy.dir, -90)
			. = TRUE

/datum/clothing_approval_queue/proc/load_next_pattern()
	if(!LAZYLEN(SSclothing_database.clothing_awaiting_approval))
		to_chat(holder, "No more clothing awaiting approval!")
		clothing_datum = null
		return
	clothing_datum = SSclothing_database.clothing_awaiting_approval[SSclothing_database.clothing_awaiting_approval.len]
	qdel(dummy)
	dummy = generate_or_wait_for_human_dummy(REF(src))
	var/icon/clothing = icon(file("data/clothing_icons/[clothing_datum.id].dmi"),"onmob")
	dummy.add_overlay(clothing)
	dummy_screen.vis_contents += dummy
