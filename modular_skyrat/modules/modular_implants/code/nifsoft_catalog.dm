GLOBAL_LIST_INIT(available_nifsofts, list(
	/datum/nifsoft/hivemind,
	/datum/nifsoft/summoner,
	/datum/nifsoft/shapeshifter,
))

/obj/item/nifsoft_catalog
	name = "NIFSoft Catalog"
	desc = "A virtual tablet that displays avalible NIFSofts and other NIF products."
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/devices.dmi'
	icon_state = "nifsoft_remover"
	///Who is currently using the catalog?
	var/datum/weakref/current_user
	///Are products free from the catalog? This is so ghost roles can get NIFSofts for free.
	var/unlocked = FALSE

/obj/item/nifsoft_catalog/pickup(mob/user)
	. = ..()
	current_user = user

/obj/item/nifsoft_catalog/dropped(mob/user, silent)
	. = ..()
	current_user = null

///Checks to see if the user has a NIF, if so, it is returned
/obj/item/nifsoft_catalog/proc/get_installed_nif()
	var/mob/living/carbon/human/nif_user = current_user
	if(!nif_user)
		return FALSE

	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif = nif_user.getorgan(/obj/item/organ/internal/cyberimp/brain/nif)
	if(!installed_nif)
		return FALSE

	return installed_nif

///Attemps to see if the nifsoft_to_purchase can be purchased
/obj/item/nifsoft_catalog/proc/check_nifsoft_purchase(datum/nifsoft/nifsoft_to_purchase)
	var/mob/living/carbon/human/user = current_user
	if(!user)
		return FALSE

	var/obj/item/card/id/id_card = user.get_idcard(TRUE)
	if(!id_card || !id_card.registered_account || !id_card.registered_account.account_job)
		balloon_alert(user, "There is no account to draw from!")
		return FALSE

	var/datum/bank_account/user_bank_account = id_card.registered_account
	if(!user_bank_account || !user_bank_account.has_money(initial(nifsoft_to_purchase.purchase_price)))
		balloon_alert(user, "You lack the funds to purchase this item!")
		return FALSE

//TGUI STUFF
/obj/item/nifsoft_catalog/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)

	if(!ui)
		ui = new(user, src, "NifsoftCatalog", name)
		ui.open()

/obj/item/nifsoft_catalog/ui_static_data(mob/user)
	var/list/data = list()
	var/list/product_list = list()


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

/obj/item/nifsoft_catalog/ui_data(mob/user)
	var/list/data = list()
	var/mob/living/carbon/human/catalog_user = current_user

	data["current_user"] = catalog_user

	return data

/obj/item/nifsoft_catalog/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	switch(action)
		if("purchase_product")
			var/product_to_buy = text2path(params["product_to_buy"])
			if(!product_to_buy || !current_user)
				return FALSE

			if(ispath(product_to_buy, /datum/nifsoft))
				var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif = get_installed_nif()
				if(!installed_nif)
					return FALSE

				var/datum/nifsoft/nifsoft_to_buy = locate(product_to_buy) in GLOB.available_nifsofts

				if(!nifsoft_to_buy || (attempt_charge(src, current_user, params["product_price"]) & COMPONENT_OBJ_CANCEL_CHARGE))
					return FALSE

				new nifsoft_to_buy(installed_nif)
				return TRUE
