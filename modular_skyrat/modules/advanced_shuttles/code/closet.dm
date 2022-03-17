/obj/structure/closet/shuttle/closet_update_overlays(list/new_overlays)
	. = new_overlays
	if(enable_door_overlay && !is_animating_door)
		if(opened && has_opened_overlay)
			var/mutable_appearance/door_overlay = mutable_appearance(icon, "[icon_door || icon_state]_open", alpha = src.alpha)	//This was the only change, adding icon_door; TG wouldnt want it.
			. += door_overlay
			door_overlay.overlays += emissive_blocker(door_overlay.icon, door_overlay.icon_state, alpha = door_overlay.alpha) // If we don't do this the door doesn't block emissives and it looks weird.
		else if(has_closed_overlay)
			. += "[icon_door || icon_state]_door"
//TG won't ever really need this because their lockers with non-matching fronts dont have non-matching backs; so I simply re-define the proc for our shuttleclosets

/obj/structure/closet/shuttle
	anchored = TRUE
	density = TRUE
	can_be_unanchored = FALSE
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	icon_state = "wallcloset"
	icon_door = "wallcloset_mesh"
	door_anim_time = 0 //CONVERT THESE DOORS YOU LAZY ASSHATS

/obj/structure/closet/shuttle/white
	icon_state = "wallcloset_white"
	icon_door = "wallcloset_white"

/obj/structure/closet/shuttle/emergency
	name = "emergency closet"
	desc = "It's a storage unit for emergency breath masks and O2 tanks."
	icon_door = "wallcloset_o2"

/obj/structure/closet/shuttle/emergency/PopulateContents()
	for (var/i in 1 to 2)
		new /obj/item/tank/internals/emergency_oxygen/engi(src)
		new /obj/item/clothing/mask/gas/alt(src)
	new /obj/item/storage/toolbox/emergency(src)

/obj/structure/closet/shuttle/emergency/white
	icon_state = "wallcloset_white"

/obj/structure/closet/shuttle/medical
	name = "first-aid closet"
	desc = "It's a storage unit for emergency medical supplies."
	icon_door = "wallcloset_med"

/obj/structure/closet/shuttle/medical/PopulateContents()
	new /obj/item/storage/medkit/emergency(src)
	new /obj/item/healthanalyzer(src)
	new /obj/item/reagent_containers/hypospray(src)

/obj/structure/closet/shuttle/medical/white
	icon_state = "wallcloset_white"

/obj/structure/closet/shuttle/mining
	desc = "It's a storage unit for emergency breath masks, O2 tanks, and a pressure suit."
	icon_state = "wallcloset_white"
	icon_door = "wallcloset_mining"

/obj/structure/closet/shuttle/mining/PopulateContents()
	for (var/i in 1 to 2)
		new /obj/item/tank/internals/emergency_oxygen/engi(src)
		new /obj/item/clothing/mask/breath(src)
	new /obj/item/storage/toolbox/emergency(src)
	new /obj/item/clothing/head/helmet/space(src)
	new /obj/item/clothing/suit/space(src)

/obj/structure/closet/shuttle/engivent
	wall_mounted = TRUE
	name = "engine ventilation"
	desc = "An exhaust vent for the shuttle's engines. It looks just big enough to fit a person..."
	icon_state = "vent"
	icon_door = "vent"

//Wall closets
/obj/structure/closet/firecloset/wall
	wall_mounted = TRUE
	max_mob_size = MOB_SIZE_SMALL
	anchored = TRUE
	density = TRUE
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	icon_state = "fire_wall"
	door_anim_time = 0 //CONVERT THESE DOORS YOU LAZY ASSHATS

/obj/structure/closet/emcloset/wall
	wall_mounted = TRUE
	max_mob_size = MOB_SIZE_SMALL
	anchored = TRUE
	density = TRUE
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	icon_state = "emergency_wall"
	door_anim_time = 0 //CONVERT THESE DOORS YOU LAZY ASSHATS

/obj/structure/closet/secure_closet/wall
	wall_mounted = TRUE
	max_mob_size = MOB_SIZE_SMALL
	anchored = TRUE
	density = TRUE
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	icon_state = "closet_wall"
	door_anim_time = 0 //CONVERT THESE DOORS YOU LAZY ASSHATS

/obj/structure/closet/secure_closet/personal/wall
	wall_mounted = TRUE
	max_mob_size = MOB_SIZE_SMALL
	anchored = TRUE
	density = TRUE
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	icon_state = "closet_wall"
	door_anim_time = 0 //CONVERT THESE DOORS YOU LAZY ASSHATS
