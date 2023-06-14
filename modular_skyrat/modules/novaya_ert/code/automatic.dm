/obj/item/gun/ballistic/automatic/nri_smg
	name = "\improper QLP/04 SMG"
	desc = "A 4.2x30mm submachine gun developed for military and police use by the now-absorbed by the Izhevsk Coalition arms manufacturer. \
		Features a mag insertion-activated holosight providing its user with information regarding the gun's ammo count and its general status, as well as \
		a folding stock. Due to its efficiency, is currently in use by the NRI's reserve military forces; support and vehicle crews, \
		not including numerous police patrols scattered across the border."
	worn_icon = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_back.dmi'
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_guns40x32.dmi'
	lefthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_righthand.dmi'
	worn_icon_state = "nri_smg"
	icon_state = "nri_smg"
	inhand_icon_state = "nri_smg"
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/cfa_lynx
	fire_delay = 1
	burst_size = 5
	dual_wield_spread = 5
	spread = 5
	can_suppress = FALSE
	mag_display = TRUE
	empty_indicator = TRUE
	alt_icons = TRUE
	fire_sound = 'sound/weapons/gun/smg/shot_alt.ogg'

/obj/item/gun/ballistic/automatic/nri_smg/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_IZHEVSK)

/obj/item/gun/ballistic/automatic/pistol/ladon/nri
	name = "\improper Szabo-Ivanek service pistol"
	desc = "A mass produced NRI-made modified reproduction of the PDH-6 line of handguns rechambered in 9×25mm.\
		'PATRIOT DEFENSE SYSTEMS' is inscribed on the receiver, indicating it's been made with a plasteel printer."
	icon = 'modular_skyrat/modules/novaya_ert/icons/pistol.dmi'
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/m9mm_aps
	burst_size = 3
	fire_delay = 3

/obj/item/gun/ballistic/automatic/pistol/ladon/nri/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_IZHEVSK)
