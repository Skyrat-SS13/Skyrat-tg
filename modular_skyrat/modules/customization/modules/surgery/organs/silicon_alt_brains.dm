/obj/item/mmi/posibrain/circuit
	name = "compact AI circuit"
	desc = "A compact circuit, perfectly dimensioned to fit in the same slot as a cyborgs positronic brain."
	icon = 'icons/obj/module.dmi'
	icon_state = "mainboard"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'

	// It pains me to copy-paste so much, but I can't do it any other way
	begin_activation_message = "<span class='notice'>You carefully locate the manual activation switch and start the compact AI circuit's boot process.</span>"
	success_message = "<span class='notice'>The compact AI circuit pings, and its lights start flashing. Success!</span>"
	fail_message = "<span class='notice'>The compact AI circuit buzzes quietly, and the golden lights fade away. Perhaps you could try again?</span>"
	new_mob_message = "<span class='notice'>The compact AI circuit chimes quietly.</span>"
	recharge_message = "<span class='warning'>The compact AI circuit isn't ready to activate again yet! Give it some time to recharge.</span>"

// Make it a little more obvious that the thing's active, mmh?
/obj/item/mmi/posibrain/circuit/add_mmi_overlay()
	. = ..()
	if(brainmob && brainmob.stat != DEAD)
		return . + list("datadisk_gene")

// I have no sprites for this.
/obj/item/mmi/posibrain/circuit/update_icon_state()
	return ..()

/obj/item/organ/internal/brain/ipc_positron/circuit
	name = "compact AI circuit"
	desc = "A compact and extremely complex circuit, perfectly dimensioned to fit in the same slot as a synthetic-compatible positronic brain. It is usually slotted into the chest of synthetic crewmembers."
	icon = 'icons/obj/module.dmi'
	icon_state = "mainboard"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'

/obj/item/organ/internal/brain/ipc_positron/mmi
	name = "compact man-machine interface"
	desc = "A compact man-machine interface, perfectly dimensioned to fit in the same slot as a synthetic-compatible positronic brain. Unfortunately, the brain seems to be permanently attached to the circuitry, and it seems relatively sensitive to it's environment. It is usually slotted into the chest of synthetic crewmembers."
	icon = 'icons/obj/assemblies/assemblies.dmi'
	icon_state = "mmi_brain"

// Otherwise there's no MMI machine at all
/obj/item/organ/internal/brain/ipc_positron/mmi/update_overlays()
	. = ..()
	return . + list("mmi_dead")
