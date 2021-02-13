/////////////////////////////
//SKYRAT MODULAR UPLINK ITEMS
/////////////////////////////

//Place any new uplink items in this file, and explain what they do

//DANGEROUS
/datum/uplink_item/dangerous/aps_traitor
	name = "Stechkin APS Machine Pistol"
	desc = "An ancient Soviet machine pistol, refurbished for the modern age. Uses 9mm auto rounds in 15-round magazines and is compatible \
			with suppressors. The gun fires in three round bursts."
	item = /obj/item/gun/ballistic/automatic/pistol/aps
	cost = 13
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/nuclear)
/datum/uplink_item/dangerous/foamsmg_traitor
	name = "Toy Submachine Gun"
	desc = "A fully-loaded Donksoft bullpup submachine gun that fires riot grade darts with a 20-round magazine."
	item = /obj/item/gun/ballistic/automatic/c20r/toy/unrestricted/riot
	cost = 5

/datum/uplink_item/dangerous/revolver_alt
	name = "Unica Six Revolver"
	desc = "A retro high-powered autorevolver typically used by officers of the New Russia military. Uses .357 ammo."
	item = /obj/item/gun/ballistic/revolver/mateba
	cost = 13
	surplus = 50
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops)


/datum/uplink_item/dangerous/smgc20r_traitor
	name = "C-20r Submachine Gun"
	desc = "A fully-loaded Scarborough Arms bullpup submachine gun. The C-20r fires .45 rounds with a \
			24-round magazine and is compatible with suppressors."
	item = /obj/item/gun/ballistic/automatic/c20r
	cost = 17
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/nuclear)

/datum/uplink_item/dangerous/shotgun_traitor
	name = "Bulldog Shotgun"
	desc = "A fully-loaded semi-automatic drum-fed shotgun. Compatible with all 12g rounds. Designed for close \
			quarter anti-personnel engagements."
	item = /obj/item/gun/ballistic/shotgun/bulldog
	cost = 15
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/nuclear)

/datum/uplink_item/dangerous/shield_traitor
	name = "Energy Shield"
	desc = "An incredibly useful personal shield projector, capable of reflecting energy projectiles and defending \
			against other attacks. Pair with an Energy Sword for a killer combination."
	item = /obj/item/shield/energy
	cost = 5
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/nuclear)

//BUNDLES

/datum/uplink_item/bundles_tc/bulldog
	name = "Bulldog bundle"
	desc = "Lean and mean: Optimized for people that want to get up close and personal. Contains the popular \
			Bulldog shotgun, two 12g buckshot drums, and a pair of Thermal imaging goggles."
	item = /obj/item/storage/backpack/duffelbag/syndie/bulldogbundle
	cost = 20 // normally 16
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/nuclear)

/datum/uplink_item/bundles_tc/c20r_traitor
	name = "C-20r bundle"
	desc = "Old Faithful: The classic C-20r, bundled with two magazines and a (surplus) suppressor at discount price."
	item = /obj/item/storage/backpack/duffelbag/syndie/c20rbundle
	cost = 25
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/nuclear)

//STEALTHY WEAPONS
/datum/uplink_item/stealthy_weapons/cqc_traitor
	name = "CQC Manual"
	desc = "A manual that teaches a single user tactical Close-Quarters Combat before self-destructing."
	item = /obj/item/book/granter/martial/cqc
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops) //Blocked them because this just costs more than the version they get.
	cost = 20
	surplus = 0

/datum/uplink_item/stealthy_weapons/telescopicbaton
	name = "Telescopic Baton"
	desc = "A telescopic baton, exactly like the ones heads are issued. Good for knocking people down briefly."
	item = /obj/item/melee/classic_baton/telescopic
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops) //Blocked them because it would be silly for them to get this.
	cost = 2
	surplus = 0

//STEALTHY TOOOLS
/datum/uplink_item/stealthy_tools/infiltratormask
	name = "Voice-Muffling Balaclava"
	desc = "A balaclava that muffles your voice, masking your identity. Also provides flash immunity!"
	item = /obj/item/clothing/mask/infiltrator
	cost = 2

//EXPLOSIVES
/datum/uplink_item/explosives/buzzkill_traitor
	name = "Buzzkill Grenade Box"
	desc = "A box with three grenades that release a swarm of angry bees upon activation. These bees indiscriminately attack friend or foe \
			with random toxins. Courtesy of the BLF and Tiger Cooperative."
	item = /obj/item/storage/box/syndie_kit/bee_grenades
	cost = 15
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops)

/datum/uplink_item/explosives/viscerators_traitor
	name = "Viscerator Delivery Grenade"
	desc = "A unique grenade that deploys a swarm of viscerators upon activation, which will chase down and shred \
			any non-operatives in the area."
	item = /obj/item/grenade/spawnergrenade/manhacks
	cost = 7
	surplus = 35
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops)

/datum/uplink_item/device_tools/syndie_jaws_of_life_traitor
	name = "Syndicate Jaws of Life"
	desc = "Based on a Nanotrasen model, this powerful tool can be used as both a crowbar and a pair of wirecutters. \
	In its crowbar configuration, it can be used to force open airlocks. Very useful for entering the station or its departments."
	item = /obj/item/crowbar/power/syndicate
	cost = 4
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops)

//DEVICE TOOLS
/datum/uplink_item/device_tools/medkit_traitor
	name = "Syndicate Combat Medic Kit"
	desc = "This first aid kit is a suspicious brown and red. Included is a combat stimulant injector \
			for rapid healing, a medical night vision HUD for quick identification of injured personnel, \
			and other supplies helpful for a field medic."
	item = /obj/item/storage/firstaid/tactical
	cost = 4
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops)

/datum/uplink_item/device_tools/guerillagloves_traitor
	name = "Guerilla Gloves"
	desc = "A pair of highly robust combat gripper gloves that excels at performing takedowns at close range, with an added lining of insulation. Careful not to hit a wall!"
	item = /obj/item/clothing/gloves/tackler/combat/insulated
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops)
	cost = 2
	illegal_tech = FALSE

/datum/uplink_item/device_tools/ammo_pouch
	name = "Ammo Pouch"
	desc = "A small yet large enough pouch that can fit in your pocket, and has room for three magazines."
	item = /obj/item/storage/bag/ammo
	cost = 1


//AMMO
/datum/uplink_item/ammo/pistolaps_traitor
	name = "9mm Stechkin APS Magazine"
	desc = "An additional 15-round 9mm magazine, compatible with the Stechkin APS machine pistol."
	item = /obj/item/ammo_box/magazine/m9mm_aps
	cost = 2
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/nuclear)

/datum/uplink_item/ammo/smg_traitor
	name = ".45 SMG Magazine"
	desc = "An additional 24-round .45 magazine suitable for use with the C-20r submachine gun."
	item = /obj/item/ammo_box/magazine/smgm45
	cost = 3
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/nuclear)

/datum/uplink_item/ammo/smgap_traitor
	name = ".45 Armor Piercing SMG Magazine"
	desc = "An additional 24-round .45 magazine suitable for use with the C-20r submachine gun.\
			These rounds are less effective at injuring the target but penetrate protective gear."
	item = /obj/item/ammo_box/magazine/smgm45/ap
	cost = 5
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/nuclear)

/datum/uplink_item/ammo/smgfire_traitor
	name = ".45 Incendiary SMG Magazine"
	desc = "An additional 24-round .45 magazine suitable for use with the C-20r submachine gun.\
			Loaded with incendiary rounds which inflict little damage, but ignite the target."
	item = /obj/item/ammo_box/magazine/smgm45/incen
	cost = 4
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/nuclear)

/datum/uplink_item/ammo/shotgun/buck_traitor
	name = "12g Buckshot Drum"
	desc = "An additional 8-round buckshot magazine for use with the Bulldog shotgun. Front towards enemy."
	item = /obj/item/ammo_box/magazine/m12g
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/nuclear)

/datum/uplink_item/ammo/shotgun/dragon_traitor
	name = "12g Dragon's Breath Drum"
	desc = "An alternative 8-round dragon's breath magazine for use in the Bulldog shotgun. \
			'I'm a fire starter, twisted fire starter!'"
	item = /obj/item/ammo_box/magazine/m12g/dragon
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/nuclear)

/datum/uplink_item/ammo/shotgun/meteor_traitor
	name = "12g Meteorslug Shells"
	desc = "An alternative 8-round meteorslug magazine for use in the Bulldog shotgun. \
		Great for blasting airlocks off their frames and knocking down enemies."
	item = /obj/item/ammo_box/magazine/m12g/meteor
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/nuclear)

/datum/uplink_item/ammo/shotgun/slug_traitor
	name = "12g Slug Drum"
	desc = "An additional 8-round slug magazine for use with the Bulldog shotgun. \
			Now 8 times less likely to shoot your pals."
	cost = 3
	item = /obj/item/ammo_box/magazine/m12g/slug
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/nuclear)

//SUITS
/datum/uplink_item/suits/hardsuit/elite_traitor
	name = "Elite Syndicate Hardsuit"
	desc = "An upgraded, elite version of the Syndicate hardsuit. It features fireproofing, and also \
			provides the user with superior armor and mobility compared to the standard Syndicate hardsuit."
	item = /obj/item/clothing/suit/space/hardsuit/syndi/elite
	cost = 14
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops) //It's exactly same as the one that costs 8 TC for nukies, so they have no reason to buy it for more.

/datum/uplink_item/suits/standard_armor
	name = "Standard Armor Vest"
	desc = "A slim Type I armored vest that provides decent protection against most types of damage."
	item = /obj/item/clothing/suit/armor/vest
	cost = 1
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops) //It's exactly same as the one that costs 8 TC for nukies, so they have no reason to buy it for more.

/datum/uplink_item/suits/standard_armor
	name = "Bulletproof Armor Vest"
	desc = "A Type III heavy bulletproof vest that excels in protecting the wearer against traditional projectile weaponry and explosives to a minor extent."
	item = /obj/item/clothing/suit/armor/bulletproof
	cost = 6
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops) //It's exactly same as the one that costs 8 TC for nukies, so they have no reason to buy it for more.

//HELMETS
/datum/uplink_item/suits/hardsuit/swathelmet_traitor
	name = "Syndicate Helmet"
	desc = "An extremely robust, space-worthy helmet in a nefarious red and black stripe pattern."
	item = /obj/item/clothing/head/helmet/swat
	cost = 64
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops) //It's exactly same as the one that costs 8 TC for nukies, so they have no reason to buy it for more.

//IMPLANTS
/datum/uplink_item/implants/antistun_traitor
	name = "CNS Rebooter Implant"
	desc = "This implant will help you get back up on your feet faster after being stunned. Comes with an autosurgeon."
	item = /obj/item/autosurgeon/organ/syndicate/anti_stun
	cost = 12
	surplus = 0
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops)
