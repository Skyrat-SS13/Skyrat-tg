// Byond direction defines, because I want to put them somewhere.
// #define NORTH 1
// #define SOUTH 2
// #define EAST 4
// #define WEST 8

/// North direction as a string "[1]"
#define TEXT_NORTH "[NORTH]"
/// South direction as a string "[2]"
#define TEXT_SOUTH "[SOUTH]"
/// East direction as a string "[4]"
#define TEXT_EAST "[EAST]"
/// West direction as a string "[8]"
#define TEXT_WEST "[WEST]"

//dir macros
///Returns true if the dir is diagonal, false otherwise
#define ISDIAGONALDIR(d) (d&(d-1))
///True if the dir is north or south, false therwise
#define NSCOMPONENT(d)   (d&(NORTH|SOUTH))
///True if the dir is east/west, false otherwise
#define EWCOMPONENT(d)   (d&(EAST|WEST))
///Flips the dir for north/south directions
#define NSDIRFLIP(d)     (d^(NORTH|SOUTH))
///Flips the dir for east/west directions
#define EWDIRFLIP(d)     (d^(EAST|WEST))

/// Inverse direction, taking into account UP|DOWN if necessary.
#define REVERSE_DIR(dir) ( ((dir & 85) << 1) | ((dir & 170) >> 1) )

/// Create directional subtypes for a path to simplify mapping.
#define MAPPING_DIRECTIONAL_HELPERS(path, offset) ##path/directional/north {\
	dir = NORTH; \
	pixel_y = offset; \
} \
##path/directional/south {\
	dir = SOUTH; \
	pixel_y = -offset; \
} \
##path/directional/east {\
	dir = EAST; \
	pixel_x = offset; \
} \
##path/directional/west {\
	dir = WEST; \
	pixel_x = -offset; \
<<<<<<< HEAD
}
=======
} \
_WALL_MOUNT_OFFSET(path, offset, -offset, 0, offset, -offset, 0)

#define MAPPING_DIRECTIONAL_HELPERS_EMPTY(path) \
##path/directional/north {\
	dir = NORTH; \
} \
##path/directional/south {\
	dir = SOUTH; \
} \
##path/directional/east {\
	dir = EAST; \
} \
##path/directional/west {\
	dir = WEST; \
} \
_WALL_MOUNT_OFFSET(path, 0, 0, 0, 0, 0, 0)

#define BUTTON_DIRECTIONAL_HELPERS(path) \
##path/table { \
	on_table = TRUE; \
	icon_state = parent_type::icon_state + "_table"; \
	base_icon_state = parent_type::icon_state + "_table"; \
} \
WALL_MOUNT_DIRECTIONAL_HELPERS(path)

#define SIGN_DIR_NORTH "n"
#define SIGN_DIR_SOUTH "s"
#define SIGN_DIR_EAST "e"
#define SIGN_DIR_WEST "w"
#define SIGN_DIR_NORTHEAST "ne"
#define SIGN_DIR_NORTHWEST "nw"
#define SIGN_DIR_SOUTHEAST "se"
#define SIGN_DIR_SOUTHWEST "sw"
#define SUPPORT_LEFT "left"
#define SUPPORT_RIGHT "right"

/// Directional helpers that generate all arrow directions as well as subdivide sign directions.
#define DIRECTIONAL_SIGNS_DIRECTIONAL_HELPERS(path) \
##path/north_arrow {\
	sign_arrow_direction = SIGN_DIR_NORTH; \
} \
##path/south_arrow {\
	sign_arrow_direction = SIGN_DIR_SOUTH; \
} \
##path/east_arrow {\
	sign_arrow_direction = SIGN_DIR_EAST; \
} \
##path/west_arrow {\
	sign_arrow_direction = SIGN_DIR_WEST; \
} \
##path/northeast_arrow {\
	sign_arrow_direction = SIGN_DIR_NORTHEAST; \
} \
##path/northwest_arrow {\
	sign_arrow_direction = SIGN_DIR_NORTHWEST; \
} \
##path/southeast_arrow {\
	sign_arrow_direction = SIGN_DIR_SOUTHEAST; \
} \
##path/southwest_arrow {\
	sign_arrow_direction = SIGN_DIR_SOUTHWEST; \
} \
_WALL_MOUNT_DIRECTIONAL_HELPERS(path/north_arrow, 35, 0, 0, 0, 0, 16)\
_WALL_MOUNT_DIRECTIONAL_HELPERS(path/south_arrow, 35, 0, 0, 0, 0, 16)\
_WALL_MOUNT_DIRECTIONAL_HELPERS(path/east_arrow, 35, 0, 0, 0, 0, 16)\
_WALL_MOUNT_DIRECTIONAL_HELPERS(##path/west_arrow, 35, 0, 0, 0, 0, 16)\
_WALL_MOUNT_DIRECTIONAL_HELPERS(##path/northeast_arrow, 35, 0, 0, 0, 0, 16)\
_WALL_MOUNT_DIRECTIONAL_HELPERS(##path/northwest_arrow, 35, 0, 0, 0, 0, 16)\
_WALL_MOUNT_DIRECTIONAL_HELPERS(##path/southeast_arrow, 35, 0, 0, 0, 0, 16)\
_WALL_MOUNT_DIRECTIONAL_HELPERS(##path/southwest_arrow, 35, 0, 0, 0, 0, 16)
>>>>>>> 09d75845ddd7 (Visually shifts south wallmounts down instead of physically (#85920))
