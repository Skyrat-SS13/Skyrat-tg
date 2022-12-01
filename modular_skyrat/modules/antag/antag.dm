#define OPFOR "Create your own opposing force application!"

/datum/objective/New(text)
	text = OPFOR
	GLOB.objectives += src
	objective_name = OPFOR
	if(text)
		explanation_text = text

/datum/antagonist/ninja
	give_objectives = FALSE

/datum/antagonist/on_gain()
	. = ..()
	if(objectives)
		for(var/datum/objective/i in objectives)
			i.explanation_text = OPFOR
			i.objective_name = OPFOR

#undef OPFOR
