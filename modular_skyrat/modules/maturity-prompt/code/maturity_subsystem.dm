// Might as well go and group it up into a subsystem.

SUBSYSTEM_DEF(maturity_guard)
	name = "Maturity guard"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_MATURITY_GUARD
	var/list/whitelisted_cache = list()
	var/current_month
	var/current_year


/datum/controller/subsystem/maturity_guard/Initialize()
	. = ..()
	var/current_time = world.realtime
	current_month = text2num(time2text(current_time, "MM"))
	current_year = text2num(time2text(current_time, "YYYY"))


/datum/controller/subsystem/maturity_guard/proc/age_check(mob/user)
	if(!istype(user))
		return

	if(!user.ckey)
		return

	if(user.ckey in whitelisted_cache)
		return TRUE

	if(validate_dob(get_age_from_db(user)))
		whitelisted_cache |= user.ckey
		return TRUE

	INVOKE_ASYNC(src, TYPE_PROC_REF(/datum/controller/subsystem/maturity_guard, age_prompt), user)
	return


/datum/controller/subsystem/maturity_guard/proc/age_prompt(mob/user)
	maturity_prompt(user)


/datum/controller/subsystem/maturity_guard/proc/get_age_from_db(mob/user)
	if(IsAdminAdvancedProcCall())
		return

	if(!SSdbcore.Connect())
		return

	if(!istype(user) || !user.ckey)
		return

	var/datum/db_query/get_age_from_db = SSdbcore.NewQuery(
		"SELECT dob_year, dob_month FROM [format_table_name("player_dob")] WHERE ckey = :ckey",
		list("ckey" = user.ckey),
	)

	if(!get_age_from_db.warn_execute())
		return

	get_age_from_db.NextRow()
	return get_age_from_db.item


/datum/controller/subsystem/maturity_guard/proc/add_age_to_db(mob/user, year, month)
	if(IsAdminAdvancedProcCall())
		return

	if(!SSdbcore.Connect())
		return

	if(!istype(user) || !user.ckey)
		return

	if(!isnum(year) || !isnum(month))
		return

	var/datum/db_query/add_age_to_db = SSdbcore.NewQuery(
		"INSERT INTO [format_table_name("player_dob")] (ckey, dob_year, dob_month) VALUES(:ckey, :dob_year, :dob_month) \
		 ON DUPLICATE KEY UPDATE dob_year = :dob_year, dob_month = :dob_month",
		list("ckey" = user.ckey, "dob_year" = year, "dob_month" = month),
	)

	if(!add_age_to_db.warn_execute())
		return

	return TRUE

// // Code borrowed from S.P.L.U.R.T
// // https://github.com/SPLURT-Station/S.P.L.U.R.T-Station-13/blob/6e6bce87726b7a5ac7ebf23bec7b020a004c6e60/code/modules/mob/dead/new_player/new_player.dm
// /datum/controller/subsystem/maturity_guard/proc/validate_dob(year, month, day)




