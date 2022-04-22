#define ARMAMENT_CATEGORY_IMPLANTS "Implants"
#define ARMAMENT_CATEGORY_IMPLANTS_LIMIT 4

/datum/armament_entry/assault_operatives/implants
	category = ARMAMENT_CATEGORY_IMPLANTS
	category_item_limit = ARMAMENT_CATEGORY_IMPLANTS_LIMIT

/datum/armament_entry/assault_operatives/implants/deathrattle
	name = "Deathrattle Implant Kit"
	description = "A collection of implants (and one reusable implanter) that should be injected into the team. When one of the team \
	dies, all other implant holders recieve a mental message informing them of their teammates' name \
	and the location of their death. Unlike most implants, these are designed to be implanted \
	in any creature, biological or mechanical."
	item_type = /obj/item/storage/box/syndie_kit/imp_deathrattle
	cost = 1

/datum/armament_entry/assault_operatives/implants/microbomb
	name = "Microbomb Implant"
	description = "A small bomb implanted into the body. It can be activated manually, or automatically activates on death. WARNING: Permenantly destroys your body and everything you might be carrying."
	item_type = /obj/item/storage/box/syndie_kit/imp_microbomb
	cost = 2

/datum/armament_entry/assault_operatives/implants/storage
	name = "Storage Implant"
	description = "Implanted into the body and activated at will, this covert implant will open a small pocket of bluespace capable of holding two regular sized items within."
	item_type = /obj/item/storage/box/syndie_kit/imp_storage
	cost = 2

/datum/armament_entry/assault_operatives/implants/hacking
	item_type = /obj/item/autosurgeon/organ/syndicate/hackerman
	name = "Hacking Arm Implant"
	description = "An advanced arm implant that comes with cutting edge hacking tools. Perfect for the cybernetically enhanced wirerunners."
	cost = 2

/datum/armament_entry/assault_operatives/implants/freedom
	name = "Freedom Implant"
	description = "Releases the user from common restraints like handcuffs and legcuffs. Comes with four charges."
	item_type = /obj/item/storage/box/syndie_kit/imp_freedom
	cost = 3

/datum/armament_entry/assault_operatives/implants/emp
	name = "EMP Implant"
	item_type = /obj/item/implanter/emp
	description = "An implanter that grants you the ability to create several EMP pulses, centered on you."
	cost = 4

/datum/armament_entry/assault_operatives/implants/thermal
	name = "Thermal Vision Implant"
	description = "These cybernetic eyes will give you thermal vision."
	item_type = /obj/item/autosurgeon/organ/syndicate/thermal_eyes
	cost = 5

/datum/armament_entry/assault_operatives/implants/nodrop
	name = "Anti-Drop Implant"
	description = "When activated forces your hand muscles to tightly grip the object you are holding, preventing you from dropping it involuntarily."
	item_type = /obj/item/autosurgeon/organ/syndicate/nodrop
	cost = 6

/datum/armament_entry/assault_operatives/implants/xray
	name = "X-Ray Vision Implant"
	description = "These cybernetic eyes will give you X-ray vision."
	item_type = /obj/item/autosurgeon/organ/syndicate/xray_eyes
	cost = 7
