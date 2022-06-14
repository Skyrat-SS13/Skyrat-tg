/*----- Template for ruins, prevents needing to re-type the filepath prefix -----*/
/datum/map_template/ruin/icemoon/underground/skyrat/
	prefix = "_maps/RandomRuins/IceRuins/skyrat/"
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

/datum/map_template/ruin/icemoon/underground/skyrat/ashwalker_nest
	name = "Ash Walker Nest"
	id = "ash-walker-ice"
	description = "A forboding dark stoned castle, it has seen better days but at least the current occupants patched the walls."
	prefix = "_maps/RandomRuins/IceRuins/skyrat/"
	suffix = "icemoon_underground_ash_walker1_skyrat.dmm"
	always_place = TRUE
	allow_duplicates = FALSE
