/obj/item/cargo_teleporter
	name = "cargo teleporter"
	desc = "An item that can set down a set number of markers, allowing them to teleport items within a tile to the set markers."
	icon = 'modular_skyrat/modules/cargo_teleporter/icons/cargo_teleporter.dmi'
	icon_state = "cargo_tele"

	var/allow_persons = FALSE
	var/ranged_use = FALSE
	var/faster_cooldown = FALSE
	COOLDOWN_DECLARE(use_cooldown)

/obj/item/cargo_tele_upgrade
	name = "cargo teleporter upgrade"
	desc = "An item that can upgrade the cargo teleporter."
