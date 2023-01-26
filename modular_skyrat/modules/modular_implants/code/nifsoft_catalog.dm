GLOBAL_LIST_INIT(available_nifsofts, list(
	/datum/nifsoft/hivemind,
	/datum/nifsoft/summoner,
	/datum/nifsoft/shapeshifter,
))

/datum/computer_file/program/nifsoft_downloader
	filename = "nifsoftcatalog"
	filedesc = "NIFSoft Catalog"
	extended_desc = "A virtual storefront that allows the user to install NIFSofts and purchase various NIF related products"
	category = PROGRAM_CATEGORY_MISC
	size = 3
	tgui_id = "NtosNifsoftCatalog"
	program_icon = "bag-shopping"
	usage_flags = PROGRAM_TABLET
	///What bank account is money being drawn out of?
	var/datum/bank_account/paying_account
	///What NIF are the NIFSofts being sent to?
	var/datum/weakref/target_nif

/datum/computer_file/program/nifsoft_downloader/Destroy(force)
	. = ..()
	paying_account = null
	target_nif = null

//TGUI STUFF

/datum/computer_file/program/nifsoft_downloader/ui_data(mob/user)
	var/list/data = list()

	paying_account = computer.computer_id_slot?.registered_account || null
	data["paying_account"] = paying_account

	return data

/datum/computer_file/program/nifsoft_downloader/ui_static_data(mob/user)
	var/list/data = get_header_data()
	var/list/product_list = list()

	var/mob/living/carbon/human/nif_user = user
	if(nif_user)
		var/obj/item/organ/internal/cyberimp/brain/nif/user_nif = nif_user.getorgan(/obj/item/organ/internal/cyberimp/brain/nif)
		if(user_nif)
			target_nif = user_nif
		else
			target_nif = null

	data["target_nif"] = target_nif

	for(var/nifsoft in GLOB.available_nifsofts)
		var/datum/nifsoft/buyable_nifsoft = nifsoft
		if(!buyable_nifsoft)
			continue

		var/list/nifsoft_details = list(
			"name" = initial(buyable_nifsoft.name),
			"desc" = initial(buyable_nifsoft.program_desc),
			"price" = initial(buyable_nifsoft.purchase_price),
			"category" = initial(buyable_nifsoft.buying_category),
			"reference" = buyable_nifsoft
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
			var/product_to_buy = text2path(params["product_to_buy"])
			if(!product_to_buy || !paying_account)
				return FALSE

			if(!paying_account.has_money(params["product_cost"]))
				paying_account.bank_card_talk("You lack the money to make this purchase.")

			if(!ispath(product_to_buy, /datum/nifsoft) || !target_nif)
				return FALSE

			var/datum/nifsoft/installed_nifsoft = new product_to_buy(target_nif)
			if(!installed_nifsoft.parent_nif)
				paying_account.bank_card_talk("Install failed, your purchase has been refunded.")
				return FALSE

			paying_account.adjust_money(params["product_cost"], "NIFSoft purchase")
			paying_account.bank_card_talk("Transaction complete, you have been charged [params["product_cost"]].")

			return TRUE
