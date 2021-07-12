//Vox Atmos Alarms
/obj/machinery/airalarm/vox

	locked = FALSE
	req_access = null
	req_one_access = null
	aidisabled = 1
	shorted = 0

	TLV = list( // Voxified Nitrogen air.
		"pressure" = new/datum/tlv(HAZARD_LOW_PRESSURE, WARNING_LOW_PRESSURE, WARNING_HIGH_PRESSURE, HAZARD_HIGH_PRESSURE), // kPa. Values are min2, min1, max1, max2
		"temperature" = new/datum/tlv(T0C, T0C+10, T0C+40, T0C+66),
		/datum/gas/oxygen = new/datum/tlv/dangerous,
		/datum/gas/nitrogen = new/datum/tlv(70, 85, 135, 140),
		/datum/gas/carbon_dioxide = new/datum/tlv(-1, -1, 5, 10),
		/datum/gas/miasma = new/datum/tlv/(-1, -1, 15, 30),
		/datum/gas/plasma = new/datum/tlv/dangerous,
		/datum/gas/nitrous_oxide = new/datum/tlv/dangerous,
		/datum/gas/bz = new/datum/tlv/dangerous,
		/datum/gas/hypernoblium = new/datum/tlv(-1, -1, 1000, 1000), // Hyper-Noblium is inert and nontoxic
		/datum/gas/water_vapor = new/datum/tlv/dangerous,
		/datum/gas/tritium = new/datum/tlv/dangerous,
		/datum/gas/stimulum = new/datum/tlv/dangerous,
		/datum/gas/nitryl = new/datum/tlv/dangerous,
		/datum/gas/pluoxium = new/datum/tlv/dangerous,
		/datum/gas/freon = new/datum/tlv/dangerous,
		/datum/gas/hydrogen = new/datum/tlv/dangerous,
		/datum/gas/healium = new/datum/tlv/dangerous,
		/datum/gas/proto_nitrate = new/datum/tlv/dangerous,
		/datum/gas/zauker = new/datum/tlv/dangerous,
		/datum/gas/helium = new/datum/tlv/dangerous,
		/datum/gas/antinoblium = new/datum/tlv/dangerous,
		/datum/gas/halon = new/datum/tlv/dangerous
	)
