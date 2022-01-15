/////////////////////////////
//SKYRAT MODULAR UPLINK ITEMS
/////////////////////////////

//Place any new uplink items in this file, and explain what they do

//DANGEROUS
/datum/uplink_item/dangerous/foamsmg_traitor
	name = "Toy Submachine Gun"
	desc = "A fully-loaded Donksoft bullpup submachine gun that fires riot grade darts with a 20-round magazine."
	item = /obj/item/gun/ballistic/automatic/c20r/toy/unrestricted/riot
	cost = 5

/datum/uplink_item/dangerous/katana_traitor
	name = "Katana"
	desc = "An incredibly sharp sword used by Samurais. Woefully underpowered in D20."
	item = /obj/item/katana
	cost = 8
	progression_minimum = 20 MINUTES

/datum/uplink_item/dangerous/oddjob
	name = "Deadly Bowler Hat"
	desc = "An incredibly sharp edged bowler hat used by an infamously short operative."
	item = /obj/item/clothing/head/sus_bowler
	cost = 20

//STEALTHY TOOOLS
/datum/uplink_item/stealthy_tools/syndieshotglasses
	name = "Extra Large Syndicate Shotglasses"
	desc = "These modified shot glasses can hold up to 50 units of booze while looking like a regular 15 unit model \
	guaranteed to knock someone on their ass with a hearty dose of bacchus blessing. Look for the Snake underneath \
	to tell these are the real deal. Box of 7."
	item = /obj/item/storage/box/syndieshotglasses
	cost = 2 //These are taken nearly exactly from Goon, very fun tool.
	restricted_roles = list(JOB_BARTENDER)

//EXPLOSIVES
/datum/uplink_item/explosives/bonebang
	name = "Bonebang"
	desc = "A horrifying grenade filled with what looks to be bone and gore, which upon detonation will fill the room you're in with bone fragments."
	item = /obj/item/grenade/stingbang/bonebang
	cost = 5

//DEVICE TOOLS
/datum/uplink_item/device_tools/ammo_pouch
	name = "Ammo Pouch"
	desc = "A small yet large enough pouch that can fit in your pocket, and has room for three magazines."
	item = /obj/item/storage/bag/ammo
	cost = 1

/datum/uplink_item/device_tools/syndie_glue
	name = "Glue"
	desc = "A cheap bottle of one use syndicate brand super glue. \
			Use on any item to make it undroppable. \
			Be careful not to glue an item you're already holding!"
	item = /obj/item/syndie_glue
	cost = 3

/datum/uplink_item/device_tools/syndikush
	name = "Syndikush Green Crack cart"
	desc = "A cheap Chinese vape cart that contains a potent combination of THC and \
			stimulants. Not made with real crack."
	item = /obj/item/reagent_containers/vapecart/syndicate
	cost = 5
	surplus = 90

//JOBS ONLY
/datum/uplink_item/role_restricted/cultkitsr //Ported from beestation
	name = "Cult Construct Kit"
	desc = "Recovered from an abandoned Nar'sie cult lair, two construct shells and a stash of empty soulstones was found. These were purified to prevent occult contamination and have been put in a belt so they may be used as an accessible source of disposable minions. The construct shells have been packaged into two beacons for rapid and portable deployment."
	item = /obj/item/storage/box/syndie_kit/cultkitsr
	cost = 15 //If used correctly, You actually get several servants or just get fucked over because no ghosts want to be a shade.
	restricted_roles = list(JOB_CHAPLAIN)

//LOADOUTS
/datum/uplink_item/bundles_tc/recon
	name = "Reconnaisance bundle"
	desc = "Get in and get out as quickly as you came with this unique kit of gear specialized in infiltration and observation."
	item = /obj/item/storage/backpack/duffelbag/syndie/loadout/recon
	cost = TELECRYSTALS_DEFAULT
	progression_minimum = 20 MINUTES

/datum/uplink_item/bundles_tc/spy
	name = "Spy bundle"
	desc = "Blend into the environment or any of crowd with this state-of-the-art stealth kit, perfect for infiltration experts."
	item = /obj/item/storage/backpack/duffelbag/syndie/loadout/spy
	cost = TELECRYSTALS_DEFAULT
	progression_minimum = 20 MINUTES

/datum/uplink_item/bundles_tc/stealthop
	name = "Burglar Bundle"
	desc = "Not a thing aboard the station is safe from your grubby hands with this specialized set of gear, perfect for the enterprising thief."
	item = /obj/item/storage/backpack/duffelbag/syndie/loadout/stealthop
	cost = TELECRYSTALS_DEFAULT
	progression_minimum = 20 MINUTES

/datum/uplink_item/bundles_tc/hacker
	name = "Hacker bundle"
	desc = "Subvert everything in sight using some of the most advanced tools available to operatives. If it’s powered, it’s already under your thumb."
	item = /obj/item/storage/backpack/duffelbag/syndie/loadout/hacker
	cost = TELECRYSTALS_DEFAULT
	progression_minimum = 20 MINUTES

/datum/uplink_item/bundles_tc/bond
	name = "Classic Spy bundle"
	desc = "Play the hero or the villain in a cheesy spy movie with this throwback kit to far less modern syndicate operatives."
	item = /obj/item/storage/backpack/duffelbag/syndie/loadout/bond
	cost = TELECRYSTALS_DEFAULT
	progression_minimum = 20 MINUTES

/datum/uplink_item/bundles_tc/darklord
	name = "Dark Lord bundle"
	desc = "Wield unlimited power with this extremely effective combative kit, guaranteed to give the user efficient staying potential in any confrontation."
	item = /obj/item/storage/backpack/duffelbag/syndie/loadout/darklord
	cost = TELECRYSTALS_DEFAULT
	progression_minimum = 20 MINUTES

/datum/uplink_item/bundles_tc/bee
	name = "Buzzy bundle"
	desc = "Look bee-utiful in this extra specialized rapid attack kit, featuring unique armaments seen nowhere else and a bumble-y sense of style."
	item = /obj/item/storage/box/syndie_kit/loadout/bee
	cost = TELECRYSTALS_DEFAULT
	progression_minimum = 20 MINUTES

/datum/uplink_item/bundles_tc/cryomancer
	name = "Mister Freeze bundle"
	desc = "Make everybody chill out at the sight of your power with this absolutely snowy weapons kit. Also happens to be great for ice-related puns."
	item = /obj/item/storage/backpack/duffelbag/syndie/loadout/cryomancer
	cost = TELECRYSTALS_DEFAULT
	progression_minimum = 20 MINUTES

/datum/uplink_item/bundles_tc/doctordeath
	name = "Doctor Death bundle"
	desc = "Be your very own mad scientist with this toxic bundle! Warning, license void if poisons used on self. Read bottom of bag for more information."
	item = /obj/item/storage/backpack/duffelbag/syndie/loadout/doctordeath
	cost = TELECRYSTALS_DEFAULT
	progression_minimum = 20 MINUTES

/datum/uplink_item/bundles_tc/donkcoshill
	name = "Donk Co. Shill bundle"
	desc = "Love Donk Pockets? Want to shill Donk Co. Toys? This bundle is for you! Contains some DonkSoft guns, a vending machine, restocking units, and a box of Donk Pockets."
	item = /obj/item/storage/backpack/duffelbag/syndie/loadout/donkshillkit
	cost = TELECRYSTALS_DEFAULT
	progression_minimum = 20 MINUTES

/datum/uplink_item/bundles_tc/downtownspecial
	name = "Downtown Special bundle"
	desc = "Ayyy fuggedaboudit! This bundle contains everything to be your own one man mafioso. Including an icon of the Virgin Mary for your own authentic mafia nickname. Gang members not included."
	item = /obj/item/storage/backpack/duffelbag/syndie/loadout/downtownspecial
	cost = TELECRYSTALS_DEFAULT
	progression_minimum = 20 MINUTES

/datum/uplink_item/bundles_tc/ocelotfoxtrot
	name = "Snake Eater bundle"
	desc = "A kit themed around one certain gun spinning cat. Includes his famous colt special, and personalised ammo."
	item = /obj/item/storage/box/syndie_kit/loadout/ocelotfoxtrot
	cost = TELECRYSTALS_DEFAULT
	progression_minimum = 20 MINUTES

/datum/uplink_item/bundles_tc/nt_impostor
	name = "Corporate Deceit bundle"
	desc = "Don the identities of the most powerful men and women in Nanotrasen, and pull strings from the shadows as you please with this specialized kit."
	item = /obj/item/storage/box/syndie_kit/loadout/nt_impostor
	cost = TELECRYSTALS_DEFAULT
	progression_minimum = 20 MINUTES

/datum/uplink_item/bundles_tc/lasermanbundle
	name = "Laserman bundle"
	desc = "Themed after an infamous syndicate operative with a particular fighting style, this kit is both a fashionable throwback and a uniquely useful combative loadout."
	item = /obj/item/storage/box/syndie_kit/loadout/lasermanbundle
	cost = TELECRYSTALS_DEFAULT
	progression_minimum = 20 MINUTES
