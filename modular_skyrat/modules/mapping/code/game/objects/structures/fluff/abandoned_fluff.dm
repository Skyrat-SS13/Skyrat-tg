/* ----- Abandoned Decor -----*/
//Abandoned items, apocalypse-themed stuff basically. Most common examples will be found on Rockplanet's ruins, but you can obviously use it in gateways or whatever

/obj/structure/fluff/abandoned	//Keeps me from having to re-define icon over and over
	icon = 'modular_skyrat/modules/mapping/icons/obj/fluff/abandoned_fluff.dmi'
	layer = OBJ_LAYER
	plane = FLOOR_PLANE
	density = FALSE	//Will be edited when it matters
	deconstructible = TRUE	//Most, if not all the abandoned decor is deconstructable

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
	icon = 'modular_skyrat/modules/mapping/icons/obj/fluff/abandoned_fluff.dmi'
	icon_state = "nosmoking_worn"
	is_editable = FALSE
	buildable_sign = FALSE

/obj/structure/sign/warning/nosmoking/circle/worn/wrench_act(mob/living/user, obj/item/wrench/I)	//Overwrites the sign deconstruct (I just wanted to keep the wall mounting ok)
	user.visible_message(span_notice("[user] tries to take the [src] off the wall, but it falls to pieces!"), \
		span_notice("You try removing the [src] from the wall, but it falls to pieces!"))
	new /obj/item/stack/sheet/plastic
	qdel(src)
	return TRUE

/obj/structure/sign/plaques/ancient_astronaut
	name = "Long-Forgotten Astronauts"
	desc = "A plaque on the bottom of the frame once memorialized the names of these three intrepid explorers; sadly, it's fallen off and been lost to the ages."
	icon = 'modular_skyrat/modules/mapping/icons/obj/fluff/abandoned_fluff.dmi'
	icon_state = "painting_astronauts"
	custom_materials = list(/datum/material/wood = 2000) //The same as /obj/structure/sign/picture_frame

/obj/structure/sign/plaques/clock_broken
	name = "old clock"
	desc = "An ancient clock from the times when people had the patience to analyze where the arms were pointing. Deep down you're glad this one's broken."
	icon = 'modular_skyrat/modules/mapping/icons/obj/fluff/abandoned_fluff.dmi'
	icon_state = "clock"

/obj/structure/sign/plaques/clock_broken/wrench_act(mob/living/user, obj/item/wrench/I)	//Overwrites the sign deconstruct for the broken clock
	user.visible_message(span_notice("[user] tries to take the [src] off the wall, but it falls to pieces!"), \
		span_notice("You try removing the [src] from the wall, but it falls to pieces!"))
	new /obj/item/stack/sheet/iron
	qdel(src)
	return TRUE

//This is a 3x1 road blocker, use it for road checkpoints and the likes. Make sure all 3 pieces are placed
/obj/structure/fluff/abandoned/blocker
	name = "road blocker"
	desc = "An old blocker intended to prevent vehicles from passing into an area. Considering you can't move it, you'll have to climb over or go around."
	icon_state = "blocker_h"
	density = TRUE
	deconstructible = FALSE

/obj/structure/fluff/abandoned/blocker/vertical
	icon_state = "blocker_v"

/obj/structure/fluff/abandoned/blocker/worn
	icon_state = "blocker_h_worn"

/obj/structure/fluff/abandoned/blocker/worn/vertical
	icon_state = "blocker_v_worn"

/obj/structure/fluff/abandoned/blocker/Initialize()
	. = ..()
	AddElement(/datum/element/climbable)

//Cinderblock -----
/obj/structure/fluff/abandoned/cinderblock
	name = "cinderblock"
	desc = "An old concrete block."
	icon_state = "block1"
	//NOTE - Block1 is the only block with north-to-south variants
	density = TRUE
	deconstructible = FALSE
	var/climbable = TRUE

/obj/structure/fluff/abandoned/cinderblock/end
	icon_state = "block1_end"

/obj/structure/fluff/abandoned/cinderblock/mid
	icon_state = "block1_mid"

/obj/structure/fluff/abandoned/cinderblock/double
	icon_state = "block2"
	climbable = FALSE

/obj/structure/fluff/abandoned/cinderblock/large
	icon_state = "block3"
	climbable = FALSE

/obj/structure/fluff/abandoned/cinderblock/long
	icon_state = "block4"

/obj/structure/fluff/abandoned/cinderblock/tall
	icon_state = "block5"
	climbable = FALSE

/obj/structure/fluff/abandoned/cinderblock/tube	//I know this isn't a cinderblock, but they're both construction supplies so they go together
	name = "tube"
	desc = "An old metal tube, seeing no use. Could use it for some sick grinds."
	icon_state = "tube"

/obj/structure/fluff/abandoned/cinderblock/tube/middle
	icon_state = "tube_mid"

/obj/structure/fluff/abandoned/cinderblock/tube/end
	icon_state = "tube_end"

/obj/structure/fluff/abandoned/cinderblock/wirecoil	//Again, not a cinderblock, but it falls under the construction supplies
	name = "wire coil"
	desc = "A large spool of wire, to be layed underground or within walls."
	icon_state = "wirecoil"

/obj/structure/fluff/abandoned/cinderblock/Initialize()
	. = ..()
	if(climbable)
		AddElement(/datum/element/climbable)

//Furnishings -----
/obj/structure/fluff/abandoned/piping
	name = "piping"
	desc = "Old, exposed water piping."
	icon_state = "piping"
	layer = SIGN_LAYER

/obj/structure/fluff/abandoned/piping/broken
	name = "broken piping"
	desc = "Old, exposed water piping. This one has burst."
	icon_state = "piping_broken"

/obj/structure/fluff/abandoned/radiator
	name = "radiator"
	desc = "An old method of temperature control using the power of water and electricity. We've advanced past the need for these, though!"
	icon_state = "radiator"
	layer = SIGN_LAYER

/obj/structure/fluff/abandoned/radiator/worn
	icon_state = "radiator_worn"

/obj/structure/fluff/abandoned/breaker
	name = "breaker box"
	desc = "An old-fashioned method of preventing electrical hazards, these breaker boxes are full of switches to automatically cut power in case of a surge. If only Nanotrasen's APCs used this for SM output..."
	icon_state = "breaker"
	layer = SIGN_LAYER

/obj/structure/fluff/abandoned/breaker/worn
	icon_state = "breaker_worn"

/obj/structure/fluff/abandoned/breaker/worn/open
	icon_state = "breaker_open"

/obj/structure/fluff/abandoned/tire
	name = "tires"
	desc = "Some tires for long-outdated vehicles. These are useless."
	icon_state = "tire"

/obj/structure/fluff/abandoned/tire/Initialize()	//Tires are randomized in number, and in offset
	. = ..()
	icon_state += pick("", "_2", "_3","_pile")
	if(icon_state == "tire")	//Single tire gets custom name and description, for being singular. Yes, byond can do this automatically, but I like this special description
		name = "tire"
		desc = "A single lost tire for an outdated vehicle. You're free now, little tire..."
	pixel_x = rand(-8,8)
	pixel_y = rand(-8,8)

/obj/structure/fluff/abandoned/blender
	name = "blender"
	desc = "An old blender, used for - well, blending. Without power and many, many repairs, this is useless."
	icon_state = "blender"
	layer = OBJ_LAYER

/obj/structure/fluff/abandoned/terminal
	name = "computer terminal"
	desc = "A long-outdated computer terminal, though it feels much more homely. Obviously due to age, it's stopped working entirely."
	icon_state = "terminal"
	layer = OBJ_LAYER

/obj/structure/fluff/abandoned/terminal/old
	icon_state = "terminal_old"

/obj/structure/fluff/abandoned/terminal/examine_more(mob/user)
	var/msg = "A small note hastily etched in above the keyboard simply says \"Press F to pay respects, we lost a good computer today.\""
	msg += "Sadly, a trolling scavenger has stolen the F key."
	return msg
	//This is funny and no one can change my mind. Out in the wastes, any bit of humor can lighten a horrible mood. Sometimes that humor is less friendly than others'.

/obj/structure/fluff/abandoned/vent
	name = "old vent"
	desc = "Once used to control temperature and airflow, or as a drain even. Useless now..."
	icon_state = "vent"

/obj/structure/fluff/abandoned/vent/Initialize()
	. = ..()
	icon_state += pick("", "_a","_b")	//Random level of wear

/obj/item/abandoned_mic_stand	//Not a structure, but I dont care >:)
	name = "old microphone"
	desc = "An old microphone, wired to.. nothing. I guess it's still good for pretending to sing."
	icon = 'modular_skyrat/modules/mapping/icons/obj/fluff/abandoned_fluff.dmi'
	icon_state = "old_mic"
	inhand_icon_state = "razor"	//I could have sworn we had a microphone already, but apparently not. This'll do.

/obj/structure/bed/maint/abandoned	//Inherits the swabbable maint stuff
	name = "mattress"
	desc = "An old mattress, with a cross-sewn pattern. While it's not a nest to some sort of vermin, it's still probably going to give you a long-dormant disease if you touch it."
	icon_state = "mattress"
	icon = 'modular_skyrat/modules/mapping/icons/obj/fluff/abandoned_fluff.dmi'
	can_buckle = FALSE //Why would these have straps?

/obj/structure/bed/maint/abandoned/randomspawn

/obj/structure/bed/maint/abandoned/randomspawn/Initialize()	//randomized bed/frame combo, for lazy mappers
	. = ..()
	icon_state += pick("", "_filthy","_bloody_a","_bloody_b")	//Random stains... ew
	if(prob(30))	//30% chance to spawn with a bedframe below it
		new /obj/structure/fluff/abandoned/bedframe(src.loc)

/obj/structure/fluff/abandoned/bedframe
	name = "rusty bedframe"
	desc = "An old bedframe to keep a mattress off the floor. You'd be surprised if it could successfully hold one up at this point."
	icon_state = "bedframe_old"
	layer = GATEWAY_UNDERLAY_LAYER	//.05 below the default mattress layer, ensures this shows up UNDER a mattress

//Functional -----
//Probably should be in different files, but seeing how they're mostly just fluff variants of existing items, I figure they're practically fluff anyways. Saves space in the .dme too
/obj/item/radio/ancient_military	//Essentially a reskinned station-bounced, except bigger. Why would you want this? A E S T H E T I C. Yes, not a structure, but because its anchorable its going here.
	name = "military stationary radio"
	desc = "An old radio that transmits over local frequencies. Luckily, it's tuning range is close enough to NT-standard."
	icon = 'modular_skyrat/modules/mapping/icons/obj/fluff/abandoned_fluff.dmi'
	icon_state = "radio"
	slot_flags = null
	dog_fashion = null

	flags_1 = CONDUCT_1
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_BULKY	//Maybe Normal, so backpacks can carry it?

	on = FALSE	//Starts turned off
	canhear_range = 4  //Longer range for hearing, because it'd be intended to stay on a table. In fact..-

/obj/item/radio/ancient_military/attackby(obj/item/W, mob/user, params)	//Rewritten because otherwise the if statement ends early. TL;DR, this version can be anchored
	add_fingerprint(user)
	if(W.tool_behaviour == TOOL_SCREWDRIVER)
		unscrewed = !unscrewed
		if(unscrewed)
			to_chat(user, span_notice("The radio can now be attached and modified!"))
		else
			to_chat(user, span_notice("The radio can no longer be modified or attached!"))
	else if(W.tool_behaviour == TOOL_WRENCH)
		set_anchored(!anchored)
		W.play_tool_sound(src, 50)
		user.visible_message(span_notice("[user] [anchored ? "anchored" : "unanchored"] \the [src]."), \
						span_notice("You [anchored ? "anchored" : "unanchored"] \the [src]."))
	else
		return ..()

/obj/structure/closet/crate/abandoned/wooden
	name = "old wooden crate"
	desc = "An old crate, made of a long-extinct type of wood."
	icon = 'modular_skyrat/modules/mapping/icons/obj/fluff/abandoned_fluff.dmi'
	icon_state = "crate_green"
	material_drop = /obj/item/stack/sheet/mineral/wood
	material_drop_amount = 4
	integrity_failure = 0 //Makes the crate break when integrity reaches 0, instead of opening

/obj/structure/closet/crate/abandoned/wooden/loot	//Subtype used for random loot gen, mostly on Rockplanet :)

/obj/structure/closet/crate/abandoned/wooden/loot/PopulateContents()
	. = ..()
	for(var/i in 1 to rand(3,5))
		new /obj/effect/spawner/lootdrop/maintenance(src)	//Change this

/obj/structure/closet/abandoned_fridge
	name = "grimy old fridge"
	desc = "This refrigerator looks old, it's power long gone. Anything inside is bound to have spoiled or been looted by now, but there's no harm in looking, right..?"
	icon = 'modular_skyrat/modules/mapping/icons/obj/fluff/abandoned_fluff.dmi'
	icon_state = "fridge"

/obj/structure/closet/abandoned_cabinet
	name = "old cabinet"
	desc = "A nice cabinet made of a long-extinct wood. The hinges are practically stuck in place from the rust, but it should give way with some force."
	icon = 'modular_skyrat/modules/mapping/icons/obj/fluff/abandoned_fluff.dmi'
	icon_state = "cabinet"
