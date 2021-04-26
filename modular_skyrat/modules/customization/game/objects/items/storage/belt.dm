/*
* Messenger belt bag
*/

/obj/item/storage/belt/mailbelt
	name = "Messenger Belt Bag"
	desc = "A small bag with a belt, worn around the waist. Just wide enough to hold stacks of letters. Includes several dividers for ease of sorting!"
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/belts.dmi'
	icon_state = "mailbelt"
	inhand_icon_state = "mailbelt"
	worn_icon_state = "mailbelt"
	equip_sound = 'sound/items/equip/toolbelt_equip.ogg'

/obj/item/storage/belt/champion/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 5
    STR.display_numerical_stacking = TRUE
	STR.set_holdable(list(
		/obj/item/mail
        /obj/item/mail/envelope
        /obj/item/paper
		))