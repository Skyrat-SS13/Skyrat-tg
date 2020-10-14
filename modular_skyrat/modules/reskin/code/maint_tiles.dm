#define SMOOTH_GROUP_MAINTENANCE_TILE S_OBJ(72)			///turf/open/floor/plasteel/maintenance
#define SMOOTH_GROUP_PLATING S_OBJ(73)			///turf/open/floor/plasteel/maintenance

/turf/open/floor/maintenance
	icon_state = "floor"
	desc = "Cold concrete floor."
	floor_tile = /obj/item/stack/tile/maintenance
	icon = 'modular_skyrat/modules/reskin/icons/maint.dmi'
	icon_state = "maint-0"
	base_icon_state = "maint"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_MAINTENANCE_TILE)
	canSmoothWith = list(SMOOTH_GROUP_MAINTENANCE_TILE)

/turf/open/floor/maintenance/examine(mob/user)
	. = ..()
	. += "<span class='notice'>There's a <b>small crack</b> on the edge of it.</span>"

/turf/open/floor/maintenance/cargo
	icon = 'modular_skyrat/modules/reskin/icons/maint_cargo.dmi'
	icon_state = "maint_cargo-0"
	base_icon_state = "maint_cargo"
	floor_tile = /obj/item/stack/tile/maintenance/cargo

/turf/open/floor/maintenance/perforated
	icon = 'modular_skyrat/modules/reskin/icons/maint_perf.dmi'
	icon_state = "maint_perf-0"
	base_icon_state = "maint_perf"
	floor_tile = /obj/item/stack/tile/maintenance/perforated

/turf/open/floor/maintenance/panel
	icon = 'modular_skyrat/modules/reskin/icons/maint_panel.dmi'
	icon_state = "maint_panel-0"
	base_icon_state = "maint_panel"
	floor_tile = /obj/item/stack/tile/maintenance/panel

/obj/item/stack/tile/maintenance
	name = "maintenance floor tile"
	singular_name = "maintenance floor tile"
	desc = "A cold concrete maintenance tiling."
	turf_type = /turf/open/floor/maintenance

/obj/item/stack/tile/maintenance/cargo
	turf_type = /turf/open/floor/maintenance/cargo

/obj/item/stack/tile/maintenance/perforated
	turf_type = /turf/open/floor/maintenance/perforated

/obj/item/stack/tile/maintenance/panel
	turf_type = /turf/open/floor/maintenance/panel

//Hack to make it not do inheritance
/turf/open/floor/plating/Initialize()
	. = ..()
	if(type == /turf/open/floor/plating)
		icon = 'modular_skyrat/modules/reskin/icons/plating.dmi'
		icon_state = "plating-255"
		base_icon_state = "plating"
		smoothing_flags = SMOOTH_BITMASK
		smoothing_groups = list(SMOOTH_GROUP_PLATING)
		canSmoothWith = list(SMOOTH_GROUP_PLATING)

/turf/open/floor/plating/AfterChange()
	. = ..()
	icon_state = "plating-255"
