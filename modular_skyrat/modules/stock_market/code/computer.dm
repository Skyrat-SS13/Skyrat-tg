/obj/machinery/computer/stockexchange
	name = "stock exchange computer"
	icon = 'icons/obj/computer.dmi'
	icon_state = "oldcomp"
	icon_screen = "stock_computer"
	icon_keyboard = "no_keyboard"
	var/logged_in = "Cargo Department"
	var/vmode = 1
	circuit = /obj/item/circuitboard/computer/stockexchange

	light_color = LIGHT_COLOR_GREEN

	connectable = FALSE //connecting_computer change: since icon_state is not a typical console, it cannot be connectable.

/obj/machinery/computer/stockexchange/Initialize()
	. = ..()
	logged_in = "SS13 Cargo Department"

/obj/machinery/computer/stockexchange/proc/balance()
	var/datum/bank_account/dept_account = SSeconomy.get_dep_account(ACCOUNT_CAR)
	if (!logged_in)
		return 0
	return dept_account.account_balance

/obj/machinery/computer/stockexchange/attack_ai(mob/user)
	return attack_hand(user)

/obj/machinery/computer/stockexchange/attack_robot(mob/user)
	return attack_hand(user)

/obj/machinery/computer/stockexchange/attack_hand(var/mob/user)
	if(..())
		return
	user.machine = src

	var/css={"<style>
.change {
	font-weight: bold;
	font-family: monospace;
}
.up {
	background: #00a000;
}
.down {
	background: #a00000;
}
.stable {
	width: 100%
	border-collapse: collapse;
	border: 1px solid #305260;
	border-spacing: 4px 4px;
}
.stable td, .stable th {
	border: 1px solid #305260;
	padding: 0px 3px;
}
.bankrupt {
	border: 1px solid #a00000;
	background: #a00000;
}

a.updated {
	color: red;
}
</style>"}
	var/dat = "<html><head><title>[station_name()] Stock Exchange</title>[css]</head><body>"

	dat += "<span class='user'>Welcome, <b>[station_name()] Cargo Department</b></span><br><span class='balance'><b>Credits:</b> [balance()] </span><br>"
	for (var/datum/stock/last_stock in GLOB.stockExchange.last_read)
		var/list/last_read_stock = GLOB.stockExchange.last_read[last_stock]
		if (!(logged_in in last_read_stock))
			last_read_stock[logged_in] = 0
	dat += "<b>View mode:</b> <a href='?src=[REF(src)];cycleview=1'>[vmode ? "Compact" : "Full"]</a> "
	dat += "<b>Stock Transaction Log:</b> <a href='?src=[REF(src)];show_logs=1'>Check</a><br>"

	dat += "<h3>Listed stocks</h3>"

	if (vmode == 0)
		for (var/datum/stock/current_stock in GLOB.stockExchange.stocks)
			var/mystocks = 0
			if (logged_in && (logged_in in current_stock.shareholders))
				mystocks = current_stock.shareholders[logged_in]
			dat += "<hr /><div class='stock'><span class='company'>[current_stock.name]</span> <span class='s_company'>([current_stock.short_name])</span>[current_stock.bankrupt ? " <b style='color:red'>BANKRUPT</b>" : null]<br>"
			if (current_stock.last_unification)
				dat += "<b>Unified shares</b> [DisplayTimeText(world.time - current_stock.last_unification)] ago.<br>"
			dat += "<b>Current value per share:</b> [current_stock.current_value] | <a href='?src=[REF(src)];viewhistory=[REF(current_stock)]'>View history</a><br><br>"
			dat += "You currently own <b>[mystocks]</b> shares in this company. There are [current_stock.available_shares] purchasable shares on the market currently.<br>"
			if (current_stock.bankrupt)
				dat += "You cannot buy or sell shares in a bankrupt company!<br><br>"
			else
				dat += "<a href='?src=[REF(src)];buyshares=[REF(current_stock)]'>Buy shares</a> | <a href='?src=[REF(src)];sellshares=[REF(current_stock)]'>Sell shares</a><br><br>"
			dat += "<b>Prominent products:</b><br>"
			for (var/prod in current_stock.products)
				dat += "<i>[prod]</i><br>"
			var/news = 0
			if (logged_in)
				var/list/last_read_stock = GLOB.stockExchange.last_read[current_stock]
				var/last_read_time = last_read_stock[logged_in]
				for (var/datum/article/current_article in current_stock.articles)
					if (current_article.ticks > last_read_time)
						news = 1
						break
				if (!news)
					for (var/datum/stockEvent/current_stock_event in current_stock.events)
						if (current_stock_event.last_change > last_read_time && !current_stock_event.hidden)
							news = 1
							break
			dat += "<a href='?src=[REF(src)];archive=[REF(current_stock)]'>View news archives</a>[news ? " <span style='color:red'>(updated)</span>" : null]</div>"
	else if (vmode == 1)
		dat += "<b>Actions:</b> + Buy, - Sell, (A)rchives, (H)istory<br><br>"
		dat += "<table class='stable'>"
		dat += "<tr><th>&nbsp;</th><th>ID</th><th>Name</th><th>Value</th><th>Owned</th><th>Avail</th><th>Actions</th></tr>"

		for (var/datum/stock/current_stock in GLOB.stockExchange.stocks)
			var/mystocks = 0
			if (logged_in && (logged_in in current_stock.shareholders))
				mystocks = current_stock.shareholders[logged_in]

			if(current_stock.bankrupt)
				dat += "<tr class='bankrupt'>"
			else
				dat += "<tr>"

			if(current_stock.disp_value_change > 0)
				dat += "<td class='change up'>+</td>"
			else if(current_stock.disp_value_change < 0)
				dat += "<td class='change down'>-</td>"
			else
				dat += "<td class='change'>=</td>"

			dat += "<td><b>[current_stock.short_name]</b></td>"
			dat += "<td>[current_stock.name]</td>"

			if(!current_stock.bankrupt)
				dat += "<td>[current_stock.current_value]</td>"
			else
				dat += "<td>0</td>"

			if(mystocks)
				dat += "<td><b>[mystocks]</b></td>"
			else
				dat += "<td>0</td>"

			dat += "<td>[current_stock.available_shares]</td>"
			var/news = 0
			if (logged_in)
				var/list/last_read_stock = GLOB.stockExchange.last_read[current_stock]
				var/last_read_time = last_read_stock[logged_in]
				for (var/datum/article/current_article in current_stock.articles)
					if (current_article.ticks > last_read_time)
						news = 1
						break
				if (!news)
					for (var/datum/stockEvent/current_stock_event in current_stock.events)
						if (current_stock_event.last_change > last_read_time && !current_stock_event.hidden)
							news = 1
							break
			dat += "<td>"
			if (current_stock.bankrupt)
				dat += "<span class='linkOff'>+</span> <span class='linkOff'>-</span> "
			else
				dat += "<a href='?src=[REF(src)];buyshares=[REF(current_stock)]'>+</a> <a href='?src=[REF(src)];sellshares=[REF(current_stock)]'>-</a> "
			dat += "<a href='?src=[REF(src)];archive=[REF(current_stock)]' class='[news ? "updated" : "default"]'>(A)</a> <a href='?src=[REF(src)];viewhistory=[REF(current_stock)]'>(H)</a></td>"

			dat += "</tr>"

		dat += "</table>"

	dat += "</body></html>"
	var/datum/browser/popup = new(user, "computer", "Stock Exchange", 600, 600)
	popup.set_content(dat)
	popup.open()
	return

/obj/machinery/computer/stockexchange/proc/sell_some_shares(var/datum/stock/current_stock, var/mob/user)
	if (!user || !current_stock)
		return
	var/user_logged_in = logged_in
	if (!user_logged_in)
		to_chat(user, "<span class='danger'>No active account on the console!</span>")
		return
	var/datum/bank_account/dept_account = SSeconomy.get_dep_account(ACCOUNT_CAR)
	var/dept_account_balance = dept_account.account_balance
	var/avail = current_stock.shareholders[logged_in]
	if (!avail)
		to_chat(user, "<span class='danger'>This account does not own any shares of [current_stock.name]!</span>")
		return
	var/price = current_stock.current_value
	var/amt = round(input(user, "How many shares? \n(Have: [avail], unit price: [price])", "Sell shares in [current_stock.name]", 0) as num|null)
	amt = min(amt, current_stock.shareholders[logged_in])

	if (!user || (!(user in range(1, src)) && iscarbon(user)))
		return
	if (!amt)
		return
	if (user_logged_in != logged_in)
		return
	dept_account_balance = dept_account.account_balance
	if (!isnum(dept_account_balance))
		to_chat(user, "<span class='danger'>No active account on the console!</span>")
		return

	var/total = amt * current_stock.current_value
	if (!current_stock.sellShares(logged_in, amt))
		to_chat(user, "<span class='danger'>Could not complete transaction.</span>")
		return
	to_chat(user, "<span class='notice'>Sold [amt] shares of [current_stock.name] at [current_stock.current_value] a share for [total] credits.</span>")
	GLOB.stockExchange.add_log(/datum/stock_log/sell, user.name, current_stock.name, amt, current_stock.current_value, total)

/obj/machinery/computer/stockexchange/proc/buy_some_shares(var/datum/stock/current_stock, var/mob/user)
	if (!user || !current_stock)
		return
	var/user_logged_in = logged_in
	if (!user_logged_in)
		to_chat(user, "<span class='danger'>No active account on the console!</span>")
		return
	var/dept_account_balance = balance()
	if (!isnum(dept_account_balance))
		to_chat(user, "<span class='danger'>No active account on the console!</span>")
		return
	var/avail = current_stock.available_shares
	var/price = current_stock.current_value
	var/canbuy = round(dept_account_balance / price)
	var/amt = round(input(user, "How many shares? \n(Available: [avail], unit price: [price], can buy: [canbuy])", "Buy shares in [current_stock.name]", 0) as num|null)
	if (!user || (!(user in range(1, src)) && iscarbon(user)))
		return
	if (user_logged_in != logged_in)
		return
	dept_account_balance = balance()
	if (!isnum(dept_account_balance))
		to_chat(user, "<span class='danger'>No active account on the console!</span>")
		return

	amt = min(amt, current_stock.available_shares, round(dept_account_balance / current_stock.current_value))
	if (!amt)
		return
	if (!current_stock.buyShares(logged_in, amt))
		to_chat(user, "<span class='danger'>Could not complete transaction.</span>")
		return

	var/total = amt * current_stock.current_value
	to_chat(user, "<span class='notice'>Bought [amt] shares of [current_stock.name] at [current_stock.current_value] a share for [total] credits.</span>")
	GLOB.stockExchange.add_log(/datum/stock_log/buy, user.name, current_stock.name, amt, current_stock.current_value,  total)

/obj/machinery/computer/stockexchange/proc/do_borrowing_deal(var/datum/borrow/borrow_deal, var/mob/user)
	if (borrow_deal.stock.borrow(borrow_deal, logged_in))
		to_chat(user, "<span class='notice'>You successfully borrowed [borrow_deal.share_amount] shares. Deposit: [borrow_deal.deposit].</span>")
		GLOB.stockExchange.add_log(/datum/stock_log/borrow, user.name, borrow_deal.stock.name, borrow_deal.share_amount, borrow_deal.deposit)
	else
		to_chat(user, "<span class='danger'>Could not complete transaction. Check your account balance.</span>")

/obj/machinery/computer/stockexchange/Topic(href, href_list)
	if (..())
		return 1

	if (!usr || (!(usr in range(1, src)) && iscarbon(usr)))
		usr.machine = src

	if (href_list["viewhistory"])
		var/datum/stock/stock_history = locate(href_list["viewhistory"]) in GLOB.stockExchange.stocks
		if (stock_history)
			stock_history.displayValues(usr)

	if (href_list["logout"])
		logged_in = null

	if (href_list["buyshares"])
		var/datum/stock/avail_stocks = locate(href_list["buyshares"]) in GLOB.stockExchange.stocks
		if (avail_stocks)
			buy_some_shares(avail_stocks, usr)

	if (href_list["sellshares"])
		var/datum/stock/avail_stocks = locate(href_list["sellshares"]) in GLOB.stockExchange.stocks
		if (avail_stocks)
			sell_some_shares(avail_stocks, usr)

	if (href_list["show_logs"])
		var/dat = "<html><head><title>Stock Transaction Logs</title></head><body><h2>Stock Transaction Logs</h2><div><a href='?src=[REF(src)];show_logs=1'>Refresh</a></div><br>"
		for(var/stock_logs in GLOB.stockExchange.logs)
			var/datum/stock_log/current_stock_log = stock_logs
			if(istype(current_stock_log, /datum/stock_log/buy))
				dat += "[current_stock_log.time] | <b>[current_stock_log.user_name]</b> bought <b>[current_stock_log.stocks]</b> stocks at [current_stock_log.shareprice] a share for <b>[current_stock_log.money]</b> total credits in <b>[current_stock_log.company_name]</b>.<br>"
				continue
			if(istype(current_stock_log, /datum/stock_log/sell))
				dat += "[current_stock_log.time] | <b>[current_stock_log.user_name]</b> sold <b>[current_stock_log.stocks]</b> stocks at [current_stock_log.shareprice] a share for <b>[current_stock_log.money]</b> total credits from <b>[current_stock_log.company_name]</b>.<br>"
				continue
			if(istype(current_stock_log, /datum/stock_log/borrow))
				dat += "[current_stock_log.time] | <b>[current_stock_log.user_name]</b> borrowed <b>[current_stock_log.stocks]</b> stocks with a deposit of <b>[current_stock_log.money]</b> credits in <b>[current_stock_log.company_name]</b>.<br>"
				continue
		var/datum/browser/popup = new(usr, "stock_logs", "Stock Transaction Logs", 600, 400)
		popup.set_content(dat)
		popup.open()

	if (href_list["archive"])
		var/datum/stock/stock_archive = locate(href_list["archive"])
		if (logged_in && logged_in != "")
			var/list/last_read_stock = GLOB.stockExchange.last_read[stock_archive]
			last_read_stock[logged_in] = world.time
		var/dat = "<html><head><title>News feed for [stock_archive.name]</title></head><body><h2>News feed for [stock_archive.name]</h2><div><a href='?src=[REF(src)];archive=[REF(stock_archive)]'>Refresh</a></div>"
		dat += "<div><h3>Events</h3>"
		var/p = 0
		for (var/datum/stockEvent/stock_event in stock_archive.events)
			if (stock_event.hidden)
				continue
			if (p > 0)
				dat += "<hr>"
			dat += "<div><b style='font-size:1.25em'>[stock_event.current_title]</b><br>[stock_event.current_desc]</div>"
			p++
		dat += "</div><hr><div><h3>Articles</h3>"
		p = 0
		for (var/datum/article/stock_article in stock_archive.articles)
			if (p > 0)
				dat += "<hr>"
			dat += "<div><b style='font-size:1.25em'>[stock_article.headline]</b><br><i>[stock_article.subtitle]</i><br><br>[stock_article.article]<br>- [stock_article.author], [stock_article.spacetime] (via <i>[stock_article.outlet]</i>)</div>"
			p++
		dat += "</div></body></html>"
		var/datum/browser/popup = new(usr, "archive_[stock_archive.name]", "Stock News", 600, 400)
		popup.set_content(dat)
		popup.open()

	if (href_list["cycleview"])
		vmode++
		if (vmode > 1)
			vmode = 0

	src.add_fingerprint(usr)
	src.updateUsrDialog()
