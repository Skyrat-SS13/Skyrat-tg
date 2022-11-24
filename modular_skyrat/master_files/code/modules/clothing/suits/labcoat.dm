/obj/item/clothing/suit/toggle/labcoat
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suits/labcoat_digi.dmi'

//There aren't enough of these to warrant a /skyrat base type, if it goes above 4 then we can consider it

/obj/item/clothing/suit/toggle/labcoat/rd
	name = "research directors labcoat"
	desc = "A Nanotrasen standard labcoat for certified Research Directors. It has an extra plastic-latex lining on the outside for more protection from chemical and viral hazards."
	icon_state = "labcoat_rd"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/labcoat.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/labcoat.dmi'
	body_parts_covered = CHEST|ARMS|LEGS
	armor = list(MELEE = 5, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 80, FIRE = 80, ACID = 70)
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/toggle/labcoat/roboticist //Overwrite the TG Roboticist labcoat to Black and Red (not the Interdyne labcoat though)
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/labcoat.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/labcoat.dmi'
	icon_state = "labcoat_robo_sr"
