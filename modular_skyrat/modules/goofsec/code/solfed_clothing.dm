// Peacekeeper jumpsuit

/obj/item/clothing/under/sol_peacekeeper
	name = "sol peacekeeper uniform"
	desc = "A military-grade uniform with military grade comfort (none at all), often seen on \
		SolFed's various peacekeeping forces, and usually alongside a blue helmet."
	icon = 'modular_skyrat/modules/goofsec/icons/uniforms.dmi'
	icon_state = "peacekeeper"
	worn_icon = 'modular_skyrat/modules/goofsec/icons/uniforms_worn.dmi'
	worn_icon_digi = 'modular_skyrat/modules/goofsec/icons/uniforms_worn_digi.dmi'
	worn_icon_state = "peacekeeper"
	armor_type = /datum/armor/clothing_under/rank_security
	inhand_icon_state = null
	has_sensor = SENSOR_COORDS
	random_sensor = FALSE

// EMT jumpsuit

/obj/item/clothing/under/sol_emt
	name = "sol emergency medical uniform"
	desc = "A copy of SolFed's peacekeeping uniform, recolored and re-built paramedics in mind."
	icon = 'modular_skyrat/modules/goofsec/icons/uniforms.dmi'
	icon_state = "emt"
	worn_icon = 'modular_skyrat/modules/goofsec/icons/uniforms_worn.dmi'
	worn_icon_digi = 'modular_skyrat/modules/goofsec/icons/uniforms_worn_digi.dmi'
	worn_icon_state = "emt"
	armor_type = /datum/armor/clothing_under/rank_medical
	inhand_icon_state = null
	has_sensor = SENSOR_COORDS
	random_sensor = FALSE

// Solfed flak jacket, for marshals

/obj/item/clothing/suit/armor/vest/det_suit/sol
	name = "'Gordyn' flak vest"
	desc = "A light armored jacket common on SolFed personnel who need armor, but find a full vest \
		too impractical or uneeded."
	icon = 'modular_skyrat/modules/goofsec/icons/uniforms.dmi'
	icon_state = "flak"
	worn_icon = 'modular_skyrat/modules/goofsec/icons/uniforms_worn.dmi'
	worn_icon_state = "flak"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
