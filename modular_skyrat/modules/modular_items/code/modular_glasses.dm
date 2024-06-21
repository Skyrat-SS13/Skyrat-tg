#define MODE_OFF "off"
#define MODE_OFF_FLASH_PROTECTION "flash protection"
#define MODE_ON "on"
#define MODE_FREEZE_ANIMATION "freeze"

/obj/item/clothing/glasses/hud/ar
	name = "\improper AR glasses"
	icon = 'icons/obj/clothing/glasses.dmi'
	icon_state = "glasses_regular"
	desc = "A heads-up display that provides important info in (almost) real time. These don't really seem to work"
	actions_types = list(/datum/action/item_action/toggle_mode)
	glass_colour_type = /datum/client_colour/glass_colour/gray
	/// Defines sound to be played upon mode switching
	var/modeswitch_sound = 'sound/effects/pop.ogg'
	/// Iconstate for when the status is off (TODO:  off_state --> modes_states list for expandability)
	var/off_state = "salesman_fzz"
	/// Sets a list of modes to cycle through
	var/list/modes = list(MODE_OFF, MODE_ON)
	/// The current operating mode
	var/mode
	/// Defines messages that will be shown to the user upon switching modes (e.g. turning it on)
	var/list/modes_msg = list(MODE_ON = "optical matrix enabled", MODE_OFF = "optical matrix disabled")
	/// Because initial() will not work on subtypes from within the parent we need to store a reference to the type of the glasses calling the procs
	var/obj/item/clothing/glasses/hud/ar/glasses_type

/// Reuse logic from engine_goggles.dm
/obj/item/clothing/glasses/hud/ar/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob, ITEM_SLOT_EYES)

	// Set our initial values
	mode = MODE_ON
	glasses_type = type

/obj/item/clothing/glasses/hud/ar/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/clothing/glasses/hud/ar/proc/toggle_mode(mob/user, voluntary)

	if(!istype(user) || user.incapacitated())
		return

	if(mode == modes[mode])
		return // If there is only really one mode to cycle through, early return

	if(mode == MODE_FREEZE_ANIMATION)
		icon = initial(glasses_type.icon) /// Resets icon to initial value after MODE_FREEZE_ANIMATION, since MODE_FREEZE_ANIMATION replaces it with non-animated version of initial

	mode = get_next_mode(mode)

	switch(mode)
		if(MODE_ON)
			balloon_alert(user, span_notice("[modes_msg[mode]]"))
			reset_vars() // Resets all the vars to their initial values (THIS PRESUMES THE DEFAULT STATE IS ON)
			add_hud(user)
		if(MODE_FREEZE_ANIMATION)
			balloon_alert(user, span_notice("[modes_msg[mode]]"))
			freeze_animation()
		if(MODE_OFF)
			if(MODE_OFF_FLASH_PROTECTION in modes)
				flash_protect = FLASH_PROTECTION_FLASH
				balloon_alert(user, span_notice("[modes_msg[MODE_OFF_FLASH_PROTECTION]]"))
			else
				balloon_alert(user, span_notice("[modes_msg[mode]]"))
			icon_state = off_state
			disable_vars(user)
			remove_hud(user)

	playsound(src, modeswitch_sound, 50, TRUE) // play sound set in vars!
	update_sight(user)
	update_item_action_buttons()
	update_appearance()

/obj/item/clothing/glasses/hud/ar/proc/get_next_mode(current_mode)
	switch(current_mode)
		if(MODE_ON)
			if(MODE_FREEZE_ANIMATION in modes) // AR projectors go from on to freeze animation mode
				return MODE_FREEZE_ANIMATION
			else
				return MODE_OFF
		if(MODE_OFF)
			return MODE_ON
		if(MODE_FREEZE_ANIMATION)
			return MODE_OFF

/obj/item/clothing/glasses/hud/ar/proc/add_hud(mob/user)
	if(ishuman(user)) // Make sure they're a human wearing the glasses first
		var/mob/living/carbon/human/human = user
		if(human.glasses == src)
			var/datum/atom_hud/our_hud = GLOB.huds[initial(glasses_type.hud_type)]
			our_hud.show_to(human)
			for(var/trait in initial(glasses_type.clothing_traits))
				ADD_TRAIT(human, trait, GLASSES_TRAIT)

/obj/item/clothing/glasses/hud/ar/proc/remove_hud(mob/user)
	if(ishuman(user)) // Make sure they're a human wearing the glasses first
		var/mob/living/carbon/human/human = user
		if(human.glasses == src)
			var/datum/atom_hud/our_hud = GLOB.huds[initial(glasses_type.hud_type)]
			our_hud.hide_from(human)
			for(var/trait in initial(glasses_type.clothing_traits))
				REMOVE_TRAIT(human, trait, GLASSES_TRAIT)

/obj/item/clothing/glasses/hud/ar/proc/reset_vars()
	worn_icon = initial(glasses_type.worn_icon)
	icon_state = initial(glasses_type.icon_state)
	flash_protect = initial(glasses_type.flash_protect)
	tint = initial(glasses_type.tint)
	color_cutoffs = initial(glasses_type.color_cutoffs)
	vision_flags = initial(glasses_type.vision_flags)
	hud_type = initial(glasses_type.hud_type)
	//initial does not currently work on lists so we must do this
	var/obj/item/clothing/glasses/hud/ar/glasses_object = new glasses_type // make a temporary glasses obj
	clothing_traits = glasses_object.clothing_traits // pull the list from the created obj
	qdel(glasses_object) // delete the object

/obj/item/clothing/glasses/hud/ar/proc/disable_vars(mob/user)
	vision_flags = 0 /// Sets vision_flags to 0 to disable meson view mainly
	color_cutoffs = null // Resets lighting_alpha to user's default one
	clothing_traits = null /// also disables the options for Science functionality
	hud_type = null

/// Create new icon and worn_icon, with only the first frame of every state and setting that as icon.
/// this practically freezes the animation :)
/obj/item/clothing/glasses/hud/ar/proc/freeze_animation()
	var/icon/frozen_icon = new(icon, frame = 1)
	icon = frozen_icon
	var/icon/frozen_worn_icon = new(worn_icon, frame = 1)
	worn_icon = frozen_worn_icon

// Blah blah, fix vision and update icons
/obj/item/clothing/glasses/hud/ar/proc/update_sight(mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/human = user
		if(human.glasses == src)
			human.update_sight()

/obj/item/clothing/glasses/hud/ar/attack_self(mob/user)
	toggle_mode(user, TRUE)

/obj/item/clothing/glasses/hud/ar/aviator
	name = "aviators"
	desc = "A pair of designer sunglasses with electrochromatic darkening lenses!"
	worn_icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses_mob.dmi'
	icon_state = "aviator"
	off_state = "aviator_off"
	icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses.dmi'
	flash_protect = FLASH_PROTECTION_FLASH
	modes = list(MODE_OFF, MODE_ON)
	tint = 0

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
	clothing_traits = list(TRAIT_SECURITY_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/red
	modes = list(MODE_OFF_FLASH_PROTECTION, MODE_ON)
	modes_msg = list(MODE_OFF_FLASH_PROTECTION = "flash protection mode", MODE_ON = "optical matrix enabled")

// Medical Aviators
/obj/item/clothing/glasses/hud/ar/aviator/health
	name = "medical HUD aviators"
	desc = "A heads-up display that scans the humanoids in view and provides accurate data about their health status. This HUD has been fitted inside of a pair of sunglasses."
	icon_state = "aviator_med"
	flash_protect = FLASH_PROTECTION_NONE
	hud_type = DATA_HUD_MEDICAL_ADVANCED
	clothing_traits = list(TRAIT_MEDICAL_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/lightblue

// (Normal) meson scanner Aviators
/obj/item/clothing/glasses/hud/ar/aviator/meson
	name = "meson HUD aviators"
	desc = "A heads-up display used by engineering and mining staff to see basic structural and terrain layouts through walls, regardless of lighting conditions. This HUD has been fitted inside of a pair of sunglasses."
	icon_state = "aviator_meson"
	flash_protect = FLASH_PROTECTION_NONE
	clothing_traits = list(TRAIT_MADNESS_IMMUNE)
	vision_flags = SEE_TURFS
	color_cutoffs = list(5, 15, 5)
	glass_colour_type = /datum/client_colour/glass_colour/lightgreen

// diagnostic Aviators
/obj/item/clothing/glasses/hud/ar/aviator/diagnostic
	name = "diagnostic HUD aviators"
	desc = "A heads-up display capable of analyzing the integrity and status of robotics and exosuits. This HUD has been fitted inside of a pair of sunglasses."
	icon_state = "aviator_diagnostic"
	flash_protect = FLASH_PROTECTION_NONE
	hud_type = DATA_HUD_DIAGNOSTIC_BASIC
	clothing_traits = list(TRAIT_DIAGNOSTIC_HUD)
	glass_colour_type = /datum/client_colour/glass_colour/lightorange

// Science Aviators
/obj/item/clothing/glasses/hud/ar/aviator/science
	name = "science aviators"
	desc = "A pair of tacky purple aviator sunglasses that allow the wearer to recognize various chemical compounds with only a glance."
	icon_state = "aviator_sci"
	flash_protect = FLASH_PROTECTION_NONE
	glass_colour_type = /datum/client_colour/glass_colour/purple
	resistance_flags = ACID_PROOF
	armor_type = /datum/armor/aviator_science
	clothing_traits = list(TRAIT_REAGENT_SCANNER, TRAIT_RESEARCH_SCANNER)

/datum/armor/aviator_science
	fire = 80
	acid = 100

/obj/item/clothing/glasses/hud/ar/aviator/security/prescription
	name = "prescription security HUD aviators"
	desc = "A heads-up display that scans the humanoids in view and provides accurate data about their ID status and security records. This HUD has been fitted inside of a pair of sunglasses with toggleable electrochromatic tinting which. Has lenses that help correct eye sight."
	clothing_traits = list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/hud/ar/aviator/health/prescription
	name = "prescription medical HUD aviators"
	desc = "A heads-up display that scans the humanoids in view and provides accurate data about their health status. This HUD has been fitted inside of a pair of sunglasses which has lenses that help correct eye sight."
	clothing_traits = list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/hud/ar/aviator/meson/prescription
	name = "prescription meson HUD aviators"
	desc = "A heads-up display used by engineering and mining staff to see basic structural and terrain layouts through walls, regardless of lighting conditions. This HUD has been fitted inside of a pair of sunglasses which has lenses that help correct eye sight."
	clothing_traits = list(TRAIT_MADNESS_IMMUNE, TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/hud/ar/aviator/diagnostic/prescription
	name = "prescription diagnostic HUD aviators"
	desc = "A heads-up display capable of analyzing the integrity and status of robotics and exosuits. This HUD has been fitted inside of a pair of sunglasses which has lenses that help correct eye sight."
	clothing_traits = list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/hud/ar/aviator/science/prescription
	name = "prescription science aviators"
	desc = "A pair of tacky purple aviator sunglasses that allow the wearer to recognize various chemical compounds with only a glance, which has lenses that help correct eye sight."
	clothing_traits = list(TRAIT_REAGENT_SCANNER, TRAIT_RESEARCH_SCANNER, TRAIT_NEARSIGHTED_CORRECTED)

// Retinal projector

/obj/item/clothing/glasses/hud/ar/projector
	name = "retinal projector"
	desc = "A headset equipped with a scanning lens and mounted retinal projector. It doesn't provide any eye protection, but it's less obtrusive than a visor."
	icon_state = "projector"
	worn_icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses_mob.dmi'
	icon = 'modular_skyrat/modules/modular_items/icons/modular_glasses.dmi'
	flags_cover = null /// It doesn't actually cover up any parts
	off_state = "projector-off"
	modes = list(MODE_OFF, MODE_ON, MODE_FREEZE_ANIMATION)
	modes_msg = list(MODE_ON = "projector enabled", MODE_FREEZE_ANIMATION = "continuous beam mode", MODE_OFF = "projector disabled" )

/obj/item/clothing/glasses/hud/ar/projector/meson
	name = "retinal projector meson HUD"
	icon_state = "projector_meson"
	vision_flags = SEE_TURFS
	color_cutoffs = list(10, 30, 10)

/obj/item/clothing/glasses/hud/ar/projector/health
	name = "retinal projector health HUD"
	icon_state = "projector_med"
	hud_type = DATA_HUD_MEDICAL_ADVANCED
	clothing_traits = list(ID_HUD, TRAIT_MEDICAL_HUD)

/obj/item/clothing/glasses/hud/ar/projector/security
	name = "retinal projector security HUD"
	icon_state = "projector_sec"
	hud_type = DATA_HUD_SECURITY_ADVANCED
	clothing_traits = list(TRAIT_SECURITY_HUD)

/obj/item/clothing/glasses/hud/ar/projector/diagnostic
	name = "retinal projector diagnostic HUD"
	icon_state = "projector_diagnostic"
	hud_type = DATA_HUD_DIAGNOSTIC_BASIC
	clothing_traits = list(TRAIT_DIAGNOSTIC_HUD)

/obj/item/clothing/glasses/hud/ar/projector/science
	name = "science retinal projector"
	icon_state = "projector_sci"
	clothing_traits = list(TRAIT_REAGENT_SCANNER, TRAIT_RESEARCH_SCANNER)

#undef MODE_OFF
#undef MODE_OFF_FLASH_PROTECTION
#undef MODE_ON
#undef MODE_FREEZE_ANIMATION
