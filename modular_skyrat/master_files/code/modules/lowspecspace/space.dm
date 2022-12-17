#define SPACE_TEXT num2text(rand(1,25))
/turf/closed/wall/space
	icon_state = "0"
	icon = 'modular_skyrat/master_files/icons/turf/space.dmi'

/turf/closed/wall/space/Initialize(mapload)
	. = ..()
	icon_state = SPACE_TEXT

/turf/open/floor/holofloor/space/Initialize(mapload)
	icon = 'modular_skyrat/master_files/icons/turf/space.dmi'
	icon_state = SPACE_TEXT
	. = ..()
/*
/turf/open/space/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	underlay_appearance.icon = 'modular_skyrat/master_files/icons/turf/space.dmi'
	underlay_appearance.icon_state = SPACE_TEXT
	SET_PLANE(underlay_appearance, PLANE_SPACE, src)
	return TRUE */
/turf/open/space/
	icon = 'modular_skyrat/master_files/icons/turf/space.dmi'

/turf/open/space/Initialize(mapload)
	. = ..()
	icon_state = SPACE_TEXT
#undef SPACE_TEXT
