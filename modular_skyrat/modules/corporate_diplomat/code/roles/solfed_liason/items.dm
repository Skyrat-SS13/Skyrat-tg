/obj/item/radio/headset/solfed
	name = "\improper Solar Federation headset"
	icon_state = "rob_headset"
	freerange = TRUE
	freqlock = TRUE
	keyslot = new /obj/item/encryptionkey/headset_solfed

/obj/item/radio/headset/solfed/command
	command = TRUE

/obj/item/radio/headset/solfed/liaison
	name = "\improper Solar Federation liaison headset"
	keyslot = new /obj/item/encryptionkey/headset_solfed/liaison
	command = TRUE

/obj/item/radio/headset/solfed/liaison/alt
	icon = 'modular_skyrat/modules/corporate_diplomat/icons/solfed_liaison/headset.dmi'
	icon_state = "sol_headset_alt"

/obj/item/radio/headset/solfed/liaison/alt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))


/obj/item/radio/headset/solfed/marshal
	icon = 'modular_skyrat/modules/corporate_diplomat/icons/solfed_liaison/headset.dmi'
	icon_state = "sol_headset_alt"
	keyslot2 = new /obj/item/encryptionkey/headset_sec

/obj/item/radio/headset/solfed/marshal/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))


/obj/item/radio/headset/solfed/breach_control
	keyslot2 = new /obj/item/encryptionkey/headset_eng

/obj/item/radio/headset/solfed/emt
	keyslot2 = new /obj/item/encryptionkey/headset_med


/obj/item/encryptionkey/headset_solfed
	name = "\improper Solar Federation radio encryption key"
	channels = list(
		RADIO_CHANNEL_SOLFED = 1,
	)
	greyscale_colors = "#C39C00#f28a1b"


/obj/item/encryptionkey/headset_solfed/liaison
	name = "\improper Solar Federation liaison encryption key"
	channels = list(
		RADIO_CHANNEL_SOLFED = 1,
		RADIO_CHANNEL_COMMAND = 1,
	)
	greyscale_colors = "#C39C00#f28a1b"


/obj/item/modular_computer/pda/solfed_lasion
	name = "\improper Solar Federation Liaison's PDA"
	inserted_disk = /obj/item/computer_disk/command
	inserted_item = /obj/item/pen/fountain
	greyscale_colors = "#C39C00#0060b8"

/obj/item/stamp/solfed
	name = "SolFed rubber stamp"
	icon = 'modular_skyrat/modules/corporate_diplomat/icons/stamps/stamps.dmi'
	icon_state = "stamp-solfed"
	dye_color = DYE_CE // I'm not shitcoding the stamp system to work with modular files
