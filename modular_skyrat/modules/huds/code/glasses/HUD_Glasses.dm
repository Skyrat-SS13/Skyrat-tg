/obj/item/clothing/glasses/hud/health/prescription
	name = "prescription health scanner HUD"
	desc = "A heads-up display that scans the humanoids in view and provides accurate data about their health status. This one has prescription lenses."
	icon = 'modular_skyrat/modules/huds/icons/huds.dmi'
	icon_state = "glasses_healthhud"
	worn_icon = 'modular_skyrat/modules/huds/icons/hudeyes.dmi'

/obj/item/clothing/glasses/hud/health/prescription/Initialize(mapload)
	. = ..()
	clothing_traits += list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/hud/diagnostic/prescription
	name = "prescription diagnostic HUD"
	desc = "A heads-up display capable of analyzing the integrity and status of robotics and exosuits. This one has prescription lenses."
	icon = 'modular_skyrat/modules/huds/icons/huds.dmi'
	icon_state = "glasses_diagnostichud"
	worn_icon = 'modular_skyrat/modules/huds/icons/hudeyes.dmi'

/obj/item/clothing/glasses/hud/diagnostic/prescription/Initialize(mapload)
	. = ..()
	clothing_traits += list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/hud/security/prescription
	name = "prescription security HUD"
	desc = "A heads-up display that scans the humanoids in view and provides accurate data about their ID status and security records. This one has prescription lenses."
	icon = 'modular_skyrat/modules/huds/icons/huds.dmi'
	icon_state = "glasses_securityhud"
	worn_icon = 'modular_skyrat/modules/huds/icons/hudeyes.dmi'

/obj/item/clothing/glasses/hud/security/prescription/Initialize(mapload)
	. = ..()
	clothing_traits += list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/science/prescription
	name = "prescription science glasses"
	desc = "These glasses scan the contents of containers and projects their contents to the user in an easy to read format. This one has prescription lenses."
	icon = 'modular_skyrat/modules/huds/icons/huds.dmi'
	icon_state = "glasses_sciencehud"
	worn_icon = 'modular_skyrat/modules/huds/icons/hudeyes.dmi'
	glass_colour_type = /datum/client_colour/glass_colour/purple
	armor_type = /datum/armor/prescription_science

/obj/item/clothing/glasses/science/prescription/Initialize()
	. = ..()
	clothing_traits += list(TRAIT_NEARSIGHTED_CORRECTED)

/datum/armor/prescription_science
	fire = 80
	acid = 100

/obj/item/clothing/glasses/meson/prescription
	name = "prescription optical meson scanner"
	desc = "Used by engineering and mining staff to see basic structural and terrain layouts through walls, regardless of lighting conditions. This one has prescription lens fitted in."

/obj/item/clothing/glasses/meson/prescription/Initialize(mapload)
	. = ..()
	clothing_traits += list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/meson/engine/prescription
	name = "prescription engineering scanner goggles"
	desc = "Goggles used by engineers. The Meson Scanner mode lets you see basic structural and terrain layouts through walls, the T-ray Scanner mode lets you see underfloor objects such as cables and pipes, and the Radiation Scanner mode let's you see objects contaminated by radiation. Each lens has been replaced with a corrective lens."

/obj/item/clothing/glasses/meson/engine/prescription/Initialize(mapload)
	. = ..()
	clothing_traits += list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/meson/engine/tray/prescription
	name = "prescription optical t-ray scanner"
	desc = "Goggles used by engineers. The Meson Scanner mode lets you see basic structural and terrain layouts through walls, the T-ray Scanner mode lets you see underfloor objects such as cables and pipes, and the Radiation Scanner mode let's you see objects contaminated by radiation. This one has a lens that help correct eye sight."

/obj/item/clothing/glasses/meson/engine/tray/prescription/Initialize(mapload)
	. = ..()
	clothing_traits += list(TRAIT_NEARSIGHTED_CORRECTED)
