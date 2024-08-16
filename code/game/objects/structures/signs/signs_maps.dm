//map and direction signs

/obj/structure/sign/map
	name = "station map"
	desc = "A navigational chart of the station."
	max_integrity = 500

/obj/structure/sign/map/left
	icon_state = "map-left"

/obj/structure/sign/map/right
	icon_state = "map-right"

<<<<<<< HEAD
=======
WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/map/right)

/// Metastation Map
/obj/structure/sign/map/left/metastation
	icon_state = "map-left-MS"

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/map/left/metastation)

/obj/structure/sign/map/right/metastation
	icon_state = "map-right-MS"

WALL_MOUNT_DIRECTIONAL_HELPERS(/obj/structure/sign/map/right/metastation)

/obj/structure/sign/directions
	icon = 'icons/obj/structures/directional_signs.dmi'
	/// What direction is the arrow on the sign pointing?
	var/sign_arrow_direction = null
	/// If this sign has a support on the left or right, which side? null if niether
	var/support_side = null

/obj/structure/sign/directions/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/structure/sign/directions/update_icon_state()
	. = ..()
	if(support_side)
		icon_state = "[initial(icon_state)]_[support_side]"
	else
		icon_state = "[initial(icon_state)]"

/obj/structure/sign/directions/update_overlays()
	. = ..()
	if(sign_arrow_direction)
		. += "arrow_[sign_arrow_direction]"

>>>>>>> fec946e9c007 (/Icon/ Folder cleansing crusade part, I think 4; post-wallening clean-up. (#85823))
/obj/structure/sign/directions/science
	name = "science department sign"
	desc = "A direction sign, pointing out which way the Science department is."
	icon_state = "direction_sci"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/science, 32)

/obj/structure/sign/directions/engineering
	name = "engineering department sign"
	desc = "A direction sign, pointing out which way the Engineering department is."
	icon_state = "direction_eng"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/engineering, 32)

/obj/structure/sign/directions/security
	name = "security department sign"
	desc = "A direction sign, pointing out which way the Security department is."
	icon_state = "direction_sec"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/security, 32)

/obj/structure/sign/directions/medical
	name = "medbay sign"
	desc = "A direction sign, pointing out which way the Medbay is."
	icon_state = "direction_med"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/medical, 32)

/obj/structure/sign/directions/evac
	name = "evacuation sign"
	desc = "A direction sign, pointing out which way the escape shuttle dock is."
	icon_state = "direction_evac"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/evac, 32)

/obj/structure/sign/directions/supply
	name = "cargo sign"
	desc = "A direction sign, pointing out which way the Cargo Bay is."
	icon_state = "direction_supply"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/supply, 32)

/obj/structure/sign/directions/command
	name = "command department sign"
	desc = "A direction sign, pointing out which way the Command department is."
	icon_state = "direction_bridge"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/command, 32)

/obj/structure/sign/directions/vault
	name = "vault sign"
	desc = "A direction sign, pointing out which way the station's Vault is."
	icon_state = "direction_vault"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/vault, 32)

/obj/structure/sign/directions/upload
	name = "upload sign"
	desc = "A direction sign, pointing out which way the station's AI Upload is."
	icon_state = "direction_upload"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/upload, 32)

/obj/structure/sign/directions/dorms
	name = "dormitories sign"
	desc = "A direction sign, pointing out which way the dormitories are."
	icon_state = "direction_dorms"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/dorms, 32)

/obj/structure/sign/directions/lavaland
	name = "lava sign"
	desc = "A direction sign, pointing out which way the hot stuff is."
	icon_state = "direction_lavaland"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/lavaland, 32)

/obj/structure/sign/directions/arrival
	name = "arrivals sign"
	desc = "A direction sign, pointing out which way the arrivals shuttle dock is."
	icon_state = "direction_arrival"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/directions/arrival, 32)
