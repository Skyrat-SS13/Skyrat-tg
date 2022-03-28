/obj/item/radio/headset/heads/qm
	name = "\proper the quartermaster's headset"
	desc = "The headset of the king (or queen) of paperwork."
	icon_state = "com_headset"
	keyslot = new /obj/item/encryptionkey/heads/qm

/obj/item/radio/headset/heads/rd/alt
	name = "\proper the research director's bowman headset"
	desc = "Headset of the fellow who keeps society marching towards technological singularity. Protects ears from flashbangs."
	icon_state = "com_headset_alt"

/obj/item/radio/headset/heads/rd/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/radio/headset/heads/ce/alt
	name = "\proper the chief engineer's bowman headset"
	desc = "The headset of the guy in charge of keeping the station powered and undamaged. Protects ears from flashbangs."
	icon_state = "com_headset_alt"

/obj/item/radio/headset/heads/ce/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/radio/headset/heads/cmo/alt
	name = "\proper the chief medical officer's bowman headset"
	desc = "The headset of the highly trained medical chief. Protects ears from flashbangs."
	icon_state = "com_headset_alt"

/obj/item/radio/headset/heads/cmo/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))
/obj/item/radio/headset/heads/qm/alt
	name = "\proper the quartermaster's bowman headset"
	desc = "The headset of the king (or queen) of paperwork. Protects ears from flashbangs."
	icon_state = "com_headset_alt"

/obj/item/radio/headset/heads/qm/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))
