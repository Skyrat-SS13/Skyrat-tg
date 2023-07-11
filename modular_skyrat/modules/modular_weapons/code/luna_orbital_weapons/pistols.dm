// Military pistol

/obj/item/gun/ballistic/automatic/pistol/luna
	name = "\improper Luno 'Anglofiŝo' Service Pistol"
	desc = "The standard issue service pistol of SolFed's various military branches. Comes with attached light."

	icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/guns_32.dmi'
	icon_state = "anglofiso"

	w_class = WEIGHT_CLASS_NORMAL

	fire_delay = 2

/obj/item/gun/ballistic/automatic/pistol/g17
	name = "\improper GK-17"
	desc = "A weapon from bygone times, this has been made to look like an old, blocky firearm from the 21st century. Let's hope it's more reliable. Chambered in 9x25mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/glock.dmi'
	icon_state = "glock"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/g17
	can_suppress = FALSE
	fire_sound = 'sound/weapons/gun/pistol/shot_alt.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	fire_delay = 1.90
	projectile_damage_multiplier = 0.5

/obj/item/gun/ballistic/automatic/pistol/g17/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_CANTALAN)

/obj/item/gun/ballistic/automatic/pistol/g17/add_seclight_point()
	return

/obj/item/ammo_box/magazine/multi_sprite/g17
	name = "\improper GK-17 magazine"
	desc = "A magazine for the GK-17 handgun, chambered for 9x25mm ammo."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "g17"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 17
	multiple_sprites = AMMO_BOX_FULL_EMPTY
