#define OPS_SUBCATEGORY_RIFLE "Assault Rifles"
#define OPS_SUBCATEGORY_RIFLE_AMMO "Specialty Assault Rifle Ammo"

#define OPS_SUBCATEGORY_SMG "Submachine Guns"
#define OPS_SUBCATEGORY_SMG_AMMO "Speciality Submachine Gun Ammo"

#define OPS_SUBCATEGORY_SHOTGUN "Shotguns"
#define OPS_SUBCATEGORY_SHOTGUN_AMMO "Speciality Shotgun Ammo"

#define OPS_SUBCATEGORY_SNIPER "Marksman Rifles"
#define OPS_SUBCATEGORY_SNIPER_AMMO "Speciality Marksman Rifle Ammo"

/datum/armament_entry/assault_operatives/primary
	category = "Long Arms"
	category_item_limit = 6
	mags_to_spawn = 3
	cost = 10

/datum/armament_entry/assault_operatives/primary/rifle
	subcategory = OPS_SUBCATEGORY_RIFLE

/datum/armament_entry/assault_operatives/primary/rifle/assault_ops_rifle
	item_type = /obj/item/gun/ballistic/automatic/assault_ops_rifle

/datum/armament_entry/assault_operatives/primary/rifle_ammo
	subcategory = OPS_SUBCATEGORY_RIFLE_AMMO
	max_purchase = 10
	cost = 1

/datum/armament_entry/assault_operatives/primary/rifle_ammo/rubber
	name = "\improper IGE-110 rubber magazine"
	description = "Rifle ammo that is more likely to exhaust whoever its shot at, rather than killing them."
	item_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_rifle/rubber

/datum/armament_entry/assault_operatives/primary/rifle_ammo/ap
	name = "\improper IGE-110 armor piercing magazine"
	description = "Rifle ammo built specifically to penetrate through armor."
	item_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_rifle/ap


/datum/armament_entry/assault_operatives/primary/submachinegun
	subcategory = OPS_SUBCATEGORY_SMG

/datum/armament_entry/assault_operatives/primary/submachinegun/assault_ops_smg
	item_type = /obj/item/gun/ballistic/automatic/assault_ops_smg

/datum/armament_entry/assault_operatives/primary/submachinegun_ammo
	subcategory = OPS_SUBCATEGORY_SMG_AMMO
	max_purchase = 10
	cost = 1

/datum/armament_entry/assault_operatives/primary/submachinegun_ammo/rubber
	name = "\improper IGE-260 rubber magazine"
	description = "Submachine gun ammo that is more likely to exhaust whoever its shot at, rather than killing them."
	item_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_smg/rubber

/datum/armament_entry/assault_operatives/primary/submachinegun_ammo/hp
	name = "\improper IGE-260 hollowpoint magazine"
	description = "Submachine gun ammo that hurts unarmored targets more, in exchange for worse performance against armor."
	item_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_smg/hp

/datum/armament_entry/assault_operatives/primary/shotgun
	subcategory = OPS_SUBCATEGORY_SHOTGUN

/datum/armament_entry/assault_operatives/primary/shotgun/assault_ops_shotgun
	item_type = /obj/item/gun/ballistic/automatic/assault_ops_shotgun

/datum/armament_entry/assault_operatives/primary/shotgun_ammo
	subcategory = OPS_SUBCATEGORY_SHOTGUN_AMMO
	max_purchase = 10
	cost = 1

/datum/armament_entry/assault_operatives/primary/shotgun_ammo/rubber
	name = "\improper IGE-340 rubbershot magazine"
	description = "Shotgun ammo that's much like buckshot, but more likely to exhaust whoever its shot at rather than killing them."
	item_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_shotgun/rubbershot

/datum/armament_entry/assault_operatives/primary/shotgun_ammo/flechette
	name = "\improper IGE-340 flechette magazine"
	description = "Shotgun ammo that fires armor piercing flechettes that can cause some nasty wounds."
	item_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_shotgun/flechette

/datum/armament_entry/assault_operatives/primary/shotgun_ammo/hollowpoint
	name = "\improper IGE-340 hollowpoint slug magazine"
	description = "Shotgun ammo that fires a large hollowpoint slug that hurts unarmored targets a lot more, in exchange for worse performance against armor."
	item_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_shotgun/hollowpoint

/datum/armament_entry/assault_operatives/primary/shotgun_ammo/beehive
	name = "\improper IGE-340 'beehive' magazine"
	description = "Shotgun ammo that fires a spread of smart-bouncing pellets, that are more likely to exhaust whoever its shot at rather than killing them."
	item_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_shotgun/beehive

/datum/armament_entry/assault_operatives/primary/shotgun_ammo/dragonsbreath
	name = "\improper IGE-340 dragonsbreath magazine"
	description = "Shotgun ammo that fires a spread of incendiary projectiles, creating a wall of fire whichever direction they are shot in."
	item_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_shotgun/dragonsbreath

/datum/armament_entry/assault_operatives/primary/sniper
	subcategory = OPS_SUBCATEGORY_SNIPER

/datum/armament_entry/assault_operatives/primary/sniper/assault_ops_sniper
	item_type = /obj/item/gun/ballistic/rifle/boltaction/assault_ops_sniper

/datum/armament_entry/assault_operatives/primary/sniper_ammo
	subcategory = OPS_SUBCATEGORY_SNIPER_AMMO
	max_purchase = 10
	cost = 1

/datum/armament_entry/assault_operatives/primary/sniper_ammo/eepy
	name = "\improper IGE-410 soporific magazine"
	description = "Sniper ammo that will put whoever it hits right to sleep, rather than killing them."
	item_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_sniper/sleepytime

/datum/armament_entry/assault_operatives/primary/sniper_ammo/penetrator
	name = "\improper IGE-410 penetrator magazine"
	description = "Sniper ammo that is capable of penetrating through multiple walls and people at once."
	item_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_sniper/penetrator

#undef OPS_SUBCATEGORY_RIFLE
#undef OPS_SUBCATEGORY_RIFLE_AMMO

#undef OPS_SUBCATEGORY_SMG
#undef OPS_SUBCATEGORY_SMG_AMMO

#undef OPS_SUBCATEGORY_SHOTGUN
#undef OPS_SUBCATEGORY_SHOTGUN_AMMO

#undef OPS_SUBCATEGORY_SNIPER
#undef OPS_SUBCATEGORY_SNIPER_AMMO
