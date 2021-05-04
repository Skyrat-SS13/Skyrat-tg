

/datum/stockMarket
	var/list/stocks = list()
	var/list/balances = list()
	var/list/last_read = list()
	var/list/stockBrokers = list()
	var/list/logs = list()

/datum/stockMarket/New()
		..()
		generateBrokers()
		generateStocks()
		START_PROCESSING(SSobj, src)

/datum/stockMarket/proc/balanceLog(var/whose, var/net)
	if (!(whose in balances))
		balances[whose] = net
	else
		balances[whose] += net
/datum/stockMarket/proc/generateBrokers()
	stockBrokers = list()
	var/list/fnames = list("Goldman", "Edward", "James", "Luis", "Alexander", "Walter", "Eugene", "Mary", "Morgan", "Jane", "Elizabeth", "Xavier", "Hayden", "Samuel", "Lee")
	var/list/names = list("Johnson", "Rothschild", "Sachs", "Stanley", "Hepburn", "Brown", "McColl", "Fischer", "Edwards", "Becker", "Witter", "Walker", "Lambert", "Smith", "Montgomery", "Lynch", "Roosevelt", "Lehman")
	var/list/locations = list("Earth", "Luna", "Mars", "Saturn", "Jupiter", "Uranus", "Pluto", "Europa", "Io", "Phobos", "Deimos", "Space", "Venus", "Neptune", "Mercury", "Kalliope", "Ganymede", "Callisto", "Amalthea", "Himalia", "Sybil", "Basil", "Badger", "Terry", "Artyom")
	var/list/first = list("The", "First", "Premier", "Finest", "Prime")
	var/list/company = list("Investments", "Securities", "Corporation", "Bank", "Brokerage", "& Co.", "Brothers", "& Sons", "Investement Firm", "Union", "Partners", "Capital", "Trade", "Holdings")
	for(var/i in 1 to 5)
		var/pname = ""
		switch (rand(1,5))
			if (1)
				pname = "[prob(10) ? pick(first) + " " : null][pick(names)] [pick(company)]"
			if (2)
				pname = "[pick(names)] & [pick(names)][prob(25) ? " " + pick(company) : null]"
			if (3)
				pname = "[prob(45) ? pick(first) + " " : null][pick(locations)] [pick(company)]"
			if (4)
				pname = "[prob(10) ? "The " : null][pick(names)] [pick(locations)] [pick(company)]"
			if (5)
				pname = "[prob(10) ? "The " : null][pick(fnames)] [pick(names)][prob(10) ? " " + pick(company) : null]"
		if (pname in stockBrokers)
			i--
			continue
		stockBrokers += pname

/datum/stockMarket/proc/generateDesignation(var/name)
	if (length(name) <= 4)
		return uppertext(name)
	var/list/split_name = splittext(name, " ")
	if (split_name.len >= 2)
		var/capitalised_name = ""
		for(var/string_index in 1 to min(5, split_name.len))
			capitalised_name += uppertext(ascii2text(text2ascii(split_name[string_index], 1)))
		return capitalised_name
	else
		var/capitalised_name = uppertext(ascii2text(text2ascii(name, 1)))
		for(var/string_index in 2 to length(name))
			if (prob(100 / string_index))
				capitalised_name += uppertext(ascii2text(text2ascii(name, string_index)))
		return capitalised_name

/datum/stockMarket/proc/generateStocks(var/amt = 15)
	var/list/fruits = list("Banana", "Mimana", "Watermelon", "Ambrosia", "Pomegranate", "Reishi", "Papaya", "Mango", "Tomato", "Conkerberry", "Wood", "Lychee", "Mandarin", "Harebell", "Pumpkin", "Rhubarb", "Tamarillo", "Yantok", "Ziziphus", "Oranges", "Daisy", "Kudzu")
	var/list/tech_prefix = list("Nano", "Cyber", "Funk", "Astro", "Fusion", "Tera", "Exo", "Star", "Virtual", "Plasma", "Robust", "Bit", "Future", "Hugbox", "Carbon", "Nerf", "Buff", "Nova", "Space", "Meta", "Cyber")
	var/list/tech_short = list("soft", "tech", "prog", "tec", "tek", "ware", "", "gadgets", "nics", "tric", "trasen", "tronic", "coin")
	var/list/random_nouns = list("Johnson", "Cluwne", "General", "Specific", "Master", "King", "Queen", "Table", "Rupture", "Dynamic", "Massive", "Mega", "Giga", "Certain", "Singulo", "State", "National", "International", "Interplanetary", "Sector", "Planet", "Burn", "Robust", "Exotic", "Solar", "Lunar", "Chelp", "Corgi", "Lag", "Lizard")
	var/list/company = list("Company", "Factory", "Incorporated", "Industries", "Group", "Consolidated", "GmbH", "LLC", "Ltd", "Inc.", "Association", "Limited", "Software", "Technology", "Programming", "IT Group", "Electronics", "Nanotechnology", "Farms", "Stores", "Mobile", "Motors", "Electric", "Designs", "Energy", "Pharmaceuticals", "Communications", "Wholesale", "Holding", "Health", "Machines", "Astrotech", "Gadgets", "Kinetics")
	for (var/i = 1, i <= amt, i++)
		var/datum/stock/new_stock = new
		var/sname = ""
		switch (rand(1,6))
			if(1) //                          VVVVVVVV this is a check to prevent the word from randomly showing up in game, github dont lynch us
				while (sname == "" || sname == "FAG") // honestly it's a 0.6% chance per round this happens - or once in 166 rounds - so i'm accounting for it before someone yells at me
					sname = "[consonant()][vowel()][consonant()]"
			if (2)
				sname = "[pick(tech_prefix)][pick(tech_short)][prob(20) ? " " + pick(company) : null]"
			if (3 to 4)
				var/fruit = pick(fruits)
				fruits -= fruit
				sname = "[prob(10) ? "The " : null][fruit][prob(40) ? " " + pick(company): null]"
			if (5 to 6)
				var/pname = pick(random_nouns)
				random_nouns -= pname
				switch (rand(1,3))
					if (1)
						sname = "[pname] & [pname]"
					if (2)
						sname = "[pname] [pick(company)]"
					if (3)
						sname = "[pname]"
		new_stock.name = sname
		new_stock.short_name = generateDesignation(new_stock.name)
		new_stock.current_value = rand(10, 125)
		var/rate_of_change = rand(10, 40) / 10
		new_stock.fluctuational_coefficient = prob(50) ? (1 / rate_of_change) : rate_of_change
		new_stock.average_optimism = rand(-10, 10) / 100
		new_stock.optimism = new_stock.average_optimism + (rand(-40, 40) / 100)
		new_stock.current_trend = rand(-200, 200) / 10
		new_stock.last_trend = new_stock.current_trend
		new_stock.disp_value_change = rand(-1, 1)
		new_stock.speculation = rand(-20, 20)
		new_stock.average_shares = round(rand(500, 10000) / 10)
		new_stock.outside_shareholders = rand(1000, 30000)
		new_stock.available_shares = rand(200000, 800000)
		new_stock.fluctuation_rate = rand(6, 20)
		new_stock.generateIndustry()
		new_stock.generateEvents()
		stocks += new_stock
		last_read[new_stock] = list()

/datum/stockMarket/process()
	for (var/stock in stocks)
		var/datum/stock/current_stock = stock
		current_stock.process()

/datum/stockMarket/proc/add_log(var/log_type, var/user, var/company_name, var/stocks, var/shareprice, var/money)
	var/datum/stock_log/new_stock_log = new log_type
	new_stock_log.user_name = user
	new_stock_log.company_name = company_name
	new_stock_log.stocks = stocks
	new_stock_log.shareprice = shareprice
	new_stock_log.money = money
	new_stock_log.time = time2text(world.timeofday, "hh:mm")
	logs += new_stock_log

GLOBAL_DATUM_INIT(stockExchange, /datum/stockMarket, new)

/proc/plotBarGraph(var/list/points, var/base_text, var/width=400, var/height=400)
	var/output = "<HTML><HEAD><meta charset='UTF-8'></HEAD><BODY><table style='border:1px solid black; border-collapse: collapse; width: [width]px; height: [height]px'>"
	if (points.len && height > 20 && width > 20)
		var/min = points[1]
		var/max = points[1]
		for (var/data_point in points)
			if (data_point < min)
				min = data_point
			if (data_point > max)
				max = data_point
		var/cells = (height - 20) / 20
		if (cells > round(cells))
			cells = round(cells) + 1
		var/diff = max - min
		var/ost = diff / cells
		if (min > 0)
			min = max(min - ost, 0)
		diff = max - min
		ost = diff / cells
		var/cval = max
		var/cwid = width / (points.len + 1)
		for (var/y_axis = cells, y_axis > 0, y_axis--)
			if (y_axis == cells)
				output += "<tr>"
			else
				output += "<tr style='border:none; border-top:1px solid #00ff00; height: 20px'>"
			for (var/x_axis = 0, x_axis <= points.len, x_axis++)
				if (x_axis == 0)
					output += "<td style='border:none; height: 20px; width: [cwid]px; font-size:10px; color:#00ff00; background:black; text-align:right; vertical-align:bottom'>[round(cval - ost)]</td>"
				else
					var/data_point = points[x_axis]
					if (data_point >= cval)
						output += "<td style='border:none; height: 20px; width: [cwid]px; background:#0000ff'>&nbsp;</td>"
					else
						output += "<td style='border:none; height: 20px; width: [cwid]px; background:black'>&nbsp;</td>"
			output += "</tr>"
			cval -= ost
		output += "<tr><td style='font-size:10px; height: 20px; width: 100%; background:black; color:green; text-align:center' colspan='[points.len + 1]'>[base_text]</td></tr>"
	else
		output += "<tr><td style='width:[width]px; height:[height]px; background: black'></td></tr>"
		output += "<tr><td style='font-size:10px; background:black; color:green; text-align:center'>[base_text]</td></tr>"

	return "[output]</table></BODY></HTML>"
