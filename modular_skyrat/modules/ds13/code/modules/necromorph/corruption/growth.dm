/obj/structure/corruption_node/growth
	name = "propagator"
	desc = "Corruption spreads out in all directions from this horrible mass."
	max_health = 200	//Takes a while to kill
	resistance = 8
	icon_state = "growth"
	density = FALSE

	var/range = 14
	var/speed = 1.25
	var/falloff = 0.1
	var/limit = null	//Maximum number of tiles it can support

/obj/structure/corruption_node/growth/debug
	name = "debug propagator"
	desc = "you shouldn't see this"
	speed = 9999
	falloff = 0
	marker_spawnable = FALSE


/obj/structure/corruption_node/growth/Initialize()
	.=..()
	if (!dummy)	//Don't do this stuff if its a dummy for placement preview

		set_extension(src, /datum/extension/corruption_source, range, speed, falloff, limit)
		//new /obj/effect/vine/corruption(get_turf(src),GLOB.corruption_seed, start_matured = 1)

/obj/structure/corruption_node/growth/get_blurb()
	. = "This node acts as a heart for corruption spread, allowing it to extend out up to [range] tiles in all directions from the node. It must be placed on existing corruption from another propagator node, or from the marker."


/obj/structure/corruption_node/growth/get_visualnet_tiles(var/datum/visualnet/network)
	var/datum/extension/corruption_source/CS = get_extension(src, /datum/extension/corruption_source)
	if (CS)
		return CS.get_visualnet_tiles(network)
	return list()

/obj/structure/corruption_node/growth/Destroy()
	remove_extension(src, /datum/extension/corruption_source)
	.=..()

/*
	Smaller version for signals
*/
/obj/structure/corruption_node/growth/branch
	name = "branch"
	desc = "This is just a tribute"
	max_health = 60//Takes a while to kill
	resistance = 6
	icon_state = "minigrowth"
	density = FALSE
	marker_spawnable = FALSE

	range = 7
	speed = 1
	falloff = 0.15
	randpixel = 4


/obj/structure/corruption_node/growth/branch/get_blurb()
	. = "This node acts as a smaller source for corruption spread, allowing it to extend out up to [range] tiles in all directions from the node. It must be placed on existing corruption from another propagator node, or from the marker."


/datum/signal_ability/placement/corruption/branch
	name = "branch"
	id = "branch"
	desc = ""
	energy_cost = 150
	placement_atom = /obj/structure/corruption_node/growth/branch


/*
	Root: An alternate version for tight spaces
*/
/obj/structure/corruption_node/growth/root
	name = "root"
	desc = "The root of all evil"
	max_health = 60//Takes a while to kill
	resistance = 6
	icon_state = "minigrowth"
	density = FALSE
	marker_spawnable = FALSE

	range = 40
	speed = 3
	falloff = 0.025
	limit = 60
	randpixel = 4


/obj/structure/corruption_node/growth/root/get_blurb()
	. = "This node acts as a specialised source for corruption spread, it has a massive radius of [range] tiles, and grows [speed] times as fast as normal.<br>\
	However, it has a limit of [limit] on the number of corruption tiles it can support, which is far less than other nodes would normally get. <br>\
	<br>\
	Root is optimised for snaking corruption through long, narrow spaces, like maintenance corridors. It will not perform well if placed in an open space like a large room. Generally, root should be used in areas that are only 1-2 tiles wide."

/datum/signal_ability/placement/corruption/root
	name = "Root"
	id = "root"
	desc = ""
	energy_cost = 150
	placement_atom = /obj/structure/corruption_node/growth/root
