// Semi-automatic rifle firing .310 with reduced damage compared to a Sakhno

/obj/item/gun/ballistic/automatic/lanca
	name = "\improper Szot 'Lanca' Battle Rifle"
	desc = "A relatively compact, long barreled bullpup battle rifle chambered for .310 Strilka. Has an integrated sight with \
		a surprisingly functional amount of magnification, given its place of origin."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/guns_48.dmi'
	icon_state = "lanca"

	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_worn.dmi'
	worn_icon_state = "lanca"

	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/szot_dynamica/guns_righthand.dmi'
	inhand_icon_state = "lanca"

	SET_BASE_PIXEL(-8, 0)

	special_mags = FALSE

	bolt_type = BOLT_TYPE_STANDARD

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING

	accepted_magazine_type = /obj/item/ammo_box/magazine/lanca

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/battle_rifle.ogg'
	suppressed_sound = 'modular_skyrat/modules/modular_weapons/sounds/suppressed_heavy.ogg'
	can_suppress = FALSE

	can_bayonet = FALSE

	burst_size = 1
	fire_delay = 0.6 SECONDS
	actions_types = list()

	spread = 2.5
	projectile_wound_bonus = -10
	projectile_damage_multiplier = 0.85

/obj/item/gun/ballistic/automatic/lanca/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/scope, range_modifier = 1.5)

/obj/item/gun/ballistic/automatic/lanca/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_SZOT)

/obj/item/gun/ballistic/automatic/lanca/examine_more(mob/user)
	. = ..()

	. += "The Lanca is a now relatively dated replacement for Kalashnikov pattern rifles \
		adopted by states now combining to form the CIN. While the rifle that came before them \
		had its benefits, leadership of many armies started to realize that the Kalashnikov-based \
		rifles were really showing their age once the variants began reaching the thousands in serial. \
		The solution was presented by a then new company, Szot Dynamica. This new rifle, not too \
		unlike the one you are seeing now, adopted all of the latest technology of the time. Lightweight \
		caseless ammunition, well known for its use in Sakhno rifles, as well as various electronics and \
		other incredible technological advancements. These advancements may have already been around since \
		before the creation of even the Sakhno, but the fact you're seeing this now fifty year old design \
		must mean something, right?"

	return .

/obj/item/gun/ballistic/automatic/lanca/no_mag
	spawnwithmagazine = FALSE
