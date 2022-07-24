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
	var/mob/living/carbon/human/vm_user

/datum/nifsoft/virtual_machine/New()
	. = ..()

	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif = parent_nif
	vm_user = installed_nif.linked_mob

	virtual_machine = new virtual_machine
	virtual_machine.loc = vm_user
	virtual_machine.device_theme = installed_nif.current_theme

/datum/nifsoft/virtual_machine/Destroy()
	qdel(virtual_machine)
	. = ..()

/datum/nifsoft/virtual_machine/activate()
	. = ..()
	if(active)
		vm_action = new

		vm_action.target = virtual_machine
		vm_action.Grant(vm_user)
		return

	if(vm_action)
		vm_action.Remove(vm_user)
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
	comp_light_luminosity = 0
	max_bays = 0

/obj/item/modular_computer/tablet/virtual/Initialize(mapload)
	. = ..()
	install_component(new /obj/item/computer_hardware/battery(src, /obj/item/stock_parts/cell/computer/micro))
	install_component(new /obj/item/computer_hardware/hard_drive/small)
	install_component(new /obj/item/computer_hardware/network_card)
