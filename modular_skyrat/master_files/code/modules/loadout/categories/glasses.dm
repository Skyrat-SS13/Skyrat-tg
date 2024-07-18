/*
*	PRESCRIPTION GLASSES
*/

/datum/loadout_item/glasses/prescription_glasses
	name = "Glasses"
	item_path = /obj/item/clothing/glasses/regular
	additional_displayed_text = list("PRESCRIPTION")

/datum/loadout_item/glasses/prescription_glasses/circle_glasses
	name = "Circle Glasses"
	item_path = /obj/item/clothing/glasses/regular/circle

/datum/loadout_item/glasses/prescription_glasses/hipster_glasses
	name = "Hipster Glasses"
	item_path = /obj/item/clothing/glasses/regular/hipster

/datum/loadout_item/glasses/prescription_glasses/jamjar_glasses
	name = "Jamjar Glasses"
	item_path = /obj/item/clothing/glasses/regular/jamjar

/datum/loadout_item/glasses/prescription_glasses/thin
	name = "Thin Glasses"
	item_path = /obj/item/clothing/glasses/thin

/datum/loadout_item/glasses/prescription_glasses/better
	name = "Modern Glasses"
	item_path = /obj/item/clothing/glasses/regular/betterunshit

/datum/loadout_item/glasses/prescription_glasses/kim
	name = "Binoclard Lenses"
	item_path = /obj/item/clothing/glasses/regular/kim

/*
*	COSMETIC GLASSES
*/

/datum/loadout_item/glasses/cold_glasses
	name = "Cold Glasses"
	item_path = /obj/item/clothing/glasses/cold

/datum/loadout_item/glasses/heat_glasses
	name = "Heat Glasses"
	item_path = /obj/item/clothing/glasses/heat

/datum/loadout_item/glasses/geist_glasses
	name = "Geist Gazers"
	item_path = /obj/item/clothing/glasses/geist_gazers

/datum/loadout_item/glasses/orange_glasses
	name = "Orange Glasses"
	item_path = /obj/item/clothing/glasses/orange

/datum/loadout_item/glasses/psych_glasses
	name = "Psych Glasses"
	item_path = /obj/item/clothing/glasses/psych

/datum/loadout_item/glasses/red_glasses
	name = "Red Glasses"
	item_path = /obj/item/clothing/glasses/red

/*
*	MISC
*/

/datum/loadout_item/glasses/eyepatch
	name = "Eyepatch"
	item_path = /obj/item/clothing/glasses/eyepatch

/datum/loadout_item/glasses/white_eyepatch
	name = "White Eyepatch"
	item_path = /obj/item/clothing/glasses/eyepatch/white

/datum/loadout_item/glasses/medical_eyepatch
	name = "Medical Eyepatch"
	item_path = /obj/item/clothing/glasses/eyepatch/medical


/datum/loadout_item/glasses/fakeblindfold
	name = "Fake Blindfold"
	item_path = /obj/item/clothing/glasses/trickblindfold

/datum/loadout_item/glasses/obsoleteblindfold
	name = "Obselete Fake Blindfold"
	item_path = /obj/item/clothing/glasses/trickblindfold/obsolete

/datum/loadout_item/glasses/eyewrap
	name = "Eyepatch Wrap"
	item_path = /obj/item/clothing/glasses/eyepatch/wrap

/datum/loadout_item/glasses/monocle
	name = "Monocle"
	item_path = /obj/item/clothing/glasses/monocle

/datum/loadout_item/glasses/biker
	name = "Biker Goggles"
	item_path = /obj/item/clothing/glasses/biker

/datum/loadout_item/glasses/aviator_fake
	name = "Fake Aviators"
	item_path = /obj/item/clothing/glasses/fake_sunglasses/aviator

/datum/loadout_item/glasses/retinal_projector
	name = "Civilian Retinal Projector"
	item_path = /obj/item/clothing/glasses/hud/ar/projector

/*
*	JOB-LOCKED
*/

/datum/loadout_item/glasses/medicpatch
	name = "Medical Eyepatch (Skyrat)"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/med
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CORONER)

/datum/loadout_item/glasses/robopatch
	name = "Diagnostic Eyepatch"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/diagnostic
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_SCIENCE_GUARD)

/datum/loadout_item/glasses/scipatch
	name = "Science Eyepatch"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/sci
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_CHEMIST, JOB_SCIENCE_GUARD)

/datum/loadout_item/glasses/mesonpatch
	name = "Meson Eyepatch"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/meson
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_CUSTOMS_AGENT, JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ENGINEERING_GUARD)

/datum/loadout_item/glasses/sechud
	name = "Security HUD"
	item_path = /obj/item/clothing/glasses/hud/security
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/glasses/secpatch
	name = "Security Eyepatch HUD"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/sec
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/glasses/sechud_glasses
	name = "Prescription Security HUD"
	item_path = /obj/item/clothing/glasses/hud/security/prescription
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/glasses/medhud_glasses
	name = "Prescription Medical HUD"
	item_path = /obj/item/clothing/glasses/hud/health/prescription
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CORONER)

/datum/loadout_item/glasses/diaghud_glasses
	name = "Prescription Diagnostic HUD"
	item_path = /obj/item/clothing/glasses/hud/diagnostic/prescription
	restricted_roles = list(JOB_RESEARCH_DIRECTOR,JOB_SCIENTIST, JOB_ROBOTICIST)

/datum/loadout_item/glasses/science_glasses
	name = "Prescription Science glasses"
	item_path = /obj/item/clothing/glasses/hud/science/prescription
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_CHEMIST, JOB_SCIENCE_GUARD)

/datum/loadout_item/glasses/aviator_security
	name = "Security HUD Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/security
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/glasses/aviator_health
	name = "Medical HUD Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/health
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CORONER)

/datum/loadout_item/glasses/aviator_meson
	name = "Meson HUD Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/meson
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_CUSTOMS_AGENT, JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ENGINEERING_GUARD)

/datum/loadout_item/glasses/aviator_diagnostic
	name = "Diagnostic HUD Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/diagnostic
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST)

/datum/loadout_item/glasses/aviator_science
	name = "Science Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/science
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_CHEMIST, JOB_SCIENCE_GUARD)


/datum/loadout_item/glasses/prescription_aviator_security
	name = "Prescription Security HUD Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/security/prescription
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/glasses/prescription_aviator_health
	name = "Prescription Medical HUD Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/health/prescription
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CORONER)

/datum/loadout_item/glasses/prescription_aviator_meson
	name = "Prescription Meson HUD Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/meson/prescription
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_CUSTOMS_AGENT, JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ENGINEERING_GUARD)

/datum/loadout_item/glasses/prescription_aviator_diagnostic
	name = "Prescription Diagnostic HUD Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/diagnostic/prescription
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST)

/datum/loadout_item/glasses/prescription_aviator_science
	name = "Prescription Science Aviators"
	item_path = /obj/item/clothing/glasses/hud/ar/aviator/science/prescription
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_CHEMIST, JOB_SCIENCE_GUARD)

/datum/loadout_item/glasses/retinal_projector_security
	name = "Retinal Projector Security HUD"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/security
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER, JOB_BOUNCER, JOB_ORDERLY, JOB_SCIENCE_GUARD, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_BLUESHIELD)

/datum/loadout_item/glasses/retinal_projector_health
	name = "Retinal Projector Health HUD"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/health
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_PARAMEDIC, JOB_ORDERLY, JOB_CORONER)

/datum/loadout_item/glasses/retinal_projector_meson
	name = "Retinal Projector Meson HUD"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/meson
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_CUSTOMS_AGENT, JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ENGINEERING_GUARD)

/datum/loadout_item/glasses/retinal_projector_diagnostic
	name = "Retinal Projector Diagnostic HUD"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/diagnostic
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST)

/datum/loadout_item/glasses/retinal_projector_science
	name = "Science Retinal Projector"
	item_path = /obj/item/clothing/glasses/hud/ar/projector/science
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_CHEMIST, JOB_SCIENCE_GUARD)

/*
*	FAMILIES
*/

/datum/loadout_item/glasses/osi
	name = "OSI Glasses"
	item_path = /obj/item/clothing/glasses/osi

/datum/loadout_item/glasses/phantom
	name = "Phantom Glasses"
	item_path = /obj/item/clothing/glasses/phantom

/*
*	DONATOR
*/

/datum/loadout_item/glasses/fake_sunglasses
	name = "Fake Sunglasses"
	item_path = /obj/item/clothing/glasses/fake_sunglasses
	donator_only = TRUE
