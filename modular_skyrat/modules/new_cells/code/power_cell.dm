/obj/item/stock_parts/cell/crank
	name = "crank cell"
	desc = "Go ahead, wind it up to charge it."
	icon = 'modular_skyrat/modules/new_cells/icons/power.dmi'
	icon_state = "crankcell"
	COOLDOWN_DECLARE(discharge_cooldown)

/obj/item/stock_parts/cell/crank/examine(mob/user)
	. = ..()
	. += span_notice("ALT-CLICK to start cranking the cell.")

/obj/item/stock_parts/cell/crank/Initialize(mapload, override_maxcharge)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/stock_parts/cell/crank/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/stock_parts/cell/crank/process(delta_time)
	if(!COOLDOWN_FINISHED(src, discharge_cooldown))
		return
	COOLDOWN_START(src, discharge_cooldown, 2 SECONDS)
	use(10)

/obj/item/stock_parts/cell/crank/AltClick(mob/user)
	if(!ismob(loc))
		return ..()
	while(charge < maxcharge)
		if(!do_after(user, 1 SECONDS, src))
			return
		give(100)

/obj/item/stock_parts/cell/auto_charge
	name = "charging cell"
	desc = "A special cell that will recharge itself over time."
	icon = 'modular_skyrat/modules/new_cells/icons/power.dmi'
	icon_state = "chargecell"
	maxcharge = 2500
	COOLDOWN_DECLARE(recharge_cooldown)

/obj/item/stock_parts/cell/auto_charge/Initialize(mapload, override_maxcharge)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/stock_parts/cell/auto_charge/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/stock_parts/cell/auto_charge/process(delta_time)
	if(!COOLDOWN_FINISHED(src, recharge_cooldown))
		return
	COOLDOWN_START(src, recharge_cooldown, 2 SECONDS)
	give(200)
