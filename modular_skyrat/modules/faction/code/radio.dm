/obj/item/encryptionkey/headset_faction
	name = "faction radio encryption key"
	icon_state = "cypherkey_cargo"
	channels = list(RADIO_CHANNEL_FACTION = 1)
	greyscale_config = /datum/greyscale_config/encryptionkey_cargo
	greyscale_colors = "#49241a#dca01b"
	special_channels = RADIO_SPECIAL_CENTCOM

/obj/item/radio/headset/headset_faction
	name = "faction radio headset"
	desc = "Headset used by the faction."
	icon_state = "cargo_headset"
	keyslot = new /obj/item/encryptionkey/headset_faction

/obj/item/radio/headset/headset_faction/bowman
	name = "faction bowman headset"
	desc = "Headset used by the faction. Protects ears from flashbangs."
	icon_state = "com_headset_alt"

/obj/item/radio/headset/headset_faction/bowman/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/radio/headset/headset_faction/bowman/captain
	name = "faction captain bowman headset"
	desc = "The headset of the boss. Protects ears from flashbangs."
	command = TRUE
