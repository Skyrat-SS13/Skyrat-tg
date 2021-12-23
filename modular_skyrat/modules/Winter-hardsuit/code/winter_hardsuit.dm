/obj/item/clothing/head/helmet/space/hardsuit/syndi/winter
	name = "winterized Syndicate hardsuit helmet"
	desc = "A winterized variant of the ever feared Blood-Red Hardsuit for work in frozen conditions, despite the extra padding for comfort it does not have superior armor, it is in EVA mode. Property of Gorlex Marauders."
	alt_desc = "A winterized variant of the ever feared Blood-Red Hardsuit for work in frozen conditions, despite the extra padding for comfort it does not have superior armor, it is in combat mode. Property of Gorlex Marauders."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "hardsuit1-syndi-winter"
	inhand_icon_state = "syndie_helm"
	hardsuit_type = "syndi-winter"

/obj/item/clothing/suit/space/hardsuit/syndi/winter
	name = "winterized Syndicate hardsuit"
	desc = "A winterized variant of the ever feared Blood-Red Hardsuit for work in frozen conditions, despite the extra padding for comfort it does not have superior armor, it is in EVA mode. Property of Gorlex Marauders."
	alt_desc = "A winterized variant of the ever feared Blood-Red Hardsuit for work in frozen conditions, despite the extra padding for comfort it does not have superior armor, it is in combat mode. Property of Gorlex Marauders."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "hardsuit1-syndi-winter"
	inhand_icon_state = "syndie_hardsuit"
	hardsuit_type = "syndi-winter"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/winter
	hardsuit_tail_colors = list("#DDDDDD", "#111111", "#d8d8d8")

/obj/item/clothing/head/helmet/space/hardsuit/syndi/wintertas
	name = "winterized Syndicate hardsuit helmet"
	desc = "A winterized variant of the ever feared Blood-Red Hardsuit for work in frozen conditions, despite the extra padding for comfort it does not have superior armor, it is in EVA mode. Property of Gorlex Marauders."
	alt_desc = "A winterized variant of the ever feared Blood-Red Hardsuit for work in frozen conditions, despite the extra padding for comfort it does not have superior armor, it is in combat mode. Property of Gorlex Marauders."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "hardsuit1-syndi-wintertas"
	inhand_icon_state = "syndie_helm"
	hardsuit_type = "syndi-wintertas"

/obj/item/clothing/suit/space/hardsuit/syndi/wintertas
	name = "winterized Syndicate hardsuit"
	desc = "A winterized variant of the ever feared Blood-Red Hardsuit for work in frozen conditions, despite the extra padding for comfort it does not have superior armor; this version does not have tassets, it is in EVA mode. Property of Gorlex Marauders."
	alt_desc = "A winterized variant of the ever feared Blood-Red Hardsuit for work in frozen conditions, despite the extra padding for comfort it does not have superior armor; this version does not have tassets, it is in combat mode. Property of Gorlex Marauders."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "hardsuit1-syndi-wintertas"
	inhand_icon_state = "syndie_hardsuit"
	hardsuit_type = "syndi-wintertas"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/wintertas
	hardsuit_tail_colors = list("#DDDDDD", "#111111", "#d8d8d8")

/obj/item/device/custom_kit/winterized
	name = "syndicate Hardsuit winterized plating kit"
	desc = "A modification kit that comes with the tools neccessary to modify a Standard Blood-Red Hardsuit into it's winterized variant. This one comes with tassets. Warranty void if tampered with, property of Gorlex Marauders."
	icon = 'modular_skyrat/master_files/icons/donator/obj/kits.dmi'
	icon_state = "partskit-synd"
	from_obj = /obj/item/clothing/suit/space/hardsuit/syndi
	to_obj = /obj/item/clothing/suit/space/hardsuit/syndi/winter

/obj/item/device/custom_kit/winterized_notasset
	name = "syndicate Hardsuit winterized plating kit"
	desc = "A modification kit that comes with the tools neccessary to modify a Standard Blood-Red Hardsuit into it's winterized variant. This one comes with no tassets. Warranty void if tampered with, property of Gorlex Marauders."
	icon = 'modular_skyrat/master_files/icons/donator/obj/kits.dmi'
	icon_state = "partskit-synd"
	from_obj = /obj/item/clothing/suit/space/hardsuit/syndi
	to_obj = /obj/item/clothing/suit/space/hardsuit/syndi/wintertas
