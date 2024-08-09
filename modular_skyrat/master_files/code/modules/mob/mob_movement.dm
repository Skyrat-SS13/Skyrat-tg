/mob/living/carbon/verb/army_crawl()
	set name = "Army Crawl"
	set category = "IC"

	var/mob/living/carbon/crawler = src
	if(!crawler.resting)
		return balloon_alert(src, "you must be laying down to army crawl.")
	switch(HAS_TRAIT(crawler, TRAIT_PRONE))
		if(FALSE)
			balloon_alert_to_viewers("[crawler] begins to lower themself all the way to the ground.")
			if(!do_after(crawler, 3 SECONDS))
				return
			crawler.AddElement(/datum/element/prone_mob)
		if(TRUE)
			balloon_alert_to_viewers("[crawler] begins to get back up from their crawl.")
			if(!do_after(crawler, 3 SECONDS))
				return
			SEND_SIGNAL(crawler, COMSIG_MOVABLE_REMOVE_PRONE_STATE)
