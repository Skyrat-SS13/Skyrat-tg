///What items do we want to remove from the person clocking out?
#define TIME_CLOCK_RETURN_ITEMS list( \
	/obj/item/melee/baton/security, \
	/obj/item/melee/baton/security/loaded, \
	/obj/item/melee/baton/telescopic, \
	/obj/item/melee/baton, \
	/obj/item/assembly/flash/handheld, \
	/obj/item/gun/energy/disabler, \
	/obj/item/megaphone/command, \
	/obj/item/door_remote/captain, \
	/obj/item/door_remote/chief_engineer, \
	/obj/item/door_remote/research_director, \
	/obj/item/door_remote/head_of_security, \
	/obj/item/door_remote/quartermaster, \
	/obj/item/door_remote/chief_medical_officer, \
	/obj/item/door_remote/civilian, \
	/obj/item/circuitboard/machine/techfab/department/engineering, \
	/obj/item/circuitboard/machine/techfab/department/service, \
	/obj/item/circuitboard/machine/techfab/department/security, \
	/obj/item/circuitboard/machine/techfab/department/medical, \
	/obj/item/circuitboard/machine/techfab/department/cargo, \
	/obj/item/circuitboard/machine/techfab/department/science, \
	/obj/item/blueprints, \
	/obj/item/pipe_dispenser/bluespace, \
	/obj/item/mod/control/pre_equipped/advanced, \
	/obj/item/clothing/shoes/magboots/advance, \
	/obj/item/shield/riot/tele, \
	/obj/item/storage/belt/security/full, \
	/obj/item/gun/energy/e_gun/hos, \
	/obj/item/pinpointer/nuke, \
	/obj/item/gun/energy/e_gun, \
	/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/skild, \
	/obj/item/storage/belt/sabre, \
	/obj/item/mod/control/pre_equipped/magnate, \
	/obj/item/mod/control/pre_equipped/blueshield, \
	/obj/item/clothing/suit/armor/vest/warden, \
	/obj/item/clothing/glasses/hud/security/sunglasses, \
	/obj/item/clothing/gloves/krav_maga/sec, \
	/obj/item/clothing/suit/armor/vest/alt/sec, \
	/obj/item/storage/belt/holster/detective/full, \
	/obj/item/reagent_containers/spray/pepper, \
	/obj/item/detective_scanner, \
	/obj/item/gun/ballistic/revolver/c38/detective, \
	/obj/item/mod/control/pre_equipped/security, \
	/obj/item/mod/control/pre_equipped/safeguard, \
	/obj/item/gun/energy/cell_loaded/medigun/cmo, \
	/obj/item/defibrillator/compact/loaded, \
	/obj/item/storage/hypospraykit/cmo/preloaded, \
	/obj/item/mod/control/pre_equipped/rescue, \
	/obj/item/gun/ballistic/rifle/boltaction/sporterized, \
	/obj/item/clothing/glasses/hud/gun_permit/sunglasses, \
	/obj/item/card/id/departmental_budget/car, \
	/obj/item/clothing/suit/armor/reactive/teleport, \
	/obj/item/mod/control/pre_equipped/research, \
)


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
				if(!(clock_in()))
					return
				log_admin("[key_name(usr)] clocked in as \an [inserted_id.assignment].")

				var/datum/mind/user_mind = usr.mind
				if(user_mind)
					user_mind.clocked_out_of_job = FALSE

			else
				log_admin("[key_name(usr)] clocked out as \an [inserted_id.assignment].")
				clock_out()
				var/mob/living/carbon/human/human_user = usr
				if(human_user)
					human_user.return_items_to_console(TIME_CLOCK_RETURN_ITEMS)

				var/datum/mind/user_mind = usr.mind
				if(user_mind)
					user_mind.clocked_out_of_job = TRUE

				if(important_job_check())
					message_admins("[key_name(usr)] has clocked out as a head of staff. [ADMIN_JMP(src)]")

			playsound(src, 'sound/machines/ping.ogg', 50, FALSE)

		if("eject_id")
			eject_inserted_id(usr)

#undef TIME_CLOCK_RETURN_ITEMS
