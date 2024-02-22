/obj/item/weldingtool/Initialize(mapload)
	. = ..()
	RegisterSignals(reagents,
		list(
			COMSIG_REAGENTS_ADD_REAGENT,
			COMSIG_REAGENTS_NEW_REAGENT,
			COMSIG_REAGENTS_REM_REAGENT,
			COMSIG_REAGENTS_DEL_REAGENT,
			COMSIG_REAGENTS_CLEAR_REAGENTS,
			COMSIG_REAGENTS_REACTED,),
		PROC_REF(update_ammo_hud))

/obj/item/weldingtool/set_welding(new_value)
	. = ..()
	update_ammo_hud()

/obj/item/weldingtool/proc/update_ammo_hud()
	SIGNAL_HANDLER

	SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
