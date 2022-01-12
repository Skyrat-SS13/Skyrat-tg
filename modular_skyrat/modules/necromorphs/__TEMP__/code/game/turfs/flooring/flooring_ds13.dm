/turf/simulated/floor/ds
	name = "grim plating"
	desc = "The naked, ancient hull."
	icon = 'icons/turf/floors_ds13.dmi'
	icon_state = "dank_plating"


/decl/flooring/tiling_ds
	name = "floor"
	desc = "Scuffed from the passage of countless planet crackers, it looks ancient."
	icon = 'icons/turf/floors_ds13.dmi'
	icon_base = "dank_tile"
	has_damage_range = 4
	damage_temperature = T0C+1400
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK | TURF_CAN_BURN
	build_type = /obj/item/stack/tile/dank
	can_paint = 1

/decl/flooring/tiling_ds/roller
	name = "roller"
	desc = "Scuffed from the passage of countless greyshirts."
	icon_base = "dank_roller"
	build_type = /obj/item/stack/tile/dankroller

/decl/flooring/tiling_ds/heavy
	name = "heavy floor"
	desc = "Scuffed from the passage of countless planet crackers, it looks ancient and sturdy."
	icon_base = "dank_tile_heavy"
	build_type = /obj/item/stack/tile/dankheavy

/decl/flooring/tiling_ds/medical
	name = "medical floor"
	desc = "Scuffed from the passage of countless planet crackers, it reminds you of the asylum..."
	icon_base = "dank_tile_medical"
	build_type = /obj/item/stack/tile/dankmedical

/decl/flooring/tiling_ds/mono
	name = "floor"
	desc = "Scuffed from the passage of countless planet crackers, it looks grimy and smooth."
	icon_base = "dank_tile_mono"
	build_type = /obj/item/stack/tile/dankmono

/decl/flooring/tiling_ds/bathroom
	name = "bathroom tiles"
	desc = "Grim colorings for a grim job to do."
	icon_base = "bathroom"
	build_type = /obj/item/stack/tile/bathroom

/decl/flooring/complex/tiling_ds
	icon = 'icons/turf/floors_ds13.dmi'

/decl/flooring/complex/tiling_ds/rivets
	name = "riveted plating"
	desc = "It keeps the ship together."
	icon_base = "rivets"
	build_type = /obj/item/stack/tile/rivets
	has_base_range = 4

/decl/flooring/complex/tiling_ds/slashed
	name = "slashed plating"
	desc = "Robust plating to reinforce the edges of a room."
	icon_base = "slashed"
	build_type = /obj/item/stack/tile/slashed
	has_base_range = 3

/decl/flooring/complex/tiling_ds/slashed/odd
	icon_base = "slashed_odd"
	build_type = /obj/item/stack/tile/slashed/odd

/decl/flooring/tiling/mono
	icon_base = "monotile"
	build_type = /obj/item/stack/tile/mono

/decl/flooring/tiling/mono/dark
	color = COLOR_DARK_GRAY
	build_type = /obj/item/stack/tile/mono/dark

/decl/flooring/tiling/mono/white
	icon_base = "monotile_light"
	color = COLOR_OFF_WHITE
	build_type = /obj/item/stack/tile/mono/white

/decl/flooring/tiling/new_tile
	icon_base = "tile_full"
	color = null

/decl/flooring/tiling/new_tile/cargo_one
	icon_base = "cargo_one_full"

/decl/flooring/tiling/new_tile/kafel
	icon_base = "kafel_full"

/decl/flooring/tiling/new_tile/techmaint
	icon_base = "techmaint"
	build_type = /obj/item/stack/tile/techmaint

/decl/flooring/tiling/new_tile/monofloor
	icon_base = "monofloor"
	color = COLOR_GUNMETAL

/decl/flooring/tiling/new_tile/steel_grid
	icon_base = "grid"
	color = COLOR_GUNMETAL
	build_type = /obj/item/stack/tile/grid

/decl/flooring/tiling/new_tile/steel_ridged
	icon_base = "ridged"
	color = COLOR_GUNMETAL
	build_type = /obj/item/stack/tile/ridge

// FLOOR UPDATE 2 ELECTRIC BOOGALO.

/decl/flooring/complex/tiling_ds
	footstep_sound = "hull"

/decl/flooring/complex/tiling_ds/tech
	name = "tech plating"
	desc = "Ingenius plating that can supposedly withstand more tension stress."
	icon_base = "tech"
	build_type = null
	has_base_range = 6

/decl/flooring/complex/tiling_ds/slides
	name = "sliding plating"
	desc = "Layered plating that expands when subjected to heat, keeping ship pressure limited near heavy machinery."
	icon_base = "slides"
	build_type = null
	has_base_range = 6

/decl/flooring/complex/tiling_ds/slides/end
	name = "sliding plating"
	desc = "Layered plating that expands when subjected to heat, keeping ship pressure limited near heavy machinery."
	icon_base = "slides_end"
	build_type = null
	has_base_range = 6

/decl/flooring/complex/tiling_ds/golf_gray
	name = " gray golf plating"
	desc = "Rickety, noisy plating that dents relatively easy despite being made by a dense alloy."
	icon_base = "golf_gray"
	build_type = null
	has_base_range = 6

/decl/flooring/complex/tiling_ds/golf_brown
	name = " brown golf plating"
	desc = "Rickety, noisy plating that dents relatively easy despite being made by a dense alloy."
	icon_base = "golf_brown"
	build_type = null
	has_base_range = 6

/decl/flooring/complex/tiling_ds/rectangles
	name = "rectangle plating"
	desc = "Sturdy, simple, just what you need to keep the ship together."
	icon_base = "rectangles"
	build_type = null
	has_base_range = 6

/decl/flooring/complex/tiling_ds/maint
	name = "path plating"
	desc = "Designed with extra grip in mind, this plating pads the way."
	icon_base = "maint_center"
	build_type = null
	has_base_range = 4

/decl/flooring/complex/tiling_ds/maint/left
	name = "path plating"
	desc = "Designed with extra grip in mind, this plating pads the way."
	icon_base = "maint_left"
	build_type = null
	has_base_range = 4

/decl/flooring/complex/tiling_ds/maint/right
	name = "path plating"
	desc = "Designed with extra grip in mind, this plating pads the way."
	icon_base = "maint_right"
	build_type = null
	has_base_range = 4

/decl/flooring/complex/tiling_ds/hardwood
	name = "hardwood"
	desc = "Dusty, ancient, but unusually sturdy."
	icon_base = "hardwood"
	build_type = null
	has_base_range = 0

/decl/flooring/complex/tiling_ds/hardwood/alt
	icon_base = "hardwood_alt"

/decl/flooring/complex/tiling_ds/ornate1
	name = "ornate"
	desc = "Extremely fancy plating that represents the CEC logo, keep working employee!"
	icon_base = "1_ornate"
	build_type = null
	has_base_range = 0

/decl/flooring/complex/tiling_ds/ornate2
	name = "ornate"
	desc = "Extremely fancy plating that represents the CEC logo, keep working employee!"
	icon_base = "2_ornate"
	build_type = null
	has_base_range = 0

/decl/flooring/complex/tiling_ds/ornate3
	name = "ornate"
	desc = "Extremely fancy plating that represents the CEC logo, keep working employee!"
	icon_base = "3_ornate"
	build_type = null
	has_base_range = 0

/decl/flooring/complex/tiling_ds/ornate4
	name = "ornate"
	desc = "Extremely fancy plating that represents the CEC logo, keep working employee!"
	icon_base = "4_ornate"
	build_type = null
	has_base_range = 0

/decl/flooring/complex/tiling_ds/ornate5
	name = "ornate"
	desc = "Extremely fancy plating that represents the CEC logo, keep working employee!"
	icon_base = "5_ornate"
	build_type = null
	has_base_range = 0

/decl/flooring/complex/tiling_ds/ornate6
	name = "ornate"
	desc = "Extremely fancy plating that represents the CEC logo, keep working employee!"
	icon_base = "6_ornate"
	build_type = null
	has_base_range = 0

/decl/flooring/complex/tiling_ds/ornate7
	name = "ornate"
	desc = "Extremely fancy plating that represents the CEC logo, keep working employee!"
	icon_base = "7_ornate"
	build_type = null
	has_base_range = 0

/decl/flooring/complex/tiling_ds/ornate8
	name = "ornate"
	desc = "Extremely fancy plating that represents the CEC logo, keep working employee!"
	icon_base = "8_ornate"
	build_type = null
	has_base_range = 0

/decl/flooring/complex/tiling_ds/grille_spare1
	name = "grille"
	desc = "Don't loose your keys."
	icon_base = "grille-spare1"
	build_type = null
	has_base_range = 0

/decl/flooring/complex/tiling_ds/grille_spare2
	name = "grille"
	desc = "Don't loose your keys."
	icon_base = "grille-spare2"
	build_type = null
	has_base_range = 0

/decl/flooring/complex/tiling_ds/grille_spare3
	name = "grille"
	desc = "Don't loose your keys."
	icon_base = "grille-spare3"
	build_type = null
	has_base_range = 0

/decl/flooring/complex/tiling_ds/grille_spare4
	name = "grille"
	desc = "Don't loose your keys."
	icon_base = "grille-spare4"
	build_type = null
	has_base_range = 0

/decl/flooring/complex/tiling_ds/grate
	name = "grate"
	desc = "Especially rough grating, guaranteed knee-scratches without protection."
	icon_base = "grate"
	build_type = null
	has_base_range = 0

/decl/flooring/complex/tiling_ds/grater
	name = "grater"
	desc = "You can't see anything but the abyss."
	icon_base = "grater"
	build_type = null
	has_base_range = 0

/decl/flooring/complex/tiling_ds/cable
	name = "dense cabling"
	desc = "Surprisingly well insulated cabling running between two grates, seems deprecated."
	icon_base = "cable"
	build_type = null
	has_base_range = 0

/decl/flooring/complex/tiling_ds/cable/start
	name = "dense cabling"
	desc = "Surprisingly well insulated cabling running between two grates, seems deprecated."
	icon_base = "cable_start"
	build_type = null
	has_base_range = 0

/decl/flooring/complex/tiling_ds/cable/end
	name = "dense cabling"
	desc = "Surprisingly well insulated cabling running between two grates, seems deprecated."
	icon_base = "cable_end"
	build_type = null
	has_base_range = 0