/obj/machinery/computer/atmos_control/medbay
	circuit = /obj/item/circuitboard/computer/atmos_control/medbay
	reconnecting = FALSE // this is hardwired to main station chambers

/obj/item/circuitboard/computer/atmos_control/medbay
	name = "Medbay Atmospheric Control"
	build_path = /obj/machinery/computer/atmos_control/medbay

/obj/machinery/air_sensor/medbay

/obj/machinery/computer/atmos_control/medbay/incinerator
	name = "Medbay Incinerator Chamber Control"
	circuit = /obj/item/circuitboard/computer/atmos_control/medbay/incinerator
	atmos_chambers = list(ATMOS_GAS_MONITOR_MEDBAY_INCINERATOR = "Incinerator Chamber")

/obj/item/circuitboard/computer/atmos_control/medbay/incinerator
	name = "Medbay Incinerator Chamber Control"
	build_path = /obj/machinery/computer/atmos_control/medbay/incinerator

/obj/machinery/air_sensor/medbay/incinerator_tank
	name = "incinerator chamber gas sensor"
	chamber_id = ATMOS_GAS_MONITOR_MEDBAY_INCINERATOR
