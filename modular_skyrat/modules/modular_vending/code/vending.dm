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

	skyrat_products = null
	skyrat_premium = null
	skyrat_contraband = null
	return ..()

