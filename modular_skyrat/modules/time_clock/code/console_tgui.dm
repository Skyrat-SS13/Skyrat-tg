/obj/machinery/time_clock/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN))
		return

	add_fingerprint(user)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TimeClock", name)
		ui.open()


/obj/machinery/time_clock/ui_state(mob/user)
	return GLOB.conscious_state

/obj/machinery/time_clock/ui_static_data(mob/user)
	var/data = list()
	data["inserted_id"] = inserted_id
	data["station_alert_level"] = SSsecurity_level.get_current_level_as_text()
	data["clock_status"] = off_duty_check()

	if(inserted_id)
		data["id_holder_name"] = inserted_id.registered_name
		data["id_job_title"] = inserted_id.assignment

	return data

/obj/machinery/time_clock/ui_data(mob/user)
	var/data = list()
	data["current_time"] = station_time_timestamp()

	if(inserted_id)
		data["insert_id_cooldown"] = id_cooldown_check()

	return data

/obj/machinery/time_clock/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	switch(action)
		if("clock_in_or_out")
			if(off_duty_check())
				clock_in()
				log_admin("[key_name(usr)] clocked in as a [inserted_id.assignment]")
			else
				log_admin("[key_name(usr)] clocked out as a [inserted_id.assignment]")
				clock_out()

		if("eject_id")
			eject_inserted_id(usr)
