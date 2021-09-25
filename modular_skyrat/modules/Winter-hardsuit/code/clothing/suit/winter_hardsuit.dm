/obj/item/clothing/head/helmet/space/hardsuit/syndi/winter
	name = "Winterized Syndicate hardsuit helmet"
	desc = "A winterized variant of the ever feared Blood-Red Hardsuit for work in frozen conditions, despite the extra padding for comfort it does not have superior armor, it is in EVA mode. Property of Gorlex Marauders."
	alt_desc = "A winterized variant of the ever feared Blood-Red Hardsuit for work in frozen conditions, despite the extra padding for comfort it does not have superior armor, it is in combat mode. Property of Gorlex Marauders."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "hardsuit1-syndi-winter"
	inhand_icon_state = "syndie_helm"
	hardsuit_type = "syndi-winter"

/obj/item/clothing/suit/space/hardsuit/syndi/winter
	name = "Winterized Syndicate Hardsuit"
	desc = "A winterized variant of the ever feared Blood-Red Hardsuit for work in frozen conditions, despite the extra padding for comfort it does not have superior armor, it is in EVA mode. Property of Gorlex Marauders."
	alt_desc = "A winterized variant of the ever feared Blood-Red Hardsuit for work in frozen conditions, despite the extra padding for comfort it does not have superior armor, it is in combat mode. Property of Gorlex Marauders."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "hardsuit1-syndi-winter"
	inhand_icon_state = "syndie_hardsuit"
	hardsuit_type = "syndi-winter"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/winter
	hardsuit_tail_colors = list("EEE", "111", "211")

/obj/item/clothing/head/helmet/space/hardsuit/syndi/wintertas
	name = "Winterized Syndicate hardsuit helmet"
	desc = "A winterized variant of the ever feared Blood-Red Hardsuit for work in frozen conditions, despite the extra padding for comfort it does not have superior armor, it is in EVA mode. Property of Gorlex Marauders."
	alt_desc = "A winterized variant of the ever feared Blood-Red Hardsuit for work in frozen conditions, despite the extra padding for comfort it does not have superior armor, it is in combat mode. Property of Gorlex Marauders."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "hardsuit1-syndi-wintertas"
	inhand_icon_state = "syndie_helm"
	hardsuit_type = "syndi-wintertas"

/obj/item/clothing/suit/space/hardsuit/syndi/wintertas
	name = "Winterized Syndicate Hardsuit"
	desc = "A winterized variant of the ever feared Blood-Red Hardsuit for work in frozen conditions, despite the extra padding for comfort it does not have superior armor; this version does not have tassets, it is in EVA mode. Property of Gorlex Marauders."
	alt_desc = "A winterized variant of the ever feared Blood-Red Hardsuit for work in frozen conditions, despite the extra padding for comfort it does not have superior armor; this version does not have tassets, it is in combat mode. Property of Gorlex Marauders."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "hardsuit1-syndi-wintertas"
	inhand_icon_state = "syndie_hardsuit"
	hardsuit_type = "syndi-wintertas"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/wintertas
	hardsuit_tail_colors = list("EEE", "111", "211")

/obj/item/clothing/suit/space/hardsuit/syndi/camo/attack_self(mob/user)	//Some weird amalgamation from the reskin_obj proc
	if(cell_cover_open)
		remove_cell(user)
		//Y'know, just in case someone wants to use the suit without bothering to toggle it
	else
		var/list/radial_items = list() //Used to handle counting to 3. Very challenging.
		var/list/camo_types = list("Default (Blood-Red)", "Winterized", "Winterized (without tassets)")
		var/list/camo_icons = list("hardsuit1-syndi", "hardsuit1-syndi-winter", "hardsuit1-syndi-wintertas")

		for(var/radial_icon_option in camo_types)
			var/image/item_image = image(icon = src.icon, icon_state = camo_icons[camo_types])
			radial_items += list("[radial_icon_option]" = item_image)
		sortList(radial_items)
		var/pick_camo = show_radial_menu(user, src, radial_items, custom_check = CALLBACK(src, .proc/check_reskin_menu, user), radius = 38, require_near = TRUE)
		if(!pick_camo)
			return
		else
			switch(pick_camo)
				if("Default (Blood-Red)")
					user.put_in_hands(new /obj/item/clothing/suit/space/hardsuit/syndi(get_turf(src)))
				if("Winterized")
					user.put_in_hands(new /obj/item/clothing/suit/space/hardsuit/syndi/winter(get_turf(src)))
				if("Winterized (without tassets)")
					user.put_in_hands(new /obj/item/clothing/suit/space/hardsuit/syndi/wintertas(get_turf(src)))
			to_chat(user, "The Hardsuit rematerializes in your hand, you've changed it to [pick_camo]! A small voice crackles from the Hardsuit: 'Warranty is void if tampered with.'")
			qdel(src)
