/*
*	PISTOLS
*/

/obj/item/gun/ballistic/automatic/pistol/cfa_snub
	name = "CFA Snub"
	desc = "An  easily-concealable pistol chambered for 4.2x30mm."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile.dmi'
	icon_state = "cfa-snub"
	accepted_magazine_type = /obj/item/ammo_box/magazine/multi_sprite/cfa_snub
	can_suppress = TRUE
	fire_sound_volume = 30
	w_class = WEIGHT_CLASS_SMALL

/obj/item/gun/ballistic/automatic/pistol/cfa_snub/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_CANTALAN)

/obj/item/gun/ballistic/automatic/pistol/cfa_snub/give_gun_safeties()
	return

/obj/item/gun/ballistic/automatic/pistol/cfa_snub/empty
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/cfa_ruby
	name = "CFA Ruby"
	desc = "A heavy-duty sidearm chambered in 12x27mm."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile.dmi'
	icon_state = "cfa_ruby"
	accepted_magazine_type = /obj/item/ammo_box/magazine/multi_sprite/cfa_ruby
	can_suppress = FALSE
	fire_sound_volume = 120
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/gun/ballistic/automatic/pistol/cfa_ruby/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_CANTALAN)

/obj/item/gun/ballistic/automatic/pistol/cfa_ruby/give_gun_safeties()
	return

/obj/item/gun/ballistic/automatic/pistol/cfa_ruby/empty
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/enforcer
	name = "\improper Enforcer-TEN handgun"
	desc = "A robust, full-size handgun, chambered in 10mm. Built for the discerning customer, and derived from a higher-caliber design. \
	Uses the same magazines as the Ansem, but lacks a threaded barrel, leaving it unable to be suppressed."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile.dmi'
	icon_state = "baymagnum"
	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/weapons/guns_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/weapons/guns_right.dmi'
	inhand_icon_state = "magnum"
	force = 12 // every problem a nail
	can_suppress = FALSE
	accepted_magazine_type = /obj/item/ammo_box/magazine/m10mm
	fire_sound_volume = 120
	w_class = WEIGHT_CLASS_NORMAL
	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/gunshot_strong.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	load_sound = 'modular_skyrat/modules/modular_weapons/sounds/hpistol_magin.ogg'
	load_empty_sound = 'modular_skyrat/modules/modular_weapons/sounds/hpistol_magin.ogg'
	eject_sound = 'modular_skyrat/modules/modular_weapons/sounds/hpistol_magout.ogg'
	eject_empty_sound = 'modular_skyrat/modules/modular_weapons/sounds/hpistol_magout.ogg'
	empty_indicator = TRUE
	/// Do we show the loaded chamber indicator? If changing the icon, either have both this and a safety indicator, or turn these off.
	var/chamber_indicator_overlay = TRUE
	/// Do we show the safety light indicator?
	var/safety_indicator_overlay = TRUE

/obj/item/gun/ballistic/automatic/pistol/enforcer/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_GUN_SAFETY_TOGGLED, PROC_REF(safety_toggled))

/obj/item/gun/ballistic/automatic/pistol/enforcer/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SCARBOROUGH)

/obj/item/gun/ballistic/automatic/pistol/enforcer/examine_more(mob/user)
	. = ..()
	. += "The Enforcer series of full-frame handguns is defined by their common base chassis and single-stack magazines, \
	allowing for reduced weight and thinner profiles. This makes them popular choices in regards to ease of use, ease of (non-concealed) carry - \
	and still being upheld to Scarborough Arms's high standards in terms of reliability and performance. While not as concealable as \
	some of their other more popular (or, to Nanotrasen, infamous) offerings, such as the Makarov or the Ansem handguns, and not offering enough stopping power \
	to be classified as a true \"hand cannon,\" the 10mm offering is popular amongst those looking for a no-frills handgun \
	that can reliably drop a target - and not break the bank, nor the wrist, while doing so."
	return .

/// this proc exists for the sole purpose of listening for safety toggles and refreshing our overlays
/obj/item/gun/ballistic/automatic/pistol/enforcer/proc/safety_toggled()
	SIGNAL_HANDLER
	update_appearance()

/obj/item/gun/ballistic/automatic/pistol/enforcer/update_overlays()
	. = ..()
	// chamber light indicator
	if(chamber_indicator_overlay)
		if(chambered)
			. += "[icon_state]_chambered"
	// safety indicator
	if(safety_indicator_overlay)
		var/datum/component/gun_safety/our_safety = GetComponent(/datum/component/gun_safety)
		if(our_safety.safety_currently_on)
			. += "[icon_state]_safety-on"
		else
			. += "[icon_state]_safety-off"

/*
*	AMMO
*/

/obj/item/ammo_box/magazine/multi_sprite/cfa_snub
	name = "CFA Snub magazine (4.2x30mm)"
	desc = "An advanced magazine with smart type displays. Alt+click to reskin it."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/ammo.dmi'
	icon_state = "m42x30"
	possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_AP, AMMO_TYPE_RUBBER, AMMO_TYPE_INCENDIARY)
	ammo_type = /obj/item/ammo_casing/c42x30mm
	caliber = CALIBER_42X30MM
	max_ammo = 16
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/multi_sprite/cfa_snub/ap
	ammo_type = /obj/item/ammo_casing/c42x30mm/ap
	round_type = AMMO_TYPE_AP

/obj/item/ammo_box/magazine/multi_sprite/cfa_snub/rubber
	ammo_type = /obj/item/ammo_casing/c42x30mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/cfa_snub/incendiary
	ammo_type = /obj/item/ammo_casing/c42x30mm/inc
	round_type = AMMO_TYPE_INCENDIARY

/obj/item/ammo_box/magazine/multi_sprite/cfa_snub/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby
	name = "CFA Ruby magazine (12mm Magnum)"
	desc = "An advanced magazine with smart type displays. Alt+click to reskin it."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/ammo.dmi'
	icon_state = "m12mm"
	possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_AP, AMMO_TYPE_RUBBER, AMMO_TYPE_HOLLOWPOINT, AMMO_TYPE_INCENDIARY)
	ammo_type = /obj/item/ammo_casing/c12mm
	caliber = CALIBER_12MM
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/ap
	ammo_type = /obj/item/ammo_casing/c12mm/ap
	round_type = AMMO_TYPE_AP

/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/rubber
	ammo_type = /obj/item/ammo_casing/c12mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/hp
	ammo_type = /obj/item/ammo_casing/c12mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/incendiary
	ammo_type = /obj/item/ammo_casing/c12mm/fire
	round_type = AMMO_TYPE_INCENDIARY
