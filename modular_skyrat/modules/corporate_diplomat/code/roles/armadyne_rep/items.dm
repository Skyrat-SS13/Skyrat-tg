#define STACKS_OF_CASH 4

/obj/item/modular_computer/tablet/pda/armadyne_representative
	name = "armadyne representative's PDA"
	inserted_disk = /obj/item/computer_disk/command
	inserted_item = /obj/item/pen/fountain
	greyscale_colors = "#D71E1E#0060b8"


/obj/item/storage/secure/briefcase/armadyne_incentive
	desc = "A black briefcase with red stripes and a secure digital padlock. Feels particularly heavy."
	icon = 'modular_skyrat/modules/corporate_diplomat/icons/armadyne_rep/storage.dmi'
	icon_state = "armadyne_case"
	force = 12

/obj/item/storage/secure/briefcase/armadyne_incentive/PopulateContents()
	new /obj/item/paper/armadyne_incentive(src)
	for(var/iterator in 1 to STACKS_OF_CASH)
		new /obj/item/stack/spacecash/c1000(src)
	new /obj/item/reagent_containers/cocaine(src)
	new /obj/item/reagent_containers/cocaine(src)
	new /obj/item/reagent_containers/cup/glass/bottle/whiskey(src)



/obj/item/paper/armadyne_incentive
	name = "incentive guide"

/obj/item/paper/armadyne_incentive/Initialize(mapload)
	default_raw_text = {"
		## Incentives Guide
		---

		Greetings, representative.
		This briefcase of "incentives" isn't here for your benefit.
		If you feel there is valuable information or objects
		to be gained for the Armadyne Corporation, you are
		authorized to spend the contents as you see fit to further that goal.

		To repeat, you are not to use the contents for your exclusive benefit,
		it must be used for Corporation purposes. Misuse of these will lead to
		internal investigation.
		Go forth, representative, and make the Corporation proud.

		Signed
		Corporate Outreach Director James Walker
		"}

	update_icon_state()
	return ..()


/obj/item/encryptionkey/headset_sec/armadyne/rep
	name = "armadyne representative radio encryption key"
	channels = list(
		RADIO_CHANNEL_ARMADYNE = 1,
		RADIO_CHANNEL_COMMAND = 1,
	)

/obj/item/radio/headset/armadyne/representative
	name = "armadyne representative headset"
	command = TRUE
	keyslot = new /obj/item/encryptionkey/headset_sec/armadyne/rep

/obj/item/radio/headset/armadyne/representative/alt
	name = "armadyne representative bowman headset"
	desc = "A radio for communicating on classified corporate frequiencies. Protects ears from flashbangs."
	icon_state = "armadyne_headset_alt"

/obj/item/radio/headset/armadyne/representative/alt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))

/obj/item/stamp/armadyne
	name = "Armadyne rubber stamp"
	icon = 'modular_skyrat/modules/corporate_diplomat/icons/stamps/stamps.dmi'
	icon_state = "stamp-armadyne"
	dye_color = DYE_HOS

#undef STACKS_OF_CASH
