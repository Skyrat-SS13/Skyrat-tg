// If a background entry has this feature, then the character will be hidden from the manifest.
/datum/background_feature/off_manifest
	name = "Off-Manifest"
	description = "Due to your circumstances, you are not visible on the manifest. Better avoid any SolFed officials, and anyone else who's in power and not in the know."
	icon_state = "scrap_mud"
	icon_path = 'icons/obj/bureaucracy.dmi'
	allowed_roles = list(BACKGROUNDS_OFF_MANIFEST_ALLOWED_ROLES)
