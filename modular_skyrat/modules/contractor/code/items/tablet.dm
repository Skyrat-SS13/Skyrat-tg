/obj/item/modular_computer/pda/contractor
	name = "contract PDA"
	icon = 'icons/obj/antags/contractor_tablet.dmi'
	icon_state = "tablet"
	icon_state_unpowered = "tablet"
	icon_state_powered = "tablet"
	icon_state_menu = "assign"
	greyscale_config = null
	greyscale_colors = null
	comp_light_luminosity = 6.3
	saved_identification = "John Doe"
	saved_job = "Citizen"
	device_theme = "syndicate"
	starting_programs = list(
		/datum/computer_file/program/contract_uplink,
		/datum/computer_file/program/crew_manifest,
	)
	device_theme = "syndicate"

	/// Contractor uplink system board has the user's data baked directly into it on creation
	var/datum/opposing_force/opfor_data

/obj/item/modular_computer/pda/contractor/Initialize(mapload)
	. = ..()
	var/datum/computer_file/program/contract_uplink/uplink = locate() in stored_files

	active_program = uplink

	var/datum/computer_file/program/messenger/msg = locate() in stored_files
	if(msg)
		msg.invisible = TRUE

/obj/item/modular_computer/pda/contractor/Destroy()
	opfor_data = null
	return ..()

/obj/item/modular_computer/pda/contractor/UpdateDisplay()
	return
