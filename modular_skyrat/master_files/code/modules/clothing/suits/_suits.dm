/obj/item/clothing/suit
	/// Does this object get cropped when worn by a taur on their suit or uniform slot?
	var/gets_cropped_on_taurs = TRUE

//Define worn_icon_digi below here for suits without making whole new .dm files
/obj/item/clothing/suit/toggle/labcoat
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suits/labcoat_digi.dmi'

/obj/item/clothing/suit/space
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suits/spacesuit_digi.dmi'
