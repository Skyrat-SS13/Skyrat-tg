/area/deathmatch
	name = "Deathmatch Arena"
	requires_power = FALSE
	has_gravity = STANDARD_GRAVITY
	area_flags = UNIQUE_AREA | NOTELEPORT | EVENT_PROTECTED | QUIET_LOGS | NO_DEATH_MESSAGE | BINARY_JAMMING

/area/deathmatch/fullbright
	static_lighting = FALSE
	base_lighting_alpha = 255

/obj/effect/landmark/deathmatch_player_spawn
	name = "Deathmatch Player Spawner"

<<<<<<< HEAD
/area/deathmatch/teleport //Prevent access to cross-z teleportation in the map itself (no wands of safety/teleportation scrolls). Cordons should prevent same-z teleportations outside of the arena.
	area_flags = /area/deathmatch::area_flags & ~NOTELEPORT

=======
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
// for the illusion of a moving train
/turf/open/chasm/true/no_smooth/fake_motion_sand
	name = "air"
	desc = "Dont jump off, unless you want to fall a really long distance."
	icon_state = "sandmoving"
	base_icon_state = "sandmoving"
	icon = 'icons/turf/floors.dmi'

/turf/open/chasm/true/no_smooth/fake_motion_sand/fast
	icon_state = "sandmovingfast"
	base_icon_state = "sandmovingfast"
<<<<<<< HEAD
=======

// fakeout

/turf/open/chasm/true/fakeout
	name = /turf/open/floor/wood::name
	// desc kept the same
	icon_state = /turf/open/floor/wood::icon_state
	base_icon_state = /turf/open/floor/wood::base_icon_state
	icon = /turf/open/floor/wood::icon
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
