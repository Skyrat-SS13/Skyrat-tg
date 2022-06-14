/datum/opposing_force_equipment/implant
	category = OPFOR_EQUIPMENT_CATEGORY_IMPLANTS

// Skillchips
/datum/opposing_force_equipment/implant/engichip
	item_type = /obj/item/skillchip/job/engineer
	description = "A skillchip that, when installed, allows the user to recognise airlock and APC wire layouts and understand their functionality at a glance. Highly valuable and sought after."

/datum/opposing_force_equipment/implant/roboticist
	item_type = /obj/item/skillchip/job/roboticist
	description = "A skillchip that, when installed, allows the user to recognise cyborg wire layouts and understand their functionality at a glance."

/datum/opposing_force_equipment/implant/tacticool
	item_type = /obj/item/skillchip/chameleon/reload

// Actual Implants
/datum/opposing_force_equipment/implant/stealth
	name = "Stealth Implant"
	item_type = /obj/item/implanter/stealth
	description = "An implanter that grants you the ability to wield the ultimate in invisible box technology. Best used in conjunction with \
					a tape recorder playing Snake Eater."

/datum/opposing_force_equipment/implant/radio
	name = "Syndicate Radio Implant"
	item_type = /obj/item/implanter/radio/syndicate
	description = "An implanter that grants you inherent access to the Syndicate radio channel, in addition to being able to listen to all on-station channels."
	admin_note = "Warning: This can let someone get in contact with actual antagonists via the Syndicate channel."

/datum/opposing_force_equipment/implant/storage
	name = "Storage Implant"
	item_type = /obj/item/implanter/storage
	description = "An implanter that grants you access to a small pocket of bluespace, capable of storing a few items."

/datum/opposing_force_equipment/implant/freedom
	name = "Freedom Implant"
	item_type = /obj/item/implanter/freedom
	description = "An implanter that grants you the ability to break out of handcuffs a certain number of times."

/datum/opposing_force_equipment/implant/micro
	name = "Microbomb Implant"
	item_type = /obj/item/implanter/explosive
	description = "An implanter that will make you explode on death in a decent-sized explosion."

/datum/opposing_force_equipment/implant/macro
	name = "Macrobomb Implant"
	item_type = /obj/item/implanter/explosive_macro
	description = "An implanter that will make you explode on death in a massive explosion, fun!"
	admin_note = "Warning: Equivalent to 10 microbombs."

/datum/opposing_force_equipment/implant/emp
	name = "EMP Implant"
	item_type = /obj/item/implanter/emp
	description = "An implanter that grants you the ability to create several EMP pulses, centered on you."

// Cybernetic Enhancements
/datum/opposing_force_equipment/implant/nodrop
	item_type = /obj/item/autosurgeon/organ/syndicate/nodrop
	name = "Anti Drop Implant"
	description = "An implant that prevents you from dropping items in your hand involuntarily. Comes loaded in a syndicate autosurgeon."

/datum/opposing_force_equipment/implant/hackerman
	item_type = /obj/item/autosurgeon/organ/syndicate/hackerman
	name = "Hacking Arm Implant"
	description = "An advanced arm implant that comes with cutting edge hacking tools. Perfect for the cybernetically enhanced wirerunners."

/datum/opposing_force_equipment/implant/cns
	name = "CNS Rebooter Implant"
	item_type = /obj/item/autosurgeon/organ/syndicate/anti_stun
	description = "This implant will automatically give you back control over your central nervous system, reducing downtime when stunned."

/datum/opposing_force_equipment/implant/reviver
	name = "Reviver Implant"
	item_type = /obj/item/autosurgeon/organ/syndicate/reviver
	description = "This implant will attempt to revive and heal you if you lose consciousness. For the faint of heart!"

/datum/opposing_force_equipment/implant/xray
	name = "X-Ray Eyes"
	item_type = /obj/item/autosurgeon/organ/syndicate/xray_eyes
	description = "These cybernetic eyes will give you X-ray vision. Blinking is futile."

/datum/opposing_force_equipment/implant/thermal
	name = "Thermal Eyes"
	item_type = /obj/item/autosurgeon/organ/syndicate/thermal_eyes
	description = "These cybernetic eye implants will give you thermal vision. Vertical slit pupil included."

/datum/opposing_force_equipment/implant/armlaser
	name = "Arm-mounted Laser Implant"
	item_type = /obj/item/autosurgeon/organ/syndicate/laser_arm
	description = "A variant of the arm cannon implant that fires lethal laser beams. The cannon emerges from the subject's arm and remains inside when not in use."

/datum/opposing_force_equipment/implant/eswordarm
	name = "Energy Sword Arm Implant"
	item_type = /obj/item/autosurgeon/organ/syndicate/esword_arm
	description = "It's an energy sword, in your arm. Pretty decent for getting past stop-searches and assassinating people. Comes loaded in a Syndicate brand autosurgeon to boot!"
