/obj/machinery/computer/market_link
	name = "Nanotrasen Market Link"
	desc = "A console used for selling items to the space market."
	icon_screen = "comm"
	icon_keyboard = "tech_key"
	req_access = list(ACCESS_CENT_CAPTAIN)
	circuit = /obj/item/circuitboard/computer/market_link
	light_color = LIGHT_COLOR_BLUE

	/// radio used by the console to send messages on supply channel
	var/obj/item/radio/headset/radio

	var/list/bay_items = list()
	var/list/possible_areas = list()

	//Export categories for this run, this is set by console sending the shuttle.
	var/export_categories = EXPORT_CARGO

/obj/machinery/computer/market_link/Initialize()
	. = ..()
	radio = new /obj/item/radio/headset/headset_cargo(src)
	for(var/area/centcom/ncvtitan/export_bay/iterating_export_bay in world)
		possible_areas += iterating_export_bay

/obj/item/circuitboard/computer/market_link
	name = "Market Link (Computer Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/market_link

/obj/machinery/computer/market_link/ui_interact(mob/user)
	var/list/dat = list("<b>Nanotrasen Market Link</b>")
	var/manual_operation = SSshuttle.supply.manual_operation
	if(manual_operation)
		dat += "<a href='byond://?src=[REF(src)];function=scan'>Scan Loading Area</a>"
		dat += "CARGO SELLING AREA:"
		if(bay_items.len)
			dat += "<select name='requested_items' size='number_of_options' multiple='multiple'>"
			for(var/atom/iterating_atom in bay_items)
				dat += "<option value='[iterating_atom.name]'>[iterating_atom.name]</option>"
			dat += "</select>"
			dat += "<a href='byond://?src=[REF(src)];function=sell'>EXPORT ITEMS</a>"
		else
			dat += "NOTHING"
	else
		dat += "MANUAL SHUTTLE OPERATION IS REQUIRED TO USE THIS TERMINAL."


	var/datum/browser/popup = new(user, "export_console","Export Console", 600, 800, src)
	popup.set_content(dat.Join("<br>"))
	popup.open()
	onclose(user, "export_console")

/obj/machinery/computer/market_link/Topic(href, href_list)
	if(..())
		return

	if(machine_stat & (NOPOWER|BROKEN|MAINT))
		return

	usr.set_machine(src)

	var/function = href_list["function"]

	if(href_list["close"])
		usr << browse(null, "window=export_console")
		return

	switch(function)
		if("scan")
			if(!SSshuttle.supply.manual_operation)
				say("Manual shuttle operation required.")
				return
			bay_items.Cut()
			for(var/place in possible_areas)
				var/area/centcom/ncvtitan/export_bay/exporting_bay = place
				for(var/atom/movable/moveable_atom in exporting_bay)
					bay_items += moveable_atom

			say("Area scanned.")
		if("sell")
			if(!SSshuttle.supply.manual_operation)
				say("Manual shuttle operation required.")
				return
			sell()
			say("Export complete.")
			radio.talk_into(src, "NCV Titan has exported your recieved items and credited you accordingly.", RADIO_CHANNEL_SUPPLY)
	updateUsrDialog()

/obj/machinery/computer/market_link/proc/sell()
	var/datum/bank_account/D = SSeconomy.get_dep_account(ACCOUNT_CAR)
	var/presale_points = D.account_balance

	if(!GLOB.exports_list.len) // No exports list? Generate it!
		setupExports()

	var/msg = ""

	var/datum/export_report/ex = new
	for(var/place in possible_areas)
		var/area/centcom/ncvtitan/export_bay/exporting_bay = place
		for(var/atom/movable/AM in exporting_bay)
			if(isliving(AM))
				say("Biological material detected in export area. Halting.")
				return
			if(iscameramob(AM))
				continue
			if(!AM.anchored || istype(AM, /obj/vehicle/sealed/mecha))
				bay_items -= AM
				export_item_and_contents(AM, export_categories , dry_run = FALSE, external_report = ex)

	if(ex.exported_atoms)
		ex.exported_atoms += "." //ugh

	for(var/datum/export/E in ex.total_amount)
		var/export_text = E.total_printout(ex)
		if(!export_text)
			continue

		msg += export_text + "\n"
		D.adjust_money(ex.total_value[E])

	SSeconomy.export_total += (D.account_balance - presale_points)
	SSshuttle.centcom_message = msg
	investigate_log("Shuttle contents sold for [D.account_balance - presale_points] credits. Contents: [ex.exported_atoms ? ex.exported_atoms.Join(",") + "." : "none."] Message: [SSshuttle.centcom_message || "none."]", INVESTIGATE_CARGO)
