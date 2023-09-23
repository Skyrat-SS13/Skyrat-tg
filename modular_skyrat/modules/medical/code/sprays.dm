/obj/item/reagent_containers/spray/hercuri/chilled
	name = "chilled hercuri spray" // effective at cooling low-temperature burns but also is more efficienct at cooling high-temperature
	desc = "A medical spray bottle. This one contains hercuri, a medicine used to negate the effects of dangerous high-temperature environments. \
	This one comes pre-chilled, making it especially good at cooling synthetic burns! \n\
	It has a bold warning label near the nozzle: <b>ONLY USE IN EMERGENCIES! WILL CAUSE FREEZING!</b>"
	var/starting_temperature = 100

/obj/item/reagent_containers/spray/hercuri/chilled/add_initial_reagents()
	. = ..()

	reagents.chem_temp = starting_temperature
