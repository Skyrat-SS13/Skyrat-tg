/obj/item/encryptionkey/tv
	name = "nanotrasen tv encryption key"
	channels = list(RADIO_CHANNEL_TV = 1)
	independent = TRUE

/obj/item/tv_radio
	icon = 'modular_skyrat/modules/television/icons/obj/devices.dmi'
	icon_state = "tv_radio"
	name = "Pocket TV Radio"
	desc = "A very old radio that still works. Someone stole the frequency knob from it."
	custom_materials = list(/datum/material/iron = 200, /datum/material/glass = 50)
	var/obj/item/radio/internal_radio = null
	var/radio_key = /obj/item/encryptionkey/tv
	var/sound = FALSE

/obj/item/tv_radio/Initialize(mapload)
	. = ..()
	internal_radio = new /obj/item/radio(src)
	internal_radio.keyslot = new radio_key
	internal_radio.set_on(sound)
	internal_radio.set_frequency(FREQ_TV)

/obj/item/tv_radio/examine()
	. = ..()
	. += "Sound indicator lights [sound ? "green" : "red"]"

/obj/item/tv_radio/attack_self(mob/user)
	. = ..()
	sound = !sound
	internal_radio.set_on(sound)
	internal_radio.set_frequency(FREQ_TV)
	to_chat(user, "You have turned [sound ? "on" : "off"] the sound")

/obj/item/tv_radio/Destroy()
	. = ..()
	QDEL_NULL(internal_radio)

/obj/item/radio/intercom/tv
	name = "TV Show Radio"
	desc = "Almost like television, only without the picture."
	keyslot = new /obj/item/encryptionkey/tv
	freqlock = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/tv, 32)

/obj/item/radio/intercom/tv/Initialize(mapload)
	. = ..()
	set_frequency(FREQ_TV)
