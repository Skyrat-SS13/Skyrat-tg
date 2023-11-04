//Smoothing causes issues such as weirdly black tiles and weirdly connected tiles, so I'll remove it for the domain to look pretty.
/turf/open/misc/grass/planet/ancient_milsim
	smoothing_flags = NONE
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN
	canSmoothWith = SMOOTH_GROUP_TURF_OPEN + SMOOTH_GROUP_OPEN_FLOOR
