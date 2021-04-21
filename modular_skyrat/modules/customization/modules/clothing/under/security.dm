// MODULAR SECURITY WEAR

// HEAD OF SECURITY

/obj/item/clothing/under/rank/security/head_of_security/parade
	name = "head of security's male parade uniform"
	desc = "A luxurious uniform for the head of security, woven in a deep red. On the lapel is a small pin in the shape of a deer's head."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/under/security.dmi'
	icon_state = "hos_parade_male"
	inhand_icon_state = "hos_parade_male"
	can_adjust = FALSE

/obj/item/clothing/suit/armor/hos/parade
	name = "head of security's parade jacket"
	desc = "A luxurious deep red jacket for the head of security, woven with a golden trim. It smells of gunpowder and authority."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	icon_state = "hos_parade"
	inhand_icon_state = "hos_parade"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	heat_protection = CHEST|GROIN|ARMS

// DETECTIVE

/obj/item/clothing/under/rank/security/detective/undersuit
	name = "detective's undersuit"
	desc = "A cool beige undersuit for the discerning PI."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/under/security.dmi'
	icon_state = "det_undersuit"
	inhand_icon_state = "det_undersuit"
	mutant_variants = NONE
	can_adjust = FALSE

/obj/item/clothing/suit/det_bomber
	name = "detective's bomber jacket"
	desc = "A classic bomber jacket in a deep red. It has a clip on the breast to attach your badge."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	icon_state = "det_bomber"
	inhand_icon_state = "det_bomber"
	body_parts_covered = CHEST|ARMS
	armor = list(MELEE = 25, BULLET = 10, LASER = 25, ENERGY = 35, BOMB = 0, BIO = 0, RAD = 0, FIRE = 0, ACID = 45)
	cold_protection = CHEST|ARMS
	mutant_variants = NONE
	heat_protection = CHEST|ARMS

// SEC GENERAL

// PRISONER
/obj/item/clothing/under/rank/protcustpskirt
	name = "protective custody prisoner jumpsuit"
	desc = "A mustard coloured prison jumpsuit, often worn by former Security members, informants and former CentComm employees."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/uniform.dmi'
	icon_state = "prisoner_protcust"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	has_sensor = LOCKED_SENSORS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/protcustp
	name = "protective custody prisoner jumpsuit"
	desc = "A mustard coloured prison jumpsuit, often worn by former Security members, informants and former CentComm employees."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/uniform.dmi'
	icon_state = "prisoner_protcust"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	has_sensor = LOCKED_SENSORS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/protcustp/supermaxp
	name = "supermax prisoner jumpsuit"
	desc = "A crimson red prison jumpsuit, for the worst of the worst, or the Clown."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/uniform.dmi'
	icon_state = "prisoner_superwax"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	has_sensor = LOCKED_SENSORS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/protcustpskirt/supermaxpskirt
	name = "supermax prisoner jumpskirt"
	desc = "A crimson red prison jumpskirt, for the worst of the worst, or the Clown."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/uniform.dmi'
	icon_state = "prisoner_superwax_skirt"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	has_sensor = LOCKED_SENSORS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/protcustpskirt/highsecpskirt
	name = "high risk prisoner jumpskirt"
	desc = "A dark red prison jumpskirt, depending on who sees it, either a badge of honour or a sign to avoid. All my life I've wanted to be famous."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/uniform.dmi'
	icon_state = "prisoner_highsec_skirt"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	has_sensor = LOCKED_SENSORS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/protcustp/lowsecpskirt
	name = "low security prisoner jumpskirt"
	desc = "A pale, almost creamy prison jumpskirt, this one denotes a low security prisoner, things like fraud and anything white collar. It screams 'I'm a bitch' to inmates."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/uniform.dmi'
	icon_state = "prisoner_lowsec_skirt"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	has_sensor = LOCKED_SENSORS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/protcustp/lowsecp
	name = "low security prisoner jumpsuit"
	desc = "A pale, almost creamy prison jumpsuit, this one denotes a low security prisoner, things like fraud and anything white collar. It screams 'I'm a bitch' to inmates."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/uniform.dmi'
	icon_state = "prisoner_lowsec"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	has_sensor = LOCKED_SENSORS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/protcustp/highsecp
	name = "high risk prisoner jumpsuit"
	desc = "A dark red prison jumpsuit, depending on who sees it, either a badge of honour or a sign to avoid. All my life I've wanted to be famous."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/uniform.dmi'
	icon_state = "prisoner_highsec"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	has_sensor = LOCKED_SENSORS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE


