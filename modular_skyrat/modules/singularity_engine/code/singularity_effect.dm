/obj/effect/singularity_creation
	name = "collapsing spacetime"
	desc = "It looks like spacetime is collapsing, oh shit!"
	icon = 'modular_skyrat/modules/singularity_engine/icons/singularity_creation.dmi'
	icon_state = ""
	anchored = TRUE
	opacity = FALSE
	pixel_x = -32
	pixel_y = -32
	/// How long till we delete outselves.
	var/timeleft = SINGULARITY_EFFECT_ANIM_TIME

/obj/effect/singularity_creation/Initialize(mapload)
	. = ..()
	if(timeleft)
		QDEL_IN(src, timeleft)

/obj/effect/singularity_creation/singularity_act()
	return

/obj/singularity/proc/make_visible()
	invisibility = NONE
