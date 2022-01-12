/*
 * Contains
 * /obj/item/rig_module/vision
 * /obj/item/rig_module/vision/multi
 * /obj/item/rig_module/vision/meson
 * /obj/item/rig_module/vision/thermal
 * /obj/item/rig_module/vision/nvg
 * /obj/item/rig_module/vision/medhud
 * /obj/item/rig_module/vision/sechud
 */

/datum/rig_vision
	var/mode
	var/obj/item/clothing/glasses/glasses

/datum/rig_vision/Destroy()
	QDEL_NULL(glasses)
	.=..()

/datum/rig_vision/New()
	if(ispath(glasses))
		glasses = new glasses

/datum/rig_vision/nvg
	mode = "night vision"
	glasses = /obj/item/clothing/glasses/night

/datum/rig_vision/thermal
	mode = "thermal scanner"
	glasses = /obj/item/clothing/glasses/thermal

/datum/rig_vision/meson
	mode = "meson scanner"
	glasses = /obj/item/clothing/glasses/meson

/datum/rig_vision/sechud
	mode = "security HUD"
	glasses = /obj/item/clothing/glasses/hud/security

/datum/rig_vision/medhud
	mode = "medical HUD"
	glasses = /obj/item/clothing/glasses/hud/health

/obj/item/rig_module/vision

	name = "RIG visor"
	desc = "A layered, translucent visor system for a RIG."
	icon_state = "optics"

	base_type = /obj/item/rig_module/vision

	interface_name = "optical scanners"
	interface_desc = "An integrated multi-mode vision system."

	usable = 1
	toggleable = 1
	disruptive = 0
	module_cooldown = 0
	active_power_cost = 100

	engage_string = "Cycle Visor Mode"
	activate_string = "Enable Visor"
	deactivate_string = "Disable Visor"

	var/datum/rig_vision/vision
	var/list/vision_modes = list(
		/datum/rig_vision/nvg,
		/datum/rig_vision/thermal,
		/datum/rig_vision/meson
		)

	var/vision_index

/obj/item/rig_module/vision/Destroy()
	QDEL_NULL(vision)
	.=..()

/obj/item/rig_module/vision/multi

	name = "RIG optical package"
	desc = "A complete visor system of optical scanners and vision modes."
	icon_state = "fulloptics"


	interface_name = "multi optical visor"
	interface_desc = "An integrated multi-mode vision system."

	vision_modes = list(/datum/rig_vision/meson,
						/datum/rig_vision/nvg,
						/datum/rig_vision/thermal,
						/datum/rig_vision/sechud,
						/datum/rig_vision/medhud)

/obj/item/rig_module/vision/meson

	name = "RIG meson scanner"
	desc = "A layered, translucent visor system for a RIG."
	icon_state = "meson"
	origin_tech = list(TECH_MAGNET = 2, TECH_ENGINEERING = 5)
	usable = 0

	interface_name = "meson scanner"
	interface_desc = "An integrated meson scanner."

	vision_modes = list(/datum/rig_vision/meson)

/obj/item/rig_module/vision/thermal

	name = "RIG thermal scanner"
	desc = "A layered, translucent visor system for a RIG."
	icon_state = "thermal"

	usable = 0

	interface_name = "thermal scanner"
	interface_desc = "An integrated thermal scanner."

	vision_modes = list(/datum/rig_vision/thermal)

/obj/item/rig_module/vision/nvg

	name = "RIG night vision interface"
	desc = "A multi input night vision system for a RIG."
	icon_state = "night"
	origin_tech = list(TECH_MAGNET = 6, TECH_ENGINEERING = 6)
	usable = 0

	interface_name = "night vision interface"
	interface_desc = "An integrated night vision system."

	vision_modes = list(/datum/rig_vision/nvg)

/obj/item/rig_module/vision/nvgsec

	name = "security night vision interface"
	desc = "A multi input night vision system for a RIG."
	icon_state = "night"
	origin_tech = list(TECH_MAGNET = 6, TECH_ENGINEERING = 6)
	usable = 0

	interface_name = "night vision hud interface"
	interface_desc = "An integrated night vision and security hud system."

	vision_modes = list(/datum/rig_vision/nvg, /datum/rig_vision/sechud)

/obj/item/rig_module/vision/sechud

	name = "RIG security hud"
	desc = "A simple tactical information system for a RIG."
	icon_state = "securityhud"
	origin_tech = list(TECH_MAGNET = 3, TECH_BIO = 2, TECH_ENGINEERING = 5)
	usable = 0

	interface_name = "security HUD"
	interface_desc = "An integrated security heads up display."

	vision_modes = list(/datum/rig_vision/sechud)

/obj/item/rig_module/vision/medhud

	name = "RIG medical hud"
	desc = "A simple medical status indicator for a RIG."
	icon_state = "healthhud"
	origin_tech = list(TECH_MAGNET = 3, TECH_BIO = 2, TECH_ENGINEERING = 5)
	usable = 0

	interface_name = "medical HUD"
	interface_desc = "An integrated medical heads up display."

	vision_modes = list(/datum/rig_vision/medhud)


// There should only ever be one vision module installed in a suit.
/obj/item/rig_module/vision/installed()
	..()
	holder.visor = src

/obj/item/rig_module/vision/uninstalled(obj/item/weapon/rig/former)
	..()
	former.visor = null

/obj/item/rig_module/vision/engage()
	if(!..())
		return

	var/starting_up = !active

	if(!..() || !vision_modes)
		return 0

	// Don't cycle if this engage() is being called by activate().
	if(starting_up)
		to_chat(holder.wearer, "<font color='blue'>You activate your visual sensors.</font>")
		playsound(get_turf(holder), vision.glasses.activation_sound, VOLUME_MID, TRUE)
		return 1

	if(vision_modes.len > 1)
		vision_index++
		if(vision_index > vision_modes.len)
			vision_index = 1
		vision = vision_modes[vision_index]

		to_chat(holder.wearer, "<font color='blue'>You cycle your sensors to <b>[vision.mode]</b> mode.</font>")
	else
		to_chat(holder.wearer, "<font color='blue'>Your sensors only have one mode.</font>")
	return 1

/obj/item/rig_module/vision/Initialize()
	. = ..()

	if(!vision_modes)
		return

	vision_index = 1
	var/list/processed_vision = list()

	for(var/vision_mode in vision_modes)
		var/datum/rig_vision/vision_datum = new vision_mode
		if(!vision) vision = vision_datum
		processed_vision += vision_datum

	vision_modes = processed_vision