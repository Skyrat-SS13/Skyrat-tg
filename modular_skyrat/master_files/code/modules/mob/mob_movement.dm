/mob/living/carbon/verb/army_crawl()
	set name = "Army Crawl"
	set category = "IC"

	var/mob/living/carbon/crawler = src

	if(HAS_TRAIT(crawler, TRAIT_PRONE))
		visible_message("[crawler] starts getting back up")
		if(!do_after(crawler, 3 SECONDS))
			return
		SEND_SIGNAL(crawler, COMSIG_MOVABLE_REMOVE_PRONE_STATE)
	else
		if(!crawler.resting)
			balloon_alert(crawler, "you must be laying down to army crawl.")
			return
		visible_message("[crawler] begins to lower themself further")
		if(!do_after(crawler, 3 SECONDS))
			return
		crawler.AddComponent(/datum/component/prone_mob)
