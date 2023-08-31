// Base yellow with symbol trappiste case

/obj/item/storage/box/gunset/trappiste_small_case
	desc = "A thick yellow gun case with foam inserts laid out to fit a weapon, magazines, and gear securely. The five square grid of Trappiste Fabriek is displayed prominently on the top."

	icon_state = "case_trappiste"

	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/cases_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/cases_righthand.dmi'
	inhand_icon_state = "yellowcase"

// Gunset for the Skild

/obj/item/storage/box/gunset/trappiste_small_case/skild
	name = "Trappiste 'Skild' gunset"

/obj/item/storage/box/gunset/trappiste_small_case/skild/PopulateContents()
	. = ..()

	generate_items_inside(list(
		/obj/item/gun/ballistic/automatic/pistol/trappiste/no_mag = 1,
		/obj/item/ammo_box/magazine/c585trappiste_pistol = 4,
	),src)
