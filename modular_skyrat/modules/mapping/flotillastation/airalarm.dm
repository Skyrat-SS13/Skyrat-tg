/obj/machinery/airalarm/Nitrogen_Atmosphere // Tailored for a 100% Nitrogen Atmosphere
	TLV = list(
		"pressure" = new/datum/tlv(ONE_ATMOSPHERE * 0.8, ONE_ATMOSPHERE *  0.9, ONE_ATMOSPHERE * 1.1, ONE_ATMOSPHERE * 1.2), // kPa
		"temperature" = new/datum/tlv(COLD_ROOM_TEMP-40, COLD_ROOM_TEMP-20, COLD_ROOM_TEMP+20, COLD_ROOM_TEMP+40),
		/datum/gas/oxygen = new/datum/tlv(-1, -1, 5, 10), // Partial pressure, kpa
		/datum/gas/nitrogen = new/datum/tlv(16, 19, 135, 140),
		/datum/gas/carbon_dioxide = new/datum/tlv(-1, -1, 5, 10),
		/datum/gas/miasma = new/datum/tlv/(-1, -1, 2, 5),
		/datum/gas/plasma = new/datum/tlv/dangerous,
		/datum/gas/nitrous_oxide = new/datum/tlv/dangerous,
		/datum/gas/bz = new/datum/tlv/dangerous,
		/datum/gas/hypernoblium = new/datum/tlv(-1, -1, 1000, 1000), // Hyper-Noblium is inert and nontoxic
		/datum/gas/water_vapor = new/datum/tlv/dangerous,
		/datum/gas/tritium = new/datum/tlv/dangerous,
		/datum/gas/nitrium = new/datum/tlv/dangerous,
		/datum/gas/pluoxium = new/datum/tlv(-1, -1, 1000, 1000), // Unlike oxygen, pluoxium does not fuel plasma/tritium fires
		/datum/gas/freon = new/datum/tlv/dangerous,
		/datum/gas/hydrogen = new/datum/tlv/dangerous,
		/datum/gas/healium = new/datum/tlv/dangerous,
		/datum/gas/proto_nitrate = new/datum/tlv/dangerous,
		/datum/gas/zauker = new/datum/tlv/dangerous,
		/datum/gas/helium = new/datum/tlv/dangerous,
		/datum/gas/antinoblium = new/datum/tlv/dangerous,
		/datum/gas/halon = new/datum/tlv/dangerous,
	)
