/*
MICROFUSION GUN UPGRADE ATTACHMENTS

For adding unique abilities to microfusion guns, these can directly interact with the gun!
*/

/obj/item/microfusion_gun_attachment
	name = "microfusion gun attachment"
	desc = "broken"
	icon = 'modular_skyrat/modules/microfusion/icons/guns.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	var/attachment_overlay_icon_state

/obj/item/microfusion_gun_attachment/proc/run_upgrade(obj/item/gun/energy/microfusion/microfusion_gun)
	SHOULD_CALL_PARENT(TRUE)
	microfusion_gun.update_appearance()
	return

/obj/item/microfusion_gun_attachment/proc/process_upgrade(obj/item/gun/energy/microfusion/microfusion_gun)
	return

/obj/item/microfusion_gun_attachment/proc/remove_upgrade(obj/item/gun/energy/microfusion/microfusion_gun)
	SHOULD_CALL_PARENT(TRUE)
	microfusion_gun.update_appearance()
	return

/*
SCATTER ATTACHMENT

The cell is stable and will not emit sparks when firing.
*/

/obj/item/microfusion_gun_attachment/scatter
	name = "scattering microfusion lens upgrade"
	desc = "Splits the microfusion laser beam entering the lens by 3!"
	icon_state = "attachment_scatter"
	attachment_overlay_icon_state = "scatter_attachment"
	/// How many pellets are we going to add to the existing amount on the gun?
	var/pellets_to_add = 2
	/// The variation in pellet scatter.
	var/variance_to_add = 10

/obj/item/microfusion_gun_attachment/scatter/run_upgrade(obj/item/gun/energy/microfusion/microfusion_gun)
	. = ..()
	for(var/obj/item/ammo_casing/ammo_casing in microfusion_gun.ammo_type)
		ammo_casing.pellets += pellets_to_add
		ammo_casing.variance += variance_to_add


/obj/item/microfusion_gun_attachment/scatter/remove_upgrade(obj/item/gun/energy/microfusion/microfusion_gun)
	. = ..()
	for(var/obj/item/ammo_casing/ammo_casing in microfusion_gun.ammo_type)
		ammo_casing.pellets = initial(ammo_casing.pellets)
		ammo_casing.variance += initial(ammo_casing.variance)
