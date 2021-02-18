/datum/uplink_item/bundles_tc/spaceassassin
	name = "Space Assassin Bundle"
	desc = "A unique kit commonly used by military infiltrators and the like to get the drop on unsuspecting crew, perfect for the aspiring covert assassin and stealthy manipulator."
	item = /obj/item/storage/box/syndie_kit/spaceassassin
	cost = 30 //40 tc would have been better

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
	cost = 25

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
