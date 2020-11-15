/datum/antagonist
	///Whether the antagonist uses ambitions
	var/uses_ambitions = FALSE

/datum/antagonist/greet()
	if(uses_ambitions)
		to_chat(owner.current, "<span class='boldnotice'>You're a story driven antagonist, this means you'll have to fill ambitions before you start antagonising!</span>")
		to_chat(owner.current, "<span class='boldnotice'>After filling them out you'll get access to your uplink or powers.</span>")
		to_chat(owner.current, "<span class='boldnotice'>Click >here< to set your ambitions, or access them at any time from your IC tab.</span>")

///This gets called after our ambitions are submitted, or the antag datum is given to someone with filled ambitions
/datum/antagonist/proc/ambitions_add()
	return

///This gets called to remove things from an antagonist, given that they had ambitions submitted (ie. remove powers from ling, remove uplink from traitors)
/datum/antagonist/proc/ambitions_removal()
	return

/datum/antagonist/traitor
	uses_ambitions = TRUE

/datum/antagonist/changeling
	uses_ambitions = TRUE

/datum/objective/ambitions
	name = "ambitions"
	explanation_text = "Open up ambitions from the IC tab and craft your unique antagonistic story."

/datum/objective/ambitions/check_completion()
	return TRUE
