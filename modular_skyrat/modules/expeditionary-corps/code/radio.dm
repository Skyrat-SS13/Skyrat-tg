/obj/item/encryptionkey/expedition_headset_commander
	name = "expedition commander's radio encryption key"
	icon = 'modular_skyrat/modules/expeditionary-corps/icons/radio.dmi'
	icon_state = "exp_com_cypherkey"
	channels = list(RADIO_CHANNEL_SUPPLY = 1, RADIO_CHANNEL_COMMAND = 1)

/obj/item/encryptionkey/expedition_headset_sci
	name = "expedition scientist's radio encryption key"
	icon = 'modular_skyrat/modules/expeditionary-corps/icons/radio.dmi'
	icon_state = "exp_sci_cypherkey"
	channels = list(RADIO_CHANNEL_SUPPLY = 1, RADIO_CHANNEL_SCIENCE = 1)

/obj/item/encryptionkey/expedition_headset_med
	name = "expedition medic's radio encryption key"
	icon = 'modular_skyrat/modules/expeditionary-corps/icons/radio.dmi'
	icon_state = "exp_med_cypherkey"
	channels = list(RADIO_CHANNEL_SUPPLY = 1, RADIO_CHANNEL_MEDICAL = 1)

/obj/item/encryptionkey/expedition_headset_sec
	name = "expedition security guard's encryption key"
	icon = 'modular_skyrat/modules/expeditionary-corps/icons/radio.dmi'
	icon_state = "exp_sec_cypherkey"
	channels = list(RADIO_CHANNEL_SUPPLY = 1, RADIO_CHANNEL_SECURITY = 1)

/obj/item/encryptionkey/expedition_headset_eng
	name = "expedition engineer's encryption key"
	icon = 'modular_skyrat/modules/expeditionary-corps/icons/radio.dmi'
	icon_state = "exp_eng_cypherkey"
	channels = list(RADIO_CHANNEL_SUPPLY = 1, RADIO_CHANNEL_ENGINEERING = 1)

/obj/item/radio/headset/expedition_headset_commander
	name = "expedition commander's headset"
	desc = "A headset that allows the wearer to communicate with cargos and command staff."
	icon = 'modular_skyrat/modules/expeditionary-corps/icons/radio.dmi'
	icon_state = "exp_commander_headset"
	keyslot = new /obj/item/encryptionkey/expedition_headset_commander

/obj/item/radio/headset/expedition_headset_sci
	name = "expedition scientist's headset"
	desc = "A headset that allows the wearer to communicate with cargos and scientific staff."
	icon = 'modular_skyrat/modules/expeditionary-corps/icons/radio.dmi'
	icon_state = "exp_sci_headset"
	keyslot = new /obj/item/encryptionkey/expedition_headset_sci

/obj/item/radio/headset/expedition_headset_med
	name = "expedition medic's headset"
	desc = "A headset that allows the wearer to communicate with cargos and medical staff."
	icon = 'modular_skyrat/modules/expeditionary-corps/icons/radio.dmi'
	icon_state = "exp_med_headset"
	keyslot = new /obj/item/encryptionkey/expedition_headset_med

/obj/item/radio/headset/expedition_headset_sec
	name = "expedition security guard's headset"
	desc = "A headset that allows the wearer to communicate with cargos and security staff."
	icon = 'modular_skyrat/modules/expeditionary-corps/icons/radio.dmi'
	icon_state = "exp_sec_headset"
	keyslot = new /obj/item/encryptionkey/expedition_headset_sec

/obj/item/radio/headset/expedition_headset_eng
	name = "expedition engineer's headset"
	desc = "A headset that allows the wearer to communicate with cargos and engineering staff."
	icon = 'modular_skyrat/modules/expeditionary-corps/icons/radio.dmi'
	icon_state = "exp_eng_headset"
	keyslot = new /obj/item/encryptionkey/expedition_headset_eng
