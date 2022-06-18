/obj/machinery/vending
	/// Additions to the `products` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/skyrat_products
	/// Additions to the `premium` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/skyrat_premium
	/// Additions to the `contraband` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/skyrat_contraband

/obj/machinery/vending/Initialize(mapload)
	if(skyrat_products)
		products += skyrat_products
	if(skyrat_premium)
		premium += skyrat_premium
	if(skyrat_contraband)
		contraband += skyrat_contraband
	
	/// Time to make clothes amounts consistent!
	for (var/item in products)
		if(products[item] < 5 && ispath(item, /obj/item/clothing) && skyrat_IsNotGameplay(item))
			products[item] = 5
	for (var/item in premium)
		if(premium[item] < 5 && ispath(item, /obj/item/clothing) && skyrat_IsNotGameplay(item))
			premium[item] = 5
			
	QDEL_NULL(skyrat_products)
	QDEL_NULL(skyrat_premium)
	QDEL_NULL(skyrat_contraband)
	return ..()

/obj/machinery/vending/proc/skyrat_IsNotGameplay(var/obj/item/clothing/clothing)
	var/list/traits = new clothing().clothing_traits

	if(TRAIT_CHUNKYFINGERS in traits)
		return FALSE
	if(TRAIT_FASTMED in traits)
		return FALSE
	if(TRAIT_QUICK_CARRY in traits)
		return FALSE
	if(TRAIT_QUICKER_CARRY in traits)
		return FALSE
	if(ispath(clothing, /obj/item/clothing/suit/armor))
		return FALSE
	if(ispath(clothing, /obj/item/clothing/head/helmet))
		return FALSE
	if(ispath(clothing, /obj/item/clothing/gloves/tackler))
		return FALSE
	return TRUE
