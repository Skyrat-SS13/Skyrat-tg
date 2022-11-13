#define STACKS_OF_CASH 3

/obj/item/modular_computer/tablet/pda/armadyne_representative
	name = "armadyne representative's PDA"
	inserted_disk = /obj/item/computer_disk/command
	inserted_item = /obj/item/pen/fountain
	greyscale_colors = "#D71E1E#0060b8"

/obj/item/storage/secure/briefcase/armadyne_incentive
	desc = "A black briefcase with red stripes and a secure digital padlock. Looks like it has good heft, too..."
	icon = 'modular_skyrat/modules/corporate_diplomat/icons/armadyne_rep/storage.dmi'
	icon_state = "armadyne-case"
	force = 12

/obj/item/storage/secure/briefcase/armadyne_incentive/PopulateContents()
	. = ..()
	new /obj/item/paper/armadyne_incentive(src)
	for(var/iterator in 1 to 3)
		new /obj/item/stack/spacecash/c1000(src)
	new /obj/item/reagent_containers/cocaine(src)
	new /obj/item/food/grown/cannabis(src)
	new /obj/item/reagent_containers/cup/glass/bottle/whiskey(src)



/obj/item/paper/armadyne_incentive
	name = "incentive guide"

/obj/item/paper/contractor_guide/Initialize(mapload)
	default_raw_text = {"
			## Incentives Guide
		---

		Greetings, representative. This briefcase of "incentives" isn't here for your benefit.
		If you feel there is valuable information or objects to be gained for the Armadyne Corporation,
		you are authorized to spend the contents as you see fit to further that goal.

		To repeat, you are not to use the contents for your exclusive benefit, it must be used for Corporation purposes.
		Misuse of these will lead to internal investigation.
		Go forth, representative, and make the Corporation proud.

		<i>Signed:</i>
		Corporate Outreach Director James Walker
		"}
	return ..()

#undef STACKS_OF_CASH
