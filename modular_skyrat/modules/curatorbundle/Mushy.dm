/obj/item/clothing/head/mush_helmet
	name = "mush cap"
	desc = "A mushroom cap, this one also doubles as an umbrella!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
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
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "mush_male"
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	slowdown = 1
	clothing_flags = THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Male Mush" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi',
			RESKIN_ICON_STATE = "mush_male",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi',
			RESKIN_WORN_ICON_STATE = "mush_male"
		),
		"Female Mush" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi',
			RESKIN_ICON_STATE = "mush_female",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi',
			RESKIN_WORN_ICON_STATE = "mush_female"
		)
	)


/obj/item/storage/box/hero/mushperson
	name = "Mushy The Mushperson - 2305"
	desc = "Can you remember?"

/obj/item/storage/box/hero/mushperson/PopulateContents()
	new /obj/item/clothing/suit/mush(src)
	new /obj/item/clothing/head/mush_helmet(src)
	new /obj/item/mushpunch(src)
