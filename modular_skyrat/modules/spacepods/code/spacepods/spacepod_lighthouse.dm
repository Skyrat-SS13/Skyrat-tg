/obj/machinery/spacepod_lighthouse
	name = "quantum lighthouse"
	desc = "A lighthouse that spacepods with the quantum entangloporter can teleport to."
	icon = 'modular_skyrat/modules/spacepods/icons/objects.dmi'
	icon_state = "lighthouse_on"
	anchored = TRUE
	density = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/spacepod_lighthouse/Initialize(mapload)
	. = ..()
	GLOB.spacepod_beacons += src
