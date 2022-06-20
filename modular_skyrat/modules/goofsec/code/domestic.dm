#define CALIBER_SECURITYPISTOL "Inhumane"

/// The Domestic.
/obj/item/gun/ballistic/automatic/pistol/security
	name = "'Domestic' Pistol"
	desc = "A pistol issued to station security personnel by Lopland. It's a small, compact pistol, but it packs a punch."
	mag_type = /obj/item/ammo_box/magazine/security_pistol
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ladon.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand40x32.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand40x32.dmi'
	icon_state = "ladon"
	inhand_icon_state = "ladon"
	can_suppress = FALSE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/pistol_fire.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'

// fucking guncode means i have to have the basetype be the magazine that spawns loaded in the gun if i want it to spawn loaded
// if I made it spawn loaded with a nonlethal magazine, then it could only load the nonlethal magazines,
// so instead the base mag type needs to be a mirror of the non-lethal one to pretend to be it
/obj/item/ammo_box/magazine/security_pistol
	name = "Nonlethal Domestic magazine"
	desc = "A magazine for the Domestic. Loaded with non-lethal Influence rounds, which bounce around and influence people to comply with arrests.\
	<br><br>\
	<i>Fires non-lethal stamina bullets that can ricochet up to 6 times. Pacifist compatible.</i>"
	icon = 'modular_skyrat/modules/goofsec/icons/gun_sprites.dmi'
	icon_state = "security_pistol_influence"
	base_icon_state = "security_pistol_influence"
	ammo_type = /obj/item/ammo_casing/security_pistol/influence
	caliber = CALIBER_SECURITYPISTOL
	max_ammo = 20

/obj/item/ammo_box/magazine/security_pistol/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][ammo_count() ? "" : "-empty"]"

/// Ammo for the Domestic.
/obj/item/ammo_casing/security_pistol // Abstract type for inheritance to avoid copypaste
	name = "debug inhumane casing"
	desc = "A casing for a Domestic magazine. If you see this, file a bug report."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sl-casing"
	caliber = CALIBER_SECURITYPISTOL
	projectile_type = /obj/projectile/bullet/security_pistol

/obj/projectile/bullet/security_pistol
	name = "debug inhumane bullet"
	damage = 0 // not supposed to exist, this is an abstract type for inheritance

// Influence rounds. Bouncy. Stamina only.
/obj/item/ammo_box/magazine/security_pistol/influence
	name = "Nonlethal Domestic magazine"
	desc = "A magazine for the Domestic. Loaded with Nonlethal rounds, which bounce around and influence people to comply with arrests.\
	<br><br>\
	<i>Fires non-lethal stamina bullets that can ricochet up to 6 times. Pacifist compatible.</i>"
	icon_state = "security_pistol_influence"
	base_icon_state = "security_pistol_influence"
	ammo_type = /obj/item/ammo_casing/security_pistol/influence

/obj/item/ammo_casing/security_pistol/influence
	name = "Nonlethal inhumane casing"
	projectile_type = /obj/projectile/bullet/security_pistol/influence
	harmful = FALSE

/obj/projectile/bullet/security_pistol/influence
	name = "Nonlethal inhumane bullet"
	damage = 30
	damage_type = STAMINA
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	wound_bonus = CANT_WOUND

// TRAC rounds. Lower raw damage. Puts a tracking chip in the target, embeds. Penetrates armor.
/obj/item/ammo_box/magazine/security_pistol/trac
	name = "trac Domestic magazine"
	desc = "A magazine for the Domestic. Loaded with TRAC rounds, which embed a tracking chip in the target, while also being handy against armor.\
	<br><br>\
	<i>Fires armor piercing bullets with a high embed chance that embed a Tracking Implant in the target for a duration of time. \
	Track them with a Bluespace Locator or the console for tracking implants.</i>"
	icon_state = "security_pistol_trac"
	base_icon_state = "security_pistol_trac"
	ammo_type = /obj/item/ammo_casing/security_pistol/trac

/obj/item/ammo_casing/security_pistol/trac
	name = "trac inhumane casing"
	projectile_type = /obj/projectile/bullet/security_pistol/trac

/obj/projectile/bullet/security_pistol/trac
	name = "trac inhumane bullet"
	damage = 25
	armour_penetration = 75
	embedding = list(embed_chance=75, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=1 SECONDS)
	wound_falloff_tile = -5
	embed_falloff_tile = -15

/obj/projectile/bullet/security_pistol/trac/on_hit(atom/target, blocked = FALSE)
	. = ..()
	var/mob/living/carbon/perp = target
	if(!istype(perp))
		return
	var/obj/item/implant/tracking/c38/implant
	for(var/obj/item/implant/tracking/c38/tracking_implant in perp.implants) //checks if the target already contains a tracking implant
		implant = tracking_implant
		return
	if(!implant)
		implant = new /obj/item/implant/tracking/c38(perp)
		implant.implant(perp)

// Iceblox Rounds. Lower raw damage. Makes the target cold.
/obj/item/ammo_box/magazine/security_pistol/iceblox
	name = "iceblox Domestic magazine"
	desc = "A magazine for the Domestic. Loaded with Iceblox rounds, which make the target cold.\
	<br><br>\
	<i>Fires cold bullets that make the target cold.</i>"
	icon_state = "security_pistol_iceblox"
	base_icon_state = "security_pistol_iceblox"
	ammo_type = /obj/item/ammo_casing/security_pistol/iceblox

/obj/item/ammo_casing/security_pistol/iceblox
	name = "iceblox inhumane casing"
	projectile_type = /obj/projectile/bullet/security_pistol/iceblox

/obj/projectile/bullet/security_pistol/iceblox
	name = "iceblox inhumane bullet"
	damage = 25
	var/temperature = 100

/obj/projectile/bullet/security_pistol/iceblox/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(isliving(target))
		var/mob/living/perp = target
		perp.adjust_bodytemperature(((100-blocked)/100)*(temperature - perp.bodytemperature))

// Hyperlethal rounds. Lower raw damage. Aggressively violent wounds and embeds.
/obj/item/ammo_box/magazine/security_pistol/cruelty
	name = "Hyperlethal Domestic magazine"
	desc = "A magazine for the Domestic. Loaded with Hyperlethal rounds, which slice through biological matter in a manner banned by the Spinward Stellar Coalition, \
	after they were used by Lopland contractors to remove a nudist ecological protest from a plasma drilling operation.\
	<br><br>\
	<i>Fires slicing wound inflicting bullets that have a high wound chance, a <b>very</b> high wound chance against bare limbs, and an <b>extremely> high embed chance.</i>"
	icon_state = "security_pistol_cruelty"
	base_icon_state = "security_pistol_cruelty"
	ammo_type = /obj/item/ammo_casing/security_pistol/cruelty

/obj/item/ammo_casing/security_pistol/cruelty
	name = "Hyperlethal inhumane casing"
	projectile_type = /obj/projectile/bullet/security_pistol/cruelty

/obj/projectile/bullet/security_pistol/cruelty
	name = "Hyperlethal inhumane bullet"
	damage = 25
	sharpness = SHARP_EDGED
	wound_bonus = 50
	bare_wound_bonus = 100
	embedding = list(embed_chance=100, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=1 SECONDS)

// Geiger rounds. Reduced damage. Irradiation.
/obj/item/ammo_box/magazine/security_pistol/geiger
	name = "geiger Domestic magazine"
	desc = "A magazine for the Domestic. Loaded with Geiger rounds, which irradiate the target and those around them.\
	<br><br>\
	<i>Fires radioactive bullets that irradiate both the target hit and everyone adjacent to them, including diagonals.</i>"
	icon_state = "security_pistol_rad"
	base_icon_state = "security_pistol_rad"
	ammo_type = /obj/item/ammo_casing/security_pistol/geiger

/obj/item/ammo_casing/security_pistol/geiger
	name = "geiger inhumane casing"
	projectile_type = /obj/projectile/bullet/security_pistol/geiger

/obj/projectile/bullet/security_pistol/geiger
	name = "geiger inhumane bullet"
	damage = 25

/obj/projectile/bullet/security_pistol/geiger/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if (ishuman(target))
		target.AddComponent(/datum/component/irradiated)
		radiation_pulse(target, max_range = 1, threshold = RAD_LIGHT_INSULATION)

// Wealth rounds. Set goals. Have a ten year plan. Invest. Wake up early. CEO mindset. Good luck.
/obj/item/ammo_box/magazine/security_pistol/ceo_mindset
	name = "Wealth Domestic magazine"
	desc = "A magazine for the Domestic. Loaded with Wealth rounds, which set goals and have a ten year plan. Invest. Wake up early. CEO mindset. Good luck.\
	<br><br>\
	<i>Fires wealth bullets that do damage based on your current ID card balance. The richer, the more damage they do.</i>"
	icon_state = "security_pistol_ceo_mindset"
	base_icon_state = "security_pistol_ceo_mindset"
	ammo_type = /obj/item/ammo_casing/security_pistol/ceo_mindset

/obj/item/ammo_casing/security_pistol/ceo_mindset
	name = "Wealth inhumane casing"
	projectile_type = /obj/projectile/bullet/security_pistol/ceo_mindset

/obj/projectile/bullet/security_pistol/ceo_mindset
	name = "Wealth inhumane bullet"
	damage = 0
	var/damage_brackets = list(5, 15, 30, 35, 50, 60)
	var/wealth_brackets = list(25, 150, 350, 500, 1000, 5000)

/obj/projectile/bullet/security_pistol/ceo_mindset/on_hit(atom/target, blocked = FALSE)
	if(!firer || !isliving(firer))
		return ..()
	var/mob/living/potential_customer = firer
	var/obj/item/card/id/ID = potential_customer.get_idcard(TRUE)
	if(!ID)
		return ..()
	var/datum/bank_account/account = ID.registered_account
	if(!account)
		return ..()
	var/investment_level = 0
	for(var/i in 1 to length(wealth_brackets))
		if(account.account_balance >= wealth_brackets[i])
			investment_level = min(damage_brackets[i] * (account.account_balance / wealth_brackets[i]), damage_brackets[i])
			continue
	damage = investment_level
	. = ..()


/// Print designs.
/datum/design/security_pistol_magazine
	name = "If you can see this, tell a coder!"
	desc = "If you can see this, tell a coder!"
	id = "security_pistol_magazine"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 10000)
	build_path = /obj/item/ammo_box/magazine/security_pistol
	category = list("Ammo")
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/security_pistol_magazine/influence
	name = "Domestic Magazine (Nonlethal)"
	desc = "Nonlethal rounds for your Domestic."
	id = "security_pistol_magazine_influence"
	build_path = /obj/item/ammo_box/magazine/security_pistol/influence

/datum/design/security_pistol_magazine/trac
	name = "Domestic Magazine (TRAC)"
	desc = "TRAC rounds for your Domestic."
	id = "security_pistol_magazine_trac"
	build_path = /obj/item/ammo_box/magazine/security_pistol/trac

/datum/design/security_pistol_magazine/iceblox
	name = "Domestic Magazine (Iceblox)"
	desc = "Iceblox rounds for your Domestic."
	id = "security_pistol_magazine_iceblox"
	build_path = /obj/item/ammo_box/magazine/security_pistol/iceblox

/datum/design/security_pistol_magazine/cruelty
	name = "Domestic Magazine (Hyperlethal)"
	desc = "Hyperlethal rounds for your Domestic."
	id = "security_pistol_magazine_cruelty"
	build_path = /obj/item/ammo_box/magazine/security_pistol/cruelty

/datum/design/security_pistol_magazine/geiger
	name = "Domestic Magazine (Geiger)"
	desc = "Geiger rounds for your Domestic."
	id = "security_pistol_magazine_geiger"
	build_path = /obj/item/ammo_box/magazine/security_pistol/geiger

/datum/design/security_pistol_magazine/ceo_mindset
	name = "Domestic Magazine (Wealth)"
	desc = "Wealth rounds for your Domestic."
	id = "security_pistol_magazine_ceo_mindset"
	build_path = /obj/item/ammo_box/magazine/security_pistol/ceo_mindset

/datum/supply_pack/security/armory/security_pistol
	name = "Domestic Crate"
	desc = "Three Domestics, if your security team gets disarmed."
	cost = CARGO_CRATE_VALUE * 6
	contains = list(/obj/item/gun/ballistic/automatic/pistol/security,
					/obj/item/gun/ballistic/automatic/pistol/security,
					/obj/item/gun/ballistic/automatic/pistol/security)
	crate_name = "Domestic crate"
