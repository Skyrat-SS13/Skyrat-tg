/*
*	GLOCK
*/

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

/obj/item/ammo_box/magazine/multi_sprite/g17/hp
	ammo_type = /obj/item/ammo_casing/c9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/g17/ihdf
	ammo_type = /obj/item/ammo_casing/c9mm/ihdf
	round_type = AMMO_TYPE_IHDF

/obj/item/ammo_box/magazine/multi_sprite/g17/rubber
	ammo_type = /obj/item/ammo_casing/c9mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/gun/ballistic/automatic/pistol/g18
	name = "\improper GK-18"
	desc = "A CFA-made burst firing cheap polymer pistol chambered in 9x25mm. Its heavy duty barrel affects firerate."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/glock.dmi'
	icon_state = "glock_spec"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/g18
	can_suppress = FALSE
	fire_sound = 'sound/weapons/gun/pistol/shot_alt.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	burst_size = 3
	fire_delay = 2.10
	spread = 8
	actions_types = list(/datum/action/item_action/toggle_firemode)
	mag_display = FALSE
	mag_display_ammo = FALSE
	projectile_damage_multiplier = 0.5

/obj/item/gun/ballistic/automatic/pistol/g18/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_CANTALAN)

/obj/item/gun/ballistic/automatic/pistol/g18/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', light_overlay = "flight")

/obj/item/ammo_box/magazine/multi_sprite/g18
	name = "\improper GK-18 magazine"
	desc = "A magazine for the GK-18 machine pistol, chambered for 9x25mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "g18"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 33
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/multi_sprite/g18/hp
	ammo_type = /obj/item/ammo_casing/c9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/g18/ihdf
	ammo_type = /obj/item/ammo_casing/c9mm/ihdf
	round_type = AMMO_TYPE_IHDF

/obj/item/ammo_box/magazine/multi_sprite/g18/rubber
	ammo_type = /obj/item/ammo_casing/c9mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/gun/ballistic/automatic/pistol/g17/mesa
	name = "\improper Glock 20"
	desc = "A weapon from bygone times, and this is the exact 21st century version. In fact, even more reliable. Chambered in 10mm Auto."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/glock.dmi'
	icon_state = "glock_mesa"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/ladon // C o m p a t i b i l i t y .
	fire_sound = 'modular_skyrat/master_files/sound/weapons/glock17_fire.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	fire_delay = 0.9

/obj/item/gun/ballistic/automatic/pistol/g17/mesa/give_manufacturer_examine()
	return

/obj/item/gun/ballistic/automatic/pistol/g17/mesa/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', light_overlay = "flight")

/*
* PDH 40x32
*/

/obj/item/gun/ballistic/automatic/pistol/pdh
	name = "\improper PDH-6H 'Osprey'"
	desc = "A modern ballistics sidearm, used primarily by the military, however this one has had a paintjob to match command. It's chambered in 12.7x30mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/pdh.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand40x32.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand40x32.dmi'
	icon_state = "pdh"
	inhand_icon_state = "pdh"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/pdh
	can_suppress = FALSE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/hpistol_fire.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'

/obj/item/gun/ballistic/automatic/pistol/pdh/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_ARMADYNE)

/obj/item/gun/ballistic/automatic/pistol/pdh/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', light_overlay = "flight")

/obj/item/gun/ballistic/automatic/pistol/pdh/alt
	name = "\improper PDH-6C 'SOCOM'"
	desc = "A prestigious 12mm sidearm normally seen in the hands of SolFed special operation units due to its reliable and time-tested design. Now's one of those times that pays to be the strong, silent type."
	icon_state = "pdh_alt"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/pdh
	can_suppress = FALSE
	fire_sound = 'sound/weapons/gun/pistol/shot_suppressed.ogg'
	fire_delay = 8
	fire_sound_volume = 30
	spread = 1

/obj/item/ammo_box/magazine/multi_sprite/pdh
	name = "12mm PDH-6 magazine"
	desc = "A heavy 12mm magazine made for the PDH-6H and PDH-6C handguns."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pdh"
	ammo_type = /obj/item/ammo_casing/b12mm
	caliber = CALIBER_12MM
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	possible_types = list(
		AMMO_TYPE_LETHAL,
		AMMO_TYPE_HOLLOWPOINT,
		AMMO_TYPE_RUBBER,
	)

/obj/item/ammo_box/magazine/multi_sprite/pdh/hp
	ammo_type = /obj/item/ammo_casing/b12mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/pdh/rubber
	ammo_type = /obj/item/ammo_casing/b12mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/gun/ballistic/automatic/pistol/pdh/corpo
	name = "\improper PDH-6M 'Corpo'"
	desc = "A prestigious ballistic sidearm, from Armadyne's military division, normally given to high-ranking corporate agents. It has a 3 round burst mode and uses .357 Magnum ammunition."
	icon_state = "pdh_corpo"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/pdh_corpo
	can_suppress = FALSE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/hpistol_fire.ogg'
	burst_size = 3
	fire_delay = 2
	spread = 5
	actions_types = list(/datum/action/item_action/toggle_firemode)

/obj/item/ammo_box/magazine/multi_sprite/pdh_corpo
	name = "\improper PDH-6M magazine"
	desc = "A magazine for Armadyne's exclusive corporate handgun. Chambered for .357, to your disgrace."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pdh"
	ammo_type = /obj/item/ammo_casing/a357
	caliber = CALIBER_357
	max_ammo = 14
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	possible_types = list(
		AMMO_TYPE_LETHAL,
	)

/*
* 	PDH STRIKER
*/

// A temporary home for this gun until the Corporate Diplomat PR goes through.
/obj/item/gun/ballistic/automatic/pistol/pdh/striker
	name = "\improper PDH-6 'Striker'"
	desc = "A sidearm used by Armadyne corporate agents who didn't make the cut for the Corpo model. Chambered in .38 special."
	icon_state = "pdh_striker"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/pdh_striker
	can_suppress = FALSE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/hpistol_fire.ogg'
	burst_size = 3
	fire_delay = 2
	spread = 9
	actions_types = list(/datum/action/item_action/toggle_firemode)

/obj/item/ammo_box/magazine/multi_sprite/pdh_striker
	name = "\improper PDH-6M magazine"
	desc = "A magazine for the PDH-6 'Striker'. Chambered in the strange choice of .38 special."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pdh"
	ammo_type = /obj/item/ammo_casing/c38
	caliber = CALIBER_38
	max_ammo = 10
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	possible_types = list(
		AMMO_TYPE_LETHAL,
	)

/*
*	PDH PEACEKEEPER
*/

/obj/item/gun/ballistic/automatic/pistol/pdh/peacekeeper
	name = "\improper PDH-6B"
	desc = "A modern ballistic sidearm, used primarily by law enforcement, chambered in 9x25mm."
	fire_delay = 1.95
	icon_state = "pdh_peacekeeper"
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/pistol_fire.ogg'
	projectile_damage_multiplier = 0.5

/obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper
	name = "\improper PDH-6B magazine"
	desc = "A magazine for the PDG-6B law enforcement pistol, chambered for 9x25mm ammo."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pdh"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 16
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper/hp
	ammo_type = /obj/item/ammo_casing/c9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper/ihdf
	ammo_type = /obj/item/ammo_casing/c9mm/ihdf
	round_type = AMMO_TYPE_IHDF

/obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper/rubber
	ammo_type = /obj/item/ammo_casing/c9mm/rubber
	round_type = AMMO_TYPE_RUBBER

/*
*	LADON 40x32
*/

/obj/item/gun/ballistic/automatic/pistol/ladon
	name = "\improper Ladon pistol"
	desc = "Modern handgun based off the PDH series, chambered in 10mm Auto."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ladon.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand40x32.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand40x32.dmi'
	icon_state = "ladon"
	inhand_icon_state = "ladon"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/ladon
	can_suppress = FALSE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/pistol_fire.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	fire_delay = 4.20
	projectile_damage_multiplier = 0.7

/obj/item/gun/ballistic/automatic/pistol/ladon/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_ARMADYNE)

/obj/item/gun/ballistic/automatic/pistol/ladon/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', light_overlay = "flight")

/obj/item/ammo_box/magazine/multi_sprite/ladon
	name = "\improper Ladon magazine"
	desc = "A magazine for the Ladon pistol, chambered for 10mm Auto."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pdh"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = CALIBER_10MM
	max_ammo = 12
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/multi_sprite/ladon/hp
	ammo_type = /obj/item/ammo_casing/c10mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/ladon/ihdf
	ammo_type = /obj/item/ammo_casing/c10mm/ihdf
	round_type = AMMO_TYPE_IHDF

/obj/item/ammo_box/magazine/multi_sprite/ladon/rubber
	ammo_type = /obj/item/ammo_casing/c10mm/rubber
	round_type = AMMO_TYPE_RUBBER

/*
*	MAKAROV
*/

/obj/item/gun/ballistic/automatic/pistol/makarov
	name = "\improper R-C 'Makarov'"
	desc = "A mediocre pocket-sized handgun of NRI origin, chambered in 10mm Auto."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/makarov.dmi'
	icon_state = "makarov"
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/makarov
	can_suppress = TRUE
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	projectile_damage_multiplier = 0.6

/obj/item/gun/ballistic/automatic/pistol/makarov/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_IZHEVSK)

/obj/item/ammo_box/magazine/multi_sprite/makarov
	name = "\improper R-C Makarov magazine"
	desc = "A tiny magazine for the R-C Makarov pocket pistol, chambered in 10mm Auto."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pdh"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = CALIBER_10MM
	max_ammo = 6
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/multi_sprite/makarov/hp
	ammo_type = /obj/item/ammo_casing/c10mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/makarov/ihdf
	ammo_type = /obj/item/ammo_casing/c10mm/ihdf
	round_type = AMMO_TYPE_IHDF

/obj/item/ammo_box/magazine/multi_sprite/makarov/rubber
	ammo_type = /obj/item/ammo_casing/c10mm/rubber
	round_type = AMMO_TYPE_RUBBER

/*
*	MK-58
*/

/obj/item/gun/ballistic/automatic/pistol/mk58
	name = "\improper MK-58"
	desc = "A modern 9x25mm handgun with an olive polymer lower frame. Looks like a generic 21st century military sidearm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mk58.dmi'
	icon_state = "mk58"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/mk58
	can_suppress = FALSE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/pistol_fire.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	projectile_damage_multiplier = 0.5

/obj/item/gun/ballistic/automatic/pistol/mk58/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_ARMADYNE)

/obj/item/ammo_box/magazine/multi_sprite/mk58
	name = "\improper MK-58 magazine"
	desc = "A flimsy double-stack polymer magazine for the MK-58 handgun, chambered for 9x25mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "g17"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 12
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/multi_sprite/mk58/hp
	ammo_type = /obj/item/ammo_casing/c9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/mk58/ihdf
	ammo_type = /obj/item/ammo_casing/c9mm/ihdf
	round_type = AMMO_TYPE_IHDF

/obj/item/ammo_box/magazine/multi_sprite/mk58/rubber
	ammo_type = /obj/item/ammo_casing/c9mm/rubber
	round_type = AMMO_TYPE_RUBBER

/*
*	FIREFLY
*/

/obj/item/gun/ballistic/automatic/pistol/firefly
	name = "\improper P-92 pistol"
	desc = "A simple sidearm made by Armadyne's Medical Directive, with a heavy front for weak wrists. A small warning label on the back says it's not fit for surgical work, and chambered for 9x25mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/firefly.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	icon_state = "firefly"
	inhand_icon_state = "firefly"
	fire_delay = 1.95
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/firefly
	can_suppress = FALSE
	projectile_damage_multiplier = 0.5

/obj/item/gun/ballistic/automatic/pistol/firefly/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_ARMADYNE)

/obj/item/gun/ballistic/automatic/pistol/firefly/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', light_overlay = "flight")


/obj/item/ammo_box/magazine/multi_sprite/firefly
	name = "\improper P-92 magazine"
	desc = "A twelve-round magazine for the P-92 pistol, chambered in 9x25mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pdh"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 12
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/multi_sprite/firefly/hp
	ammo_type = /obj/item/ammo_casing/c9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/firefly/rubber
	ammo_type = /obj/item/ammo_casing/c9mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/firefly/ihdf
	ammo_type = /obj/item/ammo_casing/c9mm/ihdf
	round_type = AMMO_TYPE_IHDF
/*
*	CROON 40x32
*/

/obj/item/gun/ballistic/automatic/croon
	name = "\improper Croon submachine gun"
	desc = "A low-quality 6.3mm reproduction of a popular SMG model, jams like a bitch. Although crude and unofficial, it gets the job done."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/croon.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand40x32.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand40x32.dmi'
	icon_state = "croon"
	inhand_icon_state = "croon"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/croon
	can_suppress = FALSE
	fire_sound = 'sound/weapons/gun/smg/shot.ogg'
	rack_sound = 'sound/weapons/gun/smg/smgrack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	burst_size = 3
	fire_delay = 2.10
	spread = 25
	actions_types = list(/datum/action/item_action/toggle_firemode)
	mag_display = FALSE
	mag_display_ammo = FALSE

/obj/item/gun/ballistic/automatic/croon/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_IZHEVSK)

/obj/item/ammo_box/magazine/multi_sprite/croon
	name = "\improper Croon magazine"
	desc = "A straight 6.3mm magazine for the Croon SMG."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "croon"
	ammo_type = /obj/item/ammo_casing/b6mm
	caliber = CALIBER_6MM
	max_ammo = 15
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_RUBBER, AMMO_TYPE_IHDF)

/obj/item/ammo_box/magazine/multi_sprite/croon/rubber
	ammo_type = /obj/item/ammo_casing/b6mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/croon/ihdf
	ammo_type = /obj/item/ammo_casing/b6mm/ihdf
	round_type = AMMO_TYPE_IHDF

/*
*	DOZER
*/

/obj/item/gun/ballistic/automatic/dozer
	name = "\improper Dozer PDW"
	desc = "The DZR-9, a notorious 9x25mm PDW that lives up to its nickname."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/dozer.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	icon_state = "dozer"
	inhand_icon_state = "dozer"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/dozer
	can_suppress = TRUE
	mag_display = FALSE
	mag_display_ammo = FALSE
	burst_size = 2
	fire_delay = 1.90
	actions_types = list(/datum/action/item_action/toggle_firemode)
	fire_sound = 'sound/weapons/gun/rifle/shot.ogg'
	rack_sound = 'sound/weapons/gun/smg/smgrack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'

/obj/item/gun/ballistic/automatic/dozer/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_ARMADYNE)

/obj/item/ammo_box/magazine/multi_sprite/dozer
	name = "\improper Dozer magazine"
	desc = "A magazine for the Dozer PDW, chambered for 9x25mm Mark 12."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "croon"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_HOLLOWPOINT, AMMO_TYPE_INCENDIARY, AMMO_TYPE_AP)

/obj/item/ammo_box/magazine/multi_sprite/dozer/hp
	ammo_type = /obj/item/ammo_casing/c9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/dozer/ap
	ammo_type = /obj/item/ammo_casing/c9mm/ap
	round_type = AMMO_TYPE_AP

/obj/item/ammo_box/magazine/multi_sprite/dozer/inc
	ammo_type = /obj/item/ammo_casing/c9mm/fire
	round_type = AMMO_TYPE_INCENDIARY

/*
*	DMR 40x32
*/

/obj/item/gun/ballistic/automatic/dmr
	name = "\improper Gen-2 Ripper rifle"
	desc = "An incredibly powerful marksman rifle with an internal stabilization gymbal. It's chambered in .577 Snider."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/dmr.dmi'
	icon_state = "dmr"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/dmr.dmi'
	worn_icon_state = "dmr_worn"
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand40x32.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand40x32.dmi'
	inhand_icon_state = "dmr"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE
	mag_type = /obj/item/ammo_box/magazine/dmr
	fire_delay = 1.7
	can_suppress = FALSE
	can_bayonet = FALSE
	mag_display = TRUE
	fire_sound_volume = 60
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/sniper_fire.ogg'

/obj/item/gun/ballistic/automatic/dmr/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/dmr/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_ARMADYNE)

/obj/item/ammo_box/magazine/dmr
	name = "\improper Gen-2 Ripper magazine"
	desc = "A magazine for the Ripper DMR, chambered for .577 Snider."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "dmr"
	ammo_type = /obj/item/ammo_casing/b577
	caliber = CALIBER_B577
	max_ammo = 25
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/*
*	ZETA
*/

/obj/item/gun/ballistic/revolver/zeta
	name = "\improper Zeta-6 revolver"
	desc = "A fairly common double-action six-shooter chambered for 10mm Auto, 'Spurchamber' is engraved on the cylinder."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/zeta.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	icon_state = "zeta"
	inhand_icon_state = "zeta"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/zeta
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/revolver_fire.ogg'
	fire_delay = 3

/obj/item/gun/ballistic/revolver/zeta/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_BOLT)

/obj/item/ammo_box/magazine/internal/cylinder/zeta
	name = "\improper Zeta-6 cylinder"
	desc = "If you see this, you should call a Bluespace Technician. Unless you're that Bluespace Technician."
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = CALIBER_10MM
	max_ammo = 6

/obj/item/ammo_box/revolver/zeta
	name = "\improper Zeta-6 speedloader"
	desc = "A speedloader for the Spurchamber revolver, chambered for 10mm Auto ammo."
	icon_state = "speedloader"
	ammo_type = /obj/item/ammo_casing/c10mm
	max_ammo = 6
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	caliber = CALIBER_10MM
	start_empty = TRUE

/obj/item/ammo_box/revolver/zeta/full
	start_empty = FALSE

/*
*	REVOLUTION
*/

/obj/item/gun/ballistic/revolver/revolution
	name = "\improper Revolution-8 revolver"
	desc = "The Zeta 6's distant cousin, sporting an eight-round competition grade cylinder chambered for 9x25mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/revolution.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	icon_state = "revolution"
	inhand_icon_state = "revolution"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/revolution
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/revolver_fire.ogg'
	fire_delay = 1.90
	projectile_damage_multiplier = 0.5

/obj/item/gun/ballistic/revolver/revolution/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_BOLT)

/obj/item/ammo_box/magazine/internal/cylinder/revolution
	name = "\improper Revolution-8 cylinder"
	desc = "If you see this, you should call a Bluespace Technician. Unless you're that Bluespace Technician."
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 8

/obj/item/ammo_box/revolver/revolution
	name = "\improper Revolution-8 speedloader"
	desc = "A speedloader for the Revolution-8 revolver, chambered in 9x25mm."
	icon_state = "speedloader"
	ammo_type = /obj/item/ammo_casing/c9mm
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	caliber = CALIBER_9MM
	start_empty = TRUE

/obj/item/ammo_box/revolver/revolution/full
	start_empty = FALSE

/*
*	S.M.A.R.T. RIFLE
*/

/obj/item/gun/ballistic/automatic/smartgun
	name = "\improper OP-15 'S.M.A.R.T.' rifle"
	desc = "Suppressive Manual Action Reciprocating Taser rifle. A modified version of an Armadyne heavy machine gun fitted to fire miniature shock-bolts."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/smartgun.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand40x32.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand40x32.dmi'
	icon_state = "smartgun"
	w_class = WEIGHT_CLASS_HUGE
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK
	inhand_icon_state = "smartgun_worn"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/smartgun.dmi'
	worn_icon_state = "smartgun_worn"
	mag_type = /obj/item/ammo_box/magazine/smartgun
	actions_types = null
	can_suppress = FALSE
	can_bayonet = FALSE
	mag_display = TRUE
	mag_display_ammo = TRUE
	empty_alarm = TRUE
	tac_reloads = FALSE
	bolt_type = BOLT_TYPE_STANDARD
	semi_auto = FALSE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/chaingun_fire.ogg'
	rack_sound = 'modular_skyrat/modules/sec_haul/sound/chaingun_cock.ogg'
	lock_back_sound = 'modular_skyrat/modules/sec_haul/sound/chaingun_open.ogg'
	bolt_drop_sound = 'modular_skyrat/modules/sec_haul/sound/chaingun_cock.ogg'
	load_sound = 'modular_skyrat/modules/sec_haul/sound/chaingun_magin.ogg'
	load_empty_sound = 'modular_skyrat/modules/sec_haul/sound/chaingun_magin.ogg'
	eject_sound = 'modular_skyrat/modules/sec_haul/sound/chaingun_magout.ogg'
	load_empty_sound = 'modular_skyrat/modules/sec_haul/sound/chaingun_magout.ogg'
	var/recharge_time = 5 SECONDS
	var/recharging = FALSE

/obj/item/gun/ballistic/automatic/smartgun/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_ARMADYNE)

/obj/item/gun/ballistic/automatic/smartgun/process_chamber()
	. = ..()
	recharging = TRUE
	addtimer(CALLBACK(src, PROC_REF(recharge)), recharge_time)

/obj/item/gun/ballistic/automatic/smartgun/proc/recharge()
	recharging = FALSE
	playsound(src, 'sound/weapons/kenetic_reload.ogg', 60, 1)

/obj/item/gun/ballistic/automatic/smartgun/can_shoot()
	. = ..()
	if(recharging)
		return FALSE

/obj/item/gun/ballistic/automatic/smartgun/update_icon()
	. = ..()
	if(!magazine)
		icon_state = "smartgun_open"
	else
		icon_state = "smartgun_closed"

/obj/item/ammo_box/magazine/smartgun
	name = "\improper SMART-Rifle magazine"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "smartgun"
	ammo_type = /obj/item/ammo_casing/smartgun
	caliber = "smartgun"
	max_ammo = 5
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/gun/ballistic/automatic/smartgun/nomag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/smartgun/scoped
	name = "\improper OP-10 'S.M.A.R.T.' Rifle";
	desc = "Suppressive Manual Action Reciprocating Taser rifle. A gauss rifle fitted to fire miniature shock-bolts. Looks like this one is prety heavy, but it has a scope on it.";
	recharge_time = 6 SECONDS;
	recoil = 3;
	slowdown = 0.25;

/obj/item/gun/ballistic/automatic/smartgun/scoped/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1.5)


/obj/structure/closet/secure_closet/smartgun
	name = "smartgun locker"
	req_access = list(ACCESS_ARMORY)
	icon_state = "shotguncase"

/obj/structure/closet/secure_closet/smartgun/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/smartgun/nomag(src)
	new /obj/item/ammo_box/magazine/smartgun(src)
	new /obj/item/ammo_box/magazine/smartgun(src)
	new /obj/item/ammo_box/magazine/smartgun(src)

/*
*	G11
*/

/obj/item/gun/ballistic/automatic/g11
	name = "\improper G11 K-490"
	desc = "An outdated german caseless battle rifle that has been revised countless times during the late 2400s. Takes 4.73x33mm toploaded magazines."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/g11.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	icon_state = "g11"
	inhand_icon_state = "g11"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/g11.dmi'
	worn_icon_state = "g11_worn"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_OCLOTHING
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/g11
	can_suppress = FALSE
	fire_delay = 0.5
	spread = 10
	mag_display = TRUE
	mag_display_ammo = TRUE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/ltrifle_fire.ogg'
	can_bayonet = TRUE

/obj/item/gun/ballistic/auotmatic/g11/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/g11/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_OLDARMS)

/obj/item/ammo_box/magazine/multi_sprite/g11
	name = "\improper G-11 magazine"
	desc = "A magazine for the G-11 rifle, meant to be filled with angry propellant cubes. Chambered for 4.73mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "g11"
	ammo_type = /obj/item/ammo_casing/caseless/b473
	caliber = CALIBER_473MM
	max_ammo = 50
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/multi_sprite/g11/hp
	ammo_type = /obj/item/ammo_casing/caseless/b473/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/g11/ihdf
	ammo_type = /obj/item/ammo_casing/caseless/b473/ihdf
	round_type = AMMO_TYPE_IHDF

/*
*	SHOTGUNS
*/

/obj/item/gun/ballistic/shotgun/m23
	name = "\improper Model 23-37"
	desc = "An outdated police shotgun sporting an eight-round tube, chambered in twelve-gauge."
	icon_state = "riotshotgun"
	worn_icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns_back.dmi'
	inhand_icon_state = "shotgun"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/m23
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_OCLOTHING

/obj/item/gun/ballistic/shotgun/m23/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_BOLT)

/obj/item/ammo_box/magazine/internal/shot/m23
	name = "m23 shotgun internal magazine"
	caliber = CALIBER_SHOTGUN
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot
	max_ammo = 8

/obj/item/gun/ballistic/shotgun/automatic/as2
	name = "\improper M2 auto-shotgun"
	desc = "A semi-automatic twelve-gauge shotgun with a four-round internal tube."
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns.dmi'
	icon_state = "as2"
	worn_icon_state = "riotshotgun"
	worn_icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns_back.dmi'
	lefthand_file = 'modular_skyrat/modules/aesthetics/guns/icons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/aesthetics/guns/icons/guns_righthand.dmi'
	inhand_icon_state = "riot_shotgun"
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	can_suppress = TRUE
	suppressed_sound = 'modular_skyrat/modules/aesthetics/guns/sound/suppressed_shotgun.ogg'
	suppressed_volume = 100
	vary_fire_sound = TRUE
	fire_sound = 'modular_skyrat/modules/aesthetics/guns/sound/shotgun_light.ogg'
	fire_delay = 5
	mag_type = /obj/item/ammo_box/magazine/internal/shot/as2
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_OCLOTHING

/obj/item/gun/ballistic/shotgun/automatic/as2/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_ARMADYNE)

/obj/item/ammo_box/magazine/internal/shot/as2
	name = "shotgun internal magazine"
	caliber = CALIBER_SHOTGUN
	ammo_type = /obj/item/ammo_casing/shotgun
	max_ammo = 4

/*
*	NORWIND
*/
/obj/item/gun/ballistic/automatic/norwind
	name = "\improper Norwind rifle"
	desc = "A rare M112 DMR rechambered to 12.7x30mm for peacekeeping work, it comes with a scope for medium-long range engagements. A bayonet lug is visible."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/norwind.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/norwind.dmi'
	worn_icon_state = "norwind_worn"
	icon_state = "norwind"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_OCLOTHING
	inhand_icon_state = "norwind"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/norwind.dmi'
	worn_icon_state = "norwind_worn"
	alt_icons = TRUE
	alt_icon_state = "norwind_worn"
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/norwind
	can_suppress = FALSE
	can_bayonet = TRUE
	mag_display = TRUE
	mag_display_ammo = TRUE
	actions_types = null
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/ltrifle_fire.ogg'
	burst_size = 1
	fire_delay = 10
	actions_types = list()

/obj/item/gun/ballistic/automatic/norwind/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1.75)

/obj/item/gun/ballistic/automatic/norwind/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_ARMADYNE)

/obj/item/gun/ballistic/automatic/norwind/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', light_overlay = "flight")

/obj/item/ammo_box/magazine/multi_sprite/norwind
	name = "\improper Norwind magazine"
	desc = "An eight-round magazine for the Norwind DMR, chambered for 12mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "norwind"
	ammo_type = /obj/item/ammo_casing/b12mm
	caliber = CALIBER_12MM
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_HOLLOWPOINT, AMMO_TYPE_RUBBER)

/obj/item/ammo_box/magazine/multi_sprite/norwind/hp
	ammo_type = /obj/item/ammo_casing/b12mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/norwind/rubber
	ammo_type = /obj/item/ammo_casing/b12mm/rubber
	round_type = AMMO_TYPE_RUBBER

/*
*	VINTOREZ
*/

/obj/item/gun/ballistic/automatic/vintorez
	name = "\improper VKC 'Vintorez'"
	desc = "The VKC Vintorez is a lightweight integrally-suppressed scoped carbine usually employed in stealth operations. It was rechambered to 9x19mm for peacekeeping work."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/vintorez.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	icon_state = "vintorez"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/norwind.dmi'
	worn_icon_state = "norwind_worn"
	alt_icons = TRUE
	alt_icon_state = "vintorez_worn"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_OCLOTHING
	inhand_icon_state = "vintorez"
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/vintorez
	suppressed = TRUE
	can_unsuppress = FALSE
	can_bayonet = FALSE
	mag_display = FALSE
	mag_display_ammo = FALSE
	fire_delay = 4
	spread = 10
	fire_sound = 'sound/weapons/gun/smg/shot_suppressed.ogg'
	projectile_damage_multiplier = 0.5

/obj/item/gun/ballistic/automatic/vintorez/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/scope, range_modifier = 1.5)

	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/vintorez/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_OLDARMS)

/obj/item/ammo_box/magazine/multi_sprite/vintorez
	name = "\improper VKC magazine"
	desc = "A twenty-round magazine for the VKC marksman rifle, chambered in 9x25mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "norwind"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 20
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/multi_sprite/vintorez/hp
	ammo_type = /obj/item/ammo_casing/c9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/vintorez/ihdf
	ammo_type = /obj/item/ammo_casing/c9mm/ihdf
	round_type = AMMO_TYPE_IHDF

/obj/item/ammo_box/magazine/multi_sprite/vintorez/rubber
	ammo_type = /obj/item/ammo_casing/c9mm/rubber
	round_type = AMMO_TYPE_RUBBER

/*
*	PCR-9
*/

/obj/item/gun/ballistic/automatic/pcr
	name = "\improper PCR-9 SMG"
	desc = "An accurate, fast-firing SMG chambered in 9x19mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/pcr.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/ostwind.dmi'
	worn_icon_state = "ostwind_worn"
	inhand_icon_state = "pcr"
	icon_state = "pcr"
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_OCLOTHING
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/pcr
	fire_delay = 1.80
	can_suppress = FALSE
	spread = 10
	can_bayonet = FALSE
	mag_display = TRUE
	mag_display_ammo = TRUE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/smg_fire.ogg'
	projectile_damage_multiplier = 0.5

/obj/item/gun/ballistic/automatic/pcr/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/pcr/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_BOLT)

/obj/item/gun/ballistic/automatic/pcr/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', light_overlay = "flight")

/obj/item/ammo_box/magazine/multi_sprite/pcr
	name = "\improper PCR-9 magazine"
	desc = "A thirty-two round magazine for the PCR-9 submachine gun, chambered for 9x25mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pcr"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 32
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/multi_sprite/pcr/hp
	ammo_type = /obj/item/ammo_casing/c9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/pcr/ihdf
	ammo_type = /obj/item/ammo_casing/c9mm/ihdf
	round_type = AMMO_TYPE_IHDF

/obj/item/ammo_box/magazine/multi_sprite/pcr/rubber
	ammo_type = /obj/item/ammo_casing/c9mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/gun/ballistic/automatic/pitbull
	name = "\improper Pitbull PDW"
	desc = "A sturdy personal defense weapon designed to fire 10mm Auto rounds."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/pitbull.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	inhand_icon_state = "pitbull"
	icon_state = "pitbull"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/ostwind.dmi'
	worn_icon_state = "ostwind_worn"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_OCLOTHING
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/pitbull
	fire_delay = 4.20
	can_suppress = FALSE
	burst_size = 3
	spread = 15
	actions_types = list(/datum/action/item_action/toggle_firemode)
	mag_display = TRUE
	mag_display_ammo = TRUE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/sfrifle_fire.ogg'
	can_bayonet = TRUE
	projectile_damage_multiplier = 0.7

/obj/item/gun/ballistic/automatic/pitbull/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/pitbull/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_BOLT)

/obj/item/gun/ballistic/automatic/pitbull/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', light_overlay = "flight")

/obj/item/ammo_box/magazine/multi_sprite/pitbull
	name = "\improper Pitbull magazine"
	desc = "A twenty-four round magazine for the Pitbull PDW, chambered in 10mm Auto."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pcr"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = CALIBER_10MM
	max_ammo = 24
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/multi_sprite/pitbull/hp
	ammo_type = /obj/item/ammo_casing/c10mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/pitbull/ihdf
	ammo_type = /obj/item/ammo_casing/c10mm/ihdf
	round_type = AMMO_TYPE_IHDF

/obj/item/ammo_box/magazine/multi_sprite/pitbull/rubber
	ammo_type = /obj/item/ammo_casing/c10mm/rubber
	round_type = AMMO_TYPE_RUBBER

/*
*	DTR-6
*/

/obj/item/gun/ballistic/automatic/ostwind
	name = "\improper DTR-6 Rifle"
	desc = "A 6.3mm special-purpose rifle designed to deal with threats uniquely. You feel like this is a support type firearm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ostwind.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	inhand_icon_state = "ostwind"
	icon_state = "ostwind"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/ostwind.dmi'
	worn_icon_state = "ostwind_worn"
	alt_icons = TRUE
	alt_icon_state = "ostwind_worn"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_OCLOTHING
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/ostwind
	spread = 10
	fire_delay = 2
	can_suppress = FALSE
	burst_size = 2
	actions_types = list(/datum/action/item_action/toggle_firemode)
	mag_display = TRUE
	mag_display_ammo = TRUE
	fire_sound = 'sound/weapons/gun/smg/shot.ogg'
	can_bayonet = TRUE

/obj/item/gun/ballistic/automatic/ostwind/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/ostwind/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_ARMADYNE)

/obj/item/ammo_box/magazine/multi_sprite/ostwind
	name = "\improper DTR-6 magazine"
	desc = "A thirty round double-stack magazine for the DTR-6 rifle, capable of loading flechettes, fragmentation ammo or dissuasive pellets. Chambered for 6.3mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pcr"
	ammo_type = /obj/item/ammo_casing/b6mm
	caliber = CALIBER_6MM
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_RUBBER, AMMO_TYPE_IHDF)

/obj/item/ammo_box/magazine/multi_sprite/ostwind/rubber
	ammo_type = /obj/item/ammo_casing/b6mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/ostwind/ihdf
	ammo_type = /obj/item/ammo_casing/b6mm/ihdf
	round_type = AMMO_TYPE_IHDF
