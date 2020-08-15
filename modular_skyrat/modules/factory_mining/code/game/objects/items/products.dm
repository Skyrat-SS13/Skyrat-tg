/obj/item/stack/factory/products
	name = "parent product"
	desc = "debug item. should not have."
	icon = 'modular_skyrat/modules/factory_mining/icons/obj/products.dmi'

	var/sell_price = 0
	var/research_price = 0
	var/ore_type = "iron"
	var/product_type = "gear"

	var/ore_multiplyer = 1
	var/product_multiplyer = 1

	novariants = FALSE

/obj/item/stack/factory/products/merge(obj/item/stack/S)
	if(istype(S, /obj/item/stack/factory/products))
		var/obj/item/stack/factory/products/P = S
		if(ore_type != P.ore_type || product_type != P.product_type)
			return
	. = ..()
	update_product()
	update_icon_state()

/obj/item/stack/factory/products/change_stack(mob/user, amount)
	. = ..()
	update_product()
	update_icon_state()

/obj/item/stack/factory/products/AltClick(mob/living/user)
	. = ..()
	update_product()
	update_icon_state()

/obj/item/stack/factory/products/copy_evidences(obj/item/stack/from)
	. = ..()
	update_product()
	update_icon_state()


/obj/item/stack/factory/products/update_icon_state()
	if(novariants)
		return
	if(amount <= (max_amount / 2))
		icon_state = "[ore_type]_[product_type]"
	else
		icon_state = "[ore_type]_[product_type]_stack"

/obj/item/stack/factory/products/proc/update_product()
	if(ore_type && product_type)
		switch(ore_type)
			if("iron")
				ore_multiplyer = 1
			if("glass")
				ore_multiplyer = 1
			if("plasma")
				ore_multiplyer = 20
			if("silver")
				ore_multiplyer = 20
			if("titanium")
				ore_multiplyer = 20
			if("gold")
				ore_multiplyer = 20
			if("uranium")
				ore_multiplyer = 20
			if("bluespace")
				ore_multiplyer = 30
			if("diamond")
				ore_multiplyer = 25
			if("bananium")
				ore_multiplyer = 50
		name = "[ore_type] [product_type]"
		desc = "A [ore_type] made of [product_type]."
		icon_state = "[ore_type]_[product_type]"
		sell_price = ore_multiplyer * product_multiplyer
		research_price = ore_multiplyer * product_multiplyer

/obj/item/stack/factory/products/coil
	product_type = "coil"
	product_multiplyer = 12

/obj/item/stack/factory/products/plate
	product_type = "plate"
	product_multiplyer = 6

/obj/item/stack/factory/products/rim
	product_type = "rim"
	product_multiplyer = 12

/obj/item/stack/factory/products/gear
	product_type = "gear"
	product_multiplyer = 18

/obj/item/stack/factory/products/rod
	product_type = "rod"
	product_multiplyer = 6

/obj/item/stack/factory/products/fabric
	product_type = "fabric"
	product_multiplyer = 18
