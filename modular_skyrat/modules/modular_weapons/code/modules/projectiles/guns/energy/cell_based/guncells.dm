/obj/item/weaponcell
	name = "default weaponcell"
	desc = "used to add ammo types to guns"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/upgrades.dmi'
	icon_state = "Oxy1"
	w_class = WEIGHT_CLASS_SMALL
	var/ammo_type = /obj/item/ammo_casing/energy/medical //What ammo type is added by defautl?
	var/toggle_modes = FALSE //Can the cell switch between modes? Formerly was known as safety
	var/is_toggled =  FALSE //Is the secondary mode toggled?
	var/primary_mode = /obj/item/ammo_casing/energy/medical //The default mode
	var/secondary_mode = /obj/item/ammo_casing/energy/medical //Secondary mode.

/obj/item/weaponcell/examine(mob/user)
	. = ..()
	if(!toggle_modes) //Doesn't show a description if it can't be toggled in the first place.
		return
	. += span_notice("[src] is using the [is_toggled ? "primary" : "secondary"] mode.")
	return .

/obj/item/weaponcell/attack_self(mob/living/user)
	if(!toggle_modes) //Is the cell abled to be toggled?
		return
	is_toggled = !is_toggled //Changes the toggle to the reverse of what it is.
	src.ammo_type = is_toggled ? primary_mode : secondary_mode
	to_chat(user, span_notice("You switch [src] to [is_toggled ? "primary" : "seconadry"] firing mode"))
	return

/obj/item/weaponcell/debug
	name = "debug medicell"
	ammo_type = /obj/item/ammo_casing/energy/ion

/obj/item/weaponcell/debug/child
	name = "debug medicell child"
	toggle_modes = TRUE
	primary_mode = /obj/item/ammo_casing/energy/ion
	secondary_mode = /obj/item/ammo_casing/energy/medical/brute1

/obj/item/weaponcell/medical
	name = "medical cell"
