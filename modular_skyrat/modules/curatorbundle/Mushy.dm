/obj/item/clothing/head/mush_helmet
	name = "mush cap"
	desc = "A mushroom cap, this one also doubles as an umbrella!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/costume.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/costume.dmi'
	icon_state = "mush_cap"
	worn_icon_state = "mush_cap"
	greyscale_config = /datum/greyscale_config/mushcap
	greyscale_config_worn = /datum/greyscale_config/mushcap/worn
	greyscale_colors = "#eb0c07"
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/mush
	name = "mushroom suit"
	desc = "A mushroom suit, these can be sporadically seen being worn by the more fungal personalities."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/costume.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/costume.dmi'
	icon_state = "mush_male"
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	slowdown = 1
	clothing_flags = THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	unique_reskin = list(
			"Male" = "mush_male",
			"Female" = "mush_female",
	)

/obj/item/storage/box/hero/mushperson
	name = "Mushy The Mushperson - 2305"
	desc = "Can you remember?"

/obj/item/storage/box/hero/mushperson/PopulateContents()
	new /obj/item/clothing/suit/mush(src)
	new /obj/item/clothing/head/mush_helmet(src)
	new /obj/item/mushpunch(src)
