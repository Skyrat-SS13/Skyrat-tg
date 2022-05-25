/*
* Objects
*/

//
// Aviators
//

// Normal Aviators
/obj/item/clothing/glasses/sunglasses/aviator
	name = "aviators"
	desc = "A pair of designer sunglasses."
  icon_state = "aviator"

// Fake-sunglasses Aviators
/obj/item/clothing/glasses/fake_sunglasses/aviator
	name = "aviators"
	desc = "A pair of designer sunglasses. Doesn't seem like it'll block flashes."
  icon_state = "aviator"

// Security Aviators
/obj/item/clothing/glasses/hud/security/aviator
	name = "security HUD aviators"
	desc = "A heads-up display that scans the humanoids in view and provides accurate data about their ID status and security records. This HUD has been fitted inside of a pair of sunglasses with toggleable electrochromatic tinting."
	icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses.dmi'
	icon_state = "aviator_sec"
	worn_icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses_mob.dmi'
	darkness_view = 1
	flash_protect = FLASH_PROTECTION_FLASH
	tint = 1
	vision_correction = FALSE

// Medical Aviators
/obj/item/clothing/glasses/hud/health/aviator
	name = "medical HUD aviators"
	desc = "A heads-up display that scans the humanoids in view and provides accurate data about their health status. This HUD has been fitted inside of a pair of sunglasses."
	icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses.dmi'
	icon_state = "aviator_med"
	worn_icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses_mob.dmi'
	vision_correction = FALSE

// (Normal) meson scanner Aviators
/obj/item/clothing/glasses/meson/aviator
	name = "meson HUD aviators"
	desc = "Used by engineering and mining staff to see basic structural and terrain layouts through walls, regardless of lighting conditions. This HUD has been fitted inside of a pair of sunglasses."
	icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses.dmi'
	icon_state = "aviator_meson"
	worn_icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses_mob.dmi'
	vision_correction = FALSE

// diagnostic Aviators
/obj/item/clothing/glasses/hud/diagnostic/aviator
	name = "diagnostic HUD aviators"
	desc = "A heads-up display capable of analyzing the integrity and status of robotics and exosuits. This HUD has been fitted inside of a pair of sunglasses."
	icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses.dmi'
	icon_state = "aviator_diag"
	worn_icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses_mob.dmi'
	vision_correction = FALSE

//
// Prescriptions
//

// Security Aviators
/obj/item/clothing/glasses/hud/security/aviator/prescription
	name = "prescription security HUD aviators"
	desc = "A heads-up display that scans the humanoids in view and provides accurate data about their ID status and security records. This HUD has been fitted inside of a pair of sunglasses with toggleable electrochromatic tinting which. Has lenses that help correct eye sight."
	vision_correction = TRUE

// Medical Aviators
/obj/item/clothing/glasses/hud/health/aviator/prescription
	name = "prescription medical HUD aviators"
	desc = "A heads-up display that scans the humanoids in view and provides accurate data about their health status. This HUD has been fitted inside of a pair of sunglasses which has lenses that help correct eye sight."
	vision_correction = TRUE

// (Normal) meson scanner Aviators
/obj/item/clothing/glasses/meson/aviator/prescription
	name = "prescription meson HUD aviators"
	desc = "Used by engineering and mining staff to see basic structural and terrain layouts through walls, regardless of lighting conditions. This HUD has been fitted inside of a pair of sunglasses which has lenses that help correct eye sight."
	vision_correction = TRUE

// diagnostic Aviators
/obj/item/clothing/glasses/hud/diagnostic/aviator/prescription
	name = "prescription diagnostic HUD aviators"
	desc = "A heads-up display capable of analyzing the integrity and status of robotics and exosuits. This HUD has been fitted inside of a pair of sunglasses which has lenses that help correct eye sight."
	vision_correction = TRUE

/*
* Designs
*/

//
// Aviators
//

/datum/design/health_hud_aviator
	name = "Medical HUD Aviators"
	desc = "A heads-up display that scans the humanoids in view and provides accurate data about their health status. This HUD has been fitted inside of a pair of sunglasses."
	id = "health_hud_aviator"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 700, /datum/material/glass = 800, /datum/material/silver = 350)
	build_path = /obj/item/clothing/glasses/hud/health/prescription
	category = list("Equipment")
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/security_hud_aviator
	name = "Security HUD Aviators"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their ID status. This HUD has been fitted inside of a pair of sunglasses."
	id = "security_hud_aviator"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 700, /datum/material/glass = 800, /datum/material/silver = 350)
	build_path = /obj/item/clothing/glasses/hud/security/aviator
	category = list("Equipment")
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/diagnostic_hud_aviator
	name = "Diagnostic HUD Aviators"
	desc = "A HUD used to analyze and determine faults within robotic machinery. This HUD has been fitted inside of a pair of sunglasses."
	id = "diagnostic_hud_aviator"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 700, /datum/material/glass = 800, /datum/material/gold = 350)
	build_path = /obj/item/clothing/glasses/hud/diagnostic/aviator
	category = list("Equipment")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/mesons_hud_aviator
	name = "Meson HUD Aviators"
	desc = "Used by engineering and mining staff to see basic structural and terrain layouts through walls, regardless of lighting condition. This HUD has been fitted inside of a pair of sunglasses."
	id = "mesons_hud_aviator"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 700, /datum/material/glass = 800, /datum/material/silver = 350)
	build_path = /obj/item/clothing/glasses/meson/aviator
	category = list("Equipment")
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING
