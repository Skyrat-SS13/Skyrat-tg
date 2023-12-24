GLOBAL_LIST_INIT(purchasable_nifsofts, list(
	/datum/nifsoft/hivemind,
	/datum/nifsoft/summoner,
	/datum/nifsoft/action_granter/shapeshifter,
	/datum/nifsoft/summoner/dorms,
	/datum/nifsoft/soul_poem,
	/datum/nifsoft/soulcatcher,
	/datum/nifsoft/scryer,
	/datum/nifsoft/summoner/book,
	/datum/nifsoft/action_granter/hypnosis,
))

/datum/computer_file/program/nifsoft_downloader
	filename = "nifsoftcatalog"
	filedesc = "NIFSoft Catalog"
	extended_desc = "A virtual storefront that allows the user to install NIFSofts and purchase various NIF related products"
	downloader_category = PROGRAM_CATEGORY_DEVICE
	size = 3
	tgui_id = "NtosNifsoftCatalog"
	program_icon = "bag-shopping"
	usage_flags = PROGRAM_PDA
	///What bank account is money being drawn out of?
	var/datum/bank_account/paying_account
	///What NIF are the NIFSofts being sent to?
	var/datum/weakref/target_nif

/datum/computer_file/program/nifsoft_downloader/Destroy(force)
	paying_account = null
	target_nif = null

	return ..()

//TGUI STUFF

/datum/computer_file/program/nifsoft_downloader/ui_data(mob/user)
	var/list/data = list()

	paying_account = computer.computer_id_slot?.registered_account || null
	data["paying_account"] = paying_account
	data["current_balance"] = computer.computer_id_slot?.registered_account?.account_balance

	var/rewards_points = 0

	if(target_nif)
		var/obj/item/organ/internal/cyberimp/brain/nif/buyer_nif = target_nif.resolve()
		if(buyer_nif)
			rewards_points = buyer_nif.rewards_points

	data["rewards_points"] = rewards_points
	return data

/datum/computer_file/program/nifsoft_downloader/ui_static_data(mob/user)
	var/list/data = list()
	var/list/product_list = list()

	var/mob/living/carbon/human/nif_user = user
	if(!ishuman(nif_user))
		target_nif = null

	else
		var/obj/item/organ/internal/cyberimp/brain/nif/user_nif = nif_user.get_organ_by_type(/obj/item/organ/internal/cyberimp/brain/nif)
		if(!user_nif)
			target_nif = null

		if(!target_nif || user_nif != target_nif.resolve())
			target_nif = WEAKREF(user_nif)

	data["target_nif"] = target_nif

	for(var/datum/nifsoft/buyable_nifsoft as anything in GLOB.purchasable_nifsofts)
		if(!buyable_nifsoft)
			continue
		if(initial(buyable_nifsoft.lewd_nifsoft) && CONFIG_GET(flag/disable_lewd_items))
			continue

		var/list/nifsoft_details = list(
			"name" = initial(buyable_nifsoft.name),
			"desc" = initial(buyable_nifsoft.program_desc),
			"price" = initial(buyable_nifsoft.purchase_price),
			"rewards_points_rate" = initial(buyable_nifsoft.rewards_points_rate),
			"points_purchasable" = initial(buyable_nifsoft.rewards_points_eligible),
			"category" = initial(buyable_nifsoft.buying_category),
			"ui_icon" = initial(buyable_nifsoft.ui_icon),
			"reference" = buyable_nifsoft,
			"keepable" = initial(buyable_nifsoft.able_to_keep),
		)
		var/category = nifsoft_details["category"]
		if(!(category in product_list))
			product_list[category] += (list(name = category, products = list()))

		product_list[category]["products"] += list(nifsoft_details)

	for(var/product_category in product_list)
		data["product_list"] += list(product_list[product_category])

	return data

/datum/computer_file/program/nifsoft_downloader/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	switch(action)
		if("purchase_product")
			var/datum/nifsoft/product_to_buy = text2path(params["product_to_buy"])
			if(!product_to_buy || !paying_account)
				return FALSE

			var/amount_to_charge = (params["product_cost"])
			var/rewards_purchase = (params["rewards_purchase"])
			var/obj/item/organ/internal/cyberimp/brain/nif/buyer_nif = target_nif.resolve()

			if(rewards_purchase)
				if(buyer_nif.rewards_points < amount_to_charge)
					buyer_nif.send_message("You don't have enough reward points to buy this.", alert = TRUE)
					return FALSE

			else if(!paying_account.has_money(amount_to_charge))
				paying_account.bank_card_talk("You lack the money to make this purchase.")
				return FALSE

			if(!ispath(product_to_buy, /datum/nifsoft) || !buyer_nif)
				paying_account.bank_card_talk("You are unable to buy this.")
				return FALSE

			var/datum/nifsoft/installed_nifsoft = new product_to_buy(buyer_nif, rewards_purchase)
			if(!installed_nifsoft.parent_nif)
				paying_account.bank_card_talk("Install failed, your purchase has been refunded.")
				return FALSE

			if(rewards_purchase)
				buyer_nif.remove_rewards_points(amount_to_charge)
				buyer_nif.send_message("Purchase completed, [amount_to_charge] reward points have been removed from your NIF")
			else
				paying_account.adjust_money(-amount_to_charge, "NIFSoft purchase")
				paying_account.bank_card_talk("Transaction complete, you have been charged [amount_to_charge]cr.")

			return TRUE
