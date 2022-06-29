/obj/item/proc/get_gun_permit_iconstate()

	if(istype(src, /obj/item/changeling/id))
		var/obj/item/changeling/id/changeling_card = src
		if(changeling_card.gun_permit)
			return "hud_permit"
		return "hudfan_no"

	var/obj/item/card/id/id_card = GetID()
	
	if(!id_card)
		return "hudfan_no"
	if(ACCESS_WEAPONS in id_card.GetAccess())
		return "hud_permit"
	return "hudfan_no"
