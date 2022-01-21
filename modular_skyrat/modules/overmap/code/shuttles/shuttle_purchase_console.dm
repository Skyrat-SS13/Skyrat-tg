/obj/machinery/computer/shuttle_purchase
	name = "shuttle purchase console"
	desc = "Console with a catalogue of shuttles available to purchase."
	icon_screen = "supply"
	circuit = /obj/item/circuitboard/computer/shuttle_purchase
	light_color = COLOR_BRIGHT_ORANGE
	/// The dock id's we try and link to
	var/list/desired_dock_ids = list(DOCKS_SMALL_UPWARDS)
	/// Reference to our dock
	var/obj/docking_port/stationary/dock
	/// Whether we are in the process of creating a shuttle. Important because the mapping process CHECK_TICK's
	var/creating_shuttle = FALSE
	/// What shuttle types can we buy from this console
	var/shuttle_types = LEGAL_SHUTTLE_TYPES
	/// Reference to a sold shuttles cache from SSshuttle
	var/list/catalogue
	/// Reference to a selected shuttle
	var/datum/sold_shuttle/selected_shuttle
	/// Input from the user about renaming the shuttle
	var/selected_rename

/obj/machinery/computer/shuttle_purchase/Initialize()
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/computer/shuttle_purchase/LateInitialize()
	. = ..()
	TryFindDock()

/turf/open/floor/planetary/dirt

/obj/machinery/computer/shuttle_purchase/proc/GetCatalogue()
	selected_shuttle = null
	catalogue = SSshuttle.get_sold_shuttles_cache(dock.port_destinations, shuttle_types)

#define SHUTTLE_PURCHASE_CONSOLE_DOCK_FIND_RANGE 10

/obj/machinery/computer/shuttle_purchase/proc/TryFindDock()
	if(dock)
		return
	var/list/candidates = list()
	for(var/i in SSshuttle.stationary_docking_ports)
		var/obj/docking_port/stationary/iterated_dock = i
		if(desired_dock_ids[iterated_dock.port_destinations])
			candidates += iterated_dock
	var/obj/docking_port/stationary/chosen_dock
	var/last_distance = 0
	for(var/i in candidates)
		var/obj/docking_port/stationary/iterated_dock = i
		if(iterated_dock.z != z)
			continue
		var/distance = get_dist(src, iterated_dock)
		if(distance <= SHUTTLE_PURCHASE_CONSOLE_DOCK_FIND_RANGE && (!chosen_dock || last_distance > distance))
			chosen_dock = iterated_dock
			last_distance = distance
	dock = chosen_dock

#undef SHUTTLE_PURCHASE_CONSOLE_DOCK_FIND_RANGE

/obj/machinery/computer/shuttle_purchase/ui_interact(mob/user, datum/tgui/ui)
	var/list/dat = list()
	if(!dock)
		TryFindDock()
	if(!catalogue)
		GetCatalogue()
	if(!dock)
		dat += "<center><b>Couldn't find a suitable dock to connect to! Please construct the console near a common docking port.</b></center>"
	else
		if(selected_shuttle)
			dat += "<a href='?src=[REF(src)];task=back'>Back</a>"
		else
			dat += "---"
		dat += "<HR>"
		if(selected_shuttle)
			var/shown_name = selected_rename ? selected_rename : selected_shuttle.name
			dat += "<b>[shown_name]</b> <a href='?src=[REF(src)];task=selected;selected_task=rename'>Rename</a>"
			dat += "<BR><i>[selected_shuttle.desc]<BR>[selected_shuttle.detailed_desc]</i><BR>Cost: [selected_shuttle.cost] cr.<BR>Stock remaining: [selected_shuttle.stock]"
			dat += "<BR><center><a href='?src=[REF(src)];task=selected;selected_task=purchase'>Purchase</a></center>"
		else
			var/index = 0
			for(var/i in catalogue)
				index++
				var/datum/sold_shuttle/iterated_shuttle = i
				dat += "<b>[iterated_shuttle.name]</b> <a href='?src=[REF(src)];task=select;index=[index]'>Select</a>"
				dat += "<BR><i>[iterated_shuttle.desc]</i><BR>Cost: [iterated_shuttle.cost] cr.<BR>Stock remaining: [iterated_shuttle.stock]"
				dat += "<HR>"
	var/datum/browser/popup = new(user, "shuttle_purchase", name, 450, 600)
	popup.set_content(dat.Join())
	popup.open()

/obj/machinery/computer/shuttle_purchase/proc/DockBlocked()
	if(!dock)
		. = "Cant find a dock."
	else if (creating_shuttle)
		. = "Your order is being processed."
	else if (dock.get_docked())
		. = "Dock busy."

/obj/machinery/computer/shuttle_purchase/Topic(href, href_list)
	var/mob/user = usr
	if(!isliving(user) || !user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	switch(href_list["task"])
		if("back")
			selected_shuttle = null
		if("select")
			var/index = text2num(href_list["index"])
			if(length(catalogue) < index)
				return
			selected_rename = null
			selected_shuttle = catalogue[index]
		if("selected")
			if(!selected_shuttle)
				return
			switch(href_list["selected_task"])
				if("purchase")
					if(DockBlocked())
						say("Dock currently blocked!")
						return
					if(!selected_shuttle.stock)
						say("Out of stock!")
						return
					var/mob/living/carbon/carbon_user = usr
					if(!istype(carbon_user))
						return
					var/obj/item/card/id/held_id = carbon_user.get_active_held_item()
					if(!istype(held_id))
						to_chat(carbon_user, span_warning("Swipe your ID!"))
						return
					if(!held_id.registered_account)
						to_chat(carbon_user, span_warning("Your ID has no registered account!"))
						return
					if(!held_id.registered_account.adjust_money(-selected_shuttle.cost))
						to_chat(carbon_user, span_warning("You can't afford this!"))
						return
					selected_shuttle.stock--
					say("Thank you for the purchase! Your shuttle will arrive shortly.")
					SpawnSelectedShuttle(carbon_user)
				if("rename")
					var/renamed = input(usr, "Choose the ship's desired name:","Ship Customization") as text|null
					if(renamed)
						selected_rename = reject_bad_name(renamed, allow_numbers = TRUE, strict = FALSE)
	ui_interact(usr)

/obj/machinery/computer/shuttle_purchase/proc/SpawnSelectedShuttle(mob/user)
	creating_shuttle = TRUE
	var/datum/map_template/shuttle/shuttle_template = SSmapping.shuttle_templates[selected_shuttle.shuttle_id]
	var/obj/docking_port/mobile/mdp = SSshuttle.action_load(shuttle_template)
	mdp.destination = dock
	mdp.mode = SHUTTLE_IGNITING
	mdp.setTimer(5 SECONDS)
	message_admins("[key_name_admin(user)] purchased and loaded [mdp] with shuttle purchase console.")
	log_admin("[key_name(user)] purchased and loaded [mdp] with shuttle purchase console.</span>")
	creating_shuttle = FALSE
	selected_shuttle = null

/obj/item/circuitboard/computer/shuttle_purchase
	name = "Shuttle Purchase Console (Computer Board)"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/computer/shuttle_purchase
