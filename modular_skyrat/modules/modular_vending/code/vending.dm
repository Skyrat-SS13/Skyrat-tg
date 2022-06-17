/obj/machinery/vending
	/// Additions to the `products` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/skyrat_products
	/// Additions to the `premium` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/skyrat_premium
	/// Additions to the `contraband` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/skyrat_contraband
	/// If this is set, it will set all product amounts to be this number on initialize. Intended for use on !!clothing only vendors!!.
	var/skyrat_amount_override

/obj/machinery/vending/Initialize(mapload)
	if(skyrat_products)
		products += skyrat_products
	if(skyrat_premium)
		premium += skyrat_premium
	if(skyrat_contraband)
		contraband += skyrat_contraband
	if(skyrat_amount_override)
		for (var/item in products)
			products[item] = skyrat_amount_override
		for (var/item in premium)
			premium[item] = skyrat_amount_override
			
	QDEL_NULL(skyrat_products)
	QDEL_NULL(skyrat_premium)
	QDEL_NULL(skyrat_contraband)
	return ..()

