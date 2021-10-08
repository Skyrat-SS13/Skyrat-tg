/*----- Template for ruins, prevents needing to re-type the filepath prefix -----*/
/datum/map_template/ruin/icemoon/underground/skyrat/
	prefix = "modular_skyrat/modules/mapping/_maps/RandomRuins/IceRuins/"
/*------*/

/datum/map_template/ruin/icemoon/underground/skyrat/syndicate_base
	name = "Syndicate Ice Base"
	id = "ice-base"
	description = "A secret base researching illegal bioweapons, it is closely guarded by an elite team of syndicate agents."
	suffix = "icemoon_underground_syndicate_base1_skyrat.dmm"
	allow_duplicates = FALSE
	never_spawn_with = list(/datum/map_template/ruin/lavaland/skyrat/syndicate_base, /datum/map_template/ruin/rockplanet/syndicate_base)
	always_place = TRUE

/datum/map_template/ruin/icemoon/underground/skyrat/mining_site_below
	name = "Mining Site Underground"
	id = "miningsite-underground"
	description = "The Iceminer arena."
	suffix = "icemoon_underground_mining_site_skyrat.dmm"
	always_place = TRUE

/datum/map_template/ruin/icemoon/underground/skyrat/cabin1
	name = "Small Cabin"
	id = "cabin1"
	description = "A small cabin, likely beloning to a hermit of some sort once."
	suffix = "icemoon_underground_cabin1.dmm"

/datum/map_template/ruin/icemoon/underground/skyrat/cabin2
	name = "Haunted Cabin"
	id = "cabin2"
	description = "A small cabin, likely beloning to a hunter and his family."
	suffix = "icemoon_underground_cabin2.dmm"

/datum/map_template/ruin/icemoon/underground/skyrat/crashedship
	name = "Crashed Ship"
	id = "crashship"
	description = "A crashed ship full of angry Russians."
	suffix = "icemoon_underground_crashedship.dmm"

/datum/map_template/ruin/icemoon/underground/skyrat/smalltown
	name = "Small Village"
	id = "icevillage"
	description = "Little towns on frontier worlds aren't exactly uncommon, and neither are ghost towns like this one..."
	suffix = "icemoon_underground_smalltown.dmm"

/datum/map_template/ruin/icemoon/underground/skyrat/weirdlab
	name = "Odd Lab"
	id = "spiderlabs"
	description = "An abandoned lab full of spiders."
	suffix = "icemoon_underground_weirdlab.dmm"

/datum/map_template/ruin/icemoon/underground/skyrat/syndicateoutpost
	name = "Syndicate Outpost"
	id = "icesyndioutpost"
	description = "Syndicate outposts are far from uncommon, but usually aren't this well defended without good reason."
	suffix = "icemoon_underground_syndicateoutpost.dmm"

/datum/map_template/ruin/icemoon/underground/skyrat/zombielab
	name = "Zombie Infested Lab"
	id = "icezombielab"
	description = "Nanotrasen plasma research has resulted in plenty of disasters, but none as strange as plasma-infused undead."
	suffix = "icemoon_underground_zombielab.dmm"

/datum/map_template/ruin/icemoon/underground/skyrat/cult
	name = "Cult Hideout"
	id = "iceculthideout"
	description = "Mae'wa Lo sha'rim."
	suffix = "icemoon_underground_cult.dmm"

/datum/map_template/ruin/icemoon/underground/skyrat/oldminingpost
	name = "Abandoned Mining Base"
	id = "iceoldminingbase"
	description = "Something horrific happened here."
	suffix = "icemoon_underground_oldminingpost.dmm"

/datum/map_template/ruin/icemoon/underground/skyrat/huntinglodge
	name = "Hunter Guild Lodge"
	id = "huntingguildice"
	description = "One of the many Hunter's Guild lodges, a group dedicated to protecting more isolated communities and towns from dangerous wildlife."
	suffix = "icemoon_underground_huntinglodge.dmm"

/datum/map_template/ruin/icemoon/underground/skyrat/diner
	name = "Diner"
	id = "icediner"
	description = "A small diner trying to make some money."
	suffix = "icemoon_underground_diner.dmm"
