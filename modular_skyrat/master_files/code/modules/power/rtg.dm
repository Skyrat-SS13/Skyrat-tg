// Radioisotope Thermoelectric Generator (RTG)
// Simple power generator that would replace "magic SMES" on various derelicts.
// The 'ghost' variant is designed for the larger modular ruins that dont deserve a full magical SMES but also struggle to retain power
// These are mostly used when power is not supposed to be a focus of a particular ruin and should remain unprintable in lathes

/obj/machinery/power/rtg/echelon
	desc = "An specifically tailored RTG capable of moderating isotope decay, increasing power output but reducing lifetime. It uses plasma-fueled radiation collectors to increase output even further."
	power_gen = 2500 // 5kw at T1 : 20kw at T4
	circuit = /obj/item/circuitboard/machine/rtg/echelon

/obj/item/circuitboard/machine/rtg/echelon
	name = "Echelon RTG"
	build_path = /obj/machinery/power/rtg/echelon
	req_components = list(
		/obj/item/stack/cable_coil = 5,
		/datum/stock_part/capacitor = 1,
		/datum/stock_part/micro_laser = 1,
		/obj/item/stack/sheet/mineral/uranium = 20,
		/obj/item/stack/sheet/mineral/plasma = 10)
