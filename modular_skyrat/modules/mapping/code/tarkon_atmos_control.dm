// Port Tarkon Atmos Control

/obj/machinery/computer/atmos_control/tarkon
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon
	reconnecting = FALSE // this is hardwired to main station chambers

/obj/item/circuitboard/computer/atmos_control/tarkon
	name = "Tarkon Atmospheric Control"
	build_path = /obj/machinery/computer/atmos_control/tarkon

/obj/machinery/air_sensor/tarkon

/obj/machinery/computer/atmos_control/tarkon/oxygen_tank
	name = "Tarkon Oxygen Supply Control"
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon/oxygen_tank
	atmos_chambers = list(ATMOS_GAS_MONITOR_TARKON_O2 = "Oxygen Supply")

/obj/item/circuitboard/computer/atmos_control/tarkon/oxygen_tank
	name = "Tarkon Oxygen Supply Control"
	build_path = /obj/machinery/computer/atmos_control/tarkon/oxygen_tank

/obj/machinery/air_sensor/tarkon/oxygen_tank
	name = "oxygen tank gas sensor"
	chamber_id = ATMOS_GAS_MONITOR_TARKON_O2

/obj/machinery/atmospherics/components/unary/outlet_injector/monitored/oxygen_input/tarkon
	chamber_id = ATMOS_GAS_MONITOR_TARKON_O2

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/oxygen_output/tarkon
	chamber_id = ATMOS_GAS_MONITOR_TARKON_O2

/obj/machinery/computer/atmos_control/tarkon/plasma_tank
	name = "Tarkon Plasma Supply Control"
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon/plasma_tank
	atmos_chambers = list(ATMOS_GAS_MONITOR_TARKON_PLAS = "Plasma Supply")

/obj/item/circuitboard/computer/atmos_control/tarkon/plasma_tank
	name = "Tarkon Plasma Supply Control"
	build_path = /obj/machinery/computer/atmos_control/tarkon/plasma_tank

/obj/machinery/air_sensor/tarkon/plasma_tank
	name = "plasma tank gas sensor"
	chamber_id = ATMOS_GAS_MONITOR_TARKON_PLAS

/obj/machinery/atmospherics/components/unary/outlet_injector/monitored/plasma_input/tarkon
	chamber_id = ATMOS_GAS_MONITOR_TARKON_PLAS

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/plasma_output/tarkon
	chamber_id = ATMOS_GAS_MONITOR_TARKON_PLAS

/obj/machinery/computer/atmos_control/tarkon/mix_tank
	name = "Tarkon Mix Chamber Control"
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon/mix_tank
	atmos_chambers = list(ATMOS_GAS_MONITOR_TARKON_MIX = "Mix Chamber")

/obj/item/circuitboard/computer/atmos_control/tarkon/mix_tank
	name = "Tarkon Gas Mix Supply Control"
	build_path = /obj/machinery/computer/atmos_control/tarkon/mix_tank

/obj/machinery/air_sensor/tarkon/mix_tank
	name = "mix tank gas sensor"
	chamber_id = ATMOS_GAS_MONITOR_TARKON_MIX

/obj/machinery/atmospherics/components/unary/outlet_injector/monitored/air_input/tarkon
	chamber_id = ATMOS_GAS_MONITOR_TARKON_MIX

/obj/machinery/atmospherics/components/unary/vent_pump/high_volume/siphon/monitored/air_output/tarkon
	chamber_id = ATMOS_GAS_MONITOR_TARKON_MIX

/obj/machinery/computer/atmos_control/tarkon/nitrogen_tank
	name = "Tarkon Nitrogen Supply Control"
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon/nitrogen_tank
	atmos_chambers = list(ATMOS_GAS_MONITOR_TARKON_N2 = "Nitrogen Supply")

/obj/item/circuitboard/computer/atmos_control/tarkon/nitrogen_tank
	name = "Tarkon Nitrogen Supply Control"
	build_path = /obj/machinery/computer/atmos_control/tarkon/nitrogen_tank

/obj/machinery/air_sensor/tarkon/nitrogen_tank
	name = "nitrogen tank gas sensor"
	chamber_id = ATMOS_GAS_MONITOR_TARKON_N2

/obj/machinery/atmospherics/components/unary/outlet_injector/monitored/nitrogen_input/tarkon
	chamber_id = ATMOS_GAS_MONITOR_TARKON_N2

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/nitrogen_output/tarkon
	chamber_id = ATMOS_GAS_MONITOR_TARKON_N2

/obj/machinery/computer/atmos_control/tarkon/nitrous_tank
	name = "Tarkon Nitrous Oxide Supply Control"
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon/nitrous_tank
	atmos_chambers = list(ATMOS_GAS_MONITOR_TARKON_N2O = "Nitrous Oxide Supply")

/obj/item/circuitboard/computer/atmos_control/tarkon/nitrous_tank
	name = "Tarkon Nitrous Oxide Supply Control"
	build_path = /obj/machinery/computer/atmos_control/tarkon/nitrous_tank

/obj/machinery/air_sensor/tarkon/nitrous_tank
	name = "nitrous oxide tank gas sensor"
	chamber_id = ATMOS_GAS_MONITOR_TARKON_N2O

/obj/machinery/atmospherics/components/unary/outlet_injector/monitored/nitrous_input/tarkon
	chamber_id = ATMOS_GAS_MONITOR_TARKON_N2O

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/nitrous_output/tarkon
	chamber_id = ATMOS_GAS_MONITOR_TARKON_N2O

/obj/machinery/computer/atmos_control/tarkon/carbon_tank
	name = "Tarkon Carbon Dioxide Supply Control"
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon/carbon_tank
	atmos_chambers = list(ATMOS_GAS_MONITOR_TARKON_CO2 = "Carbon Dioxide Supply")

/obj/item/circuitboard/computer/atmos_control/tarkon/carbon_tank
	name = "Tarkon Carbon Dioxide Supply Control"
	build_path = /obj/machinery/computer/atmos_control/tarkon/carbon_tank

/obj/machinery/air_sensor/tarkon/carbon_tank
	name = "carbon dioxide tank gas sensor"
	chamber_id = ATMOS_GAS_MONITOR_TARKON_CO2

/obj/machinery/atmospherics/components/unary/outlet_injector/monitored/carbon_input/tarkon
	chamber_id = ATMOS_GAS_MONITOR_TARKON_CO2

/obj/machinery/atmospherics/components/unary/vent_pump/siphon/monitored/carbon_output/tarkon
	chamber_id = ATMOS_GAS_MONITOR_TARKON_CO2

/obj/machinery/computer/atmos_control/tarkon/incinerator
	name = "Tarkon Incinerator Chamber Control"
	circuit = /obj/item/circuitboard/computer/atmos_control/tarkon/incinerator
	atmos_chambers = list(ATMOS_GAS_MONITOR_TARKON_INCINERATOR = "Incinerator Chamber")

/obj/item/circuitboard/computer/atmos_control/tarkon/incinerator
	name = "Tarkon Incinerator Chamber Control"
	build_path = /obj/machinery/computer/atmos_control/tarkon/incinerator

/obj/machinery/air_sensor/tarkon/incinerator_tank
	name = "incinerator chamber gas sensor"
	chamber_id = ATMOS_GAS_MONITOR_TARKON_INCINERATOR

/obj/machinery/airlock_sensor/incinerator_tarkon
	id_tag = INCINERATOR_TARKON_AIRLOCK_SENSOR
	master_tag = INCINERATOR_TARKON_AIRLOCK_CONTROLLER

/obj/machinery/door/airlock/public/glass/incinerator/tarkon_interior
	name = "Turbine Interior Airlock"
	id_tag = INCINERATOR_TARKON_AIRLOCK_INTERIOR

/obj/machinery/door/airlock/public/glass/incinerator/tarkon_exterior
	name = "Turbine Exterior Airlock"
	id_tag = INCINERATOR_TARKON_AIRLOCK_EXTERIOR

/obj/machinery/airlock_controller/incinerator_tarkon
	name = "Incinerator Access Console"
	airpump_tag = INCINERATOR_TARKON_DP_VENTPUMP
	exterior_door_tag = INCINERATOR_TARKON_AIRLOCK_EXTERIOR
	id_tag = INCINERATOR_TARKON_AIRLOCK_CONTROLLER
	interior_door_tag = INCINERATOR_TARKON_AIRLOCK_INTERIOR
	sanitize_external = TRUE
	sensor_tag = INCINERATOR_TARKON_AIRLOCK_SENSOR

/obj/machinery/atmospherics/components/binary/dp_vent_pump/high_volume/incinerator_tarkon
	id_tag = INCINERATOR_TARKON_DP_VENTPUMP

/obj/machinery/atmospherics/components/unary/outlet_injector/monitored/incinerator_input/tarkon
	chamber_id = ATMOS_GAS_MONITOR_TARKON_INCINERATOR

/obj/machinery/igniter/incinerator_tarkon
	id = INCINERATOR_TARKON_IGNITER

/obj/machinery/button/ignition/incinerator/tarkon
	id = INCINERATOR_TARKON_IGNITER
