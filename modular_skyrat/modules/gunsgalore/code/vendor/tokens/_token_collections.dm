/obj/item/storage/box/armament_tokens_sidearm
	name = "security sidearm tokens"
	icon = 'modular_skyrat/master_files/icons/obj/guns/gunsets.dmi'
	desc = "A box full of sidearm armament tokens!"
	icon_state = "armadyne_sidearm"
	illustration = null

/obj/item/storage/box/armament_tokens_sidearm/PopulateContents()
	. = ..()
	new /obj/item/armament_token/sidearm(src)
	new /obj/item/armament_token/sidearm(src)
	new /obj/item/armament_token/sidearm(src)

/obj/item/storage/box/armament_tokens_primary
	name = "security primary tokens"
	icon = 'modular_skyrat/master_files/icons/obj/guns/gunsets.dmi'
	icon_state = "armadyne_primary"
	desc = "A box full of primary armament tokens!"
	illustration = null

/obj/item/storage/box/armament_tokens_primary/PopulateContents()
	. = ..()
	new /obj/item/armament_token/primary(src)
	new /obj/item/armament_token/primary(src)
	new /obj/item/armament_token/primary(src)
	new /obj/item/armament_token/primary(src)
	new /obj/item/armament_token/primary(src)

/obj/item/storage/box/armament_tokens_energy
	name = "security energy tokens"
	icon = 'modular_skyrat/master_files/icons/obj/guns/gunsets.dmi'
	icon_state = "armadyne_energy"
	desc = "A box full of energy armament tokens!"
	illustration = null

/obj/item/storage/box/armament_tokens_energy/PopulateContents()
	. = ..()
	new /obj/item/armament_token/energy(src)
	new /obj/item/armament_token/energy(src)
	new /obj/item/armament_token/energy(src)
