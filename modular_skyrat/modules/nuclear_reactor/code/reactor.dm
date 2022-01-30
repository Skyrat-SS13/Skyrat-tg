/*
	Experimental boiling water reactor
	This reactor utilises plumbing and atmoshperics to run an internal pressure vessel which generates heat and steam which is transferred into a turbine.

	Reactor layout
	* = fuel rod
	- = control rod

	* - *
	- * -
	* - *
*/


/obj/machinery/reactor
	name = "Micron Control Systems GA37W Reactor"
	desc = "A massive experimental boiling water reactor made by Micron Control Systems."
	icon = 'modular_skyrat/modules/nuclear_reactor/icons/reactor96x96.dmi'
	icon_state = "idle"
	bound_x = 96
	bound_y = 96

	/// Is the reactor cover open?
	var/cover_open = FALSE
	/// The last calculated power output of the reactor.
	var/calculated_power = 0
	/// The current heat of the reactor vessel
	var/core_heat = 0
	/// The core pressure of the reactor vessel
	var/core_pressure = 0
	/// The integrity of the internal reactor core, once this reaches 0, the reactor will explode
	var/vessel_integrity = 0
	/// References to currently installed fuel rods.
	var/list/fuel_rods = list()
	/// References to currently installed control rods.
	var/list/control_rods = list()
	/// What insertion percent do we want the control rods to be at?
	var/desired_control_rod_insertion = 0
	/// The currently installed moderator.
	var/obj/item/reactor_moderator


/obj/machinery/reactor/process()
	// First off, we calculate the current power out put of the combined fuel rods.
	calculated_power = calculate_power()

	// Control rods do not move instantly, they take time to move.
	move_control_rods()

	// Next, we process the reaction using our caclulated values.
	process_reaction()

/obj/machinery/reactor/proc/move_control_rods()
	for(var/obj/item/reactor_control_rod/control_rod in control_rods)
		control_rod.insertion_amount = desired_control_rod_insertion


/obj/machinery/reactor/proc/calculate_power()
	var/power = 0
	// Overall reactor power is the sum of the power of all the fuel rods.
	for(var/obj/item/reactor_fuel_rod/fuel_rod in fuel_rods)
		power += fuel_rod.radioactivity
	return power

/obj/machinery/reactor/proc/process_reaction()




/obj/structure/reactor_steam_duct
	name = "steam duct"
	desc = "A large duct for transporting steam from and to a GA37W reactor."
	icon = 'modular_skyrat/modules/nuclear_reactor/icons/reactor32x32.dmi'
	icon_state = "steam_duct"

/obj/item/reactor_control_rod
	name = "boron control rod"
	desc = "A control rod for a GA37W reactor. It is made of boron."
	icon = 'modular_skyrat/modules/nuclear_reactor/icons/reactor32x32.dmi'
	icon_state = "control_rod"

	/// How degraded is this control rod? Only degrades if the temperature exceeds the safe operating temperature.
	var/degridation = 0
	/// How much degridation can we take before we become useless?
	var/max_degridation = 100
	/// Our maximum safe heat rating in Kelvin.
	var/heat_rating = 600
	/// If we are inside a reactor, how deep are we?
	var/insertion_percent = 0
	/// How quickly does this control rod insert.
	var/insertion_rate = 1
	/// How efficent are we at controlling a reaction?
	var/efficency = 0.5

/obj/item/reactor_control_rod/proc/degrade(heat_amount)
	if(heat_amount < heat_rating)
		return

	if(efficency <= 0) //Effectively dead.
		return

	degridation += (0.001 * heat_amount)

	if(degridation >= max_degridation)
		final_degrade()

/obj/item/reactor_control_rod/proc/final_degrade()
	efficency = 0

/obj/item/reactor_fuel_rod //Uranium is the standard fuel for the GA37W reactor.
	name = "uranium-235 reactor fuel rod"
	desc = "A fuel rod for the GA37W reactor. It is contains uranium-235."
	icon = 'modular_skyrat/modules/nuclear_reactor/icons/reactor32x32.dmi'
	icon_state = "fuel_rod"
	/// The name of the fuel type.
	var/fuel_name = "uranium-235"
	/// The overlay icon we will add to the fuel rod once inserted.
	var/fuel_overlay_icon = "overlay_uranium"
	/// How radioactive the fuel is - Used to calculate the reactor's power output.
	var/radioactivity = 20
	/// How degraded the fuel is
	var/depletion = 0
	/// The depletion where depletion_final() will be called (and does something)
	var/depletion_threshold = 100
	/// Are we depleted?
	var/depleted = FALSE
	/// How many ticks does it take for the fuel to reach half power.
	var/half_life = 2000
	/// How fast do we deplete
	var/depletion_speed_modifier = 1

/obj/item/reactor_fuel_rod/update_overlays()
	. = ..()
	if(fuel_overlay_icon)
		. += fuel_overlay_icon
	else
		. += "overlay_depleted"

/// Called when it is inside a reactor, by the process.
/obj/item/reactor_fuel_rod/proc/deplete(amount)
	depletion += amount * depletion_speed_modifier
	if(depletion >= depletion_threshold && !depleted)
		depletion_final()

/obj/item/reactor_fuel_rod/proc/depletion_final()


/obj/item/reactor_fuel_rod/plutonium
	name = "plutonium-239 reactor fuel rod"
	desc = "A fuel rod for the GA37W reactor. It is contains plutonium-239."
	fuel_name = "plutonium-239"
	fuel_overlay_icon = "overlay_plutonium"
	radioactivity = 40

/obj/item/reactor_fuel_rod/mox
	name = "mox-54 reactor fuel rod"
	desc = "A fuel rod for the GA37W reactor. It is contains mox-54."
	fuel_name = "mox-54"
	fuel_overlay_icon = "overlay_mox"
	radioactivity = 60

/obj/item/reactor_moderator
	name = "graphite reactor moderator block"
	desc = "A graphite moderator block for the GA37W reactor."
	/// How good is the moderator at slowing neutrons down?
	var/moderator_efficency = 10
