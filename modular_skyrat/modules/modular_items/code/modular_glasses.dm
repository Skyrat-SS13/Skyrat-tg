#define MODE_OFF "off"
#define MODE_OFF_FLASH_PROTECTION "flash protection"
#define MODE_ON "on"
#define MODE_FREEZE_ANIMATION "freeze"

/obj/item/clothing/glasses/hud/ar
  name = "\improper AR glasses"
  icon = 'icons/obj/clothing/glasses.dmi'
  icon_state = "glasses"
  desc = "A heads-up display that provides important info in (almost) real time. These don't really seem to work"
  actions_types = list(/datum/action/item_action/toggle_mode)
  glass_colour_type = /datum/client_colour/glass_colour/gray
  /// Defines sound to be played upon mode switching
  var/modeswitch_sound = 'sound/effects/pop.ogg'
  /// Iconstate for when the status is off (TODO:  off_state --> modes_states list for expandability)
  var/off_state = "salesman_fzz"
  /// Sets a list of modes to cycle through
  var/list/modes = list(MODE_OFF = MODE_ON, MODE_ON = MODE_OFF)
  /// Defines initial mode upon initialisation, best to leave this on MODE_ON
  var/mode = MODE_ON
  /// Defines messages that will be shown to the user upon switching modes (e.g. turning it on)
  var/list/modes_msg = list(MODE_ON = "You activate the optical matrix on the ", MODE_OFF = "You deactivate the optical matrix on the ")

/// Reuse logic from engine_goggles.dm
/obj/item/clothing/glasses/hud/ar/Initialize(mapload)
  . = ..()
  AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/glasses/hud/ar/Destroy()
  . = ..()
  STOP_PROCESSING(SSobj, src)

/obj/item/clothing/glasses/hud/ar/proc/toggle_mode(mob/user, voluntary)
  if(mode == modes[mode])
    return // If there is only really one mode to cycle through, early return
  if(mode == MODE_FREEZE_ANIMATION)
    icon = initial(icon) /// Resets icon to initial value after MODE_FREEZE_ANIMATION, since MODE_FREEZE_ANIMATION replaces it with non-animated version of initial
  mode = modes[mode] // Change modes
  balloon_alert(user, span_notice("[modes_msg[mode]][src].")) /// Print the message defined for this mode as a balloon over the user
  switch(mode)
    if(MODE_ON)
      /// Resets all the vars to their initial values (THIS PRESUMES THE DEFAULT STATE IS ON)
      worn_icon = initial(worn_icon)
      icon_state = initial(icon_state)
      flash_protect = initial(flash_protect)
      tint = initial(tint)
      vision_flags = initial(vision_flags)
      hud_type = initial(hud_type)
      hud_trait = initial(hud_trait)
      clothing_traits = initial(clothing_traits)
      ADD_TRAIT(user, hud_trait, GLASSES_TRAIT)
    if(MODE_FREEZE_ANIMATION)
      /// Create new icon and worn_icon, with only the first frame of every state and setting that as icon.
      /// this practically freezes the animation :)
      var/icon/frozen_icon = new(icon, frame = 1)
      icon = frozen_icon
      var/icon/frozen_worn_icon =new(worn_icon, frame = 1)
      worn_icon = frozen_worn_icon
  if(mode == MODE_OFF || mode == MODE_OFF_FLASH_PROTECTION) /// pass both off modes to this step
    icon_state = off_state /// Sets icon_state to be the off variant set in the vars
    flash_protect = (mode == MODE_OFF_FLASH_PROTECTION) ? FLASH_PROTECTION_FLASH : FLASH_PROTECTION_NONE /// when off is supposed to have flash protection
    tint = (mode == MODE_OFF_FLASH_PROTECTION) ? 0 : 1 /// when off is suppost to tint the glasses
    vision_flags = 0 /// Sets vision_flags to 0 to disable meson view mainly
    lighting_alpha = user.default_lighting_alpha() // Resets lighting_alpha to user's default one
    hud_type = null /// no hud when off, obviously!
    hud_trait = null /// no hud when off, obviously!
    clothing_traits = null /// also disables the options for Science functionality
    REMOVE_TRAIT(user, hud_trait, GLASSES_TRAIT)
  playsound(src, modeswitch_sound, 50, TRUE) // play sound set in vars!
  // Blah blah, fix vision and update icons
  if(ishuman(user))
    var/mob/living/carbon/human/H = user
    if(H.glasses == src)
      H.update_sight()
  update_action_buttons()
  update_appearance()

/obj/item/clothing/glasses/hud/ar/attack_self(mob/user)
  toggle_mode(user, TRUE)

/obj/item/clothing/glasses/hud/ar/aviator
  name = "aviators"
  desc = "A pair of designer sunglasses with electrochromatic darkening lenses!"
  worn_icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses_mob.dmi'
  icon_state = "aviator"
  icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses.dmi'
  darkness_view = 1
  flash_protect = FLASH_PROTECTION_FLASH
  modes = list(MODE_OFF = MODE_ON, MODE_ON = MODE_OFF)
  tint = 0
  off_state = "aviator_off"

/obj/item/clothing/glasses/fake_sunglasses/aviator
  name = "aviators"
  desc = "A pair of designer sunglasses. Doesn't seem like it'll block flashes."
  worn_icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses_mob.dmi'
  icon_state = "aviator"
  icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses.dmi'

// Security Aviators
/obj/item/clothing/glasses/hud/ar/aviator/security
  name = "security HUD aviators"
  desc = "A heads-up display that scans the humanoids in view and provides accurate data about their ID status and security records. This HUD has been fitted inside of a pair of sunglasses with toggleable electrochromatic tinting."
  icon_state = "aviator_sec"
  off_state = "aviator_sec_flash"
  flash_protect = FLASH_PROTECTION_NONE
  hud_type = DATA_HUD_SECURITY_ADVANCED
  hud_trait = TRAIT_SECURITY_HUD
  glass_colour_type = /datum/client_colour/glass_colour/red
  modes = list(MODE_OFF_FLASH_PROTECTION = MODE_ON, MODE_ON = MODE_OFF_FLASH_PROTECTION)
  modes_msg = list(MODE_ON = "You switch to flash protection mode and deactivate the optical matrix on the  ", MODE_OFF_FLASH_PROTECTION = "You switch to HUD mode, activating the optical matrix on the ")

// Medical Aviators
/obj/item/clothing/glasses/hud/ar/aviator/health
  name = "medical HUD aviators"
  desc = "A heads-up display that scans the humanoids in view and provides accurate data about their health status. This HUD has been fitted inside of a pair of sunglasses."
  icon_state = "aviator_med"
  flash_protect = FLASH_PROTECTION_NONE
  hud_type = DATA_HUD_MEDICAL_ADVANCED
  hud_trait = TRAIT_MEDICAL_HUD
  glass_colour_type = /datum/client_colour/glass_colour/lightblue

// (Normal) meson scanner Aviators
/obj/item/clothing/glasses/hud/ar/aviator/meson
  name = "meson HUD aviators"
  desc = "A heads-up display used by engineering and mining staff to see basic structural and terrain layouts through walls, regardless of lighting conditions. This HUD has been fitted inside of a pair of sunglasses."
  icon_state = "aviator_meson"
  flash_protect = FLASH_PROTECTION_NONE
  clothing_traits = list(TRAIT_MADNESS_IMMUNE)
  darkness_view = 2
  vision_flags = SEE_TURFS
  lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
  glass_colour_type = /datum/client_colour/glass_colour/lightgreen

// diagnostic Aviators
/obj/item/clothing/glasses/hud/ar/aviator/diagnostic
  name = "diagnostic HUD aviators"
  desc = "A heads-up display capable of analyzing the integrity and status of robotics and exosuits. This HUD has been fitted inside of a pair of sunglasses."
  icon_state = "aviator_diagnostic"
  flash_protect = FLASH_PROTECTION_NONE
  hud_type = DATA_HUD_DIAGNOSTIC_BASIC
  hud_trait = TRAIT_DIAGNOSTIC_HUD
  glass_colour_type = /datum/client_colour/glass_colour/lightorange

// Science Aviators
/obj/item/clothing/glasses/hud/ar/aviator/science
  name = "science aviators"
  desc = "A pair of tacky purple aviator sunglasses that allow the wearer to recognize various chemical compounds with only a glance."
  icon_state = "aviator_sci"
  flash_protect = FLASH_PROTECTION_NONE
  glass_colour_type = /datum/client_colour/glass_colour/purple
  resistance_flags = ACID_PROOF
  armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 80, ACID = 100)
  clothing_traits = list(TRAIT_REAGENT_SCANNER, TRAIT_RESEARCH_SCANNER)

/obj/item/clothing/glasses/hud/ar/aviator/security/prescription
  name = "prescription security HUD aviators"
  desc = "A heads-up display that scans the humanoids in view and provides accurate data about their ID status and security records. This HUD has been fitted inside of a pair of sunglasses with toggleable electrochromatic tinting which. Has lenses that help correct eye sight."
  vision_correction = TRUE

/obj/item/clothing/glasses/hud/ar/aviator/health/prescription
  name = "prescription medical HUD aviators"
  desc = "A heads-up display that scans the humanoids in view and provides accurate data about their health status. This HUD has been fitted inside of a pair of sunglasses which has lenses that help correct eye sight."
  vision_correction = TRUE

/obj/item/clothing/glasses/hud/ar/aviator/meson/prescription
  name = "prescription meson HUD aviators"
  desc = "A heads-up display used by engineering and mining staff to see basic structural and terrain layouts through walls, regardless of lighting conditions. This HUD has been fitted inside of a pair of sunglasses which has lenses that help correct eye sight."
  vision_correction = TRUE

/obj/item/clothing/glasses/hud/ar/aviator/diagnostic/prescription
  name = "prescription diagnostic HUD aviators"
  desc = "A heads-up display capable of analyzing the integrity and status of robotics and exosuits. This HUD has been fitted inside of a pair of sunglasses which has lenses that help correct eye sight."
  vision_correction = TRUE

/obj/item/clothing/glasses/hud/ar/aviator/science/prescription
  name = "prescription science aviators"
  desc = "A pair of tacky purple aviator sunglasses that allow the wearer to recognize various chemical compounds with only a glance, which has lenses that help correct eye sight."
  vision_correction = TRUE

// Retinal projector

/obj/item/clothing/glasses/hud/ar/projector
  name = "retinal projector"
  desc = "A headset equipped with a scanning lens and mounted retinal projector. It doesn't provide any eye protection, but it's less obtrusive than a visor."
  icon_state = "projector"
  worn_icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses_mob.dmi'
  icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses.dmi'
  flags_cover = null /// It doesn't actually cover up any parts
  off_state = "projector-off"
  modes = list(MODE_OFF = MODE_ON, MODE_ON = MODE_FREEZE_ANIMATION, MODE_FREEZE_ANIMATION = MODE_OFF)
  modes_msg = list(MODE_ON = "You activate the projector, a projector folds out as it starts flashing on your ", MODE_FREEZE_ANIMATION = "You switch to a continuous beam on your ", MODE_OFF = "As you press a button on the side. The projector deactivates, the projector folds inward back into the " )

/obj/item/clothing/glasses/hud/ar/projector/meson
  name = "retinal projector meson HUD"
  icon_state = "projector_meson"
  lighting_alpha = 300
  vision_flags = SEE_TURFS
  darkness_view = 2

/obj/item/clothing/glasses/hud/ar/projector/health
  name = "retinal projector health HUD"
  icon_state = "projector_med"
  hud_type = DATA_HUD_MEDICAL_ADVANCED
  hud_trait = list(ID_HUD, TRAIT_MEDICAL_HUD)

/obj/item/clothing/glasses/hud/ar/projector/security
  name = "retinal projector security HUD"
  icon_state = "projector_sec"
  hud_type = DATA_HUD_SECURITY_ADVANCED
  hud_trait = TRAIT_SECURITY_HUD

/obj/item/clothing/glasses/hud/ar/projector/diagnostic
  name = "retinal projector diagnostic HUD"
  icon_state = "projector_diagnostic"
  hud_type = DATA_HUD_DIAGNOSTIC_BASIC
  hud_trait = TRAIT_DIAGNOSTIC_HUD

/obj/item/clothing/glasses/hud/ar/projector/science
  name = "science retinal projector"
  icon_state = "projector_sci"
  clothing_traits = list(TRAIT_REAGENT_SCANNER, TRAIT_RESEARCH_SCANNER)

#undef MODE_OFF
#undef MODE_OFF_FLASH_PROTECTION
#undef MODE_ON
#undef MODE_FREEZE_ANIMATION
