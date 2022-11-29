/datum/armament_entry/company_import/vitezstvi
	category = VITEZSTVI_AMMO_NAME
	company_bitflag = CARGO_COMPANY_VITEZSTVI_AMMO
	stock_mult = 3

// Ammo bench and the lethals disk

/datum/armament_entry/company_import/vitezstvi/ammo_bench
	subcategory = "Ammunition Manufacturing Equipment"

/datum/armament_entry/company_import/vitezstvi/ammo_bench/bench_itself
	item_type = /obj/item/circuitboard/machine/ammo_workbench
	lower_cost = CARGO_CRATE_VALUE * 10
	upper_cost = CARGO_CRATE_VALUE * 20
	interest_required = COMPANY_SOME_INTEREST
	interest_addition = COMPANY_INTEREST_GAIN_BIG

/datum/armament_entry/company_import/vitezstvi/ammo_bench
	item_type = /obj/item/disk/ammo_workbench/lethal
	lower_cost = CARGO_CRATE_VALUE * 10
	upper_cost = CARGO_CRATE_VALUE * 20
	interest_required = COMPANY_HIGH_INTEREST
	interest_addition = COMPANY_INTEREST_GAIN_BIG

// Boxes of non-shotgun ammo

/datum/armament_entry/company_import/vitezstvi/ammo_boxes
	subcategory = "Ammunition Boxes"
	lower_cost = CARGO_CRATE_VALUE * 0.75
	upper_cost = CARGO_CRATE_VALUE * 1.25

/datum/armament_entry/company_import/vitezstvi/ammo_boxes/pepperball
	item_type = /obj/item/ammo_box/advanced/pepperballs

/datum/armament_entry/company_import/vitezstvi/ammo_boxes/m1911_lethals
	item_type = /obj/item/ammo_box/c45

/datum/armament_entry/company_import/vitezstvi/ammo_boxes/wt550_lethals
	item_type = /obj/item/ammo_box/c46x30mm

/datum/armament_entry/company_import/vitezstvi/ammo_boxes/wt550_piercing
	item_type = /obj/item/ammo_box/c46x30mm/ap

/datum/armament_entry/company_import/vitezstvi/ammo_boxes/wt550_rubber
	item_type = /obj/item/ammo_box/c46x30mm/rubber

/datum/armament_entry/company_import/vitezstvi/ammo_boxes/peacekeeper_lethal
	item_type = /obj/item/ammo_box/c9mm

/datum/armament_entry/company_import/vitezstvi/ammo_boxes/peacekeeper_hp
	item_type = /obj/item/ammo_box/c9mm/hp

/datum/armament_entry/company_import/vitezstvi/ammo_boxes/peacekeeper_rubber
	item_type = /obj/item/ammo_box/c9mm/rubber

/datum/armament_entry/company_import/vitezstvi/ammo_boxes/auto10mm_lethal
	item_type = /obj/item/ammo_box/c10mm

/datum/armament_entry/company_import/vitezstvi/ammo_boxes/auto10mm_hp
	item_type = /obj/item/ammo_box/c10mm/hp

/datum/armament_entry/company_import/vitezstvi/ammo_boxes/auto10mm_rubber
	item_type = /obj/item/ammo_box/c10mm/rubber

/datum/armament_entry/company_import/vitezstvi/ammo_boxes/sabel_lethal
	item_type = /obj/item/ammo_box/c56mm
	lower_cost = CARGO_CRATE_VALUE * 1.25
	upper_cost = CARGO_CRATE_VALUE * 1.5

/datum/armament_entry/company_import/vitezstvi/ammo_boxes/sabel_rubber
	item_type = /obj/item/ammo_box/c56mm/rubber
	lower_cost = CARGO_CRATE_VALUE * 1.25
	upper_cost = CARGO_CRATE_VALUE * 1.5

/datum/armament_entry/company_import/vitezstvi/ammo_boxes/sabel_hunting
	item_type = /obj/item/ammo_box/c56mm/hunting
	lower_cost = CARGO_CRATE_VALUE * 1.25
	upper_cost = CARGO_CRATE_VALUE * 1.5

/datum/armament_entry/company_import/vitezstvi/ammo_boxes/sabel_blank
	item_type = /obj/item/ammo_box/c56mm/blank
	lower_cost = CARGO_CRATE_VALUE * 0.1
	upper_cost = CARGO_CRATE_VALUE * 0.3

// Revolver speedloaders

/datum/armament_entry/company_import/vitezstvi/speedloader
	subcategory = "Speedloaders"
	lower_cost = CARGO_CRATE_VALUE * 0.5
	upper_cost = CARGO_CRATE_VALUE

/datum/armament_entry/company_import/vitezstvi/speedloader/detective_lethal
	item_type = /obj/item/ammo_box/c38

/datum/armament_entry/company_import/vitezstvi/speedloader/detective_dumdum
	item_type = /obj/item/ammo_box/c38/dumdum

/datum/armament_entry/company_import/vitezstvi/speedloader/detective_bouncy
	item_type = /obj/item/ammo_box/c38/match

// Shotgun boxes

/datum/armament_entry/company_import/vitezstvi/shot_shells
	subcategory = "Shotgun Shells"
	lower_cost = CARGO_CRATE_VALUE * 1.25
	upper_cost = CARGO_CRATE_VALUE * 2

/datum/armament_entry/company_import/vitezstvi/shot_shells/slugs
	item_type = /obj/item/ammo_box/advanced/s12gauge
	description = "A box of 15 slug shells, large singular shots that pack a punch."

/datum/armament_entry/company_import/vitezstvi/shot_shells/buckshot
	item_type = /obj/item/ammo_box/advanced/s12gauge/buckshot
	description = "A box of 15 buckshot shells, a modest spread of weaker projectiles."

/datum/armament_entry/company_import/vitezstvi/shot_shells/beanbag_slugs
	item_type = /obj/item/ammo_box/advanced/s12gauge/bean
	description = "A box of 15 beanbag slug shells, large singular beanbags that pack a less-lethal punch."

/datum/armament_entry/company_import/vitezstvi/shot_shells/rubbershot
	item_type = /obj/item/ammo_box/advanced/s12gauge/rubber
	description = "A box of 15 rubbershot shells, a modest spread of weaker less-lethal projectiles."

/datum/armament_entry/company_import/vitezstvi/shot_shells/magnum_buckshot
	item_type = /obj/item/ammo_box/advanced/s12gauge/magnum
	description = "A box of 15 magnum buckshot shells, a wider spread of larger projectiles."

/datum/armament_entry/company_import/vitezstvi/shot_shells/express_buckshot
	item_type = /obj/item/ammo_box/advanced/s12gauge/express
	description = "A box of 15 express buckshot shells, a tighter spread of smaller projectiles."

/datum/armament_entry/company_import/vitezstvi/shot_shells/confetti
	item_type = /obj/item/ammo_box/advanced/s12gauge/honk
	description = "A box of 35 confetti shells, firing a spread of harmless confetti everywhere, yippie!"
