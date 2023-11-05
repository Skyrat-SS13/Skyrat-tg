//opt in list, gathers all crew with their settings set to whatever antagonism level we're looking for + all of command and sec
//set get anyone for true if the antags can target anyone. for contractors and heretics we set this to false b/c they only target sec and command
/proc/minimum_opt_in_level(level = NOT_TARGET, get_anyone = TRUE)
	//if you're command or security you will always be a valid target
	var/list/forced_department_bitflags = DEPARTMENT_BITFLAG_COMMAND & DEPARTMENT_BITFLAG_CENTRAL_COMMAND & DEPARTMENT_BITFLAG_SECURITY
	var/list/all_crew = get_crewmember_minds()
	var/list/eligible_crew
	LAZYINITLIST(eligible_crew) //why are you throwing errors at me. maybe this is because my vscode is busted
	for(var/datum/mind/mind as anything in all_crew)
		if(get_anyone == TRUE)
			var/preference = mind.current?.client?.prefs?.read_preference(/datum/preference/choiced/antag_opt_in_status)
			if(preference >= level)
				LAZYADD(eligible_crew, mind)
		if(mind.assigned_role.departments_bitflags & forced_department_bitflags)
			LAZYADD(eligible_crew, mind)
	return eligible_crew

//list of opt in antag strings for UI stuff
GLOBAL_LIST_INIT(opt_in_antagonist_strings, list(
    "0" = "No",
	"1" = "Yes - Temporary/Inconvienence",
    "2" = "Yes - Kill",
    "3" = "Yes - Round Remove"
))
