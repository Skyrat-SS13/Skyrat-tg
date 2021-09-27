/obj/machinery/vending
	var/list/skyrat_products
	var/list/skyrat_premium
	var/list/skyrat_contraband

/obj/machinery/vending/Initialize(mapload)
	if(skyrat_products)
		products += skyrat_products
	if(skyrat_premium)
		premium += skyrat_premium
	if(skyrat_contraband)
		contraband += skyrat_contraband
	return ..()

