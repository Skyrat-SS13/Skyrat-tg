// This system defines news that will be displayed in the course of a round.
// Uses BYOND's type system to put everything into a nice format

/datum/news_announcement
	var
		round_time // time of the round at which this should be announced, in seconds
		message // body of the message
		author = "Joseph O'Neill"
		channel_name = "New Horizon Daily"
		can_be_redacted = 0
		message_type = "Story"

	revolution_inciting_event

		paycuts_suspicion
			round_time = 60*10
			message = {"Reports have leaked that NanoTrasen is planning to put paycuts into
						effect on many of its Research Stations in Tau Ceti. Apparently these research
						stations haven't been able to yield the expected revenue, and thus adjustments
						have to be made."}
			author = "Unauthorized"

		paycuts_confirmation
			round_time = 60*40
			message = {"Earlier rumours about paycuts on Research Stations in the Tau Ceti system have
						been confirmed. Shockingly, however, the cuts will only affect lower tier
						personnel. Heads of Staff will, according to our sources, not be affected."}
			author = "Unauthorized"

		human_experiments
			round_time = 60*90
			message = {"Unbelievable reports about human experimentation have reached our ears. According
			 			to a refugee from one of the Tau Ceti Research Stations, their station, in order
			 			to increase revenue, has refactored several of their facilities to perform experiments
			 			on live humans, including virology research, genetic manipulation, and \"feeding them
			 			to the slimes to see what happens\". Allegedly, these test subjects were neither
			 			humanified monkeys nor volunteers, but rather unqualified staff that were forced into
			 			the experiments, and reported to have died in a \"work accident\" by NanoTrasen."}
			author = "Unauthorized"

	cec_neutral

		ishimura_decommissioning
			author = "Assistant Editor Veronica Best"
			channel_name = "New Horizon Daily"
			message = {"Today marks the one-year countdown for the Ishimura's last voyage. After return at Titan Station, it is due for decommissioning.
			When asked for a comment, CEC responded with a prepared statement: \"The Ishimura has served us well, but as Planet-Cracking becomes a diminished practice, we too must adapt as a company and turn to the future.\"
			Surprisingly little is known about the Ishimura's final act. CEC was not prepared to comment on this."}
			round_time = 60 * 15

	cec_scathing

		report
			channel_name = "New Horizon Daily"
			author = "Reporter Laila Hanfield"

			message = {"A scathing report was published today, putting CEC in the middle of budget cuts across their fleet. Usage of old food vendors with poorly preserved food amongst long-term mission ships makes crew ten times more likely to die of heart failure.
			\"It's an embarassment. We are one of the largest corporations, and can't even feed our crew proper nutritious meals.\" says a Captain of one of their ships.
			In response to this report, we reached out to CEC's Public Relations office, who have declined to comment at this time, citing: \"We do not comment on on-going investigations. We assure everyone that we take this report very seriously.\"
			We will update this story as new information reaches us."}
			round_time = 60 * 30

	marker_research

		breaking_news
			channel_name = "New Horizon Daily"
			author = "Joseph O'Neill"

			message = {"Breaking news: Titan Station, Director of Operation reports breakthrough in Marker research.
			States the Marker may be able to provide endless and renewable powersources. The Director was not available for comment on delivery.
			May our energy crisis finally be over? These following years will tell, says spokeswoman Tracy."}
			round_time = 60 * 10

		marker_research_more
			channel_name = "New Horizon Daily"
			author = "Joseph O'Neill"

			message = {"Increased instability in Titan Station's powergrid today as the first official Marker test commences. Chief Scientist Beatrice speaks with us:
			\"We appreciate the concern of our station residents, but there is no need for panic.\", she says in an official statement.
			Several residents speak out against her claims, saying that it is said at a period of historically low stability on Titan Station.
			\"These scientists have no regard for us, our daily lives. They are backed by Earth Government and their cronies. How can we believe anything?\", says an anonymous source.
			More on this at 9."}
			round_time = 60 * 60


var/global/list/newscaster_standard_feeds = list(/datum/news_announcement/marker_research, /datum/news_announcement/cec_scathing, /datum/news_announcement/cec_neutral)

proc/process_newscaster()
	check_for_newscaster_updates(SSticker.mode.newscaster_announcements)

var/global/tmp/announced_news_types = list()
proc/check_for_newscaster_updates(type)
	for(var/subtype in typesof(type)-type)
		var/datum/news_announcement/news = new subtype()
		if(news.round_time * 10 <= world.time && !(subtype in announced_news_types))
			announced_news_types += subtype
			announce_newscaster_news(news)

proc/announce_newscaster_news(datum/news_announcement/news)
	var/datum/feed_channel/sendto
	for(var/datum/feed_channel/FC in news_network.network_channels)
		if(FC.channel_name == news.channel_name)
			sendto = FC
			break

	if(!sendto)
		sendto = new /datum/feed_channel
		sendto.channel_name = news.channel_name
		sendto.author = news.author
		sendto.locked = 1
		sendto.is_admin_channel = 1
		news_network.network_channels += sendto

	var/author = news.author ? news.author : sendto.author
	news_network.SubmitArticle(news.message, author, news.channel_name, null, !news.can_be_redacted, news.message_type)
