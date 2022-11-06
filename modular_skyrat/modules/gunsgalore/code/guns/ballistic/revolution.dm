/obj/item/gun/ballistic/revolver/revolution
	name = "\improper Revolution-8 revolver"
	desc = "The Zeta 6's distant cousin, sporting an eight-round competition grade cylinder chambered for 9mm Peacekeeper."
	icon = 'modular_skyrat/master_files/icons/obj/guns/revolution.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/obj/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/obj/guns/inhands/lefthand.dmi'
	icon_state = "revolution"
	inhand_icon_state = "revolution"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/revolution
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/revolver_fire.ogg'
	fire_delay = 1.90
	company_flag = COMPANY_BOLT

/obj/item/ammo_box/magazine/internal/cylinder/revolution
	name = "\improper Revolution-8 cylinder"
	desc = "If you see this, you should call a Bluespace Technician. Unless you're that Bluespace Technician."
	ammo_type = /obj/item/ammo_casing/b9mm
	caliber = CALIBER_9MMPEACE
	max_ammo = 8

/obj/item/ammo_box/revolver/revolution
	name = "\improper Revolution-8 speedloader"
	desc = "A speedloader for the Revolution-8 revolver, chambered in 9mm Peacekeeper."
	icon_state = "speedloader"
	ammo_type = /obj/item/ammo_casing/b9mm
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	caliber = CALIBER_9MMPEACE
	start_empty = TRUE

/obj/item/ammo_box/revolver/revolution/full
	start_empty = FALSE
