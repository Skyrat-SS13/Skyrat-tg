#define DISAPPEAR_REAPPEAR_TIME (2 SECONDS)

/obj/structure/destructible/clockwork/sigil/research
	name = "large sigil"
	desc = "A very large, glowing sigil."
	max_integrity = 10
	icon = 'modular_skyrat/modules/clock_cult/icons/clockwork_effects_96.dmi'
	icon_state = "research_sigil"
	resistance_flags = INDESTRUCTIBLE
	can_dispel_by_hand = FALSE
	alpha = 0
	pixel_x = -32
	pixel_y = -32


/obj/structure/destructible/clockwork/sigil/research/Initialize(mapload)
	. = ..()
	animate(src, alpha = 90, DISAPPEAR_REAPPEAR_TIME)


/obj/structure/destructible/clockwork/sigil/research/can_affect(atom/movable/movable_apply)
	return FALSE


/obj/structure/destructible/clockwork/sigil/research/apply_effects(atom/movable/movable_apply)
	return FALSE


/// Called when the research finishes, as a signal to disappear + delete
/obj/structure/destructible/clockwork/sigil/research/proc/finish_research()
	animate(src, alpha = 0, DISAPPEAR_REAPPEAR_TIME)
	QDEL_IN(src, DISAPPEAR_REAPPEAR_TIME)


#undef DISAPPEAR_REAPPEAR_TIME
