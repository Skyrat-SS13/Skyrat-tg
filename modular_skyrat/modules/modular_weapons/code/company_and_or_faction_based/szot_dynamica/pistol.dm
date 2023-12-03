// Plasma spewing pistol
// Sprays a wall of plasma that sucks against armor but fucks against unarmored targets

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower
	name = "\improper Szot 'Słońce' plasma projector"
	desc = "An outdated sidearm rarely seen in use by some members of the CIN. Spews an inaccurate stream of searing plasma out the magnetic barrel so long as it has power and the trigger is pulled."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_32.dmi'
	icon_state = "slonce"

	fire_sound = 'modular_skyrat/modules/microfusion/sound/incinerate.ogg'
	fire_sound_volume = 40 // This thing is comically loud otherwise

	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/recharge/plasma_battery
	can_suppress = FALSE
	show_bolt_icon = FALSE
	casing_ejector = FALSE
	empty_indicator = FALSE
	bolt_type = BOLT_TYPE_OPEN
	fire_delay = 0.1 SECONDS
	spread = 15

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/automatic_fire, autofire_shot_delay = fire_delay)

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/automatic/pistol/plasma_thrower/examine_more(mob/user)
	. = ..()

	. += "The 'Słońce' started life as an experiment in advancing the field of accelerated \
		plasma weaponry. Despite the design's obvious shortcomings in terms of accuracy and \
		range, the CIN combined military command (which we'll call the CMC from now on) took \
		interest in the weapon as a means to counter Sol's more advanced armor technology. \
		As it would turn out, the plasma globules created by the weapon were really not \
		as effective against armor as the CMC had hoped, quite the opposite actually. \
		What the plasma did do well however was inflict grevious burns upon anyone unfortunate \
		enough to get hit by it unprotected. For this reason, the 'Słońce' saw frequent use by \
		army officers and ship crews who needed a backup weapon to incinerate the odd space \
		pirate or prisoner of war."

	return .

// Plasma sharpshooter pistol
// Shoots single, strong plasma blasts at a slow rate

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman
	name = "\improper Szot 'Gwiazda' plasma sharpshooter"
	desc = "An outdated sidearm rarely seen in use by some members of the CIN. Fires relatively accurate globs of searing plasma."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_32.dmi'
	icon_state = "gwiazda"

	fire_sound = 'modular_skyrat/modules/microfusion/sound/burn.ogg'
	fire_sound_volume = 40 // This thing is comically loud otherwise

	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/recharge/plasma_battery
	can_suppress = FALSE
	show_bolt_icon = FALSE
	casing_ejector = FALSE
	empty_indicator = FALSE
	bolt_type = BOLT_TYPE_OPEN
	fire_delay = 0.6 SECONDS
	spread = 2.5

	projectile_damage_multiplier = 3 // 30 damage a shot
	projectile_wound_bonus = 10 // +55 of the base projectile, burn baby burn

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/automatic/pistol/plasma_marksman/examine_more(mob/user)
	. = ..()

	. += "The 'Gwiazda' is a further refinement of the 'Słońce' design. with improved \
		energy cycling, magnetic launchers built to higher precision, and an overall more \
		ergonomic design. While it still fails to perform against armor, the weapon is \
		significantly more accurate and higher power, at expense of a much lower firerate. \
		Opinions on this weapon within military service were highly mixed, with many preferring \
		the sheer stopping power a spray of plasma could produce, with others loving the new ability \
		to hit something in front of you for once."

	return .

// A revolver, but it can hold shotgun shells
// Woe, buckshot be upon ye

/obj/item/gun/ballistic/revolver/shotgun_revolver
	name = "\improper Szot 'Bóbr' 12 GA revolver"
	desc = "An outdated sidearm rarely seen in use by some members of the CIN. A revolver type design with a four shell cylinder. That's right, shell, this one shoots twelve guage."
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder/rev12ga
	recoil = SAWN_OFF_RECOIL
	weapon_weight = WEAPON_MEDIUM
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_32.dmi'
	icon_state = "bobr"
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/revolver_fire.ogg'
	spread = SAWN_OFF_ACC_PENALTY

/obj/item/gun/ballistic/revolver/shotgun_revolver/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/revolver/shotgun_revolver/examine_more(mob/user)
	. = ..()

	. += "The 'Bóbr' started development as a limited run sporting weapon before \
		the military took interest. The market quickly changed from sport shooting \
		targets, to sport shooting SolFed strike teams once the conflict broke out. \
		This pattern is different from the original civilian version, with a military \
		standard pistol grip and weather resistant finish. While the 'Bóbr' was not \
		a weapon standard issued to every CIN soldier, it was available for relatively \
		cheap, and thus became rather popular among the ranks."

	return .
