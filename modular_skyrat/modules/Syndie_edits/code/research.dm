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

/datum/techweb/interdyne/New()
	. = ..()
	for(var/i in SSresearch.point_types)
		research_points[i] = 15000

/obj/machinery/rnd/server/interdyne
	stored_research = /datum/techweb/interdyne

/obj/machinery/rnd/server/interdyne/Initialize(mapload)
	. = ..()
	connect_techweb(SSresearch.interdyne_tech)
	stored_research.techweb_servers |= src

/obj/machinery/computer/rdconsole/interdyne/Initialize(mapload)
	. = ..()
	stored_research = SSresearch.interdyne_tech
	stored_research.consoles_accessing += src

/obj/machinery/rnd/server/master/interdyne
	stored_research = /datum/techweb/interdyne

/obj/machinery/rnd/server/master/interdyne/Initialize(mapload)
	. = ..()
	connect_techweb(SSresearch.interdyne_tech)
	stored_research.techweb_servers |= src

/obj/machinery/rnd/production/protolathe/offstation/interdyne/Initialize(mapload)
	. = ..()
	connect_techweb(SSresearch.interdyne_tech)

/obj/machinery/rnd/production/circuit_imprinter/offstation/interdyne/Initialize(mapload)
	. = ..()
	connect_techweb(SSresearch.interdyne_tech)

/obj/machinery/rnd/destructive_analyzer/interdyne/Initialize(mapload)
	. = ..()
	connect_techweb(SSresearch.interdyne_tech)

/obj/machinery/computer/rdservercontrol/interdyne/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	stored_research = SSresearch.interdyne_tech
