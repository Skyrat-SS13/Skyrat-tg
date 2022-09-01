/obj/item/weaponcell
	name = "default weaponcell"
	desc = "used to add ammo types to guns"
	icon = 'modular_skyrat/modules/cellguns/icons/obj/guns/mediguns/medicells.dmi'
	icon_state = "Oxy1"
	w_class = WEIGHT_CLASS_SMALL
	/// The ammo type that is added by default when inserting a cell.
	var/ammo_type = /obj/item/ammo_casing/energy/medical
	/// Does the cell have a secondary firing mode? For Medicells this is called "safety"
	var/toggle_modes = FALSE
	/// Is the secondary firing mode currently toggled?
	var/is_toggled =  TRUE
	/// This is default ammo ype that is used when toggle_modes is enabled. If you are not using toggle_modes, this doesn't need to be touched.
	var/primary_mode = /obj/item/ammo_casing/energy/medical
	/// The secondary ammo type that the cell will use when toggled in hand, this is only used if toggle_modes is enabled.
	var/secondary_mode = /obj/item/ammo_casing/energy/medical
	/// The name of the current firing mode.
	var/shot_name
	/// Enables Medigun specific examine text.
	var/medicell_examine = FALSE

/obj/item/weaponcell/proc/refresh_shot_name() //refreshes the shot name
	var/obj/item/ammo_casing/energy/shot = ammo_type

	if(initial(shot.select_name))
		shot_name = initial(shot.select_name)
		return TRUE
	else
		return FALSE

/obj/item/weaponcell/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/item_scaling, 0.5, 1)
	refresh_shot_name()

/obj/item/weaponcell/examine(mob/user)
	. = ..()
	if(shot_name)
		. += span_noticealien("Using this on a cell based gun will unlock the [shot_name] firing mode")

	if(!toggle_modes) //Doesn't show a description if it can't be toggled in the first place.
		return

	if(medicell_examine)
		. += span_notice("The safety measures on the Medicell, preventing clone damage, are [is_toggled ? "enabled" : "disabled"]")
		return
	else
		. += span_notice("[src] is using the [is_toggled ? "primary" : "secondary"] mode.")

	return .

/obj/item/weaponcell/attack_self(mob/living/user)
	if(!toggle_modes) //Is the cell abled to be toggled? If not, return.
		return

	is_toggled = !is_toggled //Changes the toggle to the reverse of what it is.
	src.ammo_type = is_toggled ? primary_mode : secondary_mode
	playsound(loc,is_toggled ? 'sound/machines/defib_SaftyOn.ogg' : 'sound/machines/defib_saftyOff.ogg', 50)

	if(medicell_examine)
		balloon_alert(user, "safety [is_toggled ? "enabled" : "disabled"]")
		return
	else if(refresh_shot_name())
		balloon_alert(user, "set to [shot_name]")

	return

