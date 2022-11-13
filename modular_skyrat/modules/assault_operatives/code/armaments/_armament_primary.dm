#define SUBCATEGORY_RIFLE "Assault Rifles"
#define SUBCATEGORY_RIFLE_AMMO "Specialty Assault Rifle Ammo"

#define SUBCATEGORY_SMG "Submachine Guns"
#define SUBCATEGORY_SMG_AMMO "Speciality Submachine Gun Ammo"

#define SUBCATEGORY_SHOTGUN "Shotguns"
#define SUBCATEGORY_SHOTGUN_AMMO "Speciality Shotgun Ammo"

#define SUBCATEGORY_SNIPER "Marksman Rifles"
#define SUBCATEGORY_SNIPER_AMMO "Speciality Marksman Rifle Ammo"

/datum/armament_entry/assault_operatives/primary
	category = ARMAMENT_CATEGORY_PRIMARY
	mags_to_spawn = 3
	cost = 10

/datum/armament_entry/assault_operatives/primary/rifle
	subcategory = SUBCATEGORY_RIFLE

/datum/armament_entry/assault_operatives/primary/rifle/assault_ops_rifle
	item_type = /obj/item/gun/ballistic/automatic/assault_ops_rifle

/datum/armament_entry/assault_operatives/primary/rifle_ammo
	subcategory = SUBCATEGORY_RIFLE_AMMO
	max_purchase = 10
	cost = 1

/datum/armament_entry/assault_operatives/primary/rifle_ammo/rubber
	description = "Rifle ammo that is more likely to exhaust whoever its shot at, rather than killing them."
	item_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_rifle/rubber

/datum/armament_entry/assault_operatives/primary/rifle_ammo/ap
	description = "Rifle ammo built specifically to penetrate through armor."
	item_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_rifle/ap


/datum/armament_entry/assault_operatives/primary/submachinegun
	subcategory = SUBCATEGORY_SMG

/datum/armament_entry/assault_operatives/primary/submachinegun/assault_ops_smg
	item_type = /obj/item/gun/ballistic/automatic/assault_ops_smg

/datum/armament_entry/assault_operatives/primary/submachinegun_ammo
	subcategory = SUBCATEGORY_SMG_AMMO
	max_purchase = 10
	cost = 1

/datum/armament_entry/assault_operatives/primary/submachinegun_ammo/rubber
	description = "Submachine gun ammo that is more likely to exhaust whoever its shot at, rather than killing them."
	item_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_smg/rubber

/datum/armament_entry/assault_operatives/primary/submachinegun_ammo/hp
	description = "Submachine gun ammo that hurts unarmored targets more, in exchange for worse performance against armor."
	item_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_smg/hp

/datum/armament_entry/assault_operatives/primary/shotgun
	subcategory = SUBCATEGORY_SHOTGUN

/datum/armament_entry/assault_operatives/primary/shotgun/assault_ops_shotgun
	item_type = /obj/item/gun/ballistic/automatic/assault_ops_shotgun

/datum/armament_entry/assault_operatives/primary/shotgun_ammo
	subcategory = SUBCATEGORY_SHOTGUN_AMMO
	max_purchase = 10
	cost = 1

/datum/armament_entry/assault_operatives/primary/shotgun_ammo/rubber
	description = "Shotgun ammo that's much like buckshot, but more likely to exhaust whoever its shot at rather than killing them."
	item_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_shotgun/rubbershot

/datum/armament_entry/assault_operatives/primary/shotgun_ammo/flechette
	description = "Shotgun ammo that fires armor piercing flechettes that can cause some nasty wounds."
	item_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_shotgun/flechette

/datum/armament_entry/assault_operatives/primary/shotgun_ammo/hollowpoint
	description = "Shotgun ammo that fires a large hollowpoint slug that hurts unarmored targets a lot more, in exchange for worse performance against armor."
	item_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_shotgun/hollowpoint

/datum/armament_entry/assault_operatives/primary/shotgun_ammo/beehive
	description = "Shotgun ammo that fires a spread of smart-bouncing pellets, that are more likely to exhaust whoever its shot at rather than killing them."
	item_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_shotgun/beehive

/datum/armament_entry/assault_operatives/primary/shotgun_ammo/dragonsbreath
	description = "Shotgun ammo that fires a spread of incendiary projectiles, creating a wall of fire whichever direction they are shot in."
	item_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_shotgun/dragonsbreath

/datum/armament_entry/assault_operatives/primary/sniper
	subcategory = SUBCATEGORY_SNIPER

/datum/armament_entry/assault_operatives/primary/sniper/assault_ops_sniper
	item_type = /obj/item/gun/ballistic/rifle/boltaction/assault_ops_sniper

/datum/armament_entry/assault_operatives/primary/sniper_ammo
	subcategory = SUBCATEGORY_SNIPER_AMMO
	max_purchase = 10
	cost = 1

/datum/armament_entry/assault_operatives/primary/sniper_ammo/eepy
	description = "Sniper ammo that will put whoever it hits right to sleep, rather than killing them."
	item_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_sniper/sleepytime

/datum/armament_entry/assault_operatives/primary/sniper_ammo/penetrator
	description = "Sniper ammo that is capable of penetrating through multiple walls and people at once."
	item_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_sniper/penetrator
