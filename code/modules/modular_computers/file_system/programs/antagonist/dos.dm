/datum/computer_file/program/ntnet_dos
	filename = "ntn_dos"
	filedesc = "DoS Traffic Generator"
	downloader_category = PROGRAM_CATEGORY_DEVICE
	program_open_overlay = "hostile"
	extended_desc = "This advanced script can perform denial of service attacks against NTNet quantum relays. The system administrator will probably notice this. Multiple devices can run this program together against same relay for increased effect"
	size = 20
	program_flags = PROGRAM_ON_SYNDINET_STORE | PROGRAM_REQUIRES_NTNET
	tgui_id = "NtosNetDos"
	program_icon = "satellite-dish"

	var/obj/machinery/ntnet_relay/target = null
	var/dos_speed = 0
	var/error = ""
	var/executed = 0

/datum/computer_file/program/ntnet_dos/process_tick(seconds_per_tick)
	dos_speed = 0
	switch(ntnet_status)
		if(NTNET_LOW_SIGNAL)
			dos_speed = NTNETSPEED_LOWSIGNAL * 10
		if(NTNET_GOOD_SIGNAL)
			dos_speed = NTNETSPEED_HIGHSIGNAL * 10
		if(NTNET_ETHERNET_SIGNAL)
			dos_speed = NTNETSPEED_ETHERNET * 10
	if(target && executed)
		target.dos_overload += dos_speed
		if(!target.is_operational)
			target.dos_sources.Remove(src)
			target = null
			error = "Connection to destination relay lost."

/datum/computer_file/program/ntnet_dos/kill_program(mob/user)
	if(target)
		target.dos_sources.Remove(src)
	target = null
	executed = FALSE
	return ..()

/datum/computer_file/program/ntnet_dos/ui_act(action, params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	switch(action)
		if("PRG_target_relay")
			for(var/obj/machinery/ntnet_relay/relays as anything in SSmachines.get_machines_by_type(/obj/machinery/ntnet_relay))
				if(relays.uid == params["targid"])
					target = relays
					break
			return TRUE
		if("PRG_reset")
			if(target)
				target.dos_sources.Remove(src)
				target = null
			executed = FALSE
			error = ""
			return TRUE
		if("PRG_execute")
			if(target)
				executed = TRUE
				target.dos_sources.Add(src)
				if(SSmodular_computers.intrusion_detection_enabled)
					SSmodular_computers.add_log("IDS WARNING - Excess traffic flood targeting relay [target.uid] detected from device: [computer.name]")
					SSmodular_computers.intrusion_detection_alarm = TRUE
			return TRUE

/datum/computer_file/program/ntnet_dos/ui_data(mob/user)
	var/list/data = list()

	data["error"] = error
	if(target && executed)
		data["target"] = TRUE
		data["speed"] = dos_speed

		data["overload"] = target.dos_overload
		data["capacity"] = target.dos_capacity
	else
		data["target"] = FALSE
		data["relays"] = list()
		for(var/obj/machinery/ntnet_relay/relays as anything in SSmachines.get_machines_by_type(/obj/machinery/ntnet_relay))
			data["relays"] += list(list("id" = relays.uid))
		data["focus"] = target ? target.uid : null

	return data
