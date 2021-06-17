/obj/machinery/dispatch_control
	name = "Dispatch and Control Console"
	icon = 'icons/obj/computer.dmi'
	icon_state = "bulb"
	use_power = NO_POWER_USE
	idle_power_usage = 200
	active_power_usage = 2000

/obj/machinery/dispatch_control/proc/HandleClick(mob/user, atom/clicked, params)
	var/list/modifiers = params2list(params)

	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		HandleRClick(user)
		return

	HandleLClick(user)

/obj/machinery/dispatch_control/proc/HandleRClick(mob/user)
	if(isobserver(user) || !user.Adjacent(src))
		return

	if(use_power == ACTIVE_POWER_USE)
		console_shutdown()

/obj/machinery/dispatch_control/proc/HandleLClick(mob/user)
	if(use_power == ACTIVE_POWER_USE)
		ui_interact(user)
		return

	if(use_power == NO_POWER_USE && directly_use_power(active_power_usage))
		console_bootup()
		return

/obj/machinery/dispatch_control/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "DispatchConsole")
		ui.autoupdate = TRUE
		ui.open()

/obj/machinery/dispatch_control/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_MACHINERY_POWER_LOST, .proc/console_shutdown)
	RegisterSignal(src, COMSIG_MOB_CLICKON, .proc/HandleClick)

/obj/machinery/dispatch_control/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_MACHINERY_POWER_LOST)
	UnregisterSignal(src, COMSIG_MOB_CLICKON)
	if(SSdispatch.dispatch_online == src)
		SSdispatch.dispatch_online = null

/obj/machinery/dispatch_control/proc/state_change(state)
	// icon_state = initial(icon_state) + "_[state]"
	update_icon()

/obj/machinery/dispatch_control/proc/message_viewers(message)
	if(use_power == NO_POWER_USE)
		return
	for(var/mob/mob in viewers(world.view, src))
		balloon_alert(mob, message)

/obj/machinery/dispatch_control/proc/console_poweron()
	use_power = ACTIVE_POWER_USE
	state_change("on")
	message_viewers("Welcome to Dispatch and Control V1.5")
	for(var/ttype in SSDISPATCH_TICKET_TYPES)
		SSdispatch.message_type_holders(ttype, "Dispatch Online")

/obj/machinery/dispatch_control/proc/console_bootup(stage = STAGE_ONE)
	use_power = IDLE_POWER_USE
	state_change("boot[stage]")

	switch(stage)
		if(STAGE_ONE)
			message_viewers("Connecting to Database...")
			addtimer(CALLBACK(src, .proc/console_bootup, STAGE_TWO), 0.5 SECONDS)

		if(STAGE_TWO)
			if(SSdispatch.dispatch_online && SSdispatch.dispatch_online != src)
				message_viewers("Database reports Dispatch already active")
				console_shutdown()
				return

			SSdispatch.dispatch_online = src
			message_viewers("Requesting Data...")
			addtimer(CALLBACK(src, .proc/console_bootup, STAGE_THREE), 0.5 SECONDS)

		if(STAGE_THREE)
			message_viewers("Recieving Data...")
			addtimer(CALLBACK(src, .proc/console_bootup, STAGE_FOUR), 0.5 SECONDS)

		if(STAGE_FOUR)
			message_viewers("Preparing...")
			addtimer(CALLBACK(src, .proc/console_poweron), 0.5 SECONDS)

/obj/machinery/dispatch_control/proc/console_shutdown()
	SIGNAL_HANDLER

	if(use_power == NO_POWER_USE) // Already shutdown
		return

	if(SSdispatch.dispatch_online == src)
		SSdispatch.dispatch_online = null
		for(var/ttype in SSDISPATCH_TICKET_TYPES)
			SSdispatch.message_type_holders(ttype, "Dispatch Offline")

	message_viewers("Shuting Down...")
	use_power = NO_POWER_USE
	state_change("off")
