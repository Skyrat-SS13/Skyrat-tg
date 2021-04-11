/obj/item/pipe_painter
	name = "pipe painter"
	desc = "Used for coloring pipes, unsurprisingly."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "labeler1"
	inhand_icon_state = "flight"
	item_flags = NOBLUDGEON
	var/paint_color = "grey"

	custom_materials = list(/datum/material/iron=5000, /datum/material/glass=2000)

	//SKYRAT EDIT ADDITION BEGIN
	var/power_cell_use = POWER_CELL_USE_NORMAL


/obj/item/pipe_painter/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/cell, null, power_cell_use)
	//SKYRAT EDIT ADDITION END

/obj/item/pipe_painter/afterattack(atom/A, mob/user, proximity_flag)
	. = ..()
	//Make sure we only paint adjacent items
	if(!proximity_flag)
		return

	if(!istype(A, /obj/machinery/atmospherics/pipe))
		return

	//SKYRAT EDIT ADDITION
	var/datum/component/cell/battery_compartment = GetComponent(/datum/component/cell)
	if(battery_compartment)
		if(!battery_compartment.simple_power_use(user))
			return
	//SKYRAT EDIT END

	var/obj/machinery/atmospherics/pipe/P = A
	if(P.paint(GLOB.pipe_paint_colors[paint_color]))
		playsound(src, 'sound/machines/click.ogg', 50, TRUE)
		user.visible_message("<span class='notice'>[user] paints \the [P] [paint_color].</span>","<span class='notice'>You paint \the [P] [paint_color].</span>")

/obj/item/pipe_painter/attack_self(mob/user)
	paint_color = input("Which colour do you want to use?","Pipe painter") in GLOB.pipe_paint_colors

/obj/item/pipe_painter/examine(mob/user)
	. = ..()
	. += "<span class='notice'>It is set to [paint_color].</span>"
