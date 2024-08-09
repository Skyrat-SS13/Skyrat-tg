/datum/keybinding/movement/army_crawl
	hotkey_keys = list("K")
	name = "Prone"
	full_name = "Army Crawl"
	description = "lay yourself as close to the ground as possible after a short delay"
	keybind_signal = COMSIG_KB_MOVEMENT_ARMY_CRAWL_DOWN

/datum/keybinding/movement/army_crawl/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/carbon/crawler = user.mob
	crawler.army_crawl()
