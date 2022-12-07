/obj/item/disk/nifsoft_uploader/virtual_machine
	name = "Virtual Machine"
	loaded_nifsoft = /datum/nifsoft/virtual_machine

/datum/nifsoft/virtual_machine
	name = "Virtual Machine"
	program_desc = "Provides a virtual machine of a tablet with limited functionality"
	active_mode = TRUE
	activation_cost = 10
	active_cost = 7.5

	/// What computer does the NIF generate as a "Virtual Machine?"
	var/obj/item/modular_computer/virtual_machine = /obj/item/modular_computer/tablet/virtual
	/// The action that opens up the virtual machine
	var/datum/action/item_action/nif/virtual_machine/vm_action
	/// The person that is using the device
	compatible_nifs = list(/obj/item/organ/internal/cyberimp/brain/nif/standard)

/datum/nifsoft/virtual_machine/New()
	. = ..()

	virtual_machine = new virtual_machine
	virtual_machine.name = "NIF Virtual Machine"
	virtual_machine.loc = linked_mob

/datum/nifsoft/virtual_machine/Destroy()
	qdel(virtual_machine)
	return ..()

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

///The "Virtual Machine" computer used in NIFs
/obj/item/modular_computer/tablet/virtual
	name = "NIF Virtual Machine"
	desc = "You shouldn't be seeing this, if you do, report it to GitHub"

	base_idle_power_usage = 0
	max_idle_programs = 1 //It's a virtual machine, not a good one.
	looping_sound = FALSE
	allow_chunky = TRUE
	comp_light_luminosity = 0


