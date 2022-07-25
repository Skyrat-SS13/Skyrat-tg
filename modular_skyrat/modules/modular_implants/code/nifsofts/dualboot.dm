/obj/item/disk/nifsoft_uploader/virtual_machine
	loaded_nifsoft = /datum/nifsoft/virtual_machine

/datum/nifsoft/virtual_machine
	name = "Virtual Machine"
	program_desc = "Provides a virtual machine of a tablet with limited functionality"
	cost = 250
	active_mode = TRUE
	activation_cost = 10
	active_cost = 7.5

	/// What computer does the NIF generate as a "Virtual Machine?"
	var/obj/item/modular_computer/virtual_machine = /obj/item/modular_computer/tablet/virtual
	/// The action that opens up the virtual machine
	var/datum/action/item_action/nif/virtual_machine/vm_action
	/// The person that is using the device

/datum/nifsoft/virtual_machine/New()
	. = ..()

	virtual_machine = new virtual_machine
	virtual_machine.name = "NIF Virtual Machine"
	virtual_machine.loc = linked_mob

/datum/nifsoft/virtual_machine/Destroy()
	qdel(virtual_machine)
	. = ..()

/datum/nifsoft/virtual_machine/activate()
	. = ..()
	if(active)
		vm_action = new

		vm_action.target = virtual_machine
		vm_action.Grant(linked_mob)
		return

	if(vm_action)
		vm_action.Remove(linked_mob)
		virtual_machine.shutdown_computer(FALSE)

///The action button to toggle the virtual machine
/datum/action/item_action/nif/virtual_machine
	background_icon_state = "android"
	icon_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'
	check_flags = AB_CHECK_CONSCIOUS
	///What "Virtual Machine" does the action open up?

/datum/action/item_action/nif/virtual_machine/Trigger(trigger_flags)
	. = ..()

///The "Virtual Machine" computer used in NIFs
/obj/item/modular_computer/tablet/virtual
	name = "NIF Virtual Machine"
	desc = "You shouldn't be seeing this, if you do, report it to GitHub"

	upgradable = FALSE
	deconstructable = FALSE
	//The actual power is being drained through the NIF.
	base_active_power_usage = 0
	base_idle_power_usage = 0
	max_idle_programs = 1 //It's a virtual machine, not a good one.
	looping_sound = FALSE
	has_variants = FALSE
	allow_chunky = TRUE
	comp_light_luminosity = 0
	max_bays = 0

/obj/item/modular_computer/tablet/virtual/Initialize(mapload)
	. = ..()
	install_component(new /obj/item/computer_hardware/battery(src, /obj/item/stock_parts/cell/computer/micro))
	install_component(new /obj/item/computer_hardware/hard_drive/small/emulated)
	install_component(new /obj/item/computer_hardware/network_card)

/obj/item/computer_hardware/hard_drive/small/emulated
	max_capacity = 32

/obj/item/computer_hardware/hard_drive/small/emulated/install_default_programs()
	store_file(new /datum/computer_file/program/ntnetdownload)
	store_file(new /datum/computer_file/program/filemanager)
	store_file(new /datum/computer_file/program/crew_manifest)
	store_file(new /datum/computer_file/program/notepad)
