#define SCRUBBER_REAGENT_SCALE 0.75

// Intermediate foam
/// A foam variant which dissipates after a duration.
/obj/effect/particle_effect/fluid/foam/intermediate_life
	lifetime = 4 SECONDS

/datum/effect_system/fluid_spread/foam/scrubber
	reagent_scale = SCRUBBER_REAGENT_SCALE
	effect_type = /obj/effect/particle_effect/fluid/foam/intermediate_life

#undef SCRUBBER_REAGENT_SCALE
