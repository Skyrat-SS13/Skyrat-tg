/*
MICROFUSION CELL SYSTEM

Microfusion cells are small battery units that house controlled nuclear fusion within, and that fusion is converted into useable energy.

They cannot be charged as standard, and require upgrades to do so.

These are basically advanced cells.
*/

/obj/item/stock_parts/cell/microfusion //Just a standard cell.
	name = "microfusion cell"
	desc = "A compact microfusion cell."
	icon = 'modular_skyrat/modules/microfusion/icons/microfusion_cells.dmi'
	charge_overlay_icon = 'modular_skyrat/modules/microfusion/icons/microfusion_cells.dmi'
	icon_state = "microfusion"
	w_class = WEIGHT_CLASS_NORMAL
	maxcharge = 1200 //12 shots
	chargerate = 0 //Standard microfusion cells can't be recharged, they're single use.

	/// A hard referenced list of upgrades currently attached to the weapon.
	var/list/attached_upgrades = list()
	/// How stable is this, percentage wise?
	var/instability = 0
	/// Are we melting down? For icon stuffs.
	var/meltdown = FALSE
	/// How many upgrades can you have on this cell?
	var/max_attachments = 1
	/// Do we show the microfusion readout instead of KJ?
	microfusion_readout = TRUE
	/// Hard ref to the parent gun.
	var/obj/item/gun/microfusion/parent_gun

/obj/item/stock_parts/cell
	/// Is this cell stabilised? (used in microfusion guns)
	var/stabalised = FALSE
	/// Thanks modularity.
	var/microfusion_readout = FALSE

/obj/item/stock_parts/cell/microfusion/Destroy()
	if(attached_upgrades.len)
		for(var/obj/item/iterating_item in attached_upgrades)
			iterating_item.forceMove(get_turf(src))
		attached_upgrades = null
	parent_gun = null
	return ..()

/obj/item/stock_parts/cell/microfusion/attackby(obj/item/attacking_item, mob/living/user, params)
	if(istype(attacking_item, /obj/item/microfusion_cell_attachment))
		attatch_upgrade(attacking_item, user)
		return
	return ..()

/obj/item/stock_parts/cell/microfusion/use(amount)
	process_instability()
	return ..()

/obj/item/stock_parts/cell/microfusion/proc/process_instability()
	if(prob(instability))
		var/seconds_to_explode = rand(MICROFUSION_CELL_FAILURE_LOWER, MICROFUSION_CELL_FAILURE_UPPER)
		say("Malfunction in [seconds_to_explode / 10] seconds!")
		playsound(src, 'sound/machines/warning-buzzer.ogg', 30, FALSE, FALSE)
		add_filter("rad_glow", 2, list("type" = "outline", "color" = "#ff5e0049", "size" = 2))
		addtimer(CALLBACK(src, .proc/process_failure), seconds_to_explode)

/obj/item/stock_parts/cell/microfusion/proc/process_failure()
	var/fuckup_type = rand(1,4)
	remove_filter("rad_glow")
	playsound(src, 'sound/effects/spray.ogg', 70)
	switch(fuckup_type)
		if(1)
			charge = clamp(charge - MICROFUSION_CELL_DRAIN_FAILURE, 0, maxcharge)
		if(2)
			explode()
		if(3)
			empulse(get_turf(src), 2, 4, FALSE)
		if(4)
			radiation_pulse(src, 1, RAD_MEDIUM_INSULATION)

/obj/item/stock_parts/cell/microfusion/update_overlays()
	. = ..()
	for(var/obj/item/microfusion_cell_attachment/microfusion_cell_attachment in attached_upgrades)
		. += microfusion_cell_attachment.attachment_overlay_icon_state

/obj/item/stock_parts/cell/microfusion/screwdriver_act(mob/living/user, obj/item/tool)
	if(!attached_upgrades.len)
		to_chat(user, span_danger("There are no attachments to remove!"))
		return
	remove_upgrades()
	playsound(src, 'sound/items/screwdriver.ogg', 70, TRUE)
	to_chat(user, span_notice("You remove the upgrades from [src]."))

/obj/item/stock_parts/cell/microfusion/process(delta_time)
	for(var/obj/item/microfusion_cell_attachment/microfusion_cell_attachment in attached_upgrades)
		microfusion_cell_attachment.process_attachment(src, delta_time)

/obj/item/stock_parts/cell/microfusion/examine(mob/user)
	. = ..()
	. += span_notice("It can hold [max_attachments] attachment(s).")
	if(attached_upgrades.len)
		for(var/obj/item/microfusion_cell_attachment/microfusion_cell_attachment in attached_upgrades)
			. += span_notice("It has a [microfusion_cell_attachment.name] installed.")
		. += span_notice("Use a <b>screwdriver</b> to remove the upgrades.")
	if(instability <= 0)
		. += span_notice("The fusion containment field is nominal.")
	else
		. += span_warning("WARNING: Fusion containment field compromised by [instability]%!")

/obj/item/stock_parts/cell/microfusion/proc/attach_upgrade(obj/item/microfusion_cell_attachment/microfusion_cell_attachment, mob/living/user)
	if(attached_upgrades.len >= max_attachments)
		to_chat(user, span_warning("[src] cannot fit any more attachments!"))
		return FALSE
	if(is_type_in_list(microfusion_cell_attachment, attached_upgrades))
		to_chat(user, span_warning("[src] already has [microfusion_cell_attachment] installed!"))
		return FALSE
	attached_upgrades += microfusion_cell_attachment
	microfusion_cell_attachment.forceMove(src)
	microfusion_cell_attachment.run_attachment(src)
	to_chat(user, span_notice("You successfully install [microfusion_cell_attachment] onto [src]!"))
	playsound(src, 'sound/effects/structure_stress/pop2.ogg', 70, TRUE)
	update_appearance()
	return TRUE

/obj/item/stock_parts/cell/microfusion/proc/remove_upgrades()
	for(var/obj/item/microfusion_cell_attachment/microfusion_cell_attachment in attached_upgrades)
		microfusion_cell_attachment.remove_attachment(src)
		microfusion_cell_attachment.forceMove(get_turf(src))
		attached_upgrades -= microfusion_cell_attachment
	update_appearance()

/datum/crafting_recipe/makeshift/microfusion_cell
	name = "Makeshift Microfusion Cell"
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER, TOOL_WELDER)
	result = /obj/item/stock_parts/cell/microfusion/makeshift
	reqs = list(/obj/item/trash/can = 1,
				/obj/item/stack/sheet/iron = 1,
				/obj/item/stack/cable_coil = 1)
	time = 120
	category = CAT_MISC

//WHY WOULD YOU MAKE THIS?
/obj/item/stock_parts/cell/microfusion/makeshift
	name = "makeshift microfusion cell"
	desc = "This can with ducttape resembles a microfusion cell. What the hell were you thinking? A makeshift microfusion battery? Are you out of your mind?!"
	icon_state = "microfusion_makeshift"
	maxcharge = 600
	instability = 20
	max_attachments = 0

/obj/item/stock_parts/cell/microfusion/enhanced
	name = "enhanced microfusion cell"
	desc = "An enhanced microfusion cell."
	icon_state = "microfusion_enhanced"
	maxcharge = 1500

/obj/item/stock_parts/cell/microfusion/advanced
	name = "advanced microfusion cell"
	desc = "An advanced microfusion cell."
	icon_state = "microfusion_advanced"
	maxcharge = 1700
	max_attachments = 3

/obj/item/stock_parts/cell/microfusion/bluespace
	name = "bluespace microfusion cell"
	desc = "An advanced microfusion cell."
	icon_state = "microfusion_bluespace"
	maxcharge = 2000
	max_attachments = 4

