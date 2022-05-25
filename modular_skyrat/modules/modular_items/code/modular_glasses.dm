// Normal Aviators
/obj/item/clothing/glasses/sunglasses/aviator
  name = "aviators"
  desc = "A pair of designer sunglasses."
  icon_state = "aviator"
  worn_icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses_mob.dmi'
  icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses.dmi'

// Fake-sunglasses Aviators
/obj/item/clothing/glasses/fake_sunglasses/aviator
  name = "aviators"
  desc = "A pair of designer sunglasses. Doesn't seem like it'll block flashes."
  icon_state = "aviator"
  worn_icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses_mob.dmi'
  icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses.dmi'

/obj/item/clothing/glasses/hud/aviator
  worn_icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses_mob.dmi'
  icon_state = "aviator"
  icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses.dmi'
  var/toggleable = FALSE
  var/activation_sound = 'sound/effects/pop.ogg'
  var/off_state
  var/on = TRUE

/obj/item/clothing/glasses/hud/aviator/update_icon()
  if(on)
    icon_state = initial(icon_state)
  else
    icon_state = off_state

/obj/item/clothing/glasses/hud/aviator/attack_self(mob/living/user)
  if(toggleable)
    if(on)
      to_chat(usr, span_notice("You deactivate the optical matrix on the [src]."))
      on = FALSE
      icon_state = off_state
      user.update_inv_glasses()
      flash_protect = FLASH_PROTECTION_NONE
      vision_flags = 0
      hud_type = null
      hud_trait = null
      tint = 0
    else
      to_chat(usr, span_notice("You activate the optical matrix on the [src]."))
      on = TRUE
      icon_state = initial(icon_state)
      user.update_inv_glasses()
      flash_protect = initial(flash_protect)
      tint = initial(tint)
      vision_flags = initial(vision_flags)
      hud_type = initial(hud_type)
      hud_trait = initial(hud_trait)
  update_icon()
  playsound(src, activation_sound, 50, TRUE)
  user.update_inv_glasses()
  user.update_action_buttons()
  user.update_sight()
  ..()

// Security Aviators
/obj/item/clothing/glasses/hud/aviator/security
  name = "security HUD aviators"
  desc = "A heads-up display that scans the humanoids in view and provides accurate data about their ID status and security records. This HUD has been fitted inside of a pair of sunglasses with toggleable electrochromatic tinting."
  icon_state = "aviator_sec"
  off_state = "aviator_sec_flash"
  toggleable = TRUE
  darkness_view = 1
  flash_protect = FLASH_PROTECTION_NONE
  tint = 0
  vision_correction = FALSE
  hud_type = DATA_HUD_SECURITY_ADVANCED
  hud_trait = TRAIT_SECURITY_HUD
  glass_colour_type = /datum/client_colour/glass_colour/red

/obj/item/clothing/glasses/hud/aviator/security/attack_self(mob/living/user)
  if(toggleable && !user.incapacitated())
    on = !on
    if(on)
      flash_protect = initial(flash_protect)
      to_chat(usr, span_notice("You switch \the [src] to flash protection mode."))
      hud_type = initial(hud_type)
      hud_trait = initial(hud_trait)
      tint = initial(tint)
    else
      flash_protect = FLASH_PROTECTION_FLASH
      to_chat(usr, span_notice("You switch the [src] to HUD mode."))
      hud_type = null
      hud_trait = null
      tint = 1
  update_icon()
  playsound(src, activation_sound, 50, TRUE)
  user.update_inv_glasses()
  user.update_action_buttons()
  user.update_sight()

// Medical Aviators
/obj/item/clothing/glasses/hud/aviator/health
  name = "medical HUD aviators"
  desc = "A heads-up display that scans the humanoids in view and provides accurate data about their health status. This HUD has been fitted inside of a pair of sunglasses."
  icon_state = "aviator_med"
  off_state = "aviator"
  toggleable = TRUE
  vision_correction = FALSE
  hud_type = DATA_HUD_MEDICAL_ADVANCED
  hud_trait = TRAIT_MEDICAL_HUD
  glass_colour_type = /datum/client_colour/glass_colour/lightblue

// (Normal) meson scanner Aviators
/obj/item/clothing/glasses/hud/aviator/meson
  name = "meson HUD aviators"
  desc = "Used by engineering and mining staff to see basic structural and terrain layouts through walls, regardless of lighting conditions. This HUD has been fitted inside of a pair of sunglasses."
  icon_state = "aviator_meson"
  off_state = "aviator"
  toggleable = TRUE
  vision_correction = FALSE
  clothing_traits = list(TRAIT_MADNESS_IMMUNE)
  darkness_view = 2
  vision_flags = SEE_TURFS
  lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
  glass_colour_type = /datum/client_colour/glass_colour/lightgreen

// diagnostic Aviators
/obj/item/clothing/glasses/hud/aviator/aviator/diagnostic
  name = "diagnostic HUD aviators"
  desc = "A heads-up display capable of analyzing the integrity and status of robotics and exosuits. This HUD has been fitted inside of a pair of sunglasses."
  icon_state = "aviator_diagnostic"
  off_state = "aviator"
  toggleable = TRUE
  vision_correction = FALSE
  hud_type = DATA_HUD_DIAGNOSTIC_BASIC
  hud_trait = TRAIT_DIAGNOSTIC_HUD
  glass_colour_type = /datum/client_colour/glass_colour/lightorange

/obj/item/clothing/glasses/hud/aviator/security/prescription
  name = "prescription security HUD aviators"
  desc = "A heads-up display that scans the humanoids in view and provides accurate data about their ID status and security records. This HUD has been fitted inside of a pair of sunglasses with toggleable electrochromatic tinting which. Has lenses that help correct eye sight."
  vision_correction = TRUE
/obj/item/clothing/glasses/hud/aviator/health/prescription
  name = "prescription medical HUD aviators"
  desc = "A heads-up display that scans the humanoids in view and provides accurate data about their health status. This HUD has been fitted inside of a pair of sunglasses which has lenses that help correct eye sight."
  vision_correction = TRUE
/obj/item/clothing/glasses/hud/aviator/meson/aviator
  name = "prescription meson HUD aviators"
  desc = "Used by engineering and mining staff to see basic structural and terrain layouts through walls, regardless of lighting conditions. This HUD has been fitted inside of a pair of sunglasses which has lenses that help correct eye sight."
  vision_correction = TRUE
/obj/item/clothing/glasses/hud/aviator/diagnostic/prescription
  name = "prescription diagnostic HUD aviators"
  desc = "A heads-up display capable of analyzing the integrity and status of robotics and exosuits. This HUD has been fitted inside of a pair of sunglasses which has lenses that help correct eye sight."
  vision_correction = TRUE

// Retinal projector
/obj/item/clothing/glasses/hud/projector
  worn_icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses_mob.dmi'
  icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses.dmi'
  var/toggleable = FALSE
  var/activation_sound = 'sound/effects/pop.ogg'
  var/off_state = "projector-off"
  var/on = TRUE

/obj/item/clothing/glasses/hud/projector/update_icon()
  if(on)
    icon_state = initial(icon_state)
  else
    icon_state = off_state

/obj/item/clothing/glasses/hud/projector/attack_self(mob/living/user)
  if(toggleable)
    if(on)
      to_chat(usr, span_notice("You deactivate the optical meson matrix on the [src]."))
      on = FALSE
      icon_state = off_state
      user.update_inv_glasses()
      flash_protect = FLASH_PROTECTION_NONE
      vision_flags = 0
      hud_type = null
      hud_trait = null
      tint = 0
    else
      to_chat(usr, span_notice("You activate the optical meson matrix on the [src]."))
      on = TRUE
      icon_state = initial(icon_state)
      user.update_inv_glasses()
      flash_protect = initial(flash_protect)
      tint = initial(tint)
      vision_flags = initial(vision_flags)
      hud_type = initial(hud_type)
      hud_trait = initial(hud_trait)
  update_icon()
  playsound(src, activation_sound, 50, TRUE)
  user.update_inv_glasses()
  user.update_action_buttons()
  user.update_sight()
  ..()

/obj/item/clothing/glasses/hud/projector/meson
  name = "retinal projector meson HUD"
  desc = "A headset equipped with a scanning lens and mounted retinal projector. It doesn't provide any eye protection, but it's less obtrusive than goggles."
  icon_state = "projector"
  lighting_alpha = NONE
  vision_flags = SEE_TURFS 
  darkness_view = 2

// Designs
/datum/design/health_hud_aviator
  name = "Medical HUD Aviators"
  desc = "A heads-up display that scans the humanoids in view and provides accurate data about their health status. This HUD has been fitted inside of a pair of sunglasses."
  id = "health_hud_aviator"
  build_type = PROTOLATHE
  materials = list(/datum/material/iron = 700, /datum/material/glass = 800, /datum/material/silver = 350)
  build_path = /obj/item/clothing/glasses/hud/aviator/health
  category = list("Equipment")
  departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/security_hud_aviator
  name = "Security HUD Aviators"
  desc = "A heads-up display that scans the humans in view and provides accurate data about their ID status. This HUD has been fitted inside of a pair of sunglasses."
  id = "security_hud_aviator"
  build_type = PROTOLATHE
  materials = list(/datum/material/iron = 700, /datum/material/glass = 800, /datum/material/silver = 350)
  build_path = /obj/item/clothing/glasses/hud/aviator/security
  category = list("Equipment")
  departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/diagnostic_hud_aviator
  name = "Diagnostic HUD Aviators"
  desc = "A HUD used to analyze and determine faults within robotic machinery. This HUD has been fitted inside of a pair of sunglasses."
  id = "diagnostic_hud_aviator"
  build_type = PROTOLATHE
  materials = list(/datum/material/iron = 700, /datum/material/glass = 800, /datum/material/gold = 350)
  build_path = /obj/item/clothing/glasses/hud/aviator/diagnostic
  category = list("Equipment")
  departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/meson_hud_aviator
  name = "Meson HUD Aviators"
  desc = "Used by engineering and mining staff to see basic structural and terrain layouts through walls, regardless of lighting condition. This HUD has been fitted inside of a pair of sunglasses."
  id = "meson_hud_aviator"
  build_type = PROTOLATHE
  materials = list(/datum/material/iron = 700, /datum/material/glass = 800, /datum/material/silver = 350)
  build_path = /obj/item/clothing/glasses/hud/aviator/meson
  category = list("Equipment")
  departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING
