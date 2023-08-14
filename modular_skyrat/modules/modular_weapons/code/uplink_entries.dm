/datum/uplink_item/dangerous/enforcer
	name = "Enforcer-TEN Handgun"
	desc = "A full-frame Scarborough Arms handgun, chambered in 10mm in 10-round magazines. Incompatible with suppressors, and not as concealable as the Makarov, \
	but robust enough to be used as a decent melee weapon in a pinch."
	item = /obj/item/gun/ballistic/automatic/pistol/enforcer
	progression_minimum = 20 MINUTES
	cost = 10
	surplus = 75
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS) // nukies get the ansem already

/datum/uplink_item/ammo/enforcer
	name = "Enforcer 10mm Magazine"
	desc = "An additional 10-round 10mm magazine, only compatible with the Enforcer-TEN handgun."
	progression_minimum = 20 MINUTES
	item = /obj/item/ammo_box/magazine/enforcer
	cost = 1
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/ammo/enforcer_rubber
	name = "Enforcer 10mm Rubber Magazine"
	desc = "An additional 10-round 10mm magazine, only compatible with the Enforcer-TEN handgun. \
	Comes with rubber ammunition, for downing targets from pain and exhaustion, rather than from gunshot-related trauma."
	progression_minimum = 20 MINUTES
	item = /obj/item/ammo_box/magazine/enforcer/rubber
	surplus = 0
	cost = 1
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/ammo/enforcer_ap
	name = "Enforcer 10mm Armor-Piercing Magazine"
	desc = "An additional 10-round 10mm magazine, only compatible with the Enforcer-TEN handgun. \
	Comes with armor-piercing ammunition, sacrificing some raw stopping power for armor penetration."
	progression_minimum = 20 MINUTES
	item = /obj/item/ammo_box/magazine/enforcer/ap
	cost = 2
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/ammo/enforcer_hp
	name = "Enforcer 10mm Hollow-Point Magazine"
	desc = "An additional 10-round 10mm magazine, only compatible with the Enforcer-TEN handgun. \
	Comes with hollow-point ammunition, dealing more damage at the cost of poor performance against armor."
	progression_minimum = 20 MINUTES
	item = /obj/item/ammo_box/magazine/enforcer/ap
	cost = 2
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/ammo/enforcer_inc
	name = "Enforcer 10mm Incendiary Magazine"
	desc = "An additional 10-round 10mm magazine, only compatible with the Enforcer-TEN handgun. \
	Comes with incendiary ammunition, sacrificing damage in return for incendiary, crowd-controlling properties."
	progression_minimum = 20 MINUTES
	item = /obj/item/ammo_box/magazine/enforcer/inc
	cost = 2
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)
