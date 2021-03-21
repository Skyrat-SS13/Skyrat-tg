/datum/action/item_action/toggle_safety
	name = "Toggle Safety"
	icon_icon = 'modular_skyrat/modules/gunsafety/icons/hud/actions.dmi'
	button_icon_state = "safety_on"

/obj/item/gun/proc/toggle_safety(mob/user, override)
	if(!has_gun_safety)
		return
	if(override)
		if(override == "off")
			safety = FALSE
		else
			safety = TRUE
	else
		safety = !safety
	tsafety.button_icon_state = "safety_[safety ? "on" : "off"]"
	tsafety.UpdateButtonIcon()
	playsound(src, 'sound/weapons/empty.ogg', 100, TRUE)
	user.visible_message("<span class='notice'>[user] toggles [src]'s safety [safety ? "<font color='#00ff15'>ON</font>" : "<font color='#ff0000'>OFF</font>"].",
	"<span class='notice'>You toggle [src]'s safety [safety ? "<font color='#00ff15'>ON</font>" : "<font color='#ff0000'>OFF</font>"].</span>")

/obj/item/gun/examine(mob/user)
	. = ..()
	. += "<span>The safety is [safety ? "<font color='#00ff15'>ON</font>" : "<font color='#ff0000'>OFF</font>"].</span>"

/obj/item/gun/ballistic
	has_gun_safety = TRUE

/obj/item/gun/ballistic/bow
	has_gun_safety = FALSE

/obj/item/gun/energy
	has_gun_safety = TRUE

/obj/item/gun/energy/kinetic_accelerator/minebot
	has_gun_safety = FALSE

/obj/item/gun/ballistic/rifle/enchanted
	has_gun_safety = FALSE
