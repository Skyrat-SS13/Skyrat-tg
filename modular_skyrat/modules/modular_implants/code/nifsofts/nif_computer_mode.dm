///The "Virtual Machine" computer used in NIFs
/obj/item/modular_computer/virtual
	name = "NIF Virtual Machine"
	desc = "You shouldn't be seeing this, if you do, report it to GitHub"

	upgradable = FALSE
	deconstructable = FALSE

	//The actual power is being drained through the NIF.
	base_active_power_usage = 0
	base_idle_power_usage = 0
	max_idle_programs = 1 //It's a virtual machine, not a good one.
	hardware_flag = PROGRAM_TABLET
	looping_sound = FALSE
	comp_light_luminosity = 0
	max_bays = 0
