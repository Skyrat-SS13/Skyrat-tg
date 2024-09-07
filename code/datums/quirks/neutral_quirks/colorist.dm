<<<<<<< HEAD
/* SKYRAT EDIT REMOVAL
=======
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
/datum/quirk/item_quirk/colorist
	name = "Colorist"
	desc = "You like carrying around a hair dye spray to quickly apply color patterns to your hair."
	icon = FA_ICON_FILL_DRIP
	value = 0
	medical_record_text = "Patient enjoys dyeing their hair with pretty colors."
	mail_goodies = list(/obj/item/dyespray)

/datum/quirk/item_quirk/colorist/add_unique(client/client_source)
	give_item_to_holder(/obj/item/dyespray, list(LOCATION_BACKPACK = ITEM_SLOT_BACKPACK, LOCATION_HANDS = ITEM_SLOT_HANDS))
<<<<<<< HEAD
*/
//SKYRAT EDIT REMOVAL
=======
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
