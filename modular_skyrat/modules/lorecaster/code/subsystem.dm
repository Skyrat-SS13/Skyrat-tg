SUBSYSTEM_DEF(lorecaster)
	name = "Lorecaster"
	wait = 30 MINUTES
	/// List of stories yet to have been run
	var/list/stories

/datum/controller/subsystem/lorecaster/Initialize()
	GLOB.news_network.create_feed_channel("Nanotrasen News Network", "NNN", "Get the latest stories from the frontier, here!", locked = TRUE, hardset_channel = 1001)
	var/config_delay = CONFIG_GET(number/lorecaster_delay)
	if(config_delay)
		wait = config_delay
	return SS_INIT_SUCCESS

/datum/controller/subsystem/lorecaster/fire(resumed)
	if(!length(stories)) // Ran out of stories? Run through 'em again
		stories = json_load(NEWS_FILE)
		return // But skip the cycle this time
	var/picked_story = pick(stories)
	var/text = stories[picked_story]["text"]
	var/title = stories[picked_story]["title"]
	GLOB.news_network.submit_article(text || "Someone forgot to fill out the article!", title || "Nanotrasen News Broadcast", "Nanotrasen News Network", null)
