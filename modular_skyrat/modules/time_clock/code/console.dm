#define CLOCK_IN_COOLDOWN 15 MINUTES

/obj/machinery/time_clock
	name = "time clock"
	desc = "Allows employees to clock in and out of their jobs"
	icon = 'modular_skyrat/modules/time_clock/icons/machinery/console.dmi'
	icon_state = "timeclock"
	density = FALSE

	///What ID card is currently inside?
	var/obj/item/card/id/inserted_id

	//These variables are the same as the ones that the cryopods use to make annoucements
	///The radio that is used to announce when someone clocks in and clocks out.
	var/obj/item/radio/headset/radio = /obj/item/radio/headset/silicon/pai
	///The channel that the radio broadcasts on.
	var/announcement_channel = null

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/time_clock, 28)

/obj/machinery/time_clock/Initialize(mapload)
	. = ..()
	radio = new radio(src)

/obj/machinery/time_clock/Destroy()
	. = ..()
	if(inserted_id)
		inserted_id.forceMove(drop_location())

	if(radio)
		QDEL_NULL(radio)

/obj/machinery/time_clock/attackby(obj/item/used_item, mob/user)
	if(!istype(used_item, /obj/item/card/id))
		. = ..()

	if(inserted_id)
		to_chat(user, span_warning("There is already an ID card present!"))
		return FALSE

	if(!user.transferItemToLoc(used_item))
		to_chat(user, span_warning("You are unable to put [used_item] inside of the [src]!"))
		return FALSE

	inserted_id = used_item
	icon_state = "timeclock_card"
	update_static_data_for_all_viewers()

	if(command_job_check())
		if(tgui_alert(user, "You are a member of command, make sure that you ahelp and return all job gear before clocking out. If you decide to clock back in later, you will need to go to the Head of Personnel. Do you wish to continue?", "[src]", list("Yes", "No")) != "Yes")
			eject_inserted_id(user)

	playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)

/obj/machinery/time_clock/AltClick(mob/user)
	. = ..()
	if(!Adjacent(user))
		to_chat(user, span_warning("You are out of range of the [src]!"))
		return FALSE

	if(!eject_inserted_id(user))
		return FALSE

///Ejects the ID stored inside of the parent machine, if there is one.
/obj/machinery/time_clock/proc/eject_inserted_id(mob/recepient)
	if(!inserted_id || !recepient)
		return FALSE

	inserted_id.forceMove(drop_location())
	recepient.put_in_hands(inserted_id)

	inserted_id = FALSE
	icon_state = "timeclock"
	update_static_data_for_all_viewers()
	playsound(src, 'sound/machines/terminal_eject.ogg', 50, FALSE)

	return TRUE

///Clocks out the currently inserted ID Card
/obj/machinery/time_clock/proc/clock_out()
	if(!inserted_id)
		return FALSE

	inserted_id.AddComponent(/datum/component/off_duty_timer, CLOCK_IN_COOLDOWN)
	inserted_id.clear_access()
	inserted_id.update_label()

	var/datum/id_trim/job/current_trim = inserted_id.trim
	var/datum/job/clocked_out_job = current_trim.job
	clocked_out_job.current_positions--

	radio.talk_into(src, "[inserted_id.registered_name], [current_trim.assignment] has gone off-duty.", announcement_channel)
	update_static_data_for_all_viewers()
	return TRUE

///Clocks the currently inserted ID Card back in
/obj/machinery/time_clock/proc/clock_in()
	if(!inserted_id)
		return FALSE

	if(id_cooldown_check())
		return FALSE

	var/datum/component/off_duty_timer/id_component = inserted_id.GetComponent(/datum/component/off_duty_timer)

	var/datum/id_trim/job/current_trim = inserted_id.trim
	var/datum/job/clocked_in_job = current_trim.job
	if(clocked_in_job.total_positions <= clocked_in_job.current_positions)
		return FALSE

	clocked_in_job.current_positions++

	inserted_id.clear_access()
	inserted_id.add_access(id_component.stored_access)
	inserted_id.add_wildcards(id_component.stored_wildcard_access)
	inserted_id.assignment = id_component.stored_assignment
	radio.talk_into(src, "[inserted_id.registered_name], [inserted_id.assignment] has gone on duty.", announcement_channel)

	qdel(id_component)
	inserted_id.update_label()
	update_static_data_for_all_viewers()

	return TRUE

///Is the job being worked a command job?
/obj/machinery/time_clock/proc/command_job_check()
	if(!inserted_id)
		return FALSE

	var/datum/id_trim/job/current_trim = inserted_id.trim
	var/datum/job/clocked_in_job = current_trim.job
	if(/datum/job_department/command in clocked_in_job.departments_list)
		return TRUE

	return FALSE

///Is the inserted ID on cooldown? returns TRUE if the ID has a cooldown
/obj/machinery/time_clock/proc/id_cooldown_check()
	if(!inserted_id)
		return FALSE

	var/datum/component/off_duty_timer/id_component = inserted_id.GetComponent(/datum/component/off_duty_timer)
	if(command_job_check() && id_component)
		return TRUE

	if(!id_component || !id_component.on_cooldown)
		return FALSE

	return TRUE

///Is the inserted ID off-duty? Returns true if the ID is off-duty
/obj/machinery/time_clock/proc/off_duty_check()
	if(!inserted_id)
		return FALSE

	var/datum/component/off_duty_timer/id_component = inserted_id.GetComponent(/datum/component/off_duty_timer)
	if(!id_component)
		return FALSE

	return TRUE

/datum/component/off_duty_timer
	///Is the ID that the component is attached to is able to clock back in?
	var/on_cooldown = FALSE
	///What access was given to the ID before going off duty?
	var/list/stored_access = list()
	///What wildcard access did the ID have on it before going off duty?
	var/list/stored_wildcard_access = list()
	///What is the name of the job the owner was working before going off duty?
	var/stored_assignment

/datum/component/off_duty_timer/Initialize(cooldown_timer = 0)
	. = ..()

	var/obj/item/card/id/attached_id = parent
	if(!attached_id)
		return COMPONENT_INCOMPATIBLE

	stored_access = attached_id.access.Copy()
	stored_wildcard_access = attached_id.wildcard_slots.Copy()
	stored_assignment = attached_id.assignment

	attached_id.assignment = "Off-Duty " + attached_id.assignment

	if(cooldown_timer)
		on_cooldown = TRUE
		addtimer(CALLBACK(src, PROC_REF(remove_cooldown)), cooldown_timer)

///Sets the on_cooldown variable to false, making it so that the ID can clock back in.
/datum/component/off_duty_timer/proc/remove_cooldown()
	on_cooldown = FALSE

/obj/item/wallframe/time_clock
	name = "time clock frame"
	desc = "Contains all of the parts needed to assemble a wall-mounted time clock"
	icon_state = "unanchoredstatusdisplay"
	result_path = /obj/machinery/time_clock
	pixel_shift = 28
	custom_materials = list(/datum/material/iron = 2000, /datum/material/glass = 4000)

#undef CLOCK_IN_COOLDOWN
