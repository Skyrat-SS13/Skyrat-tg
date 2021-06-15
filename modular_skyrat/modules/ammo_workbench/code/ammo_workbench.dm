/obj/machinery/ammo_workbench
	name = "Ammunition Workbench"
	desc = "A machine, somewhat akin to a lathe, made specifically for manufacturing ammunition. It has a slot for magazines."
	icon = 'modular_skyrat/modules/ammo_workbench/icons/ammo_workbench.dmi'
	icon_state = "ammobench"
	density = TRUE
	use_power = IDLE_POWER_USE
	circuit = /obj/item/circuitboard/machine/ammo_workbench
	var/busy = FALSE
	var/hacked = FALSE
	var/disabled = FALSE
	var/shocked = FALSE
	var/hack_wire
	var/disable_wire
	var/shock_wire
	var/timer_id
	var/obj/item/ammo_box/magazine/loaded_magazine = null
	var/obj/item/ammo_casing/selected_ammo_type
	var/time_per_round = 20
	var/creation_efficiency = 1.6

/obj/item/circuitboard/machine/ammo_workbench
	name = "Ammunition Workbench (Machine Board)"
	icon_state = "circuit_map"
	build_path = /obj/machinery/ammo_workbench
	req_components = list(
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stock_parts/matter_bin = 2,
		/obj/item/stock_parts/micro_laser = 2
		)

/obj/machinery/ammo_workbench/Initialize()
	AddComponent(/datum/component/material_container, SSmaterials.materials_by_category[MAT_CATEGORY_ITEM_MATERIAL], 0, MATCONTAINER_EXAMINE, allowed_items = /obj/item/stack, _after_insert = CALLBACK(src, .proc/AfterMaterialInsert))
	. = ..()
	wires = new /datum/wires/ammo_workbench(src)

/obj/machinery/ammo_workbench/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AmmoWorkbench")
	ui.open()

	if(shocked)
		shock(user, 80)

/obj/machinery/ammo_workbench/ui_data(mob/user)
	var/list/data = list()

	data["mag_loaded"] = FALSE
	data["error"] = null
	data["system_busy"] = busy

	data["materials"] = list()
	var/datum/component/material_container/mat_container = GetComponent(/datum/component/material_container)
	if (mat_container)
		for(var/mat in mat_container.materials)
			var/datum/material/M = mat
			var/amount = mat_container.materials[M]
			var/sheet_amount = amount / MINERAL_MATERIAL_AMOUNT
			var/ref = REF(M)
			data["materials"] += list(list("name" = M.name, "id" = ref, "amount" = sheet_amount))

	if(!loaded_magazine)
		data["error"] = "NO MAGAZINE IS INSERTED"
		return data
	else
		data["mag_loaded"] = TRUE

	if(busy)
		data["error"] = "SYSTEM IS BUSY"
		return data

	if(loaded_magazine.stored_ammo.len >= loaded_magazine.max_ammo)
		data["error"] = "MAGAZINE IS FULL"
		return data

	data["available_rounds"] = list()
	var/obj/item/ammo_casing/ammo_type = loaded_magazine.ammo_type

	if(hacked) //Hacking me gets you all the bullet types!
		var/list/round_types = typesof(ammo_type)
		for(var/casing as anything in round_types)
			var/obj/item/ammo_casing/our_casing = casing
			data["available_rounds"] += list(list(
				"name" = initial(our_casing.name),
				"typepath" = our_casing
			))
	else
		data["available_rounds"] += list(list(
			"name" = initial(ammo_type.name),
			"typepath" = initial(loaded_magazine.ammo_type)
		))

	data["mag_name"] = loaded_magazine.name
	data["caliber"] = initial(ammo_type.caliber)
	data["current_rounds"] = loaded_magazine.stored_ammo.len
	data["max_rounds"] = loaded_magazine.max_ammo
	data["efficiency"] = creation_efficiency
	data["time"] = time_per_round / 10
	data["mag_loaded"] = TRUE
	data["hacked"] = hacked

	return data

/obj/machinery/ammo_workbench/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("EjectMag")
			ejectItem()
			. = TRUE

		if("FillMagazine")
			var/type_to_pass = text2path(params["selected_type"])
			fill_magazine_start(type_to_pass)
			. = TRUE

		if("Release")

			var/datum/component/material_container/mat_container = GetComponent(/datum/component/material_container)

			if(!mat_container)
				return
			var/datum/material/mat = locate(params["id"])

			var/amount = mat_container.materials[mat]
			if(!amount)
				return

			var/stored_amount = CEILING(amount / MINERAL_MATERIAL_AMOUNT, 0.1)

			if(!stored_amount)
				return

			var/desired = 0
			if (params["sheets"])
				desired = text2num(params["sheets"])

			var/sheets_to_remove = round(min(desired,50,stored_amount))

			mat_container.retrieve_sheets(sheets_to_remove, mat, loc)
			. = TRUE

/obj/machinery/ammo_workbench/proc/ejectItem()
	if(loaded_magazine)
		loaded_magazine.forceMove(drop_location())
		loaded_magazine = null
	busy = FALSE
	if(timer_id)
		deltimer(timer_id)
		timer_id = null
	update_appearance()

/obj/machinery/ammo_workbench/proc/fill_magazine_start(casing_type)
	if(machine_stat & (NOPOWER|BROKEN))
		busy = FALSE
		if(timer_id)
			deltimer(timer_id)
			timer_id = null
		return

	var/list/allowed_types = typecacheof(loaded_magazine.ammo_type)

	if(!(casing_type in allowed_types))
		return

	if(!loaded_magazine)
		return

	if(loaded_magazine.stored_ammo.len >= loaded_magazine.max_ammo)
		return

	if(busy)
		return

	busy = TRUE

	timer_id = addtimer(CALLBACK(src, .proc/fill_round, casing_type), time_per_round, TIMER_STOPPABLE)

/obj/machinery/ammo_workbench/proc/fill_round(casing_type)
	if(machine_stat & (NOPOWER|BROKEN))
		busy = FALSE
		if(timer_id)
			deltimer(timer_id)
			timer_id = null
		return

	if(!loaded_magazine)
		return

	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)

	var/obj/item/ammo_casing/new_casing = new casing_type

	var/list/required_materials = new_casing.get_material_composition()

	if(materials.has_materials(required_materials) && loaded_magazine.stored_ammo.len < loaded_magazine.max_ammo && istype(new_casing, loaded_magazine.ammo_type))
		materials.use_materials(required_materials)
		loaded_magazine.give_round(new_casing)
		loaded_magazine.update_appearance()
		flick("ammobench_process", src)
		use_power(3000)
		playsound(loc, 'sound/machines/piston_raise.ogg', 60, 1)
	else
		qdel(new_casing)
		ammo_fill_finish(FALSE)
		return

	updateDialog()

	timer_id = addtimer(CALLBACK(src, .proc/fill_round, casing_type), time_per_round, TIMER_STOPPABLE)

/obj/machinery/ammo_workbench/proc/ammo_fill_finish(successfully = TRUE)
	updateDialog()
	if(successfully)
		playsound(loc, 'sound/machines/ping.ogg', 40, TRUE)
	else
		playsound(loc, 'sound/machines/buzz-sigh.ogg', 40, TRUE)
	update_appearance()
	busy = FALSE
	if(timer_id)
		deltimer(timer_id)
		timer_id = null

//MISC MACHINE PROCS

/obj/machinery/ammo_workbench/RefreshParts()
	var/time_efficiency = 20
	for(var/obj/item/stock_parts/micro_laser/new_laser in component_parts)
		time_efficiency -= new_laser.rating / 10
	time_per_round = time_efficiency

	var/efficiency = 1.8
	for(var/obj/item/stock_parts/manipulator/new_manipulator in component_parts)
		efficiency -= new_manipulator.rating * 0.2
	creation_efficiency = max(1,efficiency) // creation_efficiency goes 1.6 -> 1.4 -> 1.2 -> 1 per level of manipulator efficiency

	var/mat_capacity = 0
	for(var/obj/item/stock_parts/matter_bin/new_matter_bin in component_parts)
		mat_capacity += new_matter_bin.rating * 75000
	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	materials.max_amount = mat_capacity

/obj/machinery/ammo_workbench/update_overlays()
	. = ..()
	if(loaded_magazine)
		. += "ammobench_loaded"

/obj/machinery/ammo_workbench/proc/AfterMaterialInsert(obj/item/item_inserted, id_inserted, amount_inserted)
	if(istype(item_inserted, /obj/item/stack/ore/bluespace_crystal))
		use_power(MINERAL_MATERIAL_AMOUNT / 10)
	else if(item_inserted.has_material_type(/datum/material/glass))
		flick("autolathe_r", src)//plays glass insertion animation by default otherwise
	else
		flick("autolathe_o", src)//plays metal insertion animation

		use_power(min(1000, amount_inserted / 100))
	updateUsrDialog()

/obj/machinery/ammo_workbench/Destroy()
	QDEL_NULL(wires)
	return ..()

/obj/machinery/ammo_workbench/proc/shock(mob/user, prb)
	if(machine_stat & (BROKEN|NOPOWER)) // unpowered, no shock
		return FALSE
	if(!prob(prb))
		return FALSE
	do_sparks(5, TRUE, src)
	if (electrocute_mob(user, get_area(src), src, 0.7, TRUE))
		return TRUE
	else
		return FALSE

/obj/machinery/ammo_workbench/attackby(obj/item/O, mob/user, params)
	if (default_deconstruction_screwdriver(user, "[initial(icon_state)]_t", initial(icon_state), O))
		return
	if(default_deconstruction_crowbar(O))
		return
	if(panel_open && is_wire_tool(O))
		wires.interact(user)
		return TRUE
	if(is_refillable() && O.is_drainable())
		return FALSE //inserting reagents into the machine
	if(Insert_Item(O, user))
		return TRUE
	else
		return ..()

/obj/machinery/ammo_workbench/on_deconstruction()
	if(loaded_magazine)
		loaded_magazine.forceMove(loc)
	..()

/obj/machinery/ammo_workbench/Destroy()
	if(timer_id)
		deltimer(timer_id)
		timer_id = null
	. = ..()

/obj/machinery/ammo_workbench/proc/Insert_Item(obj/item/O, mob/living/user)
	if(user.combat_mode)
		return FALSE
	if(!is_insertion_ready(user))
		return FALSE
	if(!istype(O, /obj/item/ammo_box/magazine))
		return FALSE
	if(!user.transferItemToLoc(O, src))
		return FALSE
	loaded_magazine = O
	to_chat(user, "<span class='notice'>You insert [O] to into [src]'s reciprocal.</span>")
	flick("h_lathe_load", src)
	update_appearance()
	playsound(loc, 'sound/weapons/autoguninsert.ogg', 35, 1)

/obj/machinery/ammo_workbench/proc/is_insertion_ready(mob/user)
	if(panel_open)
		to_chat(user, "<span class='warning'>You can't load [src] while it's opened!</span>")
		return FALSE
	if(disabled)
		to_chat(user, "<span class='warning'>The insertion belts of [src] won't engage!</span>")
		return FALSE
	if(busy)
		to_chat(user, "<span class='warning'>[src] is busy right now.</span>")
		return FALSE
	if(machine_stat & BROKEN)
		to_chat(user, "<span class='warning'>[src] is broken.</span>")
		return FALSE
	if(machine_stat & NOPOWER)
		to_chat(user, "<span class='warning'>[src] has no power.</span>")
		return FALSE
	if(loaded_magazine)
		to_chat(user, "<span class='warning'>[src] is already loaded.</span>")
		return FALSE
	return TRUE

/obj/machinery/ammo_workbench/proc/materials_printout()
	var/datum/component/material_container/materials = GetComponent(/datum/component/material_container)
	var/dat = "<b>Total amount:</b> [materials.total_amount] / [materials.max_amount] cm<sup>3</sup><br>"
	for(var/mat_id in materials.materials)
		var/datum/material/M = mat_id
		var/mineral_amount = materials.materials[mat_id]
		if(mineral_amount > 0)
			dat += "<b>[M.name] amount:</b> [mineral_amount] cm<sup>3</sup><br>"
	return dat

/obj/machinery/ammo_workbench/proc/reset(wire)
	switch(wire)
		if(WIRE_HACK)
			if(!wires.is_cut(wire))
				adjust_hacked(FALSE)
		if(WIRE_SHOCK)
			if(!wires.is_cut(wire))
				shocked = FALSE
		if(WIRE_DISABLE)
			if(!wires.is_cut(wire))
				disabled = FALSE

/obj/machinery/ammo_workbench/proc/adjust_hacked(state)
	hacked = state


// WIRE DATUM
/datum/wires/ammo_workbench
	holder_type = /obj/machinery/ammo_workbench
	proper_name = "Ammunitions Workbench"

/datum/wires/ammo_workbench/New(atom/holder)
	wires = list(
		WIRE_HACK, WIRE_DISABLE,
		WIRE_SHOCK, WIRE_ZAP
	)
	add_duds(6)
	..()

/datum/wires/ammo_workbench/interactable(mob/user)
	if(!..())
		return FALSE
	var/obj/machinery/ammo_workbench/A = holder
	if(A.panel_open)
		return TRUE

/datum/wires/ammo_workbench/get_status()
	var/obj/machinery/ammo_workbench/A = holder
	var/list/status = list()
	status += "The red light is [A.disabled ? "on" : "off"]."
	status += "The blue light is [A.hacked ? "on" : "off"]."
	return status

/datum/wires/ammo_workbench/on_pulse(wire)
	var/obj/machinery/ammo_workbench/A = holder
	switch(wire)
		if(WIRE_HACK)
			A.adjust_hacked(!A.hacked)
			addtimer(CALLBACK(A, /obj/machinery/ammo_workbench.proc/reset, wire), 60)
		if(WIRE_SHOCK)
			A.shocked = !A.shocked
			addtimer(CALLBACK(A, /obj/machinery/ammo_workbench.proc/reset, wire), 60)
		if(WIRE_DISABLE)
			A.disabled = !A.disabled
			addtimer(CALLBACK(A, /obj/machinery/ammo_workbench.proc/reset, wire), 60)

/datum/wires/ammo_workbench/on_cut(wire, mend)
	var/obj/machinery/ammo_workbench/A = holder
	switch(wire)
		if(WIRE_HACK)
			A.adjust_hacked(!mend)
		if(WIRE_HACK)
			A.shocked = !mend
		if(WIRE_DISABLE)
			A.disabled = !mend
		if(WIRE_ZAP)
			A.shock(usr, 50)
