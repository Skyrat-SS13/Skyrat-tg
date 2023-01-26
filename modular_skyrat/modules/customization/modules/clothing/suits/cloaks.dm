/obj/item/clothing/neck/cloak/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/surgery_initiator)
	flags_inv &= ~HIDESUITSTORAGE //removes the HIDESUITSTORAGE flag
