/obj/item/armament_token/sidearm
	name = "sidearm armament holochip"
	desc = "A holochip used in any armament vendor, this is for sidearms. Do not bend."
	icon_state = "token_sidearm"

/obj/item/armament_token/sidearm/get_available_gunsets()
	return list(
	/obj/item/storage/box/gunset/pdh_peacekeeper= image(
		icon = 'modular_skyrat/master_files/icons/obj/guns/gunsets.dmi',
		icon_state = "pdh_peacekeeper"
		),
	/obj/item/storage/box/gunset/glock17 = image(
		icon = 'modular_skyrat/master_files/icons/obj/guns/gunsets.dmi',
		icon_state = "g17"
		),
	/obj/item/storage/box/gunset/ladon = image(
		icon = 'modular_skyrat/master_files/icons/obj/guns/gunsets.dmi',
		icon_state = "ladon"
		),
	/obj/item/storage/box/gunset/zeta = image(
		icon = 'modular_skyrat/master_files/icons/obj/guns/gunsets.dmi',
		icon_state = "zeta"
		),
	/obj/item/storage/box/gunset/dozer = image(
		icon = 'modular_skyrat/master_files/icons/obj/guns/gunsets.dmi',
		icon_state = "dozer"
		),
	/obj/item/storage/box/gunset/revolution = image(
		icon = 'modular_skyrat/master_files/icons/obj/guns/gunsets.dmi',
		icon_state = "revolution"
		),
	)

// BAD BOY!
/obj/item/armament_token/sidearm_blackmarket
	name = "blackmarket armament holochip"
	desc = "A holochip used in any armament vendor, this is for |bad people|. Do not bend."
	icon_state = "token_blackmarket"
	custom_price = PAYCHECK_COMMAND * 10
	custom_premium_price = PAYCHECK_COMMAND * 10

/obj/item/armament_token/sidearm_blackmarket/get_available_gunsets()
	return list(
	/obj/item/storage/box/gunset/mk58 = image(
		icon = 'modular_skyrat/master_files/icons/obj/guns/gunsets.dmi',
		icon_state = "mk58"
		),
	/obj/item/storage/box/gunset/croon = image(
		icon = 'modular_skyrat/master_files/icons/obj/guns/gunsets.dmi',
		icon_state = "croon"
		),
	/obj/item/storage/box/gunset/makarov = image(
		icon = 'modular_skyrat/master_files/icons/obj/guns/gunsets.dmi',
		icon_state = "makarov"
		)
	)
