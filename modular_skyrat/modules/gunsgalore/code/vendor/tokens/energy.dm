//BAD BOY!
/obj/item/armament_token/energy
	name = "energy armament holochip"
	desc = "A holochip used in any armament vendor, this is for energy weapons. Do not bend."
	icon_state = "token_energy"
	custom_premium_price = PAYCHECK_CREW * 3
	minimum_sec_level = SEC_LEVEL_AMBER

/obj/item/armament_token/energy/get_available_gunsets()
	return list(
	/obj/item/storage/box/gunset/laser = image(
		icon = 'modular_skyrat/master_files/icons/obj/guns/gunsets.dmi',
		icon_state = "laser"
		),
	/obj/item/storage/box/gunset/e_gun = image(
		icon = 'modular_skyrat/master_files/icons/obj/guns/gunsets.dmi',
		icon_state = "blaster"
		)
	)
