/obj/item/mmi/posibrain/circuit
	name = "compact AI circuit"
	desc = "A compact circuit, perfectly dimensioned to fit in the same slot as a cyborg's positronic brain."
	icon = 'icons/obj/module.dmi'
	icon_state = "mainboard"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'

/obj/item/organ/internal/brain/ipc_positron/circuit
	name = "compact AI circuit"
	desc = "A compact and extremely complex circuit, perfectly dimensioned to fit in the same slot as a synthetic-compatiblepositronic brain. It is usually slotted into the chest of synthetic crewmembers."
	icon = 'icons/obj/module.dmi'
	icon_state = "mainboard"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'

/obj/item/organ/internal/brain/ipc_positron/mmi
	name = "compact man-machine interface"
	desc = "A compact man-machine interface, perfectly dimensioned to fit in the same slot as a synthetic-compatible positronic brain. Unfortunately, the brain seems to be permanently attached to the circuitry. It is usually slotted into the chest of synthetic crewmembers."
	icon = 'icons/obj/assemblies/assemblies.dmi'
	icon_state = "mmi_brain"

/obj/item/organ/internal/brain/ipc_positron/mmi/update_overlays()
	. = ..()
	. += "mmi_dead"
