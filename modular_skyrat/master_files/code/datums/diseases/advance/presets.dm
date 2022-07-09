// This is simply to make it so miasma can only infect you with a virus once, no matter what kind of virus.

#define MAXIMUM_TIMES_INFECTED_BY_MIASMA 1

/datum/disease/advance/random
	/// Does this virus come from miasma? Defaults to FALSE, will fail to infect anyone that has already caught a miasma virus before.
	var/from_miasma = FALSE


/datum/disease/advance/random/try_infect(mob/living/infectee, make_copy)
	if(from_miasma && infectee.times_infected_by_miasma >= MAXIMUM_TIMES_INFECTED_BY_MIASMA)
		return FALSE

	return ..()


/datum/disease/advance/random/infect(mob/living/infectee, make_copy)
	. = ..()
	if(from_miasma)
		infectee.times_infected_by_miasma++
