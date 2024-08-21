/obj/item/clothing/suit
	/// Does this object get cropped when worn by a taur on their suit or uniform slot?
	var/gets_cropped_on_taurs = TRUE

//Define worn_icon_digi below here for suits so we don't have to make whole new .dm files for each
/obj/item/clothing/suit/armor
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor_digi.dmi'

/obj/item/clothing/suit/bio_suit
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suits/bio_digi.dmi'

/obj/item/clothing/suit/wizrobe
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suits/wizard_digi.dmi'
	gets_cropped_on_taurs = FALSE
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/suit.dmi'

/obj/item/clothing/suit/toggle/labcoat
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suits/labcoat_digi.dmi'

/obj/item/clothing/suit/space
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suits/spacesuit_digi.dmi'

/obj/item/clothing/suit/chaplainsuit
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suits/chaplain_digi.dmi'

/obj/item/clothing/suit/hooded/chaplainsuit
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suits/chaplain_digi.dmi'
