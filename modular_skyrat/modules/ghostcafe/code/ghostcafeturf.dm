/turf/open/lava/planet
	name = "lava"
	desc = "Go on. Step in it. Maybe you'll be like some sort of Lava based Jesus."
	planetary_atmos = TRUE
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	baseturfs = /turf/open/lave/planet //Shout at me if this is meant to be something else.
	var/lava_damage = 0
	/// How many firestacks we add to living mobs stepping on us
	var/lava_firestacks = 0
	/// How much temperature we expose objects with
	var/temperature_damage = 0
	/// mobs with this trait won't burn.
	var/immunity_trait = GHOSTROLE_TRAIT
	/// objects with these flags won't burn.
	var/immunity_resistance_flags = LAVA_PROOF

