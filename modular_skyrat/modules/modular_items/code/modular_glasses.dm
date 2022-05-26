/obj/item/clothing/glasses/hud/aviator
  name = "aviators"
  desc = "A pair of designer sunglasses."
  worn_icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses_mob.dmi'
  icon_state = "aviator"
  icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses.dmi'
  darkness_view = 1
  flash_protect = FLASH_PROTECTION_FLASH
  tint = 0
  vision_correction = FALSE
  var/toggleable = FALSE
  var/activation_sound = 'sound/effects/pop.ogg'
  var/off_state
  var/on = TRUE

/obj/item/clothing/glasses/hud/aviator/suicide_act(mob/living/carbon/user)
  user.visible_message(span_suicide("[user] is posing rapidly with their [src] on... Clearly breathtaking. It looks like [user.p_theyre()] trying to commit suicide!"))
  return OXYLOSS

/obj/item/clothing/glasses/hud/aviator/fake
  desc = "A pair of designer sunglasses. Doesn't seem like it'll block flashes."
  flash_protect = FLASH_PROTECTION_NONE

/obj/item/clothing/glasses/hud/aviator/update_icon()
  if(on)
    icon_state = initial(icon_state)
  else
    icon_state = off_state

/obj/item/clothing/glasses/hud/aviator/attack_self(mob/living/user)
  !toggleable ? return ..() : null
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
    clothing_traits = null
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
    clothing_traits = initial(clothing_traits)
  update_icon()
  playsound(src, activation_sound, 50, TRUE)
  user.update_inv_glasses()
  user.update_action_buttons()
  if(ishuman(user))
    var/mob/living/carbon/human/H = user
    if(H.glasses == src)
      H.update_sight()

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
    if(ishuman(user))
      var/mob/living/carbon/human/H = user
      if(H.glasses == src)
        H.update_sight()
  ..()

// Medical Aviators
/obj/item/clothing/glasses/hud/aviator/health
  name = "medical HUD aviators"
  desc = "A heads-up display that scans the humanoids in view and provides accurate data about their health status. This HUD has been fitted inside of a pair of sunglasses."
  icon_state = "aviator_med"
  off_state = "aviator"
  toggleable = TRUE
  flash_protect = FLASH_PROTECTION_NONE
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
  flash_protect = FLASH_PROTECTION_NONE
  clothing_traits = list(TRAIT_MADNESS_IMMUNE)
  darkness_view = 2
  vision_flags = SEE_TURFS
  lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
  glass_colour_type = /datum/client_colour/glass_colour/lightgreen

// diagnostic Aviators
/obj/item/clothing/glasses/hud/aviator/diagnostic
  name = "diagnostic HUD aviators"
  desc = "A heads-up display capable of analyzing the integrity and status of robotics and exosuits. This HUD has been fitted inside of a pair of sunglasses."
  icon_state = "aviator_diagnostic"
  off_state = "aviator"
  toggleable = TRUE
  flash_protect = FLASH_PROTECTION_NONE
  hud_type = DATA_HUD_DIAGNOSTIC_BASIC
  hud_trait = TRAIT_DIAGNOSTIC_HUD
  glass_colour_type = /datum/client_colour/glass_colour/lightorange

// Science Aviators
/obj/item/clothing/glasses/hud/aviator/science
  name = "science aviators"
  desc = "A pair of tacky purple aviator sunglasses that allow the wearer to recognize various chemical compounds with only a glance."
  icon_state = "aviator_sci"
  off_state = "aviator"
  toggleable = TRUE
  flash_protect = FLASH_PROTECTION_NONE
  glass_colour_type = /datum/client_colour/glass_colour/purple
  resistance_flags = ACID_PROOF
  armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 80, ACID = 100)
  clothing_traits = list(TRAIT_REAGENT_SCANNER, TRAIT_RESEARCH_SCANNER)

/obj/item/clothing/glasses/hud/aviator/security/prescription
  name = "prescription security HUD aviators"
  desc = "A heads-up display that scans the humanoids in view and provides accurate data about their ID status and security records. This HUD has been fitted inside of a pair of sunglasses with toggleable electrochromatic tinting which. Has lenses that help correct eye sight."
  vision_correction = TRUE

/obj/item/clothing/glasses/hud/aviator/health/prescription
  name = "prescription medical HUD aviators"
  desc = "A heads-up display that scans the humanoids in view and provides accurate data about their health status. This HUD has been fitted inside of a pair of sunglasses which has lenses that help correct eye sight."
  vision_correction = TRUE

/obj/item/clothing/glasses/hud/aviator/meson/prescription
  name = "prescription meson HUD aviators"
  desc = "Used by engineering and mining staff to see basic structural and terrain layouts through walls, regardless of lighting conditions. This HUD has been fitted inside of a pair of sunglasses which has lenses that help correct eye sight."
  vision_correction = TRUE

/obj/item/clothing/glasses/hud/aviator/diagnostic/prescription
  name = "prescription diagnostic HUD aviators"
  desc = "A heads-up display capable of analyzing the integrity and status of robotics and exosuits. This HUD has been fitted inside of a pair of sunglasses which has lenses that help correct eye sight."
  vision_correction = TRUE

/obj/item/clothing/glasses/hud/aviator/science/prescription
  name = "prescription science aviators"
  desc = "A pair of tacky purple aviator sunglasses that allow the wearer to recognize various chemical compounds with only a glance, which has lenses that help correct eye sight."
  vision_correction = TRUE

// Retinal projector

#define MODE_OFF "off"
#define MODE_FLASHING "on1"
#define MODE_CONTINUOUS "on2"

/obj/item/clothing/glasses/hud/projector
  name = "retinal projector"
  desc = "A headset equipped with a scanning lens and mounted retinal projector. It doesn't provide any eye protection, but it's less obtrusive than goggles."
  icon_state = "projector"
  worn_icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses_mob.dmi'
  icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses.dmi'
  flags_cover = null // It doesn't actually cover up any parts
  var/toggleable = TRUE
  var/activation_sound = 'sound/effects/pop.ogg'
  var/off_state = "projector-off"
  var/list/modes = list(MODE_OFF = MODE_FLASHING, MODE_FLASHING = MODE_CONTINUOUS, MODE_CONTINUOUS = MODE_OFF)
  var/mode = MODE_FLASHING

/obj/item/clothing/glasses/hud/projector/attack_self(mob/user, voluntary)
  mode = modes[mode]
  switch(mode)
    if(MODE_FLASHING)
      to_chat(user, span_notice("You activate the [src], a projector folds out as it starts flashing."))
      icon = initial(icon)
      worn_icon = initial(worn_icon)
      icon_state = initial(icon_state)
      user.update_inv_glasses()
      flash_protect = initial(flash_protect)
      tint = initial(tint)
      vision_flags = initial(vision_flags)
      hud_type = initial(hud_type)
      hud_trait = initial(hud_trait)
      clothing_traits = initial(clothing_traits)
    if(MODE_CONTINUOUS) // freezes animation and only takes 1st frame, why would you want a laser shining in your eye all the time?
      to_chat(user, span_notice("You switch modes on the [src], it's is now projecting continously"))
      var/icon/I = new(icon, frame = 1)
      icon = I
      var/icon/W = new(worn_icon, frame = 1)
      worn_icon = W
    if(MODE_OFF)
      to_chat(user, span_notice("As you press a button on the side. The [src] deactivates, the projector folds inward."))
      icon_state = off_state
      user.update_inv_glasses()
      flash_protect = FLASH_PROTECTION_NONE
      vision_flags = 0
      hud_type = null
      hud_trait = null
      tint = 0
      clothing_traits = null
  playsound(src, activation_sound, 50, TRUE)
  user.update_inv_glasses()
  user.update_action_buttons()
  if(ishuman(user))
    var/mob/living/carbon/human/H = user
    if(H.glasses == src)
      H.update_sight()
  ..()

/obj/item/clothing/glasses/hud/projector/meson
  name = "retinal projector meson HUD"
  desc = "A headset equipped with a scanning lens and mounted retinal projector. It doesn't provide any eye protection, but it's less obtrusive than goggles."
  icon_state = "projector_meson"
  lighting_alpha = 300
  vision_flags = SEE_TURFS 
  darkness_view = 2

/obj/item/clothing/glasses/hud/projector/health
  name = "retinal projector health HUD"
  desc = "A headset equipped with a scanning lens and mounted retinal projector. It doesn't provide any eye protection, but it's less obtrusive than a visor."
  icon_state = "projector_med"
  hud_type = DATA_HUD_MEDICAL_ADVANCED
  hud_trait = TRAIT_MEDICAL_HUD

/obj/item/clothing/glasses/hud/projector/security
  name = "retinal projector security HUD"
  desc = "A headset equipped with a scanning lens and mounted retinal projector. It doesn't provide any eye protection, but it's less obtrusive than a visor."
  icon_state = "projector_sec"
  hud_type = DATA_HUD_SECURITY_ADVANCED
  hud_trait = TRAIT_SECURITY_HUD

/obj/item/clothing/glasses/hud/projector/diagnostic
  name = "retinal projector diagnostic HUD"
  desc = "A headset equipped with a scanning lens and mounted retinal projector. It doesn't provide any eye protection, but it's less obtrusive than a visor."
  icon_state = "projector_diagnostic"
  hud_type = DATA_HUD_DIAGNOSTIC_BASIC
  hud_trait = TRAIT_DIAGNOSTIC_HUD

/obj/item/clothing/glasses/hud/projector/science
  name = "science retinal projector"
  desc = "A headset equipped with a scanning lens and mounted retinal projector. It doesn't provide any eye protection, but it's less obtrusive than a visor."
  icon_state = "projector_sci"
  clothing_traits = list(TRAIT_REAGENT_SCANNER, TRAIT_RESEARCH_SCANNER)
