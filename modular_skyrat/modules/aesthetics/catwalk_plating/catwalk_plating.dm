//Adds all our options as radials to the upstream version
/obj/item/stack/tile/catwalk_tile
	tile_reskin_types = list(
		/obj/item/stack/tile/catwalk_tile,
		/obj/item/stack/tile/catwalk_tile/plated,
		/obj/item/stack/tile/catwalk_tile/plated/iron,
		/obj/item/stack/tile/catwalk_tile/plated/white,
		/obj/item/stack/tile/catwalk_tile/plated/dark,
		/obj/item/stack/tile/catwalk_tile/plated/flat_white,
		/obj/item/stack/tile/catwalk_tile/plated/titanium
	)

/turf/open/floor/catwalk_floor
	///The icon_state of the overlay applied when 'covered'
	var/above_state = "catwalk_above"

/turf/open/floor/catwalk_floor/update_overlays()
	. = ..()
	var/image/catwalk_overlay	///Per-tile instead of static, so we dont need to reset the icon file/plane/layer every single time its unscrewed
	if(isnull(catwalk_overlay))
		catwalk_overlay = new()
		catwalk_overlay.icon = icon
		catwalk_overlay.icon_state = "[above_state]"
		catwalk_overlay.plane = GAME_PLANE
		catwalk_overlay.layer = CATWALK_LAYER
		catwalk_overlay = catwalk_overlay.appearance
	if(covered)
		. += catwalk_overlay


//Itemstacks---
/obj/item/stack/tile/catwalk_tile/plated	//to cut down on filepaths, this is our base type; this one is meant for maintinence plating
	desc = "Flooring that shows its contents underneath. Engineers love it!" //also this is the tile's description; its much better than the base stack-item
	icon = 'modular_skyrat/modules/aesthetics/catwalk_plating/catwalk_plating.dmi'
	icon_state = "maint_floor"
	turf_type = /turf/open/floor/catwalk_floor/plated
	merge_type = /obj/item/stack/tile/catwalk_tile	//Just to be cleaner, these all stack with eachother

/obj/item/stack/tile/catwalk_tile/plated/iron
	icon_state = "iron_floor"
	turf_type = /turf/open/floor/catwalk_floor/plated/iron

/obj/item/stack/tile/catwalk_tile/plated/white
	icon_state = "ironwhite_floor"
	turf_type = /turf/open/floor/catwalk_floor/plated/white
/obj/item/stack/tile/catwalk_tile/plated/dark
	icon_state = "irondark_floor"
	turf_type = /turf/open/floor/catwalk_floor/plated/dark

/obj/item/stack/tile/catwalk_tile/plated/flat_white
	icon_state = "white_floor"
	turf_type = /turf/open/floor/catwalk_floor/plated/flat_white

/obj/item/stack/tile/catwalk_tile/plated/titanium
	icon_state = "titanium_floor"
	turf_type = /turf/open/floor/catwalk_floor/plated/titanium

//Turfs---
/turf/open/floor/catwalk_floor/plated	//to cut down on filepaths, this is our base type; this one is meant for maintinence plating
	icon = 'modular_skyrat/modules/aesthetics/catwalk_plating/catwalk_plating.dmi'
	icon_state = "maint_below"
	name = "catwalk plating"
	above_state = "maint_above"
	floor_tile = /obj/item/stack/tile/catwalk_tile/plated

/turf/open/floor/catwalk_floor/plated/iron
	icon_state = "iron_below"
	name = "iron plated catwalk floor"
	above_state = "iron_above"
	floor_tile = /obj/item/stack/tile/catwalk_tile/plated/iron

/turf/open/floor/catwalk_floor/plated/white
	icon_state = "ironwhite_below"
	name = "white plated catwalk floor"
	above_state = "ironwhite_above"
	floor_tile = /obj/item/stack/tile/catwalk_tile/plated/white

/turf/open/floor/catwalk_floor/plated/dark
	icon_state = "irondark_below"
	name = "dark plated catwalk floor"
	above_state = "irondark_above"
	floor_tile = /obj/item/stack/tile/catwalk_tile/plated/dark

/turf/open/floor/catwalk_floor/plated/flat_white
	icon_state = "white_below"
	name = "white large plated catwalk floor"
	above_state = "white_above"
	floor_tile = /obj/item/stack/tile/catwalk_tile/plated/flat_white

/turf/open/floor/catwalk_floor/plated/titanium
	icon_state = "titanium_below"
	name = "titanium plated catwalk floor"
	above_state = "titanium_above"
	floor_tile = /obj/item/stack/tile/catwalk_tile/plated/titanium
