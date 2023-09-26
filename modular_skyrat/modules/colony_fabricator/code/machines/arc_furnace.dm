/obj/machinery/arc_furnace
	name = "arc furnace"
	desc = "Using the unmatched power of enough electrical power to instantly kill a man, this machines is \
		capable of refining ores into a more usable state. A warning sticker on the side details that some \
		refining operations may release unwanted gasses to the external environment."
	icon = 'icons/obj/machines/microwave.dmi'
	icon_state = "map_icon"
	appearance_flags = KEEP_TOGETHER | LONG_GLIDE | PIXEL_SCALE
	layer = BELOW_OBJ_LAYER
	density = TRUE
	circuit = /obj/item/circuitboard/machine/microwave
	pass_flags = PASSTABLE
	light_color = LIGHT_COLOR_DIM_YELLOW
	light_power = 3
	anchored_tabletop_offset = 6
	var/wire_disabled = FALSE // is its internal wire cut?
	var/operating = FALSE
	/// How dirty is it?
	var/dirty = 0
	var/dirty_anim_playing = FALSE
	/// How broken is it? NOT_BROKEN, KINDA_BROKEN, REALLY_BROKEN
	var/broken = NOT_BROKEN
	var/open = FALSE
	var/max_n_of_items = 10
	var/efficiency = 0
	var/datum/looping_sound/microwave/soundloop
	var/list/ingredients = list() // may only contain /atom/movables

	var/static/radial_examine = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_examine")
	var/static/radial_eject = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_eject")
	var/static/radial_use = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_use")

	// we show the button even if the proc will not work
	var/static/list/radial_options = list("eject" = radial_eject, "use" = radial_use)
	var/static/list/ai_radial_options = list("eject" = radial_eject, "use" = radial_use, "examine" = radial_examine)
