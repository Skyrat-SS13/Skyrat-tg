/*
	Signal abilities are "spells" that can be used by signals, and the marker, while in their observer modes.
	They cost psi energy, which is passively gained over time while in the right modes.

	Almost all signal abilities can only be cast upon tiles visible to the necrovision network.
	Many, more restrictive ones, can only be cast upon corrupted tiles. And often only when not visible to humans
*/



/datum/signal_ability
	var/name = "Ability"

	var/id = "ability"	//ID should be unique and all lowercase

	var/desc = "Does stuff!"
	var/long_desc

	//Cost of casting it. Can be zero
	var/energy_cost = 60

	var/base_type = /datum/signal_ability	//Used to prevent abstract parent classes from showing up in autoverbs

	//If the user clicks something which isn't a valid target, we'll search in this radius around the clickpoint to find a valid target.
	//A value of zero still works, and will search only in the clicked turf. Set to null to disable autotargeting.
	var/autotarget_range = 1

	//If true, autotargeting only selects things in view of the clicked place. If false, things in range are selected regardless of LOS
	var/target_view = FALSE

	//Many spells have cooldowns in addition to costs
	var/cooldown = 0

	//What types of atom we are allowed to target with this ability. This will be used for autotargeting
	//Any number of valid types can be put in this list
	var/target_types = list(/turf)

	//A string telling the user what to click on/near
	var/target_string = "any visible tile"

	//If set to true or false, this requires the target to be an ally or not-ally of the user, respectively,
	//Only used when targeting mobs. Leave it null to disable this behaviour
	var/allied_check = null


	//If true, can only be cast on turfs currently in the necrovision network.
	//When false, spells can be cast onto the blackspace outside it. Not very useful but has some potential applications
	//This setting is completely ignored if require_corruption is set true, they are exclusive
	var/require_necrovision = TRUE

	//When true, the turf which contains/is the target must have corruption on it.
	var/require_corruption = FALSE

	//When true, the turf which contains/is the target must not be visible to any conscious crewmember
	var/LOS_block	=	FALSE

	//When set to a number, the spell must be cast at least this distance away from a conscious crewmember
	//var/distance_blocked = 0

	//If true, this spell can only be cast after the marker has activated
	//If false, it can be cast anytime from roundstart
	//If -1, it can only be cast BEFORE marker activation
	var/marker_active_required = FALSE


	//How many targets this spell needs. This may allow casting on multiple things at once, or tracing a path. Default 1
	//UNIMPLEMENTED//var/num_targets


	//If true, signals cannot cast this spell. Only the marker player can do it
	var/marker_only	= FALSE

	//Targeting Handling:
	//--------------------------
	var/targeting_method	=	TARGET_CLICK

	//What type of click handler this uses to select a target, if any
	//Only used when targeting method is not self
	//If not specified, defaults will be used for click and placement
	var/click_handler_type =	null

	//Atom used for the preview image of placement handler, if we're using that
	var/placement_atom = null

	//Does placement handler snap-to-grid?
	var/placement_snap = TRUE







/*----------------------------------------------
	Overrides:
	Override these in subclasses to do things
-----------------------------------------------*/
//This does nothing in the base class, override it and put spell effects here
/datum/signal_ability/proc/on_cast(var/mob/user, var/atom/target, var/list/data)
	return

//Return true if the passed thing is a valid target
//Return false to fail silently
//Return a string to fail with an error message shown to user
/datum/signal_ability/proc/special_check(var/atom/thing)
	return TRUE


/*----------------------------------------------------------------------
	Core Code: Be very careful about overrriding these, best not to
----------------------------------------------------------------------*/
//Entrypoint to this code, called when user clicks the button to start a spell.
//This code creates the click handler
/datum/signal_ability/proc/start_casting(var/mob/user)

	var/check = can_cast_now(user)
	//Validate before casting
	if (check != TRUE)
		to_chat(user, SPAN_WARNING(check))
		return

	if (!pre_cast(user))
		return

	user.RemoveClickHandlersByType(/datum/click_handler/placement/ability)	//Remove any old placement handlers first, a mob should never have more than one of these
	user.RemoveClickHandlersByType(/datum/click_handler/target)	//Remove targeting handlers too

	switch(targeting_method)
		if (TARGET_CLICK)
			to_chat(user, SPAN_NOTICE("Now Casting [name], click on a target. Right click to cancel. Hold shift to cast multiple times."))
			//We make a target clickhandler, this callback is sent through to the handler's /New. User will be maintained as the first argument
			//When the user clicks, it will call target_click, passing back the user, as well as the thing they clicked on, and clickparams
			var/datum/click_handler/CH = user.PushClickHandler((click_handler_type ? click_handler_type : /datum/click_handler/target), CALLBACK(src, /datum/signal_ability/proc/target_click, user))
			CH.id = "[src.type]"
		if (TARGET_PLACEMENT)
			to_chat(user, SPAN_NOTICE("Now Placing [name], click on a target. Right click to cancel. Hold shift to place multiple copies, press R to rotate"))
			//Make the placement handler, passing in atom to show. Callback is propagated through and will link its clicks back here
			var/datum/click_handler/CH = create_ability_placement_handler(user, placement_atom, click_handler_type ? click_handler_type : /datum/click_handler/placement/ability, placement_snap, require_corruption, LOS_block, CALLBACK(src, /datum/signal_ability/proc/placement_click, user))
			CH.id = "[src.type]"
		if (TARGET_SELF)
			to_chat(user, SPAN_NOTICE("Now Casting [name]!"))
			select_target(user, user)

/datum/signal_ability/proc/pre_cast(var/mob/user)
	return TRUE

//Path to the end of the cast
/datum/signal_ability/proc/finish_casting(var/mob/user, var/atom/target,  var/list/data)
	//Pay the energy costs
	if (!pay_cost(user))
		//TODO: Abort casting, we failed
		return


	//And do the actual effect of the spell
	on_cast(user, target,  data)

	stop_casting(user)

//This is called after finish, or at any point during casting if things fail.
//It deletes clickhandlers, cleans up, etc.
/datum/signal_ability/proc/stop_casting(var/mob/user)

	//Search the user's clickhandlers for any which have an id matching our type, indicating we put them there. And remove those
	for (var/datum/click_handler/CH in user.GetClickHandlers())
		if (CH.id == "[src.type]")
			user.RemoveClickHandler(CH)


//Called from the click handler when the user clicks a potential target.
//Data is an associative list of any miscellaneous data. It contains the direction for placement handlers
/datum/signal_ability/proc/select_target(var/mob/user, var/candidate,  var/list/data)
	var/check = can_cast_now(user)
	//Validate before casting
	if (check != TRUE)
		to_chat(user, SPAN_WARNING(check))
		return

	var/newtarget = candidate
	if (!is_valid_target(newtarget, user))	//If its not right, then find a better one
		newtarget = null
		var/list/allied_data = null
		if (!isnull(allied_check))
			allied_data = list(user, allied_check)
		var/visualnet = null
		if (require_necrovision)
			visualnet = GLOB.necrovision

		var/list/things = get_valid_target(origin = candidate,
		radius = autotarget_range,
		valid_types = target_types,
		allied = allied_data,
		visualnet = visualnet,
		require_corruption = require_corruption,
		view_limit = target_view,
		LOS_block = LOS_block,
		num_required = 1,
		special_check = CALLBACK(src, /datum/signal_ability/proc/special_check),
		error_user = user)

		if (things.len)
			newtarget = things[1]
	if (!newtarget)
		to_chat(user, SPAN_WARNING("No valid target found"))
		return FALSE


	.=TRUE
	//TODO 2:	Add add a flag to not instacast here

	finish_casting(user, newtarget,  data)




/*
	Returns a paragraph or two of text explaining what this spell does
*/
/datum/signal_ability/proc/get_long_description(var/mob/user)
	if (long_desc)
		return long_desc
	.="<b>Cost</b>: [energy_cost]<br>"
	if (cooldown)
		.+="<b>Cooldown</b>: [descriptive_time(cooldown)]<br>"
	.+="<b>Target</b>: [target_string]<br>"
	if (autotarget_range)
		.+="<b>Autotarget Range</b>: [autotarget_range]<br>"
	.+="<br>"
	.+= desc
	long_desc = .


/*
	Actually deducts energy, sets cooldowns, and makes any other costs as a result of casting. Returns true if all succeed
*/
/datum/signal_ability/proc/pay_cost(var/mob/user)
	.= FALSE

	//Pay energy cost last
	var/datum/extension/psi_energy/PE = user.get_energy_extension()

	//We set right now as the last casting time, used for cooldowns
	PE.abilities[id] = world.time



	if (energy_cost)

		if (!PE)
			return

		if (!(PE.can_afford_energy_cost(energy_cost, src)))
			return

		PE.change_energy(-energy_cost)

	return TRUE



/*
	To be called only from on_cast, or some other point where costs have already been paid.
	Gives the user their energy and cooldowns back
*/
/datum/signal_ability/proc/refund(var/mob/user)
	var/datum/extension/psi_energy/PE = user.get_energy_extension()
	PE.abilities[id] = 0	//ready to recast immediately
	if (energy_cost)
		PE.change_energy(energy_cost)


/*-----------------------------
	Click Handling
------------------------------*/

//Called from a click handler using the TARGET_CLICK method
/datum/signal_ability/proc/target_click(var/mob/user, var/atom/target, var/params)
	return select_target(user, target)




/datum/signal_ability/proc/placement_click(var/mob/user, var/atom/target, var/list/data)
	return select_target(user, target,  data)








/*---------------------------
	Safety Checks
----------------------------*/

/*
	Checks whether the given user is currently able to cast this spell.
	This is called before casting starts, so no targeting data yet. It checks:
		-Available energy
		-Correct mob type

	This proc will either return TRUE if no problem, or an error message if there is a problem
*/
/datum/signal_ability/proc/can_cast_now(var/mob/user)
	.=is_valid_user(user)

	if (!.)
		return

	var/datum/extension/psi_energy/PE = user.get_energy_extension()
	if (energy_cost)

		if (!PE)
			return "You have no energy!"

		if (!(PE.can_afford_energy_cost(energy_cost, src)))
			return "Insufficient energy."

	if (cooldown)
		var/last_cast = PE.abilities[id]	//When was it last cast?
		var/next_allowed = last_cast + cooldown	//Based on that, when will it next be ready to cast?
		//If the gametime isnt past that point yet, then the spell is still cooling
		if (world.time <= next_allowed)
			var/time_remaining = "[time2text(next_allowed - world.time, "mm:ss")]"
			return "This spell is still cooling down. It will be ready in [time_remaining]"


/*
	Checks whether the user will be able to cast this spell in the near future, without outside assistance or changing circumstances
	This is mainly used for deciding whether or not to add it to our spell list
	Checks:
		-Correct mob type
		-Marker activity requirement

	Does not check energy cost, cooldown, or other ephemeral qualities

*/
/datum/signal_ability/proc/is_valid_user(var/mob/user)
	if (!user)	//If there's no user, maybe we're casting it via script. Just let it through
		return TRUE

	if (marker_only && !is_marker_master(user))
		return FALSE


	if (marker_active_required)
		var/obj/machinery/marker/M = get_marker()
		if (M && !M.active)
			if (marker_active_required == TRUE)
				return FALSE
		else if (M && M.active)
			if (marker_active_required == -1)
				return FALSE

	return TRUE

//Does a lot of checking to see if the specified target is valid
/datum/signal_ability/proc/is_valid_target(var/atom/thing, var/mob/user, var/silent = FALSE)
	var/correct_type = FALSE
	for (var/typepath in target_types)
		if (istype(thing, typepath))
			correct_type = TRUE
			break

	if (!correct_type)
		return FALSE

	var/result = special_check(thing)
	if (result != TRUE)
		if (result != FALSE && !silent && user)
			to_chat(user, SPAN_WARNING(result))
		return FALSE


	var/turf/T = get_turf(thing)
	if (require_corruption)
		//Since corrupted tiles are always visible to necrovision, we dont check vision if corruption is required
		if (!turf_corrupted(T))
			return FALSE
	else if (require_necrovision)
		if (!T.is_in_visualnet(GLOB.necrovision))
			return FALSE


	if (LOS_block)
		var/mob/M = T.is_seen_by_crew()
		if (M)
			to_chat(user, SPAN_WARNING("Casting here is blocked because the tile is seen by [M]"))
			return FALSE

	if (!isnull(allied_check))
		if ((user.is_allied(thing) != allied_check))
			return FALSE


	return TRUE




