//
// Constants and standard colors for the holomap
//

#define HOLOMAP_ICON 'icons/480x480.dmi' // Icon file to start with when drawing holomaps (to get a 480x480 canvas).
#define HOLOMAP_ICON_SIZE 480 // Pixel width & height of the holomap icon.  Used for auto-centering etc.
#define ui_holomap "CENTER-7,CENTER-7" // Screen location of the holomap "hud"

//Holomap filters
#define HOLOMAP_FILTER_DEATHSQUAD				1
#define HOLOMAP_FILTER_ERT						2
#define HOLOMAP_FILTER_NUKEOPS					4
#define HOLOMAP_FILTER_ELITESYNDICATE			8
#define HOLOMAP_FILTER_VOX						16
#define HOLOMAP_FILTER_STATIONMAP				32
#define HOLOMAP_FILTER_STATIONMAP_STRATEGIC		64//features markers over the captain's office, the armory, the SMES
#define HOLOMAP_FILTER_CULT						128//bloodstone locators

#define HOLOMAP_EXTRA_STATIONMAP				"stationmapformatted"
#define HOLOMAP_EXTRA_STATIONMAP_STRATEGIC		"stationmapstrategic"
#define HOLOMAP_EXTRA_STATIONMAPAREAS			"stationareas"
#define HOLOMAP_EXTRA_STATIONMAPSMALL			"stationmapsmall"
#define HOLOMAP_EXTRA_STATIONMAPSMALL_NORTH		"stationmapsmallnorth"
#define HOLOMAP_EXTRA_STATIONMAPSMALL_SOUTH		"stationmapsmallsouth"
#define HOLOMAP_EXTRA_STATIONMAPSMALL_EAST		"stationmapsmalleast"
#define HOLOMAP_EXTRA_STATIONMAPSMALL_WEST		"stationmapsmallwest"
#define HOLOMAP_EXTRA_CULTMAP					"cultmap"

#define HOLOMAP_MARKER_SMES				"smes"
#define HOLOMAP_MARKER_DISK				"diskspawn"
#define HOLOMAP_MARKER_SKIPJACK			"skipjack"
#define HOLOMAP_MARKER_SYNDISHUTTLE		"syndishuttle"
#define HOLOMAP_MARKER_BLOODSTONE		"bloodstone"
#define HOLOMAP_MARKER_BLOODSTONE_BROKEN	"bloodstone-broken"
#define HOLOMAP_MARKER_BLOODSTONE_ANCHOR	"bloodstone-narsie"
#define HOLOMAP_MARKER_CULT_ALTAR		"altar"
#define HOLOMAP_MARKER_CULT_FORGE		"forge"
#define HOLOMAP_MARKER_CULT_SPIRE		"spire"
#define HOLOMAP_MARKER_CULT_ENTRANCE	"path_entrance"
#define HOLOMAP_MARKER_CULT_EXIT		"path_exit"
#define HOLOMAP_MARKER_CULT_RUNE		"rune"

#define HOLOMAP_DRAW_NORMAL	0
#define HOLOMAP_DRAW_FULL	1
#define HOLOMAP_DRAW_EMPTY	2
#define HOLOMAP_DRAW_PATH	3
#define HOLOMAP_DRAW_HALLWAY	4

// Holomap colors
#define HOLOMAP_OBSTACLE	"#FFFFFFDD"	// Color of walls and barriers
#define HOLOMAP_SOFT_OBSTACLE	"#ffffff54"	// Color of weak, climbable, or see-through barriers that aren't fulltile windows.
#define HOLOMAP_PATH		"#66666699"	// Color of floors
#define HOLOMAP_ROCK		"#66666644"	// Color of mineral walls
#define HOLOMAP_HOLOFIER	"#7998ff"	// Whole map is multiplied by this to give it a green holoish look

#define HOLOMAP_AREACOLOR_COMMAND		"#0000F099"
#define HOLOMAP_AREACOLOR_SECURITY		"#AE121299"
#define HOLOMAP_AREACOLOR_MEDICAL		"#447FC299"
#define HOLOMAP_AREACOLOR_SCIENCE		"#A154A699"
#define HOLOMAP_AREACOLOR_ENGINEERING	"#F1C23199"
#define HOLOMAP_AREACOLOR_CARGO			"#E06F0099"
#define HOLOMAP_AREACOLOR_HALLWAYS		"#FFFFFF66"
#define HOLOMAP_AREACOLOR_MAINTENANCE	"#7a7a7a66"
#define HOLOMAP_AREACOLOR_ARRIVALS		"#0000FFCC"
#define HOLOMAP_AREACOLOR_ESCAPE		"#FF0000CC"
#define HOLOMAP_AREACOLOR_DORMS			"#CCCC0099"
#define HOLOMAP_AREACOLOR_CIV			"#3ea800"

#define LIST_NUMERIC_SET(L, I, V) if(!L) { L = list(); } if (L.len < I) { L.len = I; } L[I] = V

// Handy defines to lookup the pixel offsets for this Z-level.  Cache these if you use them in a loop tho.
//#define HOLOMAP_PIXEL_OFFSET_X(zLevel) ((using_map.holomap_offset_x.len >= zLevel) ? using_map.holomap_offset_x[zLevel] : 0)
//#define HOLOMAP_PIXEL_OFFSET_Y(zLevel) ((using_map.holomap_offset_y.len >= zLevel) ? using_map.holomap_offset_y[zLevel] : 0)
//#define HOLOMAP_LEGEND_X(zLevel) ((using_map.holomap_legend_x.len >= zLevel) ? using_map.holomap_legend_x[zLevel] : 96)
//#define HOLOMAP_LEGEND_Y(zLevel) ((using_map.holomap_legend_y.len >= zLevel) ? using_map.holomap_legend_y[zLevel] : 96)
#define HOLOMAP_PIXEL_OFFSET_X(zLevel) (0)
#define HOLOMAP_PIXEL_OFFSET_Y(zLevel) (0)
#define HOLOMAP_LEGEND_X(zLevel) (96)
#define HOLOMAP_LEGEND_Y(zLevel) (96)

// Holomaps
GLOBAL_LIST_EMPTY(holomap_markers)
GLOBAL_LIST_EMPTY(mapping_units)
GLOBAL_LIST_EMPTY(mapping_beacons)

// VG stuff we probably won't use
// #define HOLOMAP_FILTER_DEATHSQUAD				1
// #define HOLOMAP_FILTER_ERT						2
// #define HOLOMAP_FILTER_NUKEOPS					4
// #define HOLOMAP_FILTER_ELITESYNDICATE			8
// #define HOLOMAP_FILTER_VOX						16
// #define HOLOMAP_FILTER_STATIONMAP				32
// #define HOLOMAP_FILTER_STATIONMAP_STRATEGIC		64//features markers over the captain's office, the armory, the SMES

// #define HOLOMAP_MARKER_SMES				"smes"
// #define HOLOMAP_MARKER_DISK				"diskspawn"
// #define HOLOMAP_MARKER_SKIPJACK			"skipjack"
// #define HOLOMAP_MARKER_SYNDISHUTTLE		"syndishuttle"

#define HOLOMAP_CENTER_X round((HOLOMAP_ICON_SIZE / 2) - (world.maxx / 2))
#define HOLOMAP_CENTER_Y round((HOLOMAP_ICON_SIZE / 2) - (world.maxy / 2))
