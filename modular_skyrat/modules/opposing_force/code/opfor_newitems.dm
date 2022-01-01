//Use this to add item variation ideas for now?

/obj/item/uplink/opfor
	name = "old radio"
	desc = "A dusty and old looking radio."

/obj/item/uplink/old/Initialize(mapload, owner, tc_amount = 0)
	. = ..()
	var/datum/component/uplink/hidden_uplink = GetComponent(/datum/component/uplink)
	hidden_uplink.name = "old radio"



/obj/item/reagent_containers/glass/rag/sus
    volume = 30
    amount_per_transfer_from_this = 30
    desc = "A damp rag made from a highly absorbant materials. Can hold up to 30u liquids. You can also clean up messes I guess."
