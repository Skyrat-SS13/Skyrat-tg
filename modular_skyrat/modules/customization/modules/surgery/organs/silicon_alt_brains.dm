/obj/item/mmi/posibrain/circuit
	name = "compact AI circuit"
	desc = "A compact circuit, perfectly dimensioned to fit in the same slot as a cyborg's positronic brain."
	icon = 'icons/obj/module.dmi'
	icon_state = "mainboard"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'

	var/begin_activation_message = "<span class='notice'>You carefully locate the manual activation switch and start the compact AI circuit's boot process.</span>"
	var/success_message = "<span class='notice'>The compact AI circuit pings, and its lights start flashing. Success!</span>"
	var/fail_message = "<span class='notice'>The compact AI circuit buzzes quietly, and the golden lights fade away. Perhaps you could try again?</span>"
	var/new_mob_message = "<span class='notice'>The compact AI circuit chimes quietly.</span>"
	var/recharge_message = "<span class='warning'>The compact AI circuit isn't ready to activate again yet! Give it some time to recharge.</span>"

/obj/item/mmi/posibrain/circuit/update_overlays()
	. = ..()
	if(brainmob && brainmob.stat != DEAD)
		. += "datadisk_gene"

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

/obj/item/organ/internal/brain/ipc_positron/mmi/update_overlays()
	. = ..()
	. += "mmi_dead"
