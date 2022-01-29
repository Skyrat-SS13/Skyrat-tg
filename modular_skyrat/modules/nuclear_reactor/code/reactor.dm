/obj/machinery/reactor
	name = "Micron Control Systems GA37W Reactor"
	desc = "A massive experimental boiling water reactor made by Micron Control Systems."
	icon = 'modular_skyrat/modules/nuclear_reactor/icons/reactor96x96.dmi'
	icon_state = "idle"
	bound_x = 96
	bound_y = 96

	var/calculated_power = 0
	/// The current heat of the reactor vessel
	var/core_heat = 0
	/// References to currently installed fuel rods.
	var/list/fuel_rods = list()
	/// References to currently installed control rods.
	var/list/control_rods = list()
	/// The currently installed moderator.
	var/obj/item/reactor_moderator

/obj/structure/reactor_steam_duct
	name = "steam duct"
	desc = "A large duct for transporting steam from and to a GA37W reactor."
	icon = 'modular_skyrat/modules/nuclear_reactor/icons/reactor32x32.dmi'
	icon_state = "steam_duct"

/obj/item/reactor_fuel_rod
	name = "empty reactor fuel rod"
	desc = "A fuel rod for the GA37W reactor."
	icon = 'modular_skyrat/modules/nuclear_reactor/icons/reactor32x32.dmi'
	icon_state = "empty_fuel_rod"

	var/datum/reactor_fuel_type/installed_fuel

/obj/item/reactor_fuel_rod/Initialize(mapload)
	. = ..()
	if(installed_fuel)
		install_fuel(installed_fuel)

/obj/item/reactor_fuel_rod/proc/install_fuel(datum/reactor_fuel_type/incoming_reactor_fuel)
	if(installed_fuel)
		return
	installed_fuel = incoming_reactor_fuel
	name = "[incoming_reactor_fuel.fuel_name] fuel rod"
	desc = "A fuel rod for the GA37W reactor. It is filled with [incoming_reactor_fuel.fuel_name]."
	update_overlays()

/obj/item/reactor_fuel_rod/update_overlays()
	. = ..()
	if(installed_fuel)
		. += "[installed_fuel.overlay_icon_state]"

/obj/item/reactor_fuel_rod/uranium
	installed_fuel = /datum/reactor_fuel_type/uranium

/obj/item/reactor_fuel_rod/uranium
	installed_fuel = /datum/reactor_fuel_type/uranium

/obj/item/reactor_fuel_rod/mox
	installed_fuel = /datum/reactor_fuel_type/mox

/datum/reactor_fuel_type
	/// The name of the fuel type.
	var/fuel_name = "error"
	/// The overlay icon we will add to the fuel rod once inserted.
	var/overlay_icon_state = "error"
	/// How radioactive the fuel is - Used to calculate the reactor's power output.
	var/radioactivity = 0
	/// How degraded the fuel is
	var/degridation = 0

/datum/reactor_fuel_type/uranium
	fuel_name = "uranium-235"
	overlay_icon_state = "reactor_fuel_uranium"
	radioactivity = 20

/datum/reactor_fuel_type/plutonium
	fuel_name = "plutonium-239"
	overlay_icon_state = "reactor_fuel_plutonium"
	radioactivity = 40

/datum/reactor_fuel_type/mox
	fuel_name = "mox-54"
	overlay_icon_state = "reactor_fuel_mox"
	radioactivity = 60

/obj/item/reactor_moderator
	name = "graphite reactor moderator block"
	desc = "A graphite moderator block for the GA37W reactor."
	/// How good is the moderator at slowing neutrons down?
	var/moderator_efficency = 10
