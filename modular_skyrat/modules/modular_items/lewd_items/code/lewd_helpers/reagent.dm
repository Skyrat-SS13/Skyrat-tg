
/datum/reagent/overdose_process(mob/living/M, delta_time, times_fired)
	// Because these chemicals shouldn't bear the same weight as normal / debatably more harmful chemicals.
	if(name == "dopamine")///This one also shouldn't have any negative mood effect.
		return
	if(name == "succubus milk" || name == "incubus draft" || name == "Camphor" || name == "Pentacamphor")
		to_chat(M, span_userdanger("You feel like you took too much [name]!"))
		M.add_mood_event("[type]_overdose", /datum/mood_event/minor_overdose, name)
		return
	. = ..()
