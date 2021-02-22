/*
	A node that provides light and nothing else.
	Its just an organic lightbulb
*/
/obj/structure/corruption_node/bioluminescence
	name = "bioluminescent nodule"
	desc = "A candle to light the way home"
	icon_state = "light"
	max_health = 20	//fragile
	default_scale = 1.6
	var/light_range = 8
	marker_spawnable = FALSE



/obj/structure/corruption_node/bioluminescence/Initialize()
	.=..()
	if (!dummy)	//Don't do this stuff if its a dummy for placement preview
		set_light(1, 1, light_range, 2, COLOR_BIOLUMINESCENT_ORANGE)


/obj/structure/corruption_node/bioluminescence/get_blurb()
	. = "This node is effectively an organic lightbulb. <br>\
	It illuminates an 8 tile radius with a soft orange glow, allowing people (especially necromorphs) to see where they're going in the dark.<br>\
	<br>\
	Providing light is all it does, there is no other function."



/*
	Signal ability
*/
/datum/signal_ability/placement/corruption/bioluminescence
	name = "Bioluminescence"
	id = "bioluminescence"
	energy_cost = 30
	placement_atom = /obj/structure/corruption_node/bioluminescence
	LOS_block	=	FALSE