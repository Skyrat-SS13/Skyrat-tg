/obj/item/ammo_casing/energy/laser/hardlight_bullet
	name = "hardlight bullet casing"
	projectile_type = /obj/projectile/beam/laser/hardlight_bullet
	e_cost = 83 // 12 shots with a normal cell.
	select_name = "hardlight bullet"
	fire_sound = 'sound/weapons/gun/pistol/shot.ogg'

 // Not a real bullet, but visually looks like one. For the aesthetic of bullets, while keeping the balance intact.
 // Every piece of armor in the game is currently balanced around "sec has lasers, syndies have bullets". This allows us to keep that balance
 // without sacrificing the bullet aesthetic.
/obj/projectile/beam/laser/hardlight_bullet
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/projectiles.dmi'
	icon_state = "bullet"
	name = "hardlight bullet"
	pass_flags = PASSTABLE // All of the below is to not break kayfabe about it not being a bullet.
	hitsound ='sound/weapons/pierce.ogg'
	hitsound_wall = "ricochet"
	light_system = NO_LIGHT_SUPPORT
	light_range = 0
	light_power = 0
	damage_type = BRUTE // So they do brute damage but still hit laser armor!
	sharpness = SHARP_POINTY
	impact_effect_type = /obj/effect/temp_visual/impact_effect
	shrapnel_type = /obj/item/shrapnel/bullet
	embedding = list(embed_chance=20, fall_chance=2, jostle_chance=0, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.5, pain_mult=3, rip_time=10)

// For calculating ammo, remember that these guns have 1000 unit power cells.

/// Vintorez
/obj/item/gun/energy/vintorez
	name = "\improper VKC 'Vintorez'"
	desc = "The VKC Vintorez is a lightweight integrally-suppressed scoped carbine usually employed in stealth operations from the long since past 20th century."
	icon = 'modular_skyrat/modules/goofsec/icons/gun_sprites.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	icon_state = "vintorez"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/norwind.dmi'
	worn_icon_state = "norwind_worn"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING
	inhand_icon_state = "vintorez"
	burst_size = 2
	fire_delay = 4
	zoomable = TRUE
	zoom_amt = 7
	zoom_out_amt = 5
	fire_sound = null
	ammo_type = list(/obj/item/ammo_casing/energy/laser/hardlight_bullet/vintorez)
	shaded_charge = TRUE
	cell_type = /obj/item/stock_parts/cell/super

/obj/item/ammo_casing/energy/laser/hardlight_bullet/vintorez
	name = "hardlight bullet vintorez casing"
	projectile_type = /obj/projectile/beam/laser/hardlight_bullet/vintorez
	e_cost = 1666 // 27 damage so 12 shots.
	fire_sound = 'sound/weapons/gun/smg/shot_suppressed.ogg'

/obj/projectile/beam/laser/hardlight_bullet/vintorez
	damage = 27 // All security armory firearms need to do, at minimum, laser gun damage.

/obj/item/gun/energy/norwind
	name = "\improper M112 'Norwind'"
	desc = "A rare M112 DMR rechambered to 12.7x30mm for peacekeeping work, it comes with a scope for medium-long range engagements. A bayonet lug is visible."
	icon = 'modular_skyrat/modules/goofsec/icons/gun_sprites.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/norwind.dmi'
	worn_icon_state = "norwind_worn"
	icon_state = "norwind"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING
	inhand_icon_state = "norwind"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/norwind.dmi'
	worn_icon_state = "norwind_worn"
	can_bayonet = TRUE
	can_flashlight = TRUE
	zoomable = TRUE
	zoom_amt = 7
	zoom_out_amt = 5
	fire_sound = null
	fire_select_modes = list(SELECT_SEMI_AUTOMATIC)
	ammo_type = list(/obj/item/ammo_casing/energy/laser/hardlight_bullet/norwind)
	burst_size = 1
	fire_delay = 10
	shaded_charge = TRUE
	cell_type = /obj/item/stock_parts/cell/super

/obj/item/ammo_casing/energy/laser/hardlight_bullet/norwind
	name = "hardlight bullet norwind casing"
	projectile_type = /obj/projectile/beam/laser/hardlight_bullet/norwind
	e_cost = 2857 // 7 shots, does 1.6x damage normal laser so fire cost increased by 1.6x
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/ltrifle_fire.ogg'

/obj/projectile/beam/laser/hardlight_bullet/norwind
	damage = 45

/obj/item/gun/energy/ostwind
	name = "\improper DTR-6 rifle"
	desc = "A 6.3mm special-purpose rifle designed for specific situations."
	icon = 'modular_skyrat/modules/goofsec/icons/gun_sprites.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	inhand_icon_state = "ostwind"
	icon_state = "ostwind"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/ostwind.dmi'
	worn_icon_state = "ostwind_worn"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING
	fire_delay = 2
	burst_size = 2
	fire_sound = null
	can_bayonet = TRUE
	ammo_type = list(/obj/item/ammo_casing/energy/laser/hardlight_bullet/ostwind)
	cell_type = /obj/item/stock_parts/cell/super
/obj/item/ammo_casing/energy/laser/hardlight_bullet/ostwind
	name = "hardlight bullet norostwindwind casing"
	projectile_type = /obj/projectile/beam/laser/hardlight_bullet/ostwind
	e_cost = 1666 // 27 damage so 12 shots.
	fire_sound = 'sound/weapons/gun/smg/shot.ogg'

/obj/projectile/beam/laser/hardlight_bullet/ostwind
	damage = 27 // Minimum damage increase to at least base /tg/ laser gun damage.
	embedding = list(embed_chance=10, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)

/obj/item/gun/energy/pitbull
	name = "\improper Pitbull PDW"
	desc = "A sturdy personal defense weapon designed to fire 10mm Auto rounds."
	icon = 'modular_skyrat/modules/goofsec/icons/gun_sprites.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	inhand_icon_state = "pitbull"
	icon_state = "pitbull"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/ostwind.dmi'
	worn_icon_state = "ostwind_worn"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING
	fire_delay = 4.20
	burst_size = 3
	fire_sound = null
	can_bayonet = TRUE
	can_flashlight = TRUE
	ammo_type = list(/obj/item/ammo_casing/energy/laser/hardlight_bullet/pitbull)
	shaded_charge = TRUE
	cell_type = /obj/item/stock_parts/cell/super

/obj/item/ammo_casing/energy/laser/hardlight_bullet/pitbull
	name = "hardlight bullet pitbull casing"
	projectile_type = /obj/projectile/beam/laser/hardlight_bullet/pitbull
	e_cost = 1666 // 27 damage so 12 shots.
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/sfrifle_fire.ogg'

/obj/projectile/beam/laser/hardlight_bullet/pitbull
	damage = 27

/obj/item/gun/energy/pcr
	name = "\improper PCR-9 SMG"
	desc = "An accurate, fast-firing SMG chambered in 9x19mm."
	icon = 'modular_skyrat/modules/goofsec/icons/gun_sprites.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/ostwind.dmi'
	worn_icon_state = "ostwind_worn"
	inhand_icon_state = "pcr"
	icon_state = "pcr"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING
	fire_delay = 1.80
	burst_size = 5
	can_flashlight = TRUE
	ammo_type = list(/obj/item/ammo_casing/energy/laser/hardlight_bullet/pcr)
	shaded_charge = TRUE
	cell_type = /obj/item/stock_parts/cell/super

/obj/item/ammo_casing/energy/laser/hardlight_bullet/pcr
	name = "hardlight bullet pcr casing"
	projectile_type = /obj/projectile/beam/laser/hardlight_bullet/pcr
	e_cost = 1666 // 27 damage so 12 shots.
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/smg_fire.ogg'

/obj/projectile/beam/laser/hardlight_bullet/pcr
	damage = 27 // Minimum damage increase to at least base /tg/ laser gun damage.

/* TODO: Use for SolFed.
/obj/item/gun/energy/peacemaker
	name = "\improper Peacemaker"
	desc = "The gun that won the space frontier. Four shots, and with a long firing delay, but packs an extreme punch."
	icon = 'modular_skyrat/modules/goofsec/icons/gun_sprites.dmi'
	icon_state = "peacemaker"
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_OCLOTHING
	fire_delay = 2 SECONDS
	ammo_type = list(/obj/item/ammo_casing/energy/laser/hardlight_bullet/peacemaker)
	shaded_charge = TRUE

/obj/item/ammo_casing/energy/laser/hardlight_bullet/peacemaker
	name = "hardlight bullet peacemaker casing"
	projectile_type = /obj/projectile/beam/laser/hardlight_bullet/peacemaker
	e_cost = 250 // 4 shots.
	fire_sound = 'sound/weapons/gun/revolver/shot_alt.ogg'

/obj/projectile/beam/laser/hardlight_bullet/peacemaker
	damage = 60
*/

/// Bullet security pistol.
/obj/item/gun/ballistic/automatic/pistol/security
	name = "security pistol"
	desc = "A pistol issued to station security personnel. It's a small, compact pistol, but it packs a punch."
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

/obj/item/ammo_box/magazine/security_pistol
	name = "influence security pistol magazine"
	desc = "A magazine for the security pistol. Loaded with rubberized influence rounds."
	icon = 'modular_skyrat/modules/goofsec/icons/gun_sprites.dmi'
	icon_state = "security_pistol_influence"
	base_icon_state = "security_pistol_influence"
	ammo_type = /obj/item/ammo_casing/security_pistol/influence
	caliber = CALIBER_SECURITYPISTOL
	max_ammo = 20

/obj/item/ammo_box/magazine/security_pistol/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][ammo_count() ? "" : "-empty"]"

/// Ammo for the Security Pistol.
/obj/item/ammo_casing/security_pistol
	name = "security pistol casing"
	desc = "A casing for a security pistol magazine."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sl-casing"
	caliber = CALIBER_SECURITYPISTOL
	projectile_type = /obj/projectile/bullet/security_pistol

/obj/projectile/bullet/security_pistol
	name = "security pistol bullet"
	damage = 0 // not supposed to exist

// Influence rounds. Bouncy. Stamina only.
/obj/item/ammo_box/magazine/security_pistol/influence
	name = "influence security pistol magazine"
	desc = "A magazine for the security pistol. Loaded with Influence rounds, which bounce around and influence people to comply with arrests."
	icon_state = "security_pistol_influence"
	base_icon_state = "security_pistol_influence"
	ammo_type = /obj/item/ammo_casing/security_pistol/influence

/obj/item/ammo_casing/security_pistol/influence
	name = "influence security pistol casing"
	projectile_type = /obj/projectile/bullet/security_pistol/influence
	harmful = FALSE

/obj/projectile/bullet/security_pistol/influence
	name = "influence security pistol bullet"
	damage = 41
	damage_type = STAMINA
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	wound_bonus = CANT_WOUND

// TRAC rounds. Lower raw damage. Puts a tracking chip in the target, embeds. Penetrates armor.
/obj/item/ammo_box/magazine/security_pistol/trac
	name = "trac security pistol magazine"
	desc = "A magazine for the security pistol. Loaded with TRAC rounds, which embed a tracking chip in the target, while also being handy against armor."
	icon_state = "security_pistol_trac"
	base_icon_state = "security_pistol_trac"
	ammo_type = /obj/item/ammo_casing/security_pistol/trac

/obj/item/ammo_casing/security_pistol/trac
	name = "trac security pistol casing"
	projectile_type = /obj/projectile/bullet/security_pistol/trac

/obj/projectile/bullet/security_pistol/trac
	name = "trac security pistol bullet"
	damage = 25
	armour_penetration = 75
	embedding = list(embed_chance=75, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=1 SECONDS)
	wound_falloff_tile = -5
	embed_falloff_tile = -15

/obj/projectile/bullet/security_pistol/trac/on_hit(atom/target, blocked = FALSE)
	. = ..()
	var/mob/living/carbon/M = target
	if(!istype(M))
		return
	var/obj/item/implant/tracking/c38/imp
	for(var/obj/item/implant/tracking/c38/TI in M.implants) //checks if the target already contains a tracking implant
		imp = TI
		return
	if(!imp)
		imp = new /obj/item/implant/tracking/c38(M)
		imp.implant(M)

// Iceblox Rounds. Lower raw damage. Makes the target cold.
/obj/item/ammo_box/magazine/security_pistol/iceblox
	name = "iceblox security pistol magazine"
	desc = "A magazine for the security pistol. Loaded with Iceblox rounds, which make the target cold."
	icon_state = "security_pistol_iceblox"
	base_icon_state = "security_pistol_iceblox"
	ammo_type = /obj/item/ammo_casing/security_pistol/iceblox

/obj/item/ammo_casing/security_pistol/iceblox
	name = "iceblox security pistol casing"
	projectile_type = /obj/projectile/bullet/security_pistol/iceblox

/obj/projectile/bullet/security_pistol/iceblox
	name = "iceblox security pistol bullet"
	damage = 25
	var/temperature = 100

/obj/projectile/bullet/security_pistol/iceblox/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(isliving(target))
		var/mob/living/M = target
		M.adjust_bodytemperature(((100-blocked)/100)*(temperature - M.bodytemperature))

// Cruelty rounds. Lower raw damage. Aggressively violent wounds and embeds.
/obj/item/ammo_box/magazine/security_pistol/cruelty
	name = "cruelty security pistol magazine"
	desc = "A magazine for the security pistol. Loaded with Cruelty rounds, which slice through biological matter in a manner banned by the Geneva Convention."
	icon_state = "security_pistol_cruelty"
	base_icon_state = "security_pistol_cruelty"
	ammo_type = /obj/item/ammo_casing/security_pistol/cruelty

/obj/item/ammo_casing/security_pistol/cruelty
	name = "cruelty security pistol casing"
	projectile_type = /obj/projectile/bullet/security_pistol/cruelty

/obj/projectile/bullet/security_pistol/cruelty
	name = "cruelty security pistol bullet"
	damage = 25
	sharpness = SHARP_EDGED
	wound_bonus = 50
	bare_wound_bonus = 100
	embedding = list(embed_chance=100, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=1 SECONDS)

// Geiger rounds. Reduced damage. Irradiation.
/obj/item/ammo_box/magazine/security_pistol/geiger
	name = "geiger security pistol magazine"
	desc = "A magazine for the security pistol. Loaded with Geiger rounds, which irradiate the target and those around them."
	icon_state = "security_pistol_rad"
	base_icon_state = "security_pistol_rad"
	ammo_type = /obj/item/ammo_casing/security_pistol/geiger

/obj/item/ammo_casing/security_pistol/geiger
	name = "geiger security pistol casing"
	projectile_type = /obj/projectile/bullet/security_pistol/geiger

/obj/projectile/bullet/security_pistol/geiger
	name = "geiger security pistol bullet"
	damage = 25

/obj/projectile/bullet/security_pistol/geiger/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if (ishuman(target))
		target.AddComponent(/datum/component/irradiated)
		radiation_pulse(target, max_range = 1, threshold = RAD_LIGHT_INSULATION)

// CEO Mindset rounds. Set goals. Have a ten year plan. Invest. Wake up early. CEO mindset. Good luck.
/obj/item/ammo_box/magazine/security_pistol/ceo_mindset
	name = "CEO mindset security pistol magazine"
	desc = "A magazine for the security pistol. Loaded with CEO mindset rounds, which set goals and have a ten year plan. Invest. Wake up early. CEO mindset. Good luck."
	icon_state = "security_pistol_ceo_mindset"
	base_icon_state = "security_pistol_ceo_mindset"
	ammo_type = /obj/item/ammo_casing/security_pistol/ceo_mindset

/obj/item/ammo_casing/security_pistol/ceo_mindset
	name = "CEO mindset security pistol casing"
	projectile_type = /obj/projectile/bullet/security_pistol/ceo_mindset

/obj/projectile/bullet/security_pistol/ceo_mindset
	name = "CEO mindset security pistol bullet"
	damage = 0
	var/damage_brackets = list(5, 15, 30, 35, 60, 80)
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
			investment_level = damage_brackets[i] * (account.account_balance / wealth_brackets[i])
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
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/security_pistol_magazine/influence
	name = "Security Pistol Magazine (Influence)"
	desc = "Influence rounds for your Security Pistol."
	id = "security_pistol_magazine_influence"
	build_path = /obj/item/ammo_box/magazine/security_pistol/influence

/datum/design/security_pistol_magazine/trac
	name = "Security Pistol Magazine (TRAC)"
	desc = "TRAC rounds for your Security Pistol."
	id = "security_pistol_magazine_trac"
	build_path = /obj/item/ammo_box/magazine/security_pistol/trac

/datum/design/security_pistol_magazine/iceblox
	name = "Security Pistol Magazine (Iceblox)"
	desc = "Iceblox rounds for your Security Pistol."
	id = "security_pistol_magazine_iceblox"
	build_path = /obj/item/ammo_box/magazine/security_pistol/iceblox

/datum/design/security_pistol_magazine/cruelty
	name = "Security Pistol Magazine (Cruelty)"
	desc = "Cruelty rounds for your Security Pistol."
	id = "security_pistol_magazine_cruelty"
	build_path = /obj/item/ammo_box/magazine/security_pistol/cruelty

/datum/design/security_pistol_magazine/geiger
	name = "Security Pistol Magazine (Geiger)"
	desc = "Geiger rounds for your Security Pistol."
	id = "security_pistol_magazine_geiger"
	build_path = /obj/item/ammo_box/magazine/security_pistol/geiger

/datum/design/security_pistol_magazine/ceo_mindset
	name = "Security Pistol Magazine (CEO Mindset)"
	desc = "CEO Mindset rounds for your Security Pistol."
	id = "security_pistol_magazine_ceo_mindset"
	build_path = /obj/item/ammo_box/magazine/security_pistol/ceo_mindset

// Techweb additions.

/datum/techweb_node/base
	skyrat_design_ids = list(
		"security_pistol_magazine_influence",
	)
/datum/techweb_node/subdermal_implants
	skyrat_design_ids = list(
		"security_pistol_magazine_trac",
	)

/datum/techweb_node/exotic_ammo
	skyrat_design_ids = list(
		"security_pistol_magazine_iceblox",
		"security_pistol_magazine_cruelty",
		"security_pistol_magazine_geiger",
		"security_pistol_magazine_ceo_mindset",
	)

/datum/supply_pack/security/security_pistol
	name = "Security Pistol Crate"
	desc = "Three security pistols, if your security team gets disarmed."
	cost = CARGO_CRATE_VALUE * 3
	access_view = ACCESS_SECURITY
	contains = list(/obj/item/gun/ballistic/automatic/pistol/security,
					/obj/item/gun/ballistic/automatic/pistol/security,
					/obj/item/gun/ballistic/automatic/pistol/security)
	crate_name = "security pistol crate"
