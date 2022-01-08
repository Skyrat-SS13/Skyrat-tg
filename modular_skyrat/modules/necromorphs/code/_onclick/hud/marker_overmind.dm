/datum/hud
	var/atom/movable/screen/markerpwrdisplay

/atom/movable/screen/marker
	icon = 'icons/hud/blob.dmi'

/atom/movable/screen/marker/MouseEntered(location,control,params)
	. = ..()
	openToolTip(usr,src,params,title = name,content = desc, theme = "blob")

/atom/movable/screen/marker/MouseExited()
	closeToolTip(usr)

/atom/movable/screen/marker/marker_help
	icon_state = "ui_help"
	name = "Marker Help"
	desc = "Help on playing marker!"

// /atom/movable/screen/marker/marker_help/Click()
// 	if(ismarkerovermind(usr))
// 		var/mob/camera/marker/B = usr
// //		B.marker_help()

/atom/movable/screen/marker/jump_to_node
	icon_state = "ui_tonode"
	name = "Jump to Node"
	desc = "Moves your camera to a selected marker node."

/atom/movable/screen/marker/jump_to_node/Click()
	if(ismarkerovermind(usr))
		var/mob/camera/marker/B = usr
		B.jump_to_node()

/atom/movable/screen/marker/jump_to_core
	icon_state = "ui_tocore"
	name = "Jump to Core"
	desc = "Moves your camera to your marker core."

/atom/movable/screen/marker/jump_to_core/MouseEntered(location,control,params)
	if(hud?.mymob && ismarkerovermind(hud.mymob))
		var/mob/camera/marker/B = hud.mymob
		if(!B.placed)
			name = "Place Marker Core"
			desc = "Attempt to place your marker core at this location."
		else
			name = initial(name)
			desc = initial(desc)
	return ..()

/atom/movable/screen/marker/jump_to_core/Click()
	if(ismarkerovermind(usr))
		var/mob/camera/marker/B = usr
		if(!B.placed)
			B.place_marker_core(0)
		B.transport_core()

// /atom/movable/screen/marker/markerbernaut
// 	icon_state = "ui_markerbernaut"
// 	// Name and description get given their proper values on Initialize()
// 	name = "Produce Markerbernaut (ERROR)"
// 	desc = "Produces a strong, smart markerbernaut from a factory marker for (ERROR) resources.<br>The factory marker used will become fragile and unable to produce spores."

// /atom/movable/screen/marker/markerbernaut/Initialize()
// 	. = ..()
// 	name = "Produce Markerbernaut ([MARKERMOB_MARKERBERNAUT_RESOURCE_COST])"
// 	desc = "Produces a strong, smart markerbernaut from a factory marker for [MARKERMOB_MARKERBERNAUT_RESOURCE_COST] resources.<br>The factory marker used will become fragile and unable to produce spores."

// /atom/movable/screen/marker/markerbernaut/Click()
// 	if(ismarkerovermind(usr))
// 		var/mob/camera/marker/B = usr
// 		B.create_markerbernaut()

/atom/movable/screen/marker/resource_marker
	icon_state = "ui_resource"
	// Name and description get given their proper values on Initialize()
	name = "Produce Resource Marker (ERROR)"
	desc = "Produces a resource marker for ERROR resources.<br>Resource markers will give you resources every few seconds."

/atom/movable/screen/marker/resource_marker/Initialize()
	. = ..()
	name = "Produce Resource Marker ([MARKER_STRUCTURE_RESOURCE_COST])"
	desc = "Produces a resource marker for [MARKER_STRUCTURE_RESOURCE_COST] resources.<br>Resource markers will give you resources every few seconds."

/atom/movable/screen/marker/resource_marker/Click()
	if(ismarkerovermind(usr))
		var/mob/camera/marker/B = usr
		B.createSpecial(MARKER_STRUCTURE_RESOURCE_COST, /obj/structure/marker/special/resource, MARKER_RESOURCE_MIN_DISTANCE, TRUE)

/atom/movable/screen/marker/node_marker
	icon_state = "ui_node"
	// Name and description get given their proper values on Initialize()
	name = "Produce Node Marker (ERROR)"
	desc = "Produces a node marker for ERROR resources.<br>Node markers will expand and activate nearby resource and factory markers."

/atom/movable/screen/marker/node_marker/Initialize()
	. = ..()
	name = "Produce Node Marker ([MARKER_STRUCTURE_NODE_COST])"
	desc = "Produces a node marker for [MARKER_STRUCTURE_NODE_COST] resources.<br>Node markers will expand and activate nearby resource and factory markers."

/atom/movable/screen/marker/node_marker/Click()
	if(ismarkerovermind(usr))
		var/mob/camera/marker/B = usr
		B.createSpecial(MARKER_STRUCTURE_NODE_COST, /obj/structure/marker/special/node, MARKER_NODE_MIN_DISTANCE, FALSE)

// /atom/movable/screen/marker/factory_marker
// 	icon_state = "ui_factory"
// 	// Name and description get given their proper values on Initialize()
// 	name = "Produce Factory Marker (ERROR)"
// 	desc = "Produces a factory marker for ERROR resources.<br>Factory markers will produce spores every few seconds."

// /atom/movable/screen/marker/factory_marker/Initialize()
// 	. = ..()
// 	name = "Produce Factory Marker ([MARKER_STRUCTURE_FACTORY_COST])"
// 	desc = "Produces a factory marker for [MARKER_STRUCTURE_FACTORY_COST] resources.<br>Factory markers will produce spores every few seconds."

// /atom/movable/screen/marker/factory_marker/Click()
// 	if(ismarkerovermind(usr))
// 		var/mob/camera/marker/B = usr
// 		B.createSpecial(MARKER_STRUCTURE_FACTORY_COST, /obj/structure/marker/special/factory, MARKER_FACTORY_MIN_DISTANCE, TRUE)

// /atom/movable/screen/marker/readapt_strain
// 	icon_state = "ui_chemswap"
// 	// Description gets given its proper values on Initialize()
// 	name = "Readapt Strain"
// 	desc = "Allows you to choose a new strain from ERROR random choices for ERROR resources."

// /atom/movable/screen/marker/readapt_strain/MouseEntered(location,control,params)
// 	if(hud?.mymob && ismarkerovermind(hud.mymob))
// 		var/mob/camera/marker/B = hud.mymob
// 		if(B.free_strain_rerolls)
// 			name = "[initial(name)] (FREE)"
// 			desc = "Randomly rerolls your strain for free."
// 		else
// 			name = "[initial(name)] ([MARKER_POWER_REROLL_COST])"
// 			desc = "Allows you to choose a new strain from [MARKER_POWER_REROLL_CHOICES] random choices for [MARKER_POWER_REROLL_COST] resources."
// 	return ..()

// /atom/movable/screen/marker/readapt_strain/Click()
// 	if(ismarkerovermind(usr))
// 		var/mob/camera/marker/B = usr
// 		B.strain_reroll()

/atom/movable/screen/marker/relocate_core
	icon_state = "ui_swap"
	// Name and description get given their proper values on Initialize()
	name = "Relocate Core (ERROR)"
	desc = "Swaps a node and your core for ERROR resources."

/atom/movable/screen/marker/relocate_core/Initialize()
	. = ..()
	name = "Relocate Core ([MARKER_POWER_RELOCATE_COST])"
	desc = "Swaps a node and your core for [MARKER_POWER_RELOCATE_COST] resources."

/atom/movable/screen/marker/relocate_core/Click()
	if(ismarkerovermind(usr))
		var/mob/camera/marker/B = usr
		//B.relocate_core()

/datum/hud/marker_overmind/New(mob/owner)
	..()
	var/atom/movable/screen/using

	markerpwrdisplay = new /atom/movable/screen()
	markerpwrdisplay.name = "marker power"
	markerpwrdisplay.icon_state = "block"
	markerpwrdisplay.screen_loc = ui_health
	markerpwrdisplay.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	markerpwrdisplay.plane = ABOVE_HUD_PLANE
	markerpwrdisplay.hud = src
	infodisplay += markerpwrdisplay

	healths = new /atom/movable/screen/healths/marker()
	healths.hud = src
	infodisplay += healths

	using = new /atom/movable/screen/marker/marker_help()
	using.screen_loc = "WEST:6,NORTH:-3"
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/marker/jump_to_node()
	using.screen_loc = ui_inventory
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/marker/jump_to_core()
	using.screen_loc = ui_zonesel
	using.hud = src
	static_inventory += using

	// using = new /atom/movable/screen/marker/markerbernaut()
	// using.screen_loc = ui_belt
	// using.hud = src
	// static_inventory += using

	using = new /atom/movable/screen/marker/resource_marker()
	using.screen_loc = ui_back
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/marker/node_marker()
	using.screen_loc = ui_hand_position(2)
	using.hud = src
	static_inventory += using

	// using = new /atom/movable/screen/marker/factory_marker()
	// using.screen_loc = ui_hand_position(1)
	// using.hud = src
	// static_inventory += using

	// using = new /atom/movable/screen/marker/readapt_strain()
	// using.screen_loc = ui_storage1
	// using.hud = src
	// static_inventory += using

	// using = new /atom/movable/screen/marker/relocate_core()
	// using.screen_loc = ui_storage2
	// using.hud = src
	// static_inventory += using
