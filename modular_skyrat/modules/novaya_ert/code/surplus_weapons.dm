// Plasma spewing pistol
// Sprays a wall of plasma that sucks against armor but fucks against unarmored targets

/obj/item/gun/energy/laser/plasma_thrower
	name = "\improper Tkach 'Zirka' plasma projector"
	desc = "An outdated sidearm rarely seen in use by some members of the CIN. Spews an inaccurate stream of searing plasma out the magnetic barrel so long as it has power and the trigger is pulled."
	icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_guns/guns_32.dmi'
	icon_state = "plasmathrower"

	fire_sound = 'modular_skyrat/modules/microfusion/sound/incinerate.ogg'
	fire_sound_volume = 40 // This thing is comically loud otherwise

	w_class = WEIGHT_CLASS_NORMAL
	can_suppress = FALSE
	fire_delay = 1
	spread = 15

	ammo_type = list(/obj/item/ammo_casing/energy/laser/plasma_glob)

/obj/item/gun/energy/laser/plasma_thrower/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.1 SECONDS)

/obj/item/gun/energy/laser/plasma_thrower/examine(mob/user)
	. = ..()
	. += "The plasma globs have <b>reduced effectiveness against blobs</b>."

/obj/item/gun/energy/laser/plasma_thrower/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_TKACH)

/obj/item/gun/energy/laser/plasma_thrower/examine_more(mob/user)
	. = ..()
	. += "The Zirka started life as an experiment in advancing the field of accelerated \
		plasma weaponry. Despite the design's obvious shortcomings in terms of accuracy and \
		range, the CIN combined military command (which we'll call the CMC from now on) took \
		interest in the weapon as a means to counter Sol's more advanced armor technology. \
		As it would turn out, the plasma globules created by the weapon were really not \
		as effective against armor as the CMC had hoped, quite the opposite actually. \
		What the plasma did do well however was inflict grevious burns upon anyone unfortunate \
		enough to get hit by it unprotected. For this reason, the Zirka saw frequent use by \
		army officers and ship crews who needed a backup weapon to incinerate the odd space \
		pirate or prisoner of war."

// Casing and projectile for the plasma thrower
/obj/item/ammo_casing/energy/laser/plasma_glob
	projectile_type = /obj/projectile/beam/laser/plasma_glob
	fire_sound = 'modular_skyrat/modules/microfusion/sound/incinerate.ogg'
	e_cost = 50

/obj/projectile/beam/laser/plasma_glob
	name = "plasma globule"
	icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_guns/ammo.dmi'
	icon_state = "plasma_glob"
	damage = 10
	speed = 1.5
	bare_wound_bonus = 75 // Lasers already get wild wound bonus this is just a bit higher than that
	wound_bonus = -50
	pass_flags = PASSTABLE | PASSGRILLE // His ass does NOT pass through glass!
	weak_against_armour = TRUE

/obj/projectile/beam/laser/plasma_glob/on_hit(atom/target, blocked)
	if(istype(target, /obj/structure/blob) || istype(target, /mob/living/simple_animal/hostile/blob))
		damage = damage * 0.75
	return ..()

// A revolver, but it can hold shotgun shells
// Woe, buckshot be upon ye

/obj/item/gun/ballistic/revolver/cin_shotgun_revolver
	name = "\improper Tkach 'Ya-Sui' 12 GA revolver"
	desc = "An outdated sidearm rarely seen in use by some members of the CIN. A revolver type design with a three shell cylinder. That's right, shell, this one shoots twelve guage."
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev12ga
	recoil = SAWN_OFF_RECOIL
	weapon_weight = WEAPON_HEAVY
	icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_guns/guns_32.dmi'
	icon_state = "shawty_revolver"
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/revolver_fire.ogg'
	spread = SAWN_OFF_ACC_PENALTY

/obj/item/gun/ballistic/revolver/cin_shotgun_revolver/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_TKACH)

/obj/item/gun/ballistic/revolver/cin_shotgun_revolver/examine_more(mob/user)
	. = ..()

	. += "The Ya-Sui started development as a limited run sporting weapon before \
		the border war broke out. The market quickly changed from sport shooting \
		targets, to sport shooting SolFed strike teams once the conflict broke out. \
		This pattern is different from the original civilian version, with a military \
		standard pistol grip and weather resistant finish. While the Ya-Sui was not \
		a weapon standard issued to every CIN soldier, it was available for relatively \
		cheap, and thus became rather popular among the ranks."

	return .

// Shotgun revolver's cylinder

/obj/item/ammo_box/magazine/internal/cylinder/rev12ga
	name = "\improper 12 GA revolver cylinder"
	ammo_type = /obj/item/ammo_casing/shotgun
	caliber = CALIBER_SHOTGUN
	max_ammo = 3
	multiload = FALSE

// The AMR
// This sounds a lot scarier than it actually is, you'll just have to trust me here

/obj/item/gun/ballistic/automatic/cin_amr
	name = "\improper Tkach-Tsuneyo AMR"
	desc = "A massive, outdated beast of an anti materiel rifle that was once in use by CIN military forces. Fires the devastating .60 Strela caseless round, the massively overperforming penetration of which being the reason this weapon was discontinued."
	icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_guns/guns_64.dmi'
	base_pixel_x = -16 // This baby is 64 pixels wide
	pixel_x = -16
	righthand_file = 'modular_skyrat/modules/novaya_ert/icons/surplus_guns/inhands_64_right.dmi'
	lefthand_file = 'modular_skyrat/modules/novaya_ert/icons/surplus_guns/inhands_64_left.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	worn_icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_guns/onmob.dmi'
	icon_state = "amr"
	inhand_icon_state = "amr"
	worn_icon_state = "amr"
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = ITEM_SLOT_BACK

	mag_type = /obj/item/ammo_box/magazine/cin_amr
	can_suppress = FALSE
	can_bayonet = FALSE

	fire_sound = 'modular_skyrat/modules/novaya_ert/sound/amr_fire.ogg'
	fire_sound_volume = 100 // BOOM BABY

	recoil = 4

	weapon_weight = WEAPON_HEAVY
	burst_size = 1
	fire_delay = 2 SECONDS
	actions_types = list()

	force = 15 // I mean if you're gonna beat someone with the thing you might as well get damage appropriate for how big the fukken thing is

/obj/item/gun/ballistic/automatic/cin_amr/give_manufacturer_examine()

	AddComponent(/datum/component/manufacturer_examine, COMPANY_TKACH)

/obj/item/gun/ballistic/automatic/cin_amr/examine_more(mob/user)
	. = ..()

	. += "The Tkach-Tsuneyo AMR was, as the name may suggest, a cooperation \
		in design between both the Tkach Design Bureau, and an (at the time) \
		relatively new Tsuneyo Defense Systems. The goal was simple, the CIN \
		needed a weapon capable of easily penetrating SolFed armor in a man \
		portable format. What they got was the gun you're looking at now, a \
		monster of a weapon firing a proprietary caseless cartridge that \
		certainly fit the order. The round ended up being so capable, in fact, \
		that the weapon had no use anywhere once the border war ended. This \
		is partially due to the fact that the rounds will go so cleanly through \
		a man that it would be more cost effective to shoot him with any \
		other weapon. It may also just be that the weapon is so large and \
		unwieldy."

	return .

// AMR magazine

/obj/item/ammo_box/magazine/cin_amr
	name = "anti-materiel magazine (.60 Strela)"
	icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_guns/ammo.dmi'
	icon_state = "amr_mag"
	base_icon_state = "amr_mag"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	ammo_type = /obj/item/ammo_casing/caseless/p60strela
	max_ammo = 3
	caliber = CALIBER_60STRELA

// AMR bullet

/obj/item/ammo_casing/caseless/p60strela
	name = ".60 Strela caseless cartridge"
	icon = 'modular_skyrat/modules/novaya_ert/icons/surplus_guns/ammo.dmi'
	icon_state = "amr_bullet"
	desc = "A massive block of propellant with an equally massive round sticking out the top of it."
	caliber = CALIBER_60STRELA
	projectile_type = /obj/projectile/bullet/p60strela

/obj/projectile/bullet/p60strela // The funny thing is, these are wild but you only get three of them
	name =".60 Strela bullet"
	icon_state = "gaussphase"
	speed = 0.4
	damage = 50
	armour_penetration = 75
	wound_bonus = -30
	bare_wound_bonus = -15
	projectile_piercing = PASSGLASS | PASSMACHINE | PASSSTRUCTURE | PASSDOORS | PASSGRILLE // Wallbang (except it cant penetrate walls) baby
