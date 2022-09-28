/obj/item/modular_computer/tablet/syndicate_contract_uplink/preset/uplink/Initialize(mapload)
	. = ..()
	var/obj/item/computer_hardware/hard_drive/portable/syndicate/hard_drive = new
	var/datum/computer_file/program/contract_uplink/uplink = new

	active_program = uplink
	uplink.program_state = PROGRAM_STATE_ACTIVE
	uplink.computer = src

	hard_drive.store_file(uplink)
	hard_drive.store_file(new /datum/computer_file/program/crew_manifest)

	install_component(new /obj/item/computer_hardware/battery(src, /obj/item/stock_parts/cell/computer))
	install_component(hard_drive)
	install_component(new /obj/item/computer_hardware/card_slot)

/obj/item/modular_computer/tablet/syndicate_contract_uplink/UpdateDisplay()
	return
