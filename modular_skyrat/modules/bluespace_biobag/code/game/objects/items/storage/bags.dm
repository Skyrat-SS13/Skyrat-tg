/obj/item/storage/bag/bio/bluespace
	name = "bio bag of holding"
	icon = 'modular_skyrat/modules/bluespace_biobag/icons/obj/bbag.dmi'
	icon_state = "bluespace_biobag"
	worn_icon = 'modular_skyrat/modules/bluespace_biobag/icons/mob/clothing/belt.dmi'
	worn_icon_state = "bluespace_biobag"
	desc = "A bag for the safe transportation and disposal of biowaste and other biological materials."
	flags_1 = RAD_PROTECT_CONTENTS_1 | COMPONENT_BLOCK_RADIATION

/obj/item/storage/bag/bio/bluespace/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = INFINITY
	STR.max_items = 100
