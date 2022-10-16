/// Accessor for the monkey_blood field in the blood data list.
#define MONKEY_ORIGINS "monkey_origins"

// This is the additional code to handle blood originating from monkeys, to make it so
// there's a way to track if blood was extracted from a monkey or not.
/mob/living/carbon/get_blood_data(blood_id)
	. = ..()
	if(blood_id == /datum/reagent/blood)
		.[MONKEY_ORIGINS] = ismonkey(src)


/datum/reagent/blood/on_merge(list/mix_data)
	. = ..()
	if(data && mix_data)
		data[MONKEY_ORIGINS] = data[MONKEY_ORIGINS] || mix_data[MONKEY_ORIGINS]
