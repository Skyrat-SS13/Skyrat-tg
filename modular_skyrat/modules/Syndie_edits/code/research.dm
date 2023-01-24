/datum/controller/subsystem/research
	var/datum/techweb/interdyne/interdyne_tech

/datum/controller/subsystem/research/Initialize()
	. = ..()
	interdyne_tech = new /datum/techweb/interdyne
	return SS_INIT_SUCCESS

/datum/techweb/interdyne
	id = "INTERDYNE"
	organization = "Interdyne Pharmaceuticals"
	should_generate_points = TRUE

/obj/item/circuitboard/machine/rdserver/interdyne
	build_path = /obj/machinery/rnd/server/interdyne

/obj/machinery/rnd/server/interdyne
	stored_research = /datum/techweb/interdyne
	circuit = /obj/item/circuitboard/machine/rdserver/interdyne

/obj/machinery/rnd/server/interdyne/Initialize()
	. = ..()
	connect_techweb(SSresearch.interdyne_tech)
	stored_research.techweb_servers |= src

/obj/item/circuitboard/computer/rdconsole/interdyne
	build_path = /obj/machinery/computer/rdconsole/interdyne

/obj/machinery/computer/rdconsole/interdyne
	circuit = /obj/item/circuitboard/computer/rdconsole/interdyne

/obj/machinery/computer/rdconsole/interdyne/Initialize()
	. = ..()
	stored_research = SSresearch.interdyne_tech
	stored_research.consoles_accessing += src

/obj/machinery/rnd/server/master/interdyne
	stored_research = /datum/techweb/interdyne

/obj/machinery/rnd/server/master/interdyne/Initialize()
	. = ..()
	connect_techweb(SSresearch.interdyne_tech)
	stored_research.techweb_servers |= src

/obj/item/circuitboard/machine/protolathe/offstation/interdyne
	build_path = /obj/machinery/rnd/production/protolathe/offstation/interdyne

/obj/machinery/rnd/production/protolathe/offstation/interdyne
	circuit = /obj/item/circuitboard/machine/protolathe/offstation/interdyne

/obj/machinery/rnd/production/protolathe/offstation/interdyne/Initialize()
	. = ..()
	connect_techweb(SSresearch.interdyne_tech)

/obj/item/circuitboard/machine/circuit_imprinter/offstation/interdyne
	build_path = /obj/machinery/rnd/production/circuit_imprinter/offstation/interdyne

/obj/machinery/rnd/production/circuit_imprinter/offstation/interdyne
	circuit = /obj/item/circuitboard/machine/circuit_imprinter/offstation/interdyne

/obj/machinery/rnd/production/circuit_imprinter/offstation/interdyne/Initialize()
	. = ..()
	connect_techweb(SSresearch.interdyne_tech)

/obj/item/circuitboard/machine/destructive_analyzer/interdyne
	build_path = /obj/machinery/rnd/destructive_analyzer/interdyne

/obj/machinery/rnd/destructive_analyzer/interdyne
	circuit = /obj/item/circuitboard/machine/destructive_analyzer/interdyne

/obj/machinery/rnd/destructive_analyzer/interdyne/Initialize()
	. = ..()
	connect_techweb(SSresearch.interdyne_tech)

/obj/item/circuitboard/computer/rdservercontrol/interdyne
	build_path = /obj/machinery/computer/rdservercontrol/interdyne

/obj/machinery/computer/rdservercontrol/interdyne
	circuit = /obj/item/circuitboard/computer/rdservercontrol/interdyne

/obj/machinery/computer/rdservercontrol/interdyne/Initialize(obj/item/circuitboard/C)
	. = ..()
	stored_research = SSresearch.interdyne_tech
