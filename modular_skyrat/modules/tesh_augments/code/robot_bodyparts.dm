#define ROBOTIC_LIGHT_BRUTE_MSG "marred"
#define ROBOTIC_MEDIUM_BRUTE_MSG "dented"
#define ROBOTIC_HEAVY_BRUTE_MSG "falling apart"

#define ROBOTIC_LIGHT_BURN_MSG "scorched"
#define ROBOTIC_MEDIUM_BURN_MSG "charred"
#define ROBOTIC_HEAVY_BURN_MSG "smoldering"

/*
 The damage modifiers here are modified to stay in line with teshari
 Although I'm not sure if it's redundant, better safe than sorry.
 
 Addendum: the limbs lack "limb_id = SPECIES_TESHARI". if this becomes a problem, just put those in xoxo -aKhro
 */

#define TESHARI_PUNCH_LOW 2
#define TESHARI_PUNCH_HIGH 6

//Teshari normal

/obj/item/bodypart/arm/left/robot/teshari
	name = "cybernetic left raptoral forelimb"
	desc = "A skeletal limb wrapped in pseudomuscles and membranous feathers, with a low-conductivity case."
	icon = 'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW
	unarmed_damage_high = TESHARI_PUNCH_HIGH

	brute_modifier = 1
	burn_modifier = 0.9

/obj/item/bodypart/arm/right/robot/teshari
	name = "cybernetic right raptoral forelimb"
	desc = "A skeletal limb wrapped in pseudomuscles and membranous feathers, with a low-conductivity case."
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW
	unarmed_damage_high = TESHARI_PUNCH_HIGH

	brute_modifier = 1
	burn_modifier = 0.9

/obj/item/bodypart/leg/left/robot/teshari
	name = "cybernetic left raptoral hindlimb"
	desc = "A skeletal limb wrapped in pseudomuscles and membranous feathers, with a low-conductivity case."
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW
	unarmed_damage_high = TESHARI_PUNCH_HIGH

	brute_modifier = 1
	burn_modifier = 0.9
	speed_modifier = -0.1

/obj/item/bodypart/leg/right/robot/teshari
	name = "cybernetic right raptoral hindlimb"
	desc = "A skeletal limb wrapped in pseudomuscles and membranous feathers, with a low-conductivity case."
	icon_static =  'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW
	unarmed_damage_high = TESHARI_PUNCH_HIGH

	brute_modifier = 1
	burn_modifier = 0.9
	speed_modifier = -0.1

/obj/item/bodypart/chest/robot/teshari
	name = "cybernetic raptoral torso"
	desc = "A heavily reinforced case containing cyborg logic boards, with space for a standard power cell, covered in a layer of membranous feathers."
	icon_static =  'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	brute_modifier = 1
	burn_modifier = 0.9

	robotic_emp_paralyze_damage_percent_threshold = 0.5

/obj/item/bodypart/head/robot/teshari
	name = "cybernetic raptoral head"
	desc = "A standard reinforced braincase, with spine-plugged neural socket and sensor gimbals. A layer of membranous feathers covers the stark metal."
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW
	unarmed_damage_high = TESHARI_PUNCH_HIGH

	brute_modifier = 1
	burn_modifier = 0.9

	head_flags = HEAD_EYESPRITES

// teshari_ surplus

/obj/item/bodypart/arm/left/robot/teshari_surplus
	name = "prosthetic left raptoral forelimb"
	desc = "A skeletal, robotic wing. Outdated and fragile, but it's still better than nothing. A layer of membranous feathers hides the cheap assembly."
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM


	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2

	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/arm/right/robot/teshari_surplus
	name = "prosthetic right raptoral forelimb"
	desc = "A skeletal, robotic wing. Outdated and fragile, but it's still better than nothing. A layer of membranous feathers hides the cheap assembly."
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2

	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/left/robot/teshari_surplus
	name = "prosthetic left raptoral hindlimb"
	desc = "A skeletal, robotic hindlimb. Outdated and fragile, but it's still better than nothing. A layer of membranous feathers hides the cheap assembly."
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2
	speed_modifier = -0.1

	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/right/robot/teshari_surplus
	name = "prosthetic right raptoral hindlimb"
	desc = "A skeletal, robotic hindlimb. Outdated and fragile, but it's still better than nothing. A layer of membranous feathers hides the cheap assembly."
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2
	speed_modifier = -0.1

	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/arm/left/robot/teshari_surplus
	name = "prosthetic left raptoral forelimb"
	desc = "A skeletal, robotic wing. Outdated and fragile, but it's still better than nothing. A layer of membranous feathers hides the cheap assembly."
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2

	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/arm/right/robot/teshari_surplus
	name = "prosthetic right raptoral forelimb"
	desc = "A skeletal, robotic wing. Outdated and fragile, but it's still better than nothing. A layer of membranous feathers hides the cheap assembly."
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2

	max_damage = LIMB_MAX_HP_PROSTHESIS

	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS


	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/left/robot/teshari_surplus
	name = "prosthetic left raptoral hindlimb"
	desc = "A skeletal, robotic hindlimb. Outdated and fragile, but it's still better than nothing. A layer of membranous feathers hides the cheap assembly."
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2
	speed_modifier = -0.1

	max_damage = LIMB_MAX_HP_PROSTHESIS

	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/right/robot/teshari_surplus
	name = "prosthetic right raptoral hindlimb"
	desc = "A skeletal, robotic hindlimb. Outdated and fragile, but it's still better than nothing. A layer of membranous feathers hides the cheap assembly."
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/surplus_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 0.3
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 0.5

	brute_modifier = 1.25
	burn_modifier = 1.2
	speed_modifier = -0.1

	max_damage = LIMB_MAX_HP_PROSTHESIS
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_PROSTHESIS

	biological_state = (BIO_METAL|BIO_JOINTED)

// teshari_ advanced

/obj/item/bodypart/arm/left/robot/teshari_advanced
	name = "advanced left raptoral forelimb"
	desc = "An advanced robotic hindlimb. These designs are usually reserved for those still on the search for Avalon."
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 2
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 3

	brute_modifier = 0.8
	burn_modifier = 1

	max_damage = LIMB_MAX_HP_ADVANCED
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_ADVANCED

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/arm/right/robot/teshari_advanced
	name = "advanced right raptoral forelimb"
	desc = "An advanced robotic hindlimb. These designs are usually reserved for those still on the search for Avalon."
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 2
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 3

	brute_modifier = 0.8
	burn_modifier = 1

	max_damage = LIMB_MAX_HP_ADVANCED
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_ADVANCED

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/left/robot/teshari_advanced
	name = "advanced left raptoral hindlimb"
	desc = "An advanced robotic hindlimb. These designs are usually reserved for those still on the search for Avalon."
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 2
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 3

	brute_modifier = 0.8
	burn_modifier = 1
	speed_modifier = -0.1

	max_damage = LIMB_MAX_HP_ADVANCED
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_ADVANCED

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/right/robot/teshari_advanced
	name = "advanced right raptoral hindlimb"
	desc = "An advanced robotic hindlimb. These designs are usually reserved for those still on the search for Avalon."
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 2
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 3

	brute_modifier = 0.8
	burn_modifier = 1
	speed_modifier = -0.1

	max_damage = LIMB_MAX_HP_ADVANCED
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_ADVANCED

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/arm/left/robot/teshari_advanced
	name = "advanced left raptoral forelimb"
	desc = "An advanced robotic hindlimb. These designs are usually reserved for those still on the search for Avalon."
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 2
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 3

	brute_modifier = 1
	burn_modifier = 0.9

	max_damage = LIMB_MAX_HP_ADVANCED
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_ADVANCED

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/arm/right/robot/teshari_advanced
	name = "advanced right raptoral forelimb"
	desc = "An advanced robotic hindlimb. These designs are usually reserved for those still on the search for Avalon."
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 2
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 3

	brute_modifier = 1
	burn_modifier = 0.9

	max_damage = LIMB_MAX_HP_ADVANCED
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_ADVANCED

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/left/robot/teshari_advanced
	name = "advanced left raptoral hindlimb"
	desc = "An advanced robotic hindlimb. These designs are usually reserved for those still on the search for Avalon."
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 2
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 3

	brute_modifier = 1
	burn_modifier = 0.9
	speed_modifier = -0.1

	max_damage = LIMB_MAX_HP_ADVANCED
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_ADVANCED

	biological_state = (BIO_METAL|BIO_JOINTED)

/obj/item/bodypart/leg/right/robot/teshari_advanced
	name = "advanced right raptoral hindlimb"
	desc = "An advanced robotic hindlimb. These designs are usually reserved for those still on the search for Avalon."
	icon_static = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	icon = 'modular_skyrat/modules/tesh_augments/icons/advanced_augments_teshari.dmi'
	bodyshape = parent_type::bodyshape | BODYSHAPE_CUSTOM

	unarmed_damage_low = TESHARI_PUNCH_LOW * 2
	unarmed_damage_high = TESHARI_PUNCH_HIGH * 3

	brute_modifier = 1
	burn_modifier = 0.9
	speed_modifier = -0.1

	max_damage = LIMB_MAX_HP_ADVANCED
	body_damage_coeff = LIMB_BODY_DAMAGE_COEFFICIENT_ADVANCED

	biological_state = (BIO_METAL|BIO_JOINTED)

#undef ROBOTIC_LIGHT_BRUTE_MSG
#undef ROBOTIC_MEDIUM_BRUTE_MSG
#undef ROBOTIC_HEAVY_BRUTE_MSG

#undef ROBOTIC_LIGHT_BURN_MSG
#undef ROBOTIC_MEDIUM_BURN_MSG
#undef ROBOTIC_HEAVY_BURN_MSG

#undef TESHARI_PUNCH_LOW
#undef TESHARI_PUNCH_HIGH
