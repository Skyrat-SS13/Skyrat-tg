/obj/item/shibari_rope
	name = "Shibari ropes"
	desc = "Coil of bondage ropes"
	current_color = "pink"

	//SOME IMPORTANT STUFF
	var/obj/item/clothing/under/shibari_body/shibaribody
	var/obj/item/clothing/under/shibari_groin/shibarigroin
	var/obj/item/clothing/under/shibari_fullbody/shibarifullbody
	var/obj/item/clothing/shoes/shibari_legs/shibarilegs
	var//obj/item/clothing/gloves/shibari_hands/shibarihands

/obj/item/shibari_rope/attack(mob/living/carbon/C, mob/living/user)
	switch(user.zone_selected)
		if(BODY_ZONE_L_LEG || BODY_ZONE_R_LEG)
			if(!(C.shoes))
				if(do_after(user, 60))
					C.equip_to_slot_if_possible(shibarilegs,ITEM_SLOT_FEET,0,0,1)
					shibarilegs.color = current_color
					shibarilegs.update_icon_state()
					shibarilegs.update_icon()

		if(BODY_ZONE_PRECISE_GROIN)
			if(!(C.w_uniform) || if(istype(C.w_uniform, /obj/item/clothing/under/shibari_body)))
				if(do_after(user, 60))
					if(istype(C.w_uniform, /obj/item/clothing/under/shibari_groin))
						qdel(shibaribody)
					else
						C.equip_to_slot_if_possible(shibarigroin,ITEM_SLOT_ICLOTHING,0,0,1)
						shibarigroin.color = current_color
						shibarigroin.update_icon_state()
						shibarigroin.update_icon()

		if(BODY_ZONE_CHEST)
			if(!(C.w_uniform) || if(istype(C.w_uniform, /obj/item/clothing/under/shibari_groin)))
				if(do_after(user, 60))
					if(istype(C.w_uniform, /obj/item/clothing/under/shibari_groin))

					else
						C.equip_to_slot_if_possible(shibaribody,ITEM_SLOT_ICLOTHING,0,0,1)
						shibaribody.color = current_color
						shibaribody.update_icon_state()
						shibaribody.update_icon()

		if(BODY_ZONE_L_ARM || BODY_ZONE_R_ARM)
			if(!(C.gloves))
				if(do_after(user, 60))
					C.equip_to_slot_if_possible(shibarihands,ITEM_SLOT_ICLOTHING,0,0,1)
					shibarihands.color = current_color
					shibarihands.update_icon_state()
					shibarihands.update_icon()
