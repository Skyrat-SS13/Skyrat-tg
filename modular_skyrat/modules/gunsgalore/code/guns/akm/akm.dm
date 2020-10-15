/obj/item/gun/ballistic/automatic/assault_rifle/akm
	name = "\improper Automatic Kalashnikov Rifle"
	desc = "Introduced into service with the Soviet Army in 1959, the AKM is the prevalent variant of the entire AK series of firearms and it has found widespread use with most member states of the former Warsaw Pact and its African and Asian allies as well as being widely exported and produced in many other countries."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/akm/akm.dmi'
	icon_state = "akm"
	lefthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/akm/akm_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/akm/akm_righthand.dmi'
	inhand_icon_state = "akm"
	slot_flags = ITEM_SLOT_BELT
	mag_type = /obj/item/ammo_box/magazine/akm
	can_suppress = FALSE
	burst_size = 3
	fire_delay = 3
	worn_icon = 'modular_skyrat/modules/gunsgalore/icons/guns/akm/akm_back.dmi'
	worn_icon_state = "akm"
	fire_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/fire/akm/akm.ogg'
	alt_icons = TRUE
	realistic = TRUE

/obj/item/ammo_box/magazine/akm
	name = "akm magazine (7.62×39mm)"
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/akm/akm.dmi'
	icon_state = "7.62mm"
	ammo_type = /obj/item/ammo_casing/realistic/a762x39
	caliber = "a762x39"
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY
