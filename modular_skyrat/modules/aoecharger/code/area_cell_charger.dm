/obj/machinery/wirelesscharger
	name = "wireless cell charger"
	desc = "An antenna based wireless charging system. It will charge any cells within it's range!"
	icon_state = "cchargerwireless-off"
	icon = 'modular_skyrat/modules/aoecharger/icons/wireless_charger.dmi'
	circuit = /obj/item/circuitboard/machine/wirelesscharger
	idle_power_usage = 5
	active_power_usage = 60
	power_channel = AREA_USAGE_EQUIP
	circuit = null
	pass_flags = PASSTABLE
	use_power = IDLE_POWER_USE
	var/charge_rate = 250
	var/charge_range = 2
	var/max_cells = 4
	var/charging = FALSE
	var/list/charging_cells = list()

/obj/item/circuitboard/machine/wirelesscharger
	name = "Wireless Cell Charger (Machine Board)"
	icon_state = "engineering"
	build_path = /obj/machinery/cell_charger
	req_components = list(/obj/item/stock_parts/capacitor = 5, /obj/item/stock_parts/scanning_module = 1, /obj/item/stock_parts/micro_laser = 5)
	needs_anchored = FALSE

/obj/machinery/wirelesscharger/update_icon_state()
	. = ..()
	if(charging)
		icon_state = "cchargerwireless-on"
	else
		icon_state = "cchargerwireless-off"

/obj/machinery/wirelesscharger/attackby(obj/item/W, mob/user, params)
	if(default_deconstruction_screwdriver(user, icon_state, icon_state, W))
		return
	if(default_deconstruction_crowbar(W))
		return
	if(default_unfasten_wrench(user, W))
		return

/obj/machinery/wirelesscharger/Destroy()
	charging_cells = null
	return ..()

/obj/machinery/wirelesscharger/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!user.can_interact(src))
		return
	if(!anchored || (machine_stat & (BROKEN|NOPOWER)))
		return
	if(charging)
		to_chat(user, "<span class='notice'>You turn [src] off!")
		playsound(src, 'sound/machines/synth_yes.ogg', 50, TRUE, frequency = rand(5120, 8800))
		stop_charging()
	else
		to_chat(user, "<span class='notice'>You turn [src] on!")
		playsound(src, 'sound/machines/synth_no.ogg', 50, TRUE, frequency = rand(5120, 8800))
		start_charging()

/obj/machinery/wirelesscharger/proc/start_charging()
	for(var/obj/item/stock_parts/cell/new_cell in range(2, loc))
		if(charging_cells > max_cells)
			break
		charging_cells += new_cell
		new /obj/effect/temp_visual/cell_charging(new_cell.loc)

/obj/machinery/wirelesscharger/proc/stop_charging()
	charging_cells.Cut()

/obj/machinery/wirelesscharger/examine(mob/user)
	. = ..()
	. += "It has a charging range of [charge_range] and a charging rate of [charge_rate]w."
	for(var/obj/item/stock_parts/cell/charging in charging_cells)
		. += "It is charging [charging]!"

/obj/machinery/wirelesscharger/RefreshParts()
	charge_rate = 250
	charge_range = 2
	for(var/obj/item/stock_parts/capacitor/C in component_parts)
		charge_rate = clamp((charge_rate *= C.rating), 0, 1000)
	for(var/obj/item/stock_parts/scanning_module/S in component_parts)
		charge_range += S.rating

/obj/machinery/wirelesscharger/process(delta_time)
	if(!anchored || (machine_stat & (BROKEN|NOPOWER)))
		return
	if(!charging_cells.len)
		return
	for(var/obj/item/stock_parts/cell/charging in charging_cells)
		if(charging.percent() >= 100)
			continue
		use_power(charge_rate)
		charging.give(charge_rate)
		charging.update_appearance()

/obj/effect/temp_visual/cell_charging
	icon_state = "emppulse"
