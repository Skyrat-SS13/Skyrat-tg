//*
//REAGENT MODIFIERS - used for handling movespeed, actionspeed buffs, etc.
//*
//Ataraxydone - stasis chem, has a modifier which varies based on number of cycles in + a flat modifier if you're prone while it's in your system (atarxyprone)
/datum/movespeed_modifier/reagent/ataraxydone
	variable = TRUE

/datum/movespeed_modifier/reagent/ataraxyprone
	multiplicative_slowdown = 1.5
