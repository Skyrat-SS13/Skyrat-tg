/proc/consonant()
	return pick("B","C","D","F","G","H","J","K","L","M","N","P","Q","R","S","T","V","W","X","Y","Z")

/proc/vowel()
	return pick("A", "E", "I", "O", "U")

/proc/ucfirst(var/string)
	return "[uppertext(ascii2text(text2ascii(string, 1)))][copytext(string, 2)]"

/proc/ucfirsts(var/string)
	var/list/split_text = splittext(string, " ")
	var/list/position_list = list()
	for (var/position in split_text)
		position_list += ucfirst(position)
	return jointext(position_list, " ")

GLOBAL_LIST_EMPTY(FrozenAccounts)

/proc/list_frozen()
	for (var/frozen_accounts in GLOB.FrozenAccounts)
		to_chat(usr, "[frozen_accounts]: [length(GLOB.FrozenAccounts[frozen_accounts])] borrows")

/datum/article
	var/headline = "Something big is happening"
	var/subtitle = "Investors panic as stock market collapses"
	var/article = "God, it's going to be fun to randomly generate this."
	var/author = "P. Pubbie"
	var/spacetime = ""
	var/opinion = 0
	var/ticks = 0
	var/datum/stock/about = null
	var/outlet = ""
	var/static/list/outlets = list()
	var/static/list/default_tokens = list( \
		"buy" = list("buy!", "buy, buy, buy!", "get in now!", "ride the share value to the stars!"), \
		"company" = list("company", "corporation", "conglomerate", "enterprise", "venture"), \
		"complete" = list("complete", "total", "absolute", "incredible"), \
		"country" = list("Electra Networks", "Microman", "Solas Colony", "Anemone", "Beacon", "Protonetworks", "Lifeworth", "Tundra Lighting", "Illume", "Terra Corps", "Visage", "Night Co.", "Coblium", "Mars Federation", "Jungle Entertainment", "Wizardlife", "Hammer Security"), \
		"development" = list("development", "unfolding of events", "turn of events", "new shit"), \
		"dip" = list("dip", "fall", "plunge", "decrease"), \
		"excited" = list("excited", "euphoric", "exhilarated", "thrilled", "stimulated"), \
		"expand_influence" = list("expands their influence over", "continues to dominate", "gains traction in", "rolls their new product line out in"), \
		"failure" = list("failure", "meltdown", "breakdown", "crash", "defeat", "wreck"), \
		"famous" = list("famous", "prominent", "leading", "renowned", "expert"), \
		"hit_shelves" = list("hit the shelves", "appeared on the market", "came out", "was released"), \
		"industry" = list("industry", "sector"), \
		"industrial" = list("industrial"), \
		"jobs" = list("workers"), \
		"negative_outcome" = list("it's not leaving the shelves", "nobody seems to care", "it's a huge money sink", "they have already pulled all advertising and marketing support"), \
		"neutral_outcome" = list("it's not lifting off as expected", "it's not selling according to expectations", "it's only generating enough profit to cover the marketing and manufacturing costs", "it does not look like it will become a massive success", "it's experiencing modest sales"), \
		"positive_outcome" = list("it's already sold out", "it has already sold over one billion units", "suppliers cannot keep up with the wild demand", "several companies using this new technology are already reporting a projected increase in profits"), \
		"resounding" = list("resounding", "tremendous", "total", "massive", "terrific", "colossal"), \
		"rise" = list("rise", "increase", "fly off the positive side of the charts", "skyrocket", "lift off"), \
		"sell" = list("sell!", "sell, sell, sell!", "bail!", "abandon ship!", "get out before it's too late!", "evacuate!", "withdraw!"), \
		"signifying" = list("signifying", "indicating", "implying", "displaying", "suggesting"), \
		"sneak_peek" = list("review", "sneak peek", "preview", "exclusive look"), \
		"stock_market" = list("stock market", "stock exchange"), \
		"stockholder" = list("stockholder", "shareholder"), \
		"success" = list("success", "triumph", "victory"), \
		"this_time" = list("this week", "last week", "this month", "yesterday", "today", "a few days ago") \
	)

/datum/article/New()
	..()
	if ((outlets.len && !prob(100 / (outlets.len + 1))) || !outlets.len)
		var/outlet_name = generateOutletName()
		if (!(outlet_name in outlets))
			outlets[outlet_name] = list()
		outlet = outlet_name
	else
		outlet = pick(outlets)

	var/list/authors = outlets[outlet]
	if ((authors.len && !prob(100 / (authors.len + 1))) || !authors.len)
		var/author_name = generateAuthorName()
		outlets[outlet] += author_name
		author = author_name
	else
		author = pick(authors)

	ticks = world.time

/datum/article/proc/generateOutletName()
	var/list/locations = list("Earth", "Mars", "Luna", "Venus", "Ceres", "Pluto", "Ceti Epsilon", "Eos", "Terstan", "Deimos", "Space", "Neptune", "Mercury", "Terra", "Terstan", "Lorriman", "Cinu", "Himalia", "Yuklid", "Lordania", "Kingston", "Gaia", "Magnitka", "Artyom")
	var/list/nouns = list("Post", "Herald", "Sun", "Tribune", "Mail", "Times", "Journal", "Report")
	var/list/timely = list("Daily", "Hourly", "Weekly", "Biweekly", "Monthly", "Yearly")

	switch(rand(1,2))
		if (1)
			return "The [pick(locations)] [pick(nouns)]"
		if (2)
			return "The [pick(timely)] [pick(nouns)]"

/datum/article/proc/generateAuthorName()
	switch(rand(1,3))
		if (1)
			return "[consonant()]. [pick(GLOB.last_names)]"
		if (2)
			return "[prob(50) ? pick(GLOB.first_names_male) : pick(GLOB.first_names_female)] [consonant()].[prob(50) ? "[consonant()]. " : null] [pick(GLOB.last_names)]"
		if (3)
			return "[prob(50) ? pick(GLOB.first_names_male) : pick(GLOB.first_names_female)] \"[prob(50) ? pick(GLOB.first_names_male) : pick(GLOB.first_names_female)]\" [pick(GLOB.last_names)]"

/datum/article/proc/formatSpacetime()
	var/ticksc = round(ticks/100)
	ticksc = ticksc % 100000
	var/ticksp = "[ticksc]"
	while (length(ticksp) < 5)
		ticksp = "0[ticksp]"
	spacetime = "[ticksp][time2text(world.realtime, "MM")][time2text(world.realtime, "DD")][text2num(time2text(world.realtime, "YYYY"))+540]"

/datum/article/proc/formatArticle()
	if (spacetime == "")
		formatSpacetime()
	var/output = "<div class='article'><div class='headline'>[headline]</div><div class='subtitle'>[subtitle]</div><div class='article-body'>[article]</div><div class='author'>[author]</div><div class='timestamp'>[spacetime]</div></div>"
	return output

/datum/article/proc/detokenize(var/token_string, var/list/industry_tokens, var/list/product_tokens = list())
	var/list/T_list = default_tokens.Copy()
	for (var/token in industry_tokens)
		T_list[token] = industry_tokens[token]
	for (var/token in product_tokens)
		T_list[token] = list(product_tokens[token])
	for (var/token in T_list)
		token_string = replacetext(token_string, "%[token]%", pick(T_list[token]))
	return ucfirst(token_string)
