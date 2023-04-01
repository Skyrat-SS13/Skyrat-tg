/obj/machinery/airalarm/Nitrogen_Atmosphere // Tailored for a 100% Nitrogen Atmosphere

/obj/machinery/airalarm/Nitrogen_Atmosphere/Initialize(mapload)
	. = ..()
	tlv_collection[/datum/gas/oxygen] = /datum/tlv/dangerous
