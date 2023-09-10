// Base yellow with symbol trappiste case

/obj/item/storage/toolbox/guncase/skyrat/trappiste_small_case
	desc = "A thick yellow gun case with foam inserts laid out to fit a weapon, magazines, and gear securely. The five square grid of Trappiste Fabriek is displayed prominently on the top."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/gunsets.dmi'
	icon_state = "case_trappiste"

	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/cases_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/inhands/cases_righthand.dmi'
	inhand_icon_state = "yellowcase"

	slot_flags = NONE

	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/toolbox/guncase/skyrat/trappiste_small_case/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL

// Gunset for the Wespe pistol

/obj/item/storage/toolbox/guncase/skyrat/trappiste_small_case/wespe
	name = "Trappiste 'Wespe' gunset"

	weapon_to_spawn = /obj/item/gun/ballistic/automatic/pistol/sol/no_mag
	extra_to_spawn = /obj/item/ammo_box/magazine/c35sol_pistol

// Gunset for the Skild heavy pistol

/obj/item/storage/toolbox/guncase/skyrat/trappiste_small_case/skild
	name = "Trappiste 'Skild' gunset"

	weapon_to_spawn = /obj/item/gun/ballistic/automatic/pistol/trappiste/no_mag
	extra_to_spawn = /obj/item/ammo_box/magazine/c585trappiste_pistol
