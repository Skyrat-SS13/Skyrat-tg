/obj/item/key/gateway
	name = "\improper gateway key"
	desc = "description"
	resistance_flags = INDESTRUCTIBLE
	var/datum/gateway_destination/target
	var/use_once = TRUE
	var/used = FALSE
	var/inactive_gateway_only = TRUE

/obj/item/key/gateway/home
	name = "\improper Global Recall Key"
	desc = "Recall to the Global Gateway."

/obj/item/key/gateway/home/Initialize()
	. = ..()
	target = GLOB.the_gateway.destination

/obj/item/key/gateway/pre_attack(atom/A, mob/living/user, params)
	if(src.used && !src.use_once)
		return
	if(istype(A,/obj/machinery/gateway))
		var/obj/machinery/gateway/gate = A
		if(gate.target)
			if(src.inactive_gateway_only)
				return
			gate.deactivate()
		gate.activate(src.target)
		src.used = TRUE
	else return ..()
