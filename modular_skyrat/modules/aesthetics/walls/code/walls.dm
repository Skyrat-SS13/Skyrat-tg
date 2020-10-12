/turf/closed/wall
	icon = 'modular_skyrat/modules/aesthetics/walls/icons/wall.dmi'

/turf/closed/wall/r_wall
	icon = 'modular_skyrat/modules/aesthetics/walls/icons/reinforced_wall.dmi'

/turf/closed/wall/rust
	icon = 'modular_skyrat/modules/aesthetics/walls/icons/wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"

/turf/closed/wall/r_wall/rust
	icon = 'modular_skyrat/modules/aesthetics/walls/icons/reinforced_wall.dmi'
	icon_state = "reinforced_wall-0"
	base_icon_state = "reinforced_wall"

/turf/closed/wall/rust/New(loc, ...)
	. = ..()
	var/mutable_appearance/rust = new(loc)
	rust.icon = icon
	rust.icon_state = "rust"
	add_overlay(rust)

/turf/closed/wall/r_wall/rust/New(loc, ...)
	. = ..()
	var/mutable_appearance/rust
	rust.icon = icon
	rust.icon_state = "rust"
	add_overlay(rust)
