/mob/living/carbon/verb/army_crawl()
	set name = "Army Crawl"
	set category = "IC"

	var/mob/living/carbon/crawler = src

	if(HAS_TRAIT(crawler, TRAIT_PRONE))
		visible_message("[crawler] starts to get up")
		if(!do_after(crawler, 3 SECONDS))
			return
		SEND_SIGNAL(crawler, COMSIG_MOVABLE_REMOVE_PRONE_STATE)
	else
		visible_message("[crawler] begins to lower themself further")
		if(!do_after(crawler, 3 SECONDS, extra_checks = CALLBACK(crawler, PROC_REF(can_army_crawl))))
			if(!crawler.resting)
				balloon_alert(crawler, "must be laying down!")
			return
		crawler.AddComponent(/datum/component/prone_mob)

/mob/living/carbon/proc/can_army_crawl()
	return resting
