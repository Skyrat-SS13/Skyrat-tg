/obj/item/mod/module/storage/bluespace/boh/inert //Inert state of the BOH mod. Requires a refined bluespace core.
	name = "Inert MOD wormhole storage module"
	desc = "placeholderdesc"
	icon_state = "module" //placeholder
	complexity = 0
	max_w_class = WEIGHT_CLASS_TINY
	max_combined_w_class = 0
	max_items = 0 //So that nothing can be stored in it, since its inactive, just like a normal BOH.

/obj/item/mod/module/storage/bluespace/boh/active //Active state of the BOH mod. Has a refined core socketed into it, making it active.
	name = "MOD wormhole storage module"
	desc = "placeholderdesc"
	icon_state = "storage_large"
	complexity = 5 //may be reasonable? unsure yet. The stock storage module has a complexity of 3.
	max_w_class = WEIGHT_CLASS_GIGANTIC
	max_combined_w_class = 35 //Same as a BOH. Maybe slightly less would be better? To be seen.
	max_items = 21 //Unsure if this is required or not but I will tag it in anyway.

/obj/item/mod/module/storage/bluespace/boh/inert/attackby(obj/item/weapon, mob/living/user, params)
	. = ..()
	if(istype(weapon, /obj/item/assembly/signaler/anomaly/bluespace))
		var/obj/item/assembly/signaler/anomaly/anomaly = weapon
		var/result_path = /obj/item/mod/module/storage/bluespace/boh/active
		to_chat(user, span_notice("You insert [anomaly] into the [src]'s socket, and the module gently hums to life."))
		new result_path(get_turf(src))
		qdel(src)
		qdel(anomaly)
	else
		to_chat(user,span_notice("That doesnt seem to fit into the [src]'s socket. It seems to be perfectly size for a refined anomaly core.."))
		return
