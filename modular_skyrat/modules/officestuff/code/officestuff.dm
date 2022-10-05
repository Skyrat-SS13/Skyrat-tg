/obj/structure/grandfatherclock
	name = "grandfather clock"
	icon = 'modular_skyrat/modules/officestuff/icons/cowboyobh.dmi'
	icon_state = "grandfather_clock"
	desc = "Tick, tick, tick, tick. It stands tall and daunting, loudly and ominously ticking, yet the hands are stuck close to midnight, the closer you get, the louder a faint whisper becomes a scream, a plea, something, but whatever it is, it says 'I am the Master, and you will obey me.'"
	var/datum/looping_sound/grandfatherclock/soundloop

// stolen from the wall clock
/obj/structure/grandfatherclock/examine(mob/user)
	. = ..()
	. += span_info("The current CST (local) time is: [station_time_timestamp()].")
	. += span_info("The current TCT (galactic) time is: [time2text(world.realtime, "hh:mm:ss")].")

/datum/looping_sound/grandfatherclock
	mid_sounds = list('modular_skyrat/modules/officestuff/sound/clock_ticking.ogg' = 1)
	mid_length = 12 SECONDS
	volume = 10

/obj/structure/grandfatherclock/Initialize(mapload)
	. = ..()
	soundloop = new(src, TRUE)

/obj/structure/grandfatherclock/Destroy()
	QDEL_NULL(soundloop)
	return ..()

/obj/structure/sign/painting/meat
	name = "Figure With Meat"
	desc = "A painting of a distorted figure, sitting between a cow cut in half."
	icon = 'modular_skyrat/modules/officestuff/icons/cowboyobh.dmi'
	icon_state = "meat"
	sign_change_name = "Painting - Meat"
	is_editable = TRUE

/obj/structure/sign/painting/parting
	name = "Parting Waves"
	desc = "A painting of a parting sea, the red sun washes over the blue ocean."
	icon = 'modular_skyrat/modules/officestuff/icons/cowboyobh.dmi'
	icon_state = "jmwt4"
	is_editable = TRUE
	sign_change_name = "Painting - Waves"


/obj/structure/sign/paint
	name = "painting"
	desc = "you shouldn't be seeing this."
	icon = 'modular_skyrat/modules/officestuff/icons/cowboyobh.dmi'
	icon_state = "gravestone"


