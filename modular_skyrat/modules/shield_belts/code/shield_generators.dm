/obj/item/clothing/gloves/shield_bracers
	name = "Milano shielded bracers"
	desc = "A common pair of shield bracers, able to provide the user with a weak personal \
		shield. The shield will break after a single impact of any sort, and will take about a \
		minute to recharge fully.
	icon = 'modular_skyrat/modules/shield_belts/icons/shield_objects.dmi'
	icon_state = "bracers"
	worn_icon = 'modular_skyrat/modules/shield_belts/icons/worn.dmi'
	resistance_flags = FIRE_PROOF
	siemens_coefficient = 0.5
	clothing_flags = THICKMATERIAL
	clothing_traits = list(TRAIT_CHUNKYFINGERS)

/obj/item/clothing/gloves/shield_bracers/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/shielded/shield_belt, \
		max_charges = 1, \
		recharge_start_delay = 1 MINUTES, \
		charge_recovery = 1, \
		lose_multiple_charges = FALSE, \
		show_charge_as_alpha = FALSE, \
		shield_icon_file = 'modular_skyrat/modules/shield_belts/icons/shield_overlay.dmi', \
		shield_icon = "shield", \
		shield_inhand = FALSE, \
	)
