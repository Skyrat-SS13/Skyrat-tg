/datum/keybinding/movement/army_crawl
	hotkey_keys = list("K")
	name = "prone"
	full_name = "army crawl"
	description = "lay yourself as close to the ground as possible after a short delay"
	keybind_signal = COMSIG_KB_MOVEMENT_ARMY_CRAWL_DOWN

/datum/keybinding/movement/army_crawl/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/carbon/crawler = user.mob
	if(istype(crawler, /mob/living/carbon))
		crawler.army_crawl()
