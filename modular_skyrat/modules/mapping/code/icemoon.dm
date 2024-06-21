/*----- Template for ruins, prevents needing to re-type the filepath prefix -----*/
/datum/map_template/ruin/icemoon/underground/skyrat/
	prefix = "_maps/RandomRuins/IceRuins/skyrat/"
/*------*/

/datum/map_template/ruin/icemoon/underground/skyrat/syndicate_base
	name = "Ice-Ruin Syndicate Ice Base"
	id = "ice-base"
	description = "A secret base researching illegal bioweapons, it is closely guarded by an elite team of syndicate agents."
	suffix = "icemoon_underground_syndicate_base1_skyrat.dmm"
	allow_duplicates = FALSE
	never_spawn_with = list(/datum/map_template/ruin/lavaland/skyrat/syndicate_base)
	always_place = TRUE

/datum/map_template/ruin/icemoon/underground/skyrat/mining_site_below
	name = "Ice-Ruin Mining Site Underground"
	id = "miningsite-underground"
	description = "The Iceminer arena."
	suffix = "icemoon_underground_mining_site_skyrat.dmm"
	always_place = TRUE
