#define SMOOTH_GROUP_MAINTENANCE_TILE S_OBJ(72)			///turf/open/floor/plasteel/maintenance
#define SMOOTH_GROUP_PLATING S_OBJ(73)			///turf/open/floor/plasteel/maintenance

/turf/open/floor/plasteel/maintenance
	icon_state = "floor"
	floor_tile = /obj/item/stack/tile/plasteel
	icon = 'modular_skyrat/modules/reskin/icons/maint.dmi'
	icon_state = "maint-0"
	base_icon_state = "maint"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_MAINTENANCE_TILE)
	canSmoothWith = list(SMOOTH_GROUP_MAINTENANCE_TILE)

/turf/open/floor/plasteel/maintenance/cargo
	icon = 'modular_skyrat/modules/reskin/icons/maint_cargo.dmi'
	icon_state = "maint_cargo-0"
	base_icon_state = "maint_cargo"

/turf/open/floor/plasteel/maintenance/perforated
	icon = 'modular_skyrat/modules/reskin/icons/maint_perf.dmi'
	icon_state = "maint_perf-0"
	base_icon_state = "maint_perf"

/turf/open/floor/plasteel/maintenance/panel
	icon = 'modular_skyrat/modules/reskin/icons/maint_panel.dmi'
	icon_state = "maint_panel-0"
	base_icon_state = "maint_panel"

/turf/open/floor/plating
	icon = 'modular_skyrat/modules/reskin/icons/plating.dmi'
	icon_state = "plating-255"
	base_icon_state = "plating"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_PLATING)
	canSmoothWith = list(SMOOTH_GROUP_PLATING)
