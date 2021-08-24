/obj/item/pen/retractable
	desc = "It's a retractable pen."
	icon_state = "pen" //for map visibility
	active = FALSE

/obj/item/pen/retractable/blue
	icon_state = "pen_blue"
	colour = "blue"
	color_description = "blue ink"

/obj/item/pen/retractable/red
	icon_state = "pen_red"
	colour = "red"
	color_description = "red ink"

/obj/item/pen/retractable/green
	icon_state = "pen_green"
	colour = "green"
	color_description = "green ink"

/obj/item/pen/retractable/Initialize()
	. = ..()
	desc = "It's a retractable [color_description] pen."
	update_icon()

/obj/item/pen/retractable/attack(atom/A, mob/user, target_zone)
	if(!active)
		toggle()
	..()

/obj/item/pen/retractable/attack_self(mob/user)
	toggle()

/obj/item/pen/retractable/proc/toggle()
	active = !active
	playsound(src, 'modular_skyrat/modules/html_paperwork/sounds/penclick.ogg', 5, 0, -4)
	if(active)
		icon_state = "[initial(icon_state)]"
	else
		icon_state = "[initial(icon_state)]-r"
	update_icon()
