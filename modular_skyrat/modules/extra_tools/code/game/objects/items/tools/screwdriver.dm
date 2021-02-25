/obj/item/screwdriver/power/green
	icon = 'modular_skyrat/modules/extra_tools/icons/obj/tools.dmi'
	icon_state = "gdrill_screw"
	inhand_icon_state = "drill"
	worn_icon_state = "drill"
	lefthand_file = 'modular_skyrat/modules/extra_tools/icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/extra_tools/icons/mob/inhands/equipment/tools_righthand.dmi'

/* /obj/item/screwdriver/power/green/get_belt_overlay() //That one doesn't work for some odd reason.
	return mutable_appearance('modular_skyrat/modules/extra_tools/icons/obj/clothing/belt_overlays.dmi', "green_drill") */

/obj/item/screwdriver/power/green/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_drill.ogg', 50, TRUE)
	if(tool_behaviour == TOOL_SCREWDRIVER)
		tool_behaviour = TOOL_WRENCH
		to_chat(user, "<span class='notice'>You attach the bolt bit to [src].</span>")
		icon_state = "gdrill_bolt"
	else
		tool_behaviour = TOOL_SCREWDRIVER
		to_chat(user, "<span class='notice'>You attach the screw bit to [src].</span>")
		icon_state = "gdrill_screw"
