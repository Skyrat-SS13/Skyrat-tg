/obj/item/circuitboard/machine/rodstopper
	name = "Rodstopper (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_SCIENCE
	build_path = /obj/machinery/rodstopper
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stack/sheet/plasteel = 1)

/obj/machinery/rodstopper
	name = "rodstopper"
	icon = 'modular_skyrat/modules/rod-stopper/icons/rodstopper.dmi'
	icon_state = "rodstopper"
	density = TRUE
	use_power = NO_POWER_USE
	circuit = /obj/item/circuitboard/machine/rodstopper
	layer = BELOW_OBJ_LAYER

/obj/machinery/attackby(obj/item/weapon, mob/user, params)
	if(!isidcard(weapon))
		return ..()
	var/obj/item/card/id/idcard = weapon

	if(!(ACCESS_HEADS in idcard.access))
		audible_message(span_warning("INVALID ACCESS"))
		return

	we_are_active = !we_are_active
	audible_message(we_are_active ? span_danger("Automated Singularity Systems: ONLINE") : span_notice("Automated Singularity Systems: OFFLINE"))
	name = we_are_active ? "active [ initial(name) ]" : initial(name)
	icon_state = "[ initial(icon_state) ]-[ we_are_active ? "act" : "off" ]"
	update_icon_state()

/obj/machinery/rodstopper/examine(mob/user)
	. = ..()
	. += span_notice("Uses advanced, and dangerous, technology to collapse immovable rods into a blackhole.")
	. += span_danger("WARNING; THIS TURNS IMMOVABLE RODS INTO A BLACKHOLE. ARE YOU SURE ABOUT THIS? MUST SWIPE HEAD CARD TO ACTIVATE!")
