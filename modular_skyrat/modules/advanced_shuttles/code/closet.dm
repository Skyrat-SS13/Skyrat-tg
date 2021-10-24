/obj/structure/closet/shuttle
	anchored = TRUE
	density = TRUE
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	icon_state = "wallcloset"
	door_anim_time = 0 //CONVERT THESE DOORS YOU LAZY ASSHATS

/obj/structure/closet/shuttle/white
	anchored = TRUE
	density = TRUE
	icon_state = "wallcloset_white"
	icon_door = "wallcloset_door"

/obj/structure/closet/shuttle/wagon
	name = "emergency closet"
	desc = "It's a storage unit for emergency breathmasks and o2 tanks."
	icon_state = "wallcloset_white"

/obj/structure/closet/shuttle/wagon/PopulateContents()
	for (var/i in 1 to 2)
		new /obj/item/tank/internals/emergency_oxygen/double(src)
		new /obj/item/clothing/mask/gas/alt(src)
	new /obj/item/storage/toolbox/emergency(src)

/obj/structure/closet/shuttle/mining
	name = "emergency closet"
	desc = "It's a storage unit for emergency o2 supply and pressure suit."
	icon_state = "wallcloset_mining"

/obj/structure/closet/shuttle/mining/PopulateContents()
	for (var/i in 1 to 2)
		new /obj/item/tank/internals/emergency_oxygen/double(src)
		new /obj/item/clothing/mask/gas/alt(src)
	new /obj/item/storage/toolbox/emergency(src)
	new /obj/item/clothing/head/helmet/space(src)
	new /obj/item/clothing/suit/space(src)

/obj/structure/closet/shuttle/medical_wall/erokez //wall mounted medical closet
	name = "first-aid closet"
	desc = "It's wall-mounted storage unit for first aid supplies."
	icon_state = "wallcloset_med"

/obj/structure/closet/shuttle/medical_wall/erokez/PopulateContents()
	for (var/i in 1 to 3)
		new /obj/item/stack/medical/bruise_pack(src)
	for (var/i in 1 to 2)
		new /obj/item/stack/medical/ointment(src)
	new /obj/item/healthanalyzer(src)
	new /obj/item/reagent_containers/hypospray(src)

/obj/structure/closet/shuttle/erokez
	name = "Closet"
	desc = "It's wall-mounted storage unit"
	icon_state = "wallcloset"

/obj/structure/closet/shuttle/evacvent
	name = "Engine ventilation"
	desc = "Looks like you can get in this small engine ventilation shaft."
	icon_state = "shuttle"
	anchored = TRUE

/obj/structure/closet/firecloset/wall
	wall_mounted = TRUE
	anchored = TRUE
	density = TRUE
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	icon_state = "fire_wall"
	door_anim_time = 0 //CONVERT THESE DOORS YOU LAZY ASSHATS

/obj/structure/closet/emcloset/wall
	wall_mounted = TRUE
	anchored = TRUE
	density = TRUE
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	icon_state = "emergency_wall"
	door_anim_time = 0 //CONVERT THESE DOORS YOU LAZY ASSHATS

/obj/structure/closet/secure_closet/wall
	wall_mounted = TRUE
	anchored = TRUE
	density = TRUE
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	icon_state = "closet_wall"
	door_anim_time = 0 //CONVERT THESE DOORS YOU LAZY ASSHATS

/obj/structure/closet/secure_closet/personal/wall
	wall_mounted = TRUE
	anchored = TRUE
	density = TRUE
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	icon_state = "closet_wall"
	door_anim_time = 0 //CONVERT THESE DOORS YOU LAZY ASSHATS
