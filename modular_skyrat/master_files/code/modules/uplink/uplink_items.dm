/////////////////////////////
//SKYRAT MODULAR UPLINK ITEMS
/////////////////////////////

//Place any new uplink items in this file, and explain what they do

//DANGEROUS
/datum/uplink_item/dangerous/aps2
	name = "Stechkin APS Machine Pistol"
	desc = "An ancient Soviet machine pistol, refurbished for the modern age. Uses 9mm auto rounds in 15-round magazines and is compatible \
			with suppressors. The gun fires in three round bursts."
	item = /obj/item/gun/ballistic/automatic/pistol/aps
	cost = 13
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/nuclear) //They don't need this since it is just a version that costs more than the original.

/datum/uplink_item/dangerous/foamsmg_traitor
	name = "Toy Submachine Gun"
	desc = "A fully-loaded Donksoft bullpup submachine gun that fires riot grade darts with a 20-round magazine."
	item = /obj/item/gun/ballistic/automatic/c20r/toy/unrestricted/riot
	cost = 5
	surplus = 0


//STEALTHY WEAPONS
/datum/uplink_item/stealthy_weapons/cqc2
	name = "CQC Manual"
	desc = "A manual that teaches a single user tactical Close-Quarters Combat before self-destructing."
	item = /obj/item/book/granter/martial/cqc
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops) //Blocked them because this just costs more than the version they get.
	cost = 24
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
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops)

//SUITS
/datum/uplink_item/suits/hardsuit/elite_traitor
	name = "Elite Syndicate Hardsuit"
	desc = "An upgraded, elite version of the Syndicate hardsuit. It features fireproofing, and also \
			provides the user with superior armor and mobility compared to the standard Syndicate hardsuit."
	item = /obj/item/clothing/suit/space/hardsuit/syndi/elite
	cost = 14
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops) //It's exactly same as the one that costs 8 TC for nukies, so they have no reason to buy it for more.

//IMPLANTS
/datum/uplink_item/implants/antistun_traitor
	name = "CNS Rebooter Implant"
	desc = "This implant will help you get back up on your feet faster after being stunned. Comes with an autosurgeon."
	item = /obj/item/autosurgeon/organ/syndicate/anti_stun
	cost = 12
	surplus = 0
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops)
