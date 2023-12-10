// Plastic panel walls, how colony of you

/turf/closed/wall/prefab_plastic
	name = "prefabricated wall"
	desc = "A conservatively built metal frame with plastic paneling covering a thin air-seal layer. \
		It's a little unnerving, but its better than nothing at all."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/prefab_wall.dmi'
	icon_state = "prefab-0"
	base_icon_state = "prefab"
	can_engrave = FALSE
	hardness = 70
	slicing_duration = 5 SECONDS
	girder_type = null

/turf/closed/wall/prefab_plastic/break_wall()
	return

/turf/closed/wall/prefab_plastic/devastate_wall()
	return

/obj/item/flatpacked_machine/wall_kit
	name = "prefab wall kit"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tiles_item.dmi'
	icon_state = "wall_item"
	deploy_time = 3 SECONDS
	type_to_deploy = /turf/closed/wall/prefab_plastic
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
	)

/obj/item/flatpacked_machine/wall_kit/give_deployable_component()
	AddComponent(/datum/component/deployable/for_turfs, deploy_time, type_to_deploy)

// Grated floor tile, for seeing wires under

/turf/open/floor/catwalk_floor/colony_fabricator
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tiles.dmi'
	icon_state = "prefab_above"
	catwalk_type = "prefab"
	baseturfs = /turf/open/floor/plating
	floor_tile = /obj/item/stack/tile/catwalk_tile/colony_lathe

/obj/item/stack/tile/catwalk_tile/colony_lathe
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tiles_item.dmi'
	icon_state = "prefab_catwalk"
	mats_per_unit = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT)
	turf_type = /turf/open/floor/catwalk_floor/colony_fabricator
	merge_type = /obj/item/stack/tile/catwalk_tile/colony_lathe
	tile_reskin_types = null

/obj/item/stack/tile/catwalk_tile/colony_lathe/lathe_spawn
	amount = 4

// "Normal" floor tiles

/turf/open/floor/iron/colony
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tiles.dmi'
	icon_state = "colony_grey"
	base_icon_state = "colony_grey"
	floor_tile = /obj/item/stack/tile/iron/colony
	tiled_dirt = FALSE

/obj/item/stack/tile/iron/colony
	name = "prefab floor tiles"
	singular_name = "prefab floor tile"
	desc = "A stack of large floor tiles that are a common sight in frontier colonies and prefab buildings."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tiles_item.dmi'
	icon_state = "colony_grey"
	turf_type = /turf/open/floor/iron/colony
	merge_type = /obj/item/stack/tile/iron/colony
	tile_reskin_types = list(
		/obj/item/stack/tile/iron/colony,
		/obj/item/stack/tile/iron/colony/texture,
		/obj/item/stack/tile/iron/colony/bolts,
		/obj/item/stack/tile/iron/colony/white,
		/obj/item/stack/tile/iron/colony/white/texture,
		/obj/item/stack/tile/iron/colony/white/bolts,
	)

/obj/item/stack/tile/iron/colony/lathe_spawn
	amount = 4

/turf/open/floor/iron/colony/texture
	icon_state = "colony_grey_texture"
	base_icon_state = "colony_grey_texture"
	floor_tile = /obj/item/stack/tile/iron/colony/texture

/obj/item/stack/tile/iron/colony/texture
	icon_state = "colony_grey_texture"
	turf_type = /turf/open/floor/iron/colony/texture

/turf/open/floor/iron/colony/bolts
	icon_state = "colony_grey_bolts"
	base_icon_state = "colony_grey_bolts"
	floor_tile = /obj/item/stack/tile/iron/colony/bolts

/obj/item/stack/tile/iron/colony/bolts
	icon_state = "colony_grey_bolts"
	turf_type = /turf/open/floor/iron/colony/bolts

// White variants of the above tiles

/turf/open/floor/iron/colony/white
	icon_state = "colony_white"
	base_icon_state = "colony_white"
	floor_tile = /obj/item/stack/tile/iron/colony/white

/obj/item/stack/tile/iron/colony/white
	icon_state = "colony_white"
	turf_type = /turf/open/floor/iron/colony/white

/turf/open/floor/iron/colony/white/texture
	icon_state = "colony_white_texture"
	base_icon_state = "colony_white_texture"
	floor_tile = /obj/item/stack/tile/iron/colony/white/texture

/obj/item/stack/tile/iron/colony/white/texture
	icon_state = "colony_white_texture"
	turf_type = /turf/open/floor/iron/colony/white/texture

/turf/open/floor/iron/colony/white/bolts
	icon_state = "colony_white_bolts"
	base_icon_state = "colony_white_bolts"
	floor_tile = /obj/item/stack/tile/iron/colony/white/bolts

/obj/item/stack/tile/iron/colony/white/bolts
	icon_state = "colony_white_bolts"
	turf_type = /turf/open/floor/iron/colony/white/bolts

// This one isn't a turf its just a catwalk, but bite me for it I don't care

/obj/structure/lattice/catwalk/colony_lathe
	name = "prefab catwalk"
	desc = "A catwalk for easier EVA maneuvering and cable placement. \
		This particular design is common around new colonies and prefab buildings, \
		where its simpler construction makes for an easier (albiet more hazardous) construction."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tiles.dmi'
	icon_state = "prefab_above"
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null

/obj/item/flatpacked_machine/catwalk_kit
	name = "prefab catwalk kit"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tiles_item.dmi'
	icon_state = "catwalk_item"
	deploy_time = 2 SECONDS
	type_to_deploy = /obj/structure/lattice/catwalk/colony_lathe
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
	)
