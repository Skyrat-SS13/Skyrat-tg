/datum/signal_ability/placement/corruption/wall
	name = "Hardened Growth"
	id = "wall"
	desc = "Creates an impassable object to block a tile"
	energy_cost = 50
	placement_atom = /obj/structure/corruption_node/wall


/datum/signal_ability/placement/corruption/wall/visible
	name = "Frantic Growth"
	id = "wall2"
	energy_cost = 100
	LOS_block = FALSE
	placement_atom = /obj/structure/corruption_node/wall/visible

/*
	The actual atom
*/
/obj/structure/corruption_node/wall
	name = "Hardened Growth"
	desc = "...to the last I grapple with thee; from hell's heart I stab at thee;"
	anchored = TRUE
	density = TRUE
	opacity = TRUE
	layer = ABOVE_OBJ_LAYER	//Make sure nodes draw ontop of corruption
	icon = 'icons/effects/corruption32x48.dmi'
	icon_state = "wall"
	marker_spawnable = FALSE	//When true, this automatically shows in the necroshop
	biomass = 0
	requires_corruption = TRUE
	random_rotation = TRUE	//If true, set rotation randomly on spawn
	default_scale = 1
	pixel_y = 6

	max_health = 65
	resistance = 5
	can_block_movement = TRUE

//Wall has a smaller random rotation range
/obj/structure/corruption_node/wall/get_rotation()
	return rand_between(-25, 25)//Randomly rotate it


/obj/structure/corruption_node/wall/update_icon()
	overlays.Cut()
	.=..()
	var/image/I = image(icon, src, icon_state)
	var/matrix/M = matrix()
	I.transform = turn(M, rand_between(-35, 35))
	I.pixel_x = -12
	overlays.Add(I)

	I = image(icon, icon_state)
	I.transform = turn(M, rand_between(-35, 35))
	I.pixel_x = 12
	overlays.Add(I)

/obj/structure/corruption_node/wall/get_blurb()
	. = "This node acts as a defensive wall, blocking movement and vision on the tile it's placed. The hardened growth can stall attackers for a few seconds, but it is not very durable, and easily overcome with hand tools.<br>\
	It does offer several creative possibilities. They can be placed to guard nothing in order to waste people's time, or hide cysts behind them that will fire as soon as they have a clear line of sight."


/obj/structure/corruption_node/wall/visible/get_blurb()
	. = "Creates an impassable object to block a tile. This ability is almost identical to hardened growth, except for two key differences:<br>\
	<br>\
	1. It is far more expensive.<br>\
	2. It can be placed on tiles that are currently visible to crew.<br>\
	<br>\
	Frantic growth can allow signals to construct a quick screen behind which other things can be placed, buying a few precious seconds of time to mount a defense."
