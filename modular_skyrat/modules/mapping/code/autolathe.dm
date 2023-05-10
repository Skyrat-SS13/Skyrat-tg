/obj/machinery/autolathe/ghost_cafe
	name = "ancient autolathe"
	hacked = TRUE
	circuit = /obj/item/circuitboard/machine/autolathe/ghost_cafe

/obj/machinery/autolathe/ghost_cafe/Initialize(mapload)
	. = ..()
	if(!GLOB.autounlock_techwebs[/datum/techweb/autounlocking/autolathe/ghost_cafe])
		GLOB.autounlock_techwebs[/datum/techweb/autounlocking/autolathe/ghost_cafe] = new /datum/techweb/autounlocking/autolathe/ghost_cafe
	stored_research = GLOB.autounlock_techwebs[/datum/techweb/autounlocking/autolathe/ghost_cafe]

/obj/item/circuitboard/machine/autolathe/ghost_cafe
	name = "Ancient Autolathe"
	build_path = /obj/machinery/autolathe/ghost_cafe

/datum/techweb/autounlocking/autolathe/ghost_cafe/New()
	. = ..()
	remove_design_by_id("radio_headset")
	remove_design_by_id("bounced_radio")
