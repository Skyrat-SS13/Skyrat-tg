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
	AddComponent(/datum/component/shielded/shield_belt, \
		max_charges = 1, \
		recharge_start_delay = 15 SECONDS, \
		charge_increment_delay = 5 SECONDS, \
		charge_recovery = 1, \
		lose_multiple_charges = FALSE, \
		show_charge_as_alpha = FALSE, \
		starting_charges = 0, \
		shield_icon_file = 'modular_skyrat/modules/shield_belts/icons/shield_overlay.dmi', \
		shield_icon = "shield", \
		shield_inhand = FALSE, \
		shield_overlay_alpha = 200, \
		shield_overlay_color = "#77bd5d", \
	)

// Shield belt, has more charges but starts recharging slower than the bracers do

/obj/item/shield_generator_belt
	name = "Milano belt shield generator"
	desc = "A belt mounted shield generator, common sight across the galaxy where armor might be impractical, \
		but protection is still required. The impact shield has three charges, and has a slow recharge rate."
	icon = 'modular_skyrat/modules/shield_belts/icons/shield_objects.dmi'
	icon_state = "belt"
	worn_icon = 'modular_skyrat/modules/shield_belts/icons/worn.dmi'
	slot_flags = ITEM_SLOT_BELT
	item_flags = NOBLUDGEON

/obj/item/shield_generator_belt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/shielded/shield_belt, \
		max_charges = 3, \
		recharge_start_delay = 45 SECONDS, \
		charge_increment_delay = 10 SECONDS, \
		charge_recovery = 1, \
		lose_multiple_charges = FALSE, \
		show_charge_as_alpha = FALSE, \
		starting_charges = 0, \
		shield_icon_file = 'modular_skyrat/modules/shield_belts/icons/shield_overlay.dmi', \
		shield_icon = "shield", \
		shield_inhand = FALSE, \
		shield_overlay_alpha = 200, \
		shield_overlay_color = "#77bd5d", \
	)
