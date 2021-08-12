
// This is literally the worst possible cheap tablet
/obj/item/modular_computer/tablet/preset/cheap
	desc = "A low-end tablet often seen among low ranked station personnel."

/obj/item/modular_computer/tablet/preset/cheap/Initialize()
	. = ..()
	install_component(new /obj/item/computer_hardware/processor_unit/small)
	install_component(new /obj/item/computer_hardware/battery(src, /obj/item/stock_parts/cell/computer/micro))
	install_component(new /obj/item/computer_hardware/hard_drive/small)
	install_component(new /obj/item/computer_hardware/network_card)

// Alternative version, an average one, for higher ranked positions mostly
/obj/item/modular_computer/tablet/preset/advanced/Initialize()
	. = ..()
	install_component(new /obj/item/computer_hardware/processor_unit/small)
	install_component(new /obj/item/computer_hardware/battery(src, /obj/item/stock_parts/cell/computer))
	install_component(new /obj/item/computer_hardware/hard_drive/small)
	install_component(new /obj/item/computer_hardware/network_card)
	install_component(new /obj/item/computer_hardware/card_slot)
	install_component(new /obj/item/computer_hardware/printer/mini)

/obj/item/modular_computer/tablet/preset/science/Initialize()
	. = ..()
	var/obj/item/computer_hardware/hard_drive/small/hard_drive = new
	install_component(new /obj/item/computer_hardware/processor_unit/small)
	install_component(new /obj/item/computer_hardware/battery(src, /obj/item/stock_parts/cell/computer))
	install_component(hard_drive)
	install_component(new /obj/item/computer_hardware/card_slot)
	install_component(new /obj/item/computer_hardware/network_card)
	install_component(new /obj/item/computer_hardware/radio_card)
	hard_drive.store_file(new /datum/computer_file/program/signaler)

/obj/item/modular_computer/tablet/preset/cargo/Initialize()
	. = ..()
	var/obj/item/computer_hardware/hard_drive/small/hard_drive = new
	install_component(new /obj/item/computer_hardware/processor_unit/small)
	install_component(new /obj/item/computer_hardware/battery(src, /obj/item/stock_parts/cell/computer))
	install_component(hard_drive)
	install_component(new /obj/item/computer_hardware/card_slot)
	install_component(new /obj/item/computer_hardware/network_card)
	install_component(new /obj/item/computer_hardware/printer/mini)
	hard_drive.store_file(new /datum/computer_file/program/shipping)
	var/datum/computer_file/program/chatclient/chatprogram
	chatprogram = new
	hard_drive.store_file(chatprogram)
	chatprogram.username = get_cargochat_username()

/obj/item/modular_computer/tablet/preset/cargo/proc/get_cargochat_username()
	return "cargonian_[rand(1,999)]"

/obj/item/modular_computer/tablet/preset/cargo/quartermaster/get_cargochat_username()
	return "quartermaster"

/obj/item/modular_computer/tablet/preset/advanced/atmos/Initialize() //This will be defunct and will be replaced when NtOS PDAs are done
	. = ..()
	install_component(new /obj/item/computer_hardware/sensorpackage)

/obj/item/modular_computer/tablet/preset/advanced/engineering/Initialize()
	. = ..()
	var/obj/item/computer_hardware/hard_drive/small/hard_drive = find_hardware_by_name("solid state drive")
	hard_drive.store_file(new /datum/computer_file/program/supermatter_monitor)

/obj/item/modular_computer/tablet/preset/advanced/command/Initialize()
	. = ..()
	var/obj/item/computer_hardware/hard_drive/small/hard_drive = find_hardware_by_name("solid state drive")
	install_component(new /obj/item/computer_hardware/sensorpackage)
	install_component(new /obj/item/computer_hardware/card_slot/secondary)
	hard_drive.store_file(new /datum/computer_file/program/budgetorders)
	hard_drive.store_file(new /datum/computer_file/program/science)

/obj/item/modular_computer/tablet/preset/advanced/command/engineering/Initialize()
	. = ..()
	var/obj/item/computer_hardware/hard_drive/small/hard_drive = find_hardware_by_name("solid state drive")
	hard_drive.store_file(new /datum/computer_file/program/supermatter_monitor)

/// Given by the syndicate as part of the contract uplink bundle - loads in the Contractor Uplink.
/obj/item/modular_computer/tablet/syndicate_contract_uplink/preset/uplink/Initialize()
	. = ..()
	var/obj/item/computer_hardware/hard_drive/small/syndicate/hard_drive = new
	var/datum/computer_file/program/contract_uplink/uplink = new

	active_program = uplink
	uplink.program_state = PROGRAM_STATE_ACTIVE
	uplink.computer = src

	hard_drive.store_file(uplink)

	install_component(new /obj/item/computer_hardware/processor_unit/small)
	install_component(new /obj/item/computer_hardware/battery(src, /obj/item/stock_parts/cell/computer))
	install_component(hard_drive)
	install_component(new /obj/item/computer_hardware/network_card)
	install_component(new /obj/item/computer_hardware/card_slot)
	install_component(new /obj/item/computer_hardware/printer/mini)

/// Given to Nuke Ops members.
/obj/item/modular_computer/tablet/nukeops/Initialize()
	. = ..()
	install_component(new /obj/item/computer_hardware/processor_unit/small)
	install_component(new /obj/item/computer_hardware/battery(src, /obj/item/stock_parts/cell/computer))
	install_component(new /obj/item/computer_hardware/hard_drive/small/nukeops)
	install_component(new /obj/item/computer_hardware/network_card)

//Borg Built-in tablet
/obj/item/modular_computer/tablet/integrated/Initialize()
	. = ..()
	var/obj/item/computer_hardware/hard_drive/small/integrated/hard_drive = new // SKYRAT EDIT ADD
	install_component(new /obj/item/computer_hardware/processor_unit/small)
	install_component(hard_drive) // SKYRAT EDIT -- ORIGINAL install_component(new /obj/item/computer_hardware/hard_drive/small/integrated/)
	install_component(new /obj/item/computer_hardware/recharger/cyborg)
	install_component(new /obj/item/computer_hardware/network_card/integrated)
	hard_drive.store_file(new /datum/computer_file/program/crew_manifest) // SKYRAT EDIT ADD

//SKYRAT EDIT ADDITION BEGIN
//Program presets for different types of cyborgs
/obj/item/modular_computer/tablet/integrated/proc/default_programs_install()
	var/obj/item/computer_hardware/hard_drive/small/hard_drive = find_hardware_by_name("solid state drive")
	hard_drive.store_file(new /datum/computer_file/program/crew_manifest)
	return null

/obj/item/modular_computer/tablet/integrated/proc/enginering_programs_install()
	var/obj/item/computer_hardware/hard_drive/small/hard_drive = find_hardware_by_name("solid state drive")
	hard_drive.store_file(new /datum/computer_file/program/power_monitor/integrated)
	hard_drive.store_file(new /datum/computer_file/program/alarm_monitor)
	hard_drive.store_file(new /datum/computer_file/program/supermatter_monitor)
	return null
	
/obj/item/modular_computer/tablet/integrated/proc/medical_programs_install()
	var/obj/item/computer_hardware/hard_drive/small/hard_drive = find_hardware_by_name("solid state drive")
	hard_drive.store_file(new /datum/computer_file/program/radar/lifeline)
	return null

/obj/item/modular_computer/tablet/integrated/proc/security_programs_install()
	var/obj/item/computer_hardware/hard_drive/small/hard_drive = find_hardware_by_name("solid state drive")
	hard_drive.store_file(new /datum/computer_file/program/secureye/integrated)
	return null
	
/obj/item/modular_computer/tablet/integrated/proc/service_programs_install()
	var/obj/item/computer_hardware/hard_drive/small/hard_drive = find_hardware_by_name("solid state drive")
	hard_drive.store_file(new /datum/computer_file/program/chatclient)
	return null

/obj/item/modular_computer/tablet/integrated/proc/peacekeeper_programs_install()
	var/obj/item/computer_hardware/hard_drive/small/hard_drive = find_hardware_by_name("solid state drive")
	hard_drive.store_file(new /datum/computer_file/program/radar/lifeline)
	hard_drive.store_file(new /datum/computer_file/program/secureye/integrated)
	return null

/obj/item/modular_computer/tablet/integrated/proc/clown_programs_install()
	var/obj/item/computer_hardware/hard_drive/small/hard_drive = find_hardware_by_name("solid state drive")
	hard_drive.store_file(new /datum/computer_file/program/chatclient)
	return null

/obj/item/modular_computer/tablet/integrated/proc/remove_module_programs()
	var/obj/item/computer_hardware/hard_drive/small/hard_drive = find_hardware_by_name("solid state drive")
	for (var/datum/computer_file/file in hard_drive.stored_files)
		if (file.filename != "robotact" & file.filename != "filemanager" & file.filename != "compconfig" & file.filename != "plexagoncrew")
			hard_drive.remove_file(file)
	return null
// SKYRAT EDIT ADDITION END
