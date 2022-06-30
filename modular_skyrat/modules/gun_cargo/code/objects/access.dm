/obj/item/proc/get_gun_permit_iconstate()

	if(istype(src, /obj/item/changeling/id))
		var/obj/item/changeling/id/changeling_card = src
		if(changeling_card.gun_permit)
			return HUD_PERMIT_YES
		return HUD_PERMIT_NO

	var/obj/item/card/id/id_card = GetID()
	
	if(!id_card)
		return HUD_PERMIT_NO
	if(ACCESS_WEAPONS in id_card.GetAccess())
		return HUD_PERMIT_YES
	return HUD_PERMIT_NO
