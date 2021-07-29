/obj/item/gun/ballistic/automatic/l6_saw/unrestricted/mg34
	name = "\improper MG-9 GPMG"
	desc = "A reproduction of the German MG-3 general purpose machine gun, this one is a revision from the 2200's and was one of several thousand distributed to SolFed expedition teams. It has been rechambered to fire 7.92mm Mauser instead of 7.62mm NATO."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/mg34/mg34.dmi'
	icon_state = "mg34"
	lefthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/mg34/mg34_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/mg34/mg34_righthand.dmi'
	inhand_icon_state = "mg34"
	worn_icon = 'modular_skyrat/modules/gunsgalore/icons/guns/mg34/mg34_back.dmi'
	worn_icon_state = "mg34"
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_HUGE
	spread = 15
	mag_type = /obj/item/ammo_box/magazine/mg34
	fire_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/fire/mg34/mg34.ogg'
	fire_sound_volume = 70
	can_suppress = FALSE
	burst_size = 5
	fire_delay = 1
	realistic = TRUE
	dirt_modifier = 0.1

/obj/item/ammo_box/magazine/mg34
	name = "mg9 drum (7.92×57mm)"
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/mg34/mg34.dmi'
	icon_state = "mg34_drum"
	ammo_type = /obj/item/ammo_casing/realistic/a792x57
	caliber = "a792x57"
	max_ammo = 75
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/l6_saw/unrestricted/mg34/update_overlays()
	. = ..()
	. += "mg34_door_[cover_open ? "open" : "closed"]"

/obj/item/gun/ballistic/automatic/l6_saw/unrestricted/mg34/packapunch //INFINITY GUNNNNNNNN
	name = "MG34 UBER"
	desc = "Here, there, seems like everywhere. Nasty things are happening, now everyone is scared. Old Jeb Brown the Blacksmith, he saw his mother die. A critter took a bite from her and now she's in the sky. "
	icon_state = "mg34_packapunch"
	fire_delay = 0.04
	burst_size = 5
	spread = 5
	dirt_modifier = 0
	durability = 500
	mag_type = /obj/item/ammo_box/magazine/mg34/packapunch

/obj/item/ammo_box/magazine/mg34/packapunch
	max_ammo = 999
	multiple_sprites = AMMO_BOX_ONE_SPRITE

/obj/item/gun/ballistic/automatic/l6_saw/unrestricted/mg34/packapunch/afterattack(atom/target, mob/living/user, flag, params)
	. = ..()
	magazine.top_off()
