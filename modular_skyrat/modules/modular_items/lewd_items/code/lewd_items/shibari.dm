/obj/item/stack/shibari_rope
	icon = 'icons/obj/stack_objects.dmi'
	icon_state = "shibari"
	name = "Shibari ropes"
	desc = "Coil of bondage ropes"
	amount = 1
	merge_type = /obj/item/stack/shibari_rope

	var/current_color = "pink"

	var/list/torso_styles = list(
		"Torso",
		"Groin"
	)

	//SOME IMPORTANT STUFF
	var/obj/item/clothing/under/shibari_body/shibaribody
	var/obj/item/clothing/under/shibari_groin/shibarigroin
	var/obj/item/clothing/under/shibari_fullbody/shibarifullbody
	var/obj/item/clothing/shoes/shibari_legs/shibarilegs
	var/obj/item/clothing/gloves/shibari_hands/shibarihands

/obj/item/stack/shibari_rope/can_merge(obj/item/stack/check)
	if(!istype(check, merge_type))
		return FALSE
	//different color stacks cannot merge
	if(istype(check, merge_type))
		var/obj/item/stack/shibari_rope/other_stuff = check
		if(other_stuff.current_color != current_color)
			return FALSE
	return TRUE

/obj/item/stack/shibari_rope/attack(mob/living/carbon/C, mob/living/user)
	add_fingerprint(user)
	if(ishuman(C))
		var/mob/living/carbon/human/them = C
		switch(user.zone_selected)
			if(BODY_ZONE_L_LEG || BODY_ZONE_R_LEG)
				if(!(them.shoes))
					if(do_after(user, 60))
						shibarilegs = new(src)
						if(them.equip_to_slot_if_possible(shibarilegs,ITEM_SLOT_FEET,0,0,1))
							use(1)
							shibarilegs.color = current_color
							shibarilegs.update_icon_state()
							shibarilegs.update_icon()
							shibarilegs = null
						else
							qdel(shibarilegs)

			if(BODY_ZONE_PRECISE_GROIN)
				if(!(them.w_uniform))
					if(do_after(user, 60))
						shibarigroin = new(src)
						if(them.equip_to_slot_if_possible(shibarigroin,ITEM_SLOT_ICLOTHING,0,0,1))
							use(1)
							shibarigroin.color = current_color
							shibarigroin.update_icon_state()
							shibarigroin.update_icon()
							shibarigroin = null
						else
							qdel(shibarigroin)
				else if(istype(them.w_uniform, /obj/item/clothing/under/shibari_body))
					if(do_after(user, 60))
						shibarigroin = new(src)
						qdel(them.w_uniform)
						if(them.equip_to_slot_if_possible(shibarigroin,ITEM_SLOT_ICLOTHING,0,0,1))
							use(1)
							shibarigroin.color = current_color
							shibarigroin.update_icon_state()
							shibarigroin.update_icon()
							shibarigroin = null
						else
							qdel(shibarigroin)

			if(BODY_ZONE_CHEST)
				if(!(them.w_uniform))
					if(do_after(user, 60))
						shibaribody = new(src)
						if(them.equip_to_slot_if_possible(shibaribody,ITEM_SLOT_ICLOTHING,0,0,1))
							use(1)
							shibaribody.color = current_color
							shibaribody.update_icon_state()
							shibaribody.update_icon()
						else
							qdel(shibaribody)
				else if(istype(them.w_uniform, /obj/item/clothing/under/shibari_groin))
					if(do_after(user, 60))
						shibaribody = new(src)
						qdel(them.w_uniform)
						if(them.equip_to_slot_if_possible(shibaribody,ITEM_SLOT_ICLOTHING,0,0,1))
							use(1)
							shibaribody.color = current_color
							shibaribody.update_icon_state()
							shibaribody.update_icon()
						else
							qdel(shibaribody)

			if(BODY_ZONE_L_ARM || BODY_ZONE_R_ARM)
				if(!(them.gloves))
					if(do_after(user, 60))
						shibarihands = new(src)
						if(them.equip_to_slot_if_possible(shibarihands,ITEM_SLOT_HANDS,0,0,1))
							use(1)
							shibarihands.color = current_color
							shibarihands.update_icon_state()
							shibarihands.update_icon()
						else
							qdel(shibarihands)
			else
				return ..()
	else
		return ..()

/obj/item/stack/shibari_rope/full
	amount = 10

/obj/item/stack/shibari_rope/full/Initialize(mapload, new_amount, merge, list/mat_override, mat_amt)
	. = ..()
	if(prob(50))
		current_color = "blue"
