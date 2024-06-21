///Datum that handles
/datum/achievement_data
	///Ckey of this achievement data's owner
	var/owner_ckey
	///Up to date list of all achievements and their info.
	var/data = list()
	///Original status of achievement.
	var/original_cached_data = list()
	///Have we done our set-up yet?
	var/initialized = FALSE

/datum/achievement_data/New(ckey)
	owner_ckey = ckey
	if(SSachievements.initialized && !initialized)
		InitializeData()

/datum/achievement_data/proc/InitializeData()
	initialized = TRUE
	load_all_achievements() //So we know which achievements we have unlocked so far.

///Gets list of changed rows in MassInsert format
/datum/achievement_data/proc/get_changed_data()
	. = list()
	for(var/T in data)
		var/datum/award/A = SSachievements.awards[T]
		if(data[T] != original_cached_data[T])//If our data from before is not the same as now, save it to db.
			var/deets = A.get_changed_rows(owner_ckey,data[T])
			if(deets)
				. += list(deets)

/datum/achievement_data/proc/load_all_achievements()
	set waitfor = FALSE

	var/list/kv = list()
	var/datum/db_query/Query = SSdbcore.NewQuery(
		"SELECT achievement_key,value FROM [format_table_name("achievements")] WHERE ckey = :ckey",
		list("ckey" = owner_ckey)
	)
	if(!Query.Execute())
		qdel(Query)
		return
	while(Query.NextRow())
		var/key = Query.item[1]
		var/value = text2num(Query.item[2])
		kv[key] = value
	qdel(Query)

	for(var/award_type in subtypesof(/datum/award))
		var/datum/award/award = SSachievements.awards[award_type]
		if(!award || !award.name) //Skip abstract achievements types
			continue
		award.on_achievement_data_init(src, kv[award.database_id])

///Updates local cache with db data for the given achievement type if it wasn't loaded yet.
/datum/achievement_data/proc/get_data(achievement_type)
	var/datum/award/A = SSachievements.awards[achievement_type]
	if(!A.name)
		return FALSE
	if(!data[achievement_type])
		data[achievement_type] = A.load(owner_ckey)
		original_cached_data[achievement_type] = data[achievement_type]

///Unlocks an achievement of a specific type. achievement type is a typepath to the award, user is the mob getting the award, and value is an optional value to be used for defining a score to add to the leaderboard
/datum/achievement_data/proc/unlock(achievement_type, mob/user, value = 1)
	set waitfor = FALSE

	if(!SSachievements.achievements_enabled)
		return
	var/datum/award/A = SSachievements.awards[achievement_type]
	get_data(achievement_type) //Get the current status first if necessary
	if(istype(A, /datum/award/achievement))
		if(data[achievement_type]) //You already unlocked it so don't bother running the unlock proc
			return
		data[achievement_type] = TRUE
		A.on_unlock(user) //Only on default achievement, as scores keep going up.
	else if(istype(A, /datum/award/score))
		data[achievement_type] += value
	update_static_data(user)

///Getter for the status/score of an achievement
/datum/achievement_data/proc/get_achievement_status(achievement_type)
	return data[achievement_type]

/datum/achievement_data/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet/simple/achievements),
	)

/datum/achievement_data/ui_state(mob/user)
	return GLOB.always_state

/datum/achievement_data/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Achievements")
		ui.open()

/datum/achievement_data/ui_static_data(mob/user)
	. = ..()
	.["categories"] = GLOB.achievement_categories
	.["achievements"] = list()
	.["highscore"] = list()
	.["user_key"] = user.ckey

	var/datum/asset/spritesheet/simple/assets = get_asset_datum(/datum/asset/spritesheet/simple/achievements)
	for(var/achievement_type in SSachievements.awards)
		var/datum/award/award = SSachievements.awards[achievement_type]
		if(!award.name) //No name? we a subtype.
			continue
		if(isnull(data[achievement_type])) //We're still loading
			continue
		var/list/award_data = list(
			"name" = award.name,
			"desc" = award.desc,
			"category" = award.category,
			"icon_class" = assets.icon_class_name("achievement-[award.icon_state]"),
			"value" = data[achievement_type],
			)
		award_data += award.get_ui_data(user.ckey)
		.["achievements"] += list(award_data)

	for(var/score in SSachievements.scores)
		var/datum/award/score/S = SSachievements.scores[score]
		if(!S.name || !S.track_high_scores || !S.high_scores.len)
			continue
		.["highscore"] += list(list("name" = S.name,"scores" = S.high_scores))

/client/verb/checkachievements()
	set category = "OOC"
	set name = "Check achievements"
	set desc = "See all of your achievements!"

	player_details.achievements.ui_interact(usr)
