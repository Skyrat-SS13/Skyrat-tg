/obj/item/gun/ballistic/automatic/pistol/nt_glock
	name = "\improper GP-9"
	desc = "General Purpose Pistl Number 9. A classic .9mm handgun with a small magazine capacity."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_system_inc/pistol.dmi'
	icon_state = "9mm_glock"
	w_class = WEIGHT_CLASS_NORMAL
	spread = 15
	fire_sound = 'sound/weapons/gun/pistol/shot_alt.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'

/obj/item/gun/ballistic/automatic/pistol/nt_glock/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_NANOTRASEN)

/obj/item/gun/ballistic/automatic/pistol/nt_glock/empty
	spawnwithmagazine = FALSE
