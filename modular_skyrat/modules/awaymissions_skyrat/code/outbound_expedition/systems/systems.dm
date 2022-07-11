#define MAX_HEALTH_REGULAR 100 //Placeholder number

/datum/outbound_ship_system
	/// Name of the system
	var/name = "Generic System"
	/// If this is a subsystem or not
	var/subsystem = FALSE
	/// Health of the system, set on new()
	var/health = 0
	/// Maximum possible health of the system
	var/max_health = MAX_HEALTH_REGULAR

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
	health = clamp(health - amount, 0, max_health)
	if(!health)
		on_fail()
	else if((amount < 0) && count_damage)
		on_damage(amount)

/datum/outbound_ship_system/atmos //iunno if this even needs to be a mechanical system or not
	name = "Atmospherics"

/datum/outbound_ship_system/thrusters
	name = "Thrusters"
	max_health = MAX_HEALTH_REGULAR * 1.5

/datum/outbound_ship_system/sensors
	name = "Sensors"

/datum/outbound_ship_system/power
	name = "Power"

#undef MAX_HEALTH_REGULAR
