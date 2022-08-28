//the suit voucher
/obj/item/suit_voucher
	name = "suit voucher"
	desc = "A token to redeem a new suit. Use it on a mining equipment vendor."
	icon = 'icons/obj/mining.dmi'
	icon_state = "mining_voucher"
	w_class = WEIGHT_CLASS_TINY


//Code to redeem new items at the mining vendor using the suit voucher
//More items can be added in the lists and in the if statement.
/obj/machinery/mineral/equipment_vendor/proc/RedeemSVoucher(obj/item/suit_voucher/voucher, mob/redeemer)
	var/items = list("SEVA suit" = image(icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi', icon_state = "seva"),
					 "Explorer suit" = image(icon = 'icons/obj/clothing/suits/utility.dmi', icon_state = "explorer"))

	var/selection = show_radial_menu(redeemer, src, items, require_near = TRUE, tooltips = TRUE)
	if(!selection || !Adjacent(redeemer) || QDELETED(voucher) || voucher.loc != redeemer)
		return
	var/drop_location = drop_location()
	switch(selection)
		if("SEVA suit")
			new /obj/item/clothing/suit/hooded/seva(drop_location)
			new /obj/item/clothing/mask/gas/seva(drop_location)
		if("Explorer suit")
			new /obj/item/clothing/suit/hooded/explorer(drop_location)
			new /obj/item/clothing/mask/gas/explorer(drop_location)

	SSblackbox.record_feedback("tally", "suit_voucher_redeemed", 1, selection)
	qdel(voucher)
