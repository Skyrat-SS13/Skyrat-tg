/* ----- Metal Poles -----*/
//Just a re-done Tram Rail, but with all 4 directions instead of being stuck east/west - more varied placement, and a more vague name. Good for mapping support beams/antennae/etc
/obj/structure/fluff/metalpole
	icon = 'modular_skyrat/modules/mapping/icons/obj/fluff.dmi'
	name = "metal pole"
	desc = "A metal pole, the likes of which are commonly used as an antennae, structural support, or simply to maneuver in zero-g."
	icon_state = "pole"
	layer = ABOVE_OPEN_TURF_LAYER
	plane = FLOOR_PLANE
	deconstructible = TRUE

/obj/structure/fluff/metalpole/end
	icon_state = "poleend"

/obj/structure/fluff/metalpole/end/left
	icon_state = "poleend_left"

/obj/structure/fluff/metalpole/end/right
	icon_state = "poleend_right"

/obj/structure/fluff/metalpole/anchor
	name = "metal pole anchor"
	icon_state = "poleanchor"

/* ----- Abandoned Decor -----*/
//Abandoned items, apocalypse-themed stuff basically. Most common examples will be found on Rockplanet's ruins, but it's here for use in gateways and other maps' ruins too
/obj/structure/fluff/abandoned	//Keeps me from having to re-define icon over and over
	icon = 'modular_skyrat/modules/mapping/icons/obj/fluff.dmi'
	layer = ABOVE_OPEN_TURF_LAYER
	plane = FLOOR_PLANE
	deconstructible = TRUE

//Signs -----
/obj/structure/fluff/abandoned/stopsign
	name = "stop sign"
	desc = "A stop sign used to control traffic flow at intersections. It hasn't seen much use since cars became obsolete."
	icon_state = "stop"

/obj/structure/fluff/abandoned/stopsign/worn
	icon_state = "stop_worn"

/obj/structure/fluff/abandoned/noentry
	name = "no-entry sign"
	desc = "A no-entry sign used to stop traffic flow into an offroad. It hasn't seen much use since cars became obsolete."
	icon_state = "noentry"

/obj/structure/fluff/abandoned/noentry/worn
	icon_state = "noentry_worn"

/obj/structure/fluff/abandoned/parking
	name = "parking zone sign"
	desc = "A parking zone sign used to designate lots to leave vehicles in. It hasn't seen much use since cars became obsolete."
	icon_state = "parking"

/obj/structure/fluff/abandoned/parking/worn
	icon_state = "parking_worn"

/obj/structure/sign/warning/nosmoking/circle/worn
	desc = "A warning sign which probably used to read 'NO SMOKING'."
	icon_state = "nosmoking_worn"
	is_editable = FALSE
	buildable_sign = FALSE

/obj/structure/sign/warning/nosmoking/circle/worn/wrench_act(mob/living/user, obj/item/wrench/I)	//Overwrites the sign deconstruct (I just wanted to keep the wall mounting ok)
	new /obj/item/stack/sheet/plastic
	user.visible_message(span_notice("[user] tries to take the [src] off the wall, but it falls to pieces!"), \
		span_notice("You try removing the [src] from the wall, but it falls to pieces!"))
	qdel(src)
	return TRUE

//Cinderblock -----
/obj/structure/fluff/abandoned/cinderblock
	//This will be block1
	//TODO: blend east/west
	//TODO: make climbable

/obj/structure/fluff/abandoned/cinderblock/double
	//This will be block2
	//TODO: blend east/west
	//TODO: block movement

/obj/structure/fluff/abandoned/cinderblock/large
	//This will be block3
	//TODO: blend east/west
	//TODO: block movement

/obj/structure/fluff/abandoned/cinderblock/long
	//This will be block4
	//TODO: blend north/south
	//TODO: make climbable

/obj/structure/fluff/abandoned/cinderblock/tall
	//This will be block5
	//TODO: blend north/south
	//TODO: block movement

/obj/structure/fluff/abandoned/cinderblock/tube	//I know this isn't a cinderblock, but they're both construction supplies so they go together
	//This will be pipe

/obj/structure/fluff/abandoned/cinderblock/tube/middle
	//This will be pipe_mid

/obj/structure/fluff/abandoned/cinderblock/tube/end
	//This will be pipe_end

//NEXT -----
