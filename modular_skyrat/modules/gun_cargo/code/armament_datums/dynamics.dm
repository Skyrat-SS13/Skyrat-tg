#define ARMAMENT_CATEGORY_DYNAMICS "Armament Dynamics Inc."

/datum/armament_entry/cargo_gun/dynamics
	category = ARMAMENT_CATEGORY_DYNAMICS
	company_bitflag = COMPANY_DYNAMICS
	stock_mult = 2 //To compensate for their interest being fairly low most of the time

/datum/armament_entry/cargo_gun/dynamics/ammo
	subcategory = ARMAMENT_SUBCATEGORY_AMMO
	lower_cost = CARGO_CRATE_VALUE * 0.75
	upper_cost = CARGO_CRATE_VALUE * 1.25
	interest_addition = COMPANY_INTEREST_AMMO

/datum/armament_entry/cargo_gun/dynamics/ammo/c9mm
	item_type = /obj/item/ammo_box/c9mm

/datum/armament_entry/cargo_gun/dynamics/ammo/c9mm_ap
	item_type = /obj/item/ammo_box/c9mm/ap

/datum/armament_entry/cargo_gun/dynamics/ammo/c9mm_hp
	item_type = /obj/item/ammo_box/c9mm/hp

/datum/armament_entry/cargo_gun/dynamics/ammo/c9mm_in
	item_type = /obj/item/ammo_box/c9mm/fire

/datum/armament_entry/cargo_gun/dynamics/ammo/b9mm
	item_type = /obj/item/ammo_box/advanced/b9mm

/datum/armament_entry/cargo_gun/dynamics/ammo/b9mm_hp
	item_type = /obj/item/ammo_box/advanced/b9mm/hp

/datum/armament_entry/cargo_gun/dynamics/ammo/b9mm_rub
	item_type = /obj/item/ammo_box/advanced/b9mm/rubber

/datum/armament_entry/cargo_gun/dynamics/ammo/c10mm
	item_type = /obj/item/ammo_box/c10mm

/datum/armament_entry/cargo_gun/dynamics/ammo/c10mm_ap
	item_type = /obj/item/ammo_box/c10mm/ap

/datum/armament_entry/cargo_gun/dynamics/ammo/c10mm_hp
	item_type = /obj/item/ammo_box/c10mm/hp

/datum/armament_entry/cargo_gun/dynamics/ammo/c10mm_in
	item_type = /obj/item/ammo_box/c10mm/fire

/datum/armament_entry/cargo_gun/dynamics/ammo/c12ga
	item_type = /obj/item/storage/box/lethalshot

/datum/armament_entry/cargo_gun/dynamics/ammo/c12ga_rub
	item_type = /obj/item/storage/box/rubbershot

/datum/armament_entry/cargo_gun/dynamics/ammo/c12ga_bean
	item_type = /obj/item/storage/box/beanbag

/datum/armament_entry/cargo_gun/dynamics/ammo/c12ga_tech
	item_type = /obj/item/storage/box/techshell

/datum/armament_entry/cargo_gun/dynamics/ammo/c46mm
	item_type = /obj/item/ammo_box/c46x30mm

/datum/armament_entry/cargo_gun/dynamics/ammo/c46mm_ap
	item_type = /obj/item/ammo_box/c46x30mm/ap

/datum/armament_entry/cargo_gun/dynamics/ammo/c46mm_rub
	item_type = /obj/item/ammo_box/c46x30mm/rubber

/datum/armament_entry/cargo_gun/dynamics/ammo/c32
	item_type = /obj/item/ammo_box/c32

/datum/armament_entry/cargo_gun/dynamics/ammo/c32_ap
	item_type = /obj/item/ammo_box/c32/ap

/datum/armament_entry/cargo_gun/dynamics/ammo/c32_in
	item_type = /obj/item/ammo_box/c32/fire

/datum/armament_entry/cargo_gun/dynamics/ammo/c32_rub
	item_type = /obj/item/ammo_box/c32/rubber

/datum/armament_entry/cargo_gun/dynamics/ammo/c38
	item_type = /obj/item/ammo_box/c38
	lower_cost = CARGO_CRATE_VALUE * 0.5
	upper_cost = CARGO_CRATE_VALUE * 1
	stock_mult = 3

/datum/armament_entry/cargo_gun/dynamics/ammo/c38/dum
	item_type = /obj/item/ammo_box/c38/dumdum

/datum/armament_entry/cargo_gun/dynamics/ammo/c38/hot
	item_type = /obj/item/ammo_box/c38/hotshot

/datum/armament_entry/cargo_gun/dynamics/ammo/c38/ice
	item_type = /obj/item/ammo_box/c38/iceblox

/datum/armament_entry/cargo_gun/dynamics/ammo/c38/mat
	item_type = /obj/item/ammo_box/c38/match

/datum/armament_entry/cargo_gun/dynamics/ammo/c38/trc
	item_type = /obj/item/ammo_box/c38/trac

/datum/armament_entry/cargo_gun/dynamics/ammo/b10mm
	item_type = /obj/item/ammo_box/advanced/b10mm
	lower_cost = CARGO_CRATE_VALUE * 0.75
	upper_cost = CARGO_CRATE_VALUE * 1.25 //more ammo per box

/datum/armament_entry/cargo_gun/dynamics/ammo/b10mm_hp
	item_type = /obj/item/ammo_box/advanced/b10mm/hp
	lower_cost = CARGO_CRATE_VALUE * 0.75
	upper_cost = CARGO_CRATE_VALUE * 1.25

/datum/armament_entry/cargo_gun/dynamics/ammo/b10mm_rub
	item_type = /obj/item/ammo_box/advanced/b10mm/rubber
	lower_cost = CARGO_CRATE_VALUE * 0.75
	upper_cost = CARGO_CRATE_VALUE * 1.25

/datum/armament_entry/cargo_gun/dynamics/ammo/b6mm
	item_type = /obj/item/ammo_box/advanced/b6mm

/datum/armament_entry/cargo_gun/dynamics/ammo/b6mm_rub
	item_type = /obj/item/ammo_box/advanced/b6mm/rubber

/datum/armament_entry/cargo_gun/dynamics/ammo/b56mm
	item_type = /obj/item/ammo_box/c56mm
	description = "A box of 60 civilian-grade cartridges. Manufactured by some backwater imperial ammunition company."
	lower_cost = CARGO_CRATE_VALUE * 1.25
	upper_cost = CARGO_CRATE_VALUE * 1.5

/datum/armament_entry/cargo_gun/dynamics/ammo/b56mm_rub
	item_type = /obj/item/ammo_box/c56mm/rubber
	description = "A box of 60 civilian-grade less-than-lethal cartridges. \"НРИ - Коллегия Сохранения Мира\" is listed as the manufacturer. \
	Which, very likely, means that it was made for the police."
	lower_cost = CARGO_CRATE_VALUE * 1
	upper_cost = CARGO_CRATE_VALUE * 1.25

/datum/armament_entry/cargo_gun/dynamics/ammo/b56mm_hunt
	item_type = /obj/item/ammo_box/c56mm/hunting
	description = "A box of 60 civilian-grade hunting cartridges. Certainly was made by some imperial huntsmen association."
	lower_cost = CARGO_CRATE_VALUE * 1.25
	upper_cost = CARGO_CRATE_VALUE * 1.75

/datum/armament_entry/cargo_gun/dynamics/ammo/b56mm_blank
	item_type = /obj/item/ammo_box/c56mm/blank
	description = "A box of 60 civilian-grade blank cartridges. Manufactured by some backwater imperial ammunition company."
	///It's literally nothing. Might as well make it dirt cheap.
	lower_cost = CARGO_CRATE_VALUE * 0.25
	upper_cost = CARGO_CRATE_VALUE * 0.75
	///And increase the amount in stock by 50%, for LARPers and other funny people.
	stock_mult = 3

/datum/armament_entry/cargo_gun/dynamics/ammo/shotgun
	item_type = /obj/item/ammo_box/advanced/s12gauge
	description = "A box of 35 Slugs. Great for accurate shooting."
	stock_mult = 3

/datum/armament_entry/cargo_gun/dynamics/ammo/shotgun/buckshot
	item_type = /obj/item/ammo_box/advanced/s12gauge/buckshot
	description = "A box of 35 Buckshots. Can't go wrong with buckshot."
	stock_mult = 3

/datum/armament_entry/cargo_gun/dynamics/ammo/shotgun/bean
	item_type = /obj/item/ammo_box/advanced/s12gauge/bean
	description = "A box of 35 Beanbags. Perfect choice for non-lethal takedowns."
	stock_mult = 3

/datum/armament_entry/cargo_gun/dynamics/ammo/shotgun/hp
	item_type = /obj/item/ammo_box/advanced/s12gauge/hp
	description = "A box of 35 Hollow Point Slugs. It is a shell purpose built for unarmored targets."
	stock_mult = 3
	lower_cost = CARGO_CRATE_VALUE * 1
	upper_cost = CARGO_CRATE_VALUE * 1.5

/datum/armament_entry/cargo_gun/dynamics/ammo/shotgun/rubber
	item_type = /obj/item/ammo_box/advanced/s12gauge/rubber
	description = "A box of 35 Rubbershots. Great choice for crowd control."
	stock_mult = 3

/datum/armament_entry/cargo_gun/dynamics/ammo/shotgun/express
	item_type = /obj/item/ammo_box/advanced/s12gauge/express
	description = "A box of 35 Express Buckshots. It is a shell that has tighter spread and smaller but more projectiles."
	stock_mult = 2
	lower_cost = CARGO_CRATE_VALUE * 1
	upper_cost = CARGO_CRATE_VALUE * 1.5

/datum/armament_entry/cargo_gun/dynamics/ammo/shotgun/magnum
	item_type = /obj/item/ammo_box/advanced/s12gauge/magnum
	description = "A box of 35 Magnum Buckshots. It is a shell that fires bigger pellets but has more spread. It is able to contend against armored targets."
	stock_mult = 3
	lower_cost = CARGO_CRATE_VALUE * 1.25
	upper_cost = CARGO_CRATE_VALUE * 2

/datum/armament_entry/cargo_gun/dynamics/ammo/shotgun/pt20
	item_type = /obj/item/ammo_box/advanced/s12gauge/pt20
	description = "A box of 15 PT-20 Armor Piercing Slugs. It is a shell that is purpose built to penetrate armored targets."
	stock_mult = 1
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 5

/datum/armament_entry/cargo_gun/dynamics/ammo/shotgun/rip
	item_type = /obj/item/ammo_box/advanced/s12gauge/rip
	description = "A box of 15 RIP Slugs. Radically Invasive Projectile slugs are designed to cause massive damage against unarmored targets by embedding inside them."
	stock_mult = 1
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 5

/datum/armament_entry/cargo_gun/dynamics/ammo/shotgun/flechette
	item_type = /obj/item/ammo_box/advanced/s12gauge/flechette
	description = "A box of 15 Flechettes. It is a shotshell that specializes in ripping through armor."
	stock_mult = 1
	lower_cost = CARGO_CRATE_VALUE * 3
	upper_cost = CARGO_CRATE_VALUE * 5

/datum/armament_entry/cargo_gun/dynamics/ammo/shotgun/beehive
	item_type = /obj/item/ammo_box/advanced/s12gauge/beehive
	description = "A box of 15 B3-HVE 'Beehive' shells. A highly experimental non-lethal shell filled with smart nanite pellets that re-aim themselves when bouncing off from surfaces. However they are not able to make out friend from foe."
	stock_mult = 1
	lower_cost = CARGO_CRATE_VALUE * 1.75
	upper_cost = CARGO_CRATE_VALUE * 3

/datum/armament_entry/cargo_gun/dynamics/ammo/shotgun/antitide
	item_type = /obj/item/ammo_box/advanced/s12gauge/antitide
	description = "A box of 15 4NT1-TD3 'Suppressor' shells. A highly experimental shell filled with nanite electrodes that will embed themselves in soft targets. The electrodes are charged from kinetic movement which means moving targets will get punished more."
	stock_mult = 1
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 4

/datum/armament_entry/cargo_gun/dynamics/ammo/shotgun/iceblox
	item_type = /obj/item/ammo_box/advanced/s12gauge/iceblox
	description = "A box of 15 Iceshot Shells. A shotshell variant of Iceblox ammo that lowers the targets body temperature."
	stock_mult = 1
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 4

/datum/armament_entry/cargo_gun/dynamics/ammo/shotgun/incendiary
	item_type = /obj/item/ammo_box/advanced/s12gauge/incendiary
	description = "A box of 35 Incendiary Slugs. Warranty is void if set on fire."
	stock_mult = 2

/datum/armament_entry/cargo_gun/dynamics/ammo/shotgun/honk
	item_type = /obj/item/ammo_box/advanced/s12gauge/honk
	description = "A box of 35 Confetti Shots. Warranty is void if found funny."
	stock_mult = 1
	contraband = TRUE

/datum/armament_entry/cargo_gun/dynamics/misc
	subcategory = ARMAMENT_SUBCATEGORY_SPECIAL

/datum/armament_entry/cargo_gun/dynamics/misc/bandolier
	item_type = /obj/item/storage/belt/bandolier
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 4

/datum/armament_entry/cargo_gun/dynamics/misc/ammo_bench
	item_type = /obj/item/circuitboard/machine/ammo_workbench
	lower_cost = CARGO_CRATE_VALUE * 28
	upper_cost = CARGO_CRATE_VALUE * 33
	interest_required = PASSED_INTEREST

/datum/armament_entry/cargo_gun/dynamics/misc/lethal_disk
	item_type = /obj/item/disk/ammo_workbench/lethal
	lower_cost = CARGO_CRATE_VALUE * 22
	upper_cost = CARGO_CRATE_VALUE * 27
	interest_required = HIGH_INTEREST
