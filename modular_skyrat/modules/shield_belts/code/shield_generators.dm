// Shield bracers, has a single shield charge but recharges relatively quickly

/obj/item/clothing/gloves/shield_bracers
	name = "Milano shielded bracers"
	desc = "A pair of bracers with built in shield projectors, which will project a single-impact shield \
		around the user's body. The single-charge system allows the projectors to have a rapid recharge rate."
	icon = 'modular_skyrat/modules/shield_belts/icons/shield_objects.dmi'
	icon_state = "bracers"
	worn_icon = 'modular_skyrat/modules/shield_belts/icons/worn.dmi'
	resistance_flags = FIRE_PROOF
	siemens_coefficient = 0.5
	clothing_flags = THICKMATERIAL

/obj/item/clothing/gloves/shield_bracers/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/shielded/shield_belt, \
		max_charges = 2, \
		recharge_start_delay = 15 SECONDS, \
		charge_increment_delay = 5 SECONDS, \
		charge_recovery = 1, \
		lose_multiple_charges = FALSE, \
		show_charge_as_alpha = FALSE, \
		shield_icon_file = 'modular_skyrat/modules/shield_belts/icons/shield_overlay.dmi', \
		shield_icon = "shield", \
		shield_inhand = FALSE, \
	)
