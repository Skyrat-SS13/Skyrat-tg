/obj/structure/alien/weeds/xen
	name = "xen weeds"
	desc = "A thick vine-like surface covers the floor."
	color = "#ac3b06"

/obj/structure/spacevine/xen
	name = "xen vines"
	color = "#ac3b06"

/obj/structure/spacevine/xen/Initialize(mapload)
	. = ..()
	add_atom_colour("#ac3b06", FIXED_COLOUR_PRIORITY)

/obj/structure/spacevine/xen/thick
	name = "thick xen vines"
	color = "#ac3b06"
	opacity = TRUE

/obj/structure/mineral_door/xen
	name = "organic door"
	color = "#ff8d58"
	icon = 'modular_skyrat/modules/black_mesa/icons/xen_door.dmi'
	icon_state = "resin"
	openSound = 'modular_skyrat/modules/black_mesa/sound/xen_door.ogg'
	closeSound = 'modular_skyrat/modules/black_mesa/sound/xen_door.ogg'

/obj/machinery/door/keycard/xen_boss
	name = "locktight organic door"
	desc = "Complete the puzzle to open this door."
	icon = 'modular_skyrat/modules/black_mesa/icons/xen_door.dmi'
	icon_state = "resin"
	puzzle_id = "xen"

/obj/item/keycard/xen
	name = "xen keycard"
	desc = "A xen keycard."
	color = "#ac3b06"
	puzzle_id = "xen"

/obj/effect/sliding_puzzle/xen
	reward_type = /obj/item/keycard/xen
