/obj/item/melee/baton/telescopic/contractor_baton
	/// Ref to the baton holster, should the baton have one.
	var/obj/item/mod/module/baton_holster/holster

/obj/item/melee/baton/telescopic/contractor_baton/dropped(mob/user, silent)
	. = ..()
	holster?.undeploy()
