/obj/item/armament_token/primary
	name = "primary armament holochip"
	desc = "A holochip used in any armament vendor, this is for main arms. Do not bend."
	icon_state = "token_primary"
	minimum_sec_level = SEC_LEVEL_RED

/obj/item/armament_token/primary/get_available_gunsets()
	return list(
	/obj/item/storage/box/gunset/pcr = image(
		icon = 'modular_skyrat/master_files/icons/obj/guns/gunsets.dmi',
		icon_state = "pcr"
		),
	/obj/item/storage/box/gunset/norwind = image(
		icon = 'modular_skyrat/master_files/icons/obj/guns/gunsets.dmi',
		icon_state = "norwind"
		),
	/obj/item/storage/box/gunset/ostwind = image(
		icon = 'modular_skyrat/master_files/icons/obj/guns/gunsets.dmi',
		icon_state = "ostwind"
		),
	/obj/item/storage/box/gunset/pitbull = image(
		icon = 'modular_skyrat/master_files/icons/obj/guns/gunsets.dmi',
		icon_state = "pitbull"
		)
	)

//Primary
/obj/item/armament_token/shotgun
	name = "shotgun armament holochip"
	desc = "A holochip used in any armament vendor, this is for shotguns. Do not bend."
	icon_state = "token_shotgun"

/obj/item/armament_token/shotgun/get_available_gunsets()
	return list(
	/obj/item/storage/box/gunset/m23 = image(
		icon = 'modular_skyrat/master_files/icons/obj/guns/gunsets.dmi',
		icon_state = "m23"
		),
	/obj/item/storage/box/gunset/as2 = image(
		icon = 'modular_skyrat/master_files/icons/obj/guns/gunsets.dmi',
		icon_state = "as2"
		)
	)
