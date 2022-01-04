/obj/item/mod/module/storage/bluespace/boh/inert //Inert state of the BOH mod. Requires a refined bluespace core.
	name = "Inert MOD wormhole storage module"
	desc = "An inert MOD Wormhole Storage Module. Without its anomaly core, it is simply just a strangely ornate metal lattice with a circular socket in the bottom of it. With its core however, it becomes a way to store large quantities of items within a compacted bluespace wormhole, akin to a Bag of Holding."
	icon_state = "module"
	complexity = 0
	max_w_class = WEIGHT_CLASS_TINY
	max_combined_w_class = 0
	max_items = 0 //So that nothing can be stored in it, since its inactive, just like a normal BOH.

/obj/item/mod/module/storage/bluespace/boh/active //Active state of the BOH mod. Has a refined core socketed into it, making it active.
	name = "MOD wormhole storage module"
	desc = "An active MOD Wormhole Storage Module. It utilizes a refined bluespace anomaly core to create a stable bluespace wormhole inside of its lattice container, allowing mass storage of objects varying widely in size."
	icon_state = "module"
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
		playsound(src, 'sound/items/rped.ogg', 40, TRUE) //Sound feedback is cool.
	else
		to_chat(user,span_notice("That doesnt seem to fit into the [src]'s socket. It seems to be perfectly size for a refined anomaly core.."))
		return

//TECHWEB

/datum/techweb_node/bohmod
	id = "bohmod"
	display_name = "Bluespace MODsuit Storage"
	description = ""
	prereq_ids = list("bluespace_storage", "mod_advanced")
	design_ids = list(
		"bohmod",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 7500)

/datum/design/module/bohmod
	name = "MOD Module: Inert Wormhole Storage"
	desc = "An inert Wormhole Storage module."
	id = "bohmod"
	materials = list(/datum/material/gold = 3000, /datum/material/diamond = 1500, /datum/material/uranium = 250, /datum/material/bluespace = 2000)
	build_path = /obj/item/mod/module/storage/bluespace/boh/inert
	build_type = MECHFAB
