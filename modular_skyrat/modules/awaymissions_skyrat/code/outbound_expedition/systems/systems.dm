#define MAX_HEALTH_REGULAR 100 //Placeholder number

GLOBAL_LIST_EMPTY(outbound_ship_systems)

/datum/outbound_ship_system
	/// Name of the system
	var/name = "Generic System"
	/// If this is a subsystem or not
	var/subsystem = FALSE
	/// Health of the system, set on new()
	var/health = 0
	/// Maximum possible health of the system
	var/max_health = MAX_HEALTH_REGULAR
	/// The typepath of the corresponding machine that this works with
	var/machine_type

/datum/outbound_ship_system/New()
	. = ..()
	health = max_health

/// Called whenever the system takes damage to adjust effects accordingly if any
/datum/outbound_ship_system/proc/on_damage(damage_amount)
	return

/// Called when the system hits 0% integrity and completely fails
/datum/outbound_ship_system/proc/on_fail()
	return

/datum/outbound_ship_system/proc/adjust_health(amount, count_damage = TRUE)
	health = round(clamp(health + amount, 0, max_health))
	if(!health)
		on_fail()
	else if((amount < 0) && count_damage)
		on_damage(amount)

/datum/outbound_ship_system/atmos //iunno if this even needs to be a mechanical system or not
	name = "Atmospherics"

/datum/outbound_ship_system/thrusters
	name = "Thrusters"
	max_health = MAX_HEALTH_REGULAR * 1.5
	machine_type = /obj/machinery/outbound_expedition/shuttle_thruster_controller

/obj/machinery/outbound_expedition/shuttle_thruster_controller
	name = "thruster control system"
	desc = "A system that manages the power and fuel distribution of on-shuttle thrusters."
	icon = 'icons/obj/power.dmi'
	icon_state = "smes"

/obj/machinery/outbound_expedition/shuttle_thruster_controller/Initialize(mapload)
	. = ..()
	GLOB.outbound_ship_systems += src

/obj/machinery/outbound_expedition/shuttle_thruster_controller/Destroy()
	GLOB.outbound_ship_systems -= src
	return ..()

/datum/outbound_ship_system/sensors
	name = "Sensors"
	machine_type = /obj/machinery/outbound_expedition/shuttle_sensor_system

/obj/machinery/outbound_expedition/shuttle_sensor_system
	name = "electronic intelligence blister"
	desc = "A weathered radar system that's used to detect far-off energy sources."
	icon = 'icons/mob/hivebot.dmi'
	icon_state = "def_radar"

/obj/machinery/outbound_expedition/shuttle_sensor_system/Initialize(mapload)
	. = ..()
	GLOB.outbound_ship_systems += src

/obj/machinery/outbound_expedition/shuttle_sensor_system/Destroy()
	GLOB.outbound_ship_systems -= src
	return ..()

/datum/outbound_ship_system/power
	name = "Power"
	machine_type = /obj/machinery/power/smes/vanguard

/obj/machinery/power/smes/vanguard
	name = "power controller"
	desc = "A deep-storage superconducting magnetic energy storage (SMES) unit, built to passively harvest power from space radiation."
	circuit = null

/obj/machinery/power/smes/vanguard/Initialize(mapload)
	. = ..()
	GLOB.outbound_ship_systems += src

/obj/machinery/power/smes/vanguard/Destroy()
	GLOB.outbound_ship_systems -= src
	return ..()

/obj/machinery/power/smes/vanguard/process()
	..()
	OUTBOUND_CONTROLLER
	if(!outbound_controller)
		return
	var/datum/outbound_ship_system/our_system = outbound_controller.machine_datums[src]
	if(our_system.health <= 0)
		capacity = 0 //suffer
		charge = 0
	else
		capacity = INFINITY
		charge = INFINITY

/obj/machinery/power/smes/vanguard/default_deconstruction_crowbar(obj/item/crowbar/C)
	to_chat(C.loc, span_notice("You can't seem to disassemble this!"))

#undef MAX_HEALTH_REGULAR
