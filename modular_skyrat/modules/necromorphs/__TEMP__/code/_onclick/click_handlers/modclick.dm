
/****************************
	Modclick Verbs
*****************************/
/*
A generic container for verbs triggered on various modified clicks
Verbs added this way will recieve the target as their first parameter. and click params as their second
Each proc expected to handle this and return true or false to indicate whether or not they will take this click.

Use add_modclick_verb to add a verb,
*/
/datum/click_handler/modifier
	var/list/verbs = list()


//We call each callback in our verbs list. If it returns true, we return false to terminate the click
/datum/click_handler/modifier/proc/handle_click(var/atom/A, var/params)
	for (var/datum/callback/C in verbs)
		if (C.Invoke(A, params))
			return FALSE
	return TRUE





//Specific types
//----------------------------------------
/datum/click_handler/modifier/alt/OnAltClick(var/atom/A, var/params)
	return handle_click(A, params)

/datum/click_handler/modifier/ctrl/OnCtrlClick(var/atom/A, var/params)
	return handle_click(A, params)

/datum/click_handler/modifier/shift/OnShiftClick(var/atom/A, var/params)
	return handle_click(A, params)

/datum/click_handler/modifier/middle/OnMiddleClick(var/atom/A, var/params)
	return handle_click(A, params)

/datum/click_handler/modifier/ctrlalt/OnCtrlAltClick(var/atom/A, var/params)
	return handle_click(A, params)

/datum/click_handler/modifier/ctrlshift/OnCtrlShiftClick(var/atom/A, var/params)
	return handle_click(A, params)



/*
	Adds an altclick verb to the specified datum
*/
/mob/proc/add_modclick_verb(var/keytype, var/function, var/priority, var/list/extra_args)
	//Firstly, lets find or create an altclick verb handler on this mob
	var/datum/click_handler/modifier/CHM = GetClickHandlerByType(keytype)
	if (!CHM)
		CHM = PushClickHandler(keytype)

	//Next we create a callback, which points to the mob, proc to call, and the arguments to pass to it
	var/list/newargs = list(src, function)
	if (extra_args)
		newargs.Add(extra_args)
	var/datum/callback/C = CALLBACK(arglist(newargs))

	if (!isnum(priority))
		priority = 1
	//Add it to the verbs list
	CHM.verbs[C] = priority

	//And sort that list
	CHM.verbs = sortTim(CHM.verbs, cmp=/proc/cmp_numeric_dsc, associative = TRUE)


//Removing by type.
/mob/proc/remove_modclick_verb(var/keytype, var/function)
	var/datum/click_handler/modifier/CHM = GetClickHandlerByType(keytype)
	if (!CHM)
		return

	for (var/datum/callback/C in CHM.verbs)
		if (C.delegate == function)
			CHM.verbs.Remove(C)