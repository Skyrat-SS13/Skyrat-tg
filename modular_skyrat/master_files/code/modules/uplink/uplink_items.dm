/////////////////////////////
//SKYRAT MODULAR UPLINK ITEMS
/////////////////////////////

//Place any new uplink items in this file, and explain what they do

//BUNDLES
/datum/uplink_item/bundles_tc/spaceassassin
	name = "Space Assassin Bundle"
	desc = "A unique kit commonly used by military infiltrators and the like to get the drop on unsuspecting crew, perfect for the aspiring covert assassin and stealthy manipulator."
	item = /obj/item/storage/box/syndie_kit/spaceassassin
	cost = 30 //40 tc would have been better

//DANGEROUS
/datum/uplink_item/dangerous/aps_traitor
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

/datum/uplink_item/dangerous/holocarp
	name = "Holocarp"
	desc = "Fishsticks prepared through ritualistic means in honor of the god Carp-sie, capable of binding a holocarp \
			to act as a servant and guardian to their host."
	item = /obj/item/guardiancreator/carp/choose
	cost = 18
	surplus = 0
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops)
	player_minimum = 25
	restricted = TRUE

//STEALTHY WEAPONS
/datum/uplink_item/stealthy_weapons/cqc_traitor
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

//LOADOUTS

/datum/uplink_item/loadout_skyrat
	category = "Loadout"
	surplus = 0
	cant_discount = TRUE //I honestly don't think discount is worth it for those things, sorry.

/datum/uplink_item/loadout_skyrat/recon
	name = "Reconnaisance bundle"
	desc = "Get in and get out as quickly as you came with this unique kit of gear specialized in infiltration and observation."
	item = /obj/item/storage/backpack/duffelbag/syndie/loadout/recon
	cost = 25 // I don't think this is enough TCs

/datum/uplink_item/loadout_skyrat/spy
	name = "Spy bundle"
	desc = "Blend into the environment or any of crowd with this state-of-the-art stealth kit, perfect for infiltration experts."
	item = /obj/item/storage/backpack/duffelbag/syndie/loadout/spy
	cost = 25

/datum/uplink_item/loadout_skyrat/stealthop
	name = "Burglar Bundle"
	desc = "Not a thing aboard the station is safe from your grubby hands with this specialized set of gear, perfect for the enterprising thief."
	item = /obj/item/storage/backpack/duffelbag/syndie/loadout/stealthop
	cost = 25

/datum/uplink_item/loadout_skyrat/hacker
	name = "Hacker bundle"
	desc = "Subvert everything in sight using some of the most advanced tools available to operatives. If it’s powered, it’s already under your thumb."
	item = /obj/item/storage/backpack/duffelbag/syndie/loadout/hacker
	cost = 25

/datum/uplink_item/loadout_skyrat/sniper
	name = "Hitman bundle"
	desc = "Carry out efficient and likely not-so-discreet assassinations with this unique sniping kit. Carrying case not included."
	item = /obj/item/storage/backpack/duffelbag/syndie/loadout/sniper
	cost = 25

/datum/uplink_item/loadout_skyrat/metaops
	name = "Bulldog Operative bundle"
	desc = "Fight the power with this frontline combatant kit, featuring armor and armaments commonly utilized by assault operative teams."
	item = /obj/item/storage/backpack/duffelbag/syndie/loadout/metaops
	cost = 28

/datum/uplink_item/loadout_skyrat/bond
	name = "Classic Spy bundle"
	desc = "Play the hero or the villain in a cheesy spy movie with this throwback kit to far less modern syndicate operatives."
	item = /obj/item/storage/backpack/duffelbag/syndie/loadout/bond
	cost = 25

/datum/uplink_item/loadout_skyrat/ninja
	name = "Cyborg Ninja bundle"
	desc = "Become a force of nature with this customized kit featuring next-generation syndicate technology in an efficient package."
	item = /obj/item/storage/backpack/duffelbag/syndie/loadout/ninja
	cost = 25

/datum/uplink_item/loadout_skyrat/darklord
	name = "Dark Lord bundle"
	desc = "Wield unlimited power with this extremely effective combative kit, guaranteed to give the user efficient staying potential in any confrontation."
	item = /obj/item/storage/backpack/duffelbag/syndie/loadout/darklord
	cost = 25

/datum/uplink_item/loadout_skyrat/hunter
	name = "Whaler bundle"
	desc = "There’s no whales in space, but there sure are carp. Blend in with your prey and wield an impossibly effective high-power harpoon gun in this tribute to a tale told long ago."
	item = /obj/item/storage/box/syndie_kit/loadout/hunter
	cost = 25

/datum/uplink_item/loadout_skyrat/bee
	name = "Buzzy bundle"
	desc = "Look bee-utiful in this extra specialized rapid attack kit, featuring unique armaments seen nowhere else and a bumble-y sense of style."
	item = /obj/item/storage/box/syndie_kit/loadout/bee
	cost = 25

/datum/uplink_item/loadout_skyrat/cryomancer
	name = "Mister Freeze bundle"
	desc = "Make everybody chill out at the sight of your power with this absolutely snowy weapons kit. Also happens to be great for ice-related puns."
	item = /obj/item/storage/backpack/duffelbag/syndie/loadout/cryomancer
	cost = 25

/datum/uplink_item/loadout_skyrat/nt_impostor
	name = "Corporate Deceit Bundle"
	desc = "Don the identities of the most powerful men and women in Nanotrasen, and pull strings from the shadows as you please with this specialized kit."
	item = /obj/item/storage/box/syndie_kit/loadout/nt_impostor
	cost = 25
