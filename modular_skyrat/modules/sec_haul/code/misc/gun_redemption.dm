//Choice Beacon for blueshield, old.

/obj/item/choice_beacon/blueshield
	name = "blueshield weapon beacon"
	desc = "A single use beacon to deliver a weapon of your choice. Please only call this in your office"
	company_source = "Sol Security Solution"
	company_message = span_bold("Supply Pod incoming please stand by")

/obj/item/choice_beacon/blueshield/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"Energy Revolver" = /obj/item/gun/energy/e_gun/blueshield,
		"Energy Carbine" = /obj/item/gun/energy/e_gun/stun/blueshield,
		".585 SMG" = /obj/item/storage/toolbox/guncase/skyrat/xhihao_large_case/bogseo //This can obviously be replaced out with any gun of your choice for future coder
	)

	return selectable_gun_types


//Both of these are defunk but still exist for archival purpose incase someone want to re-visit them later, or as references


/obj/item/choice_beacon/ntc
	name = "gunset beacon"
	desc = "A single use beacon to deliver a gunset of your choice. Please only call this in your office"
	company_source = "Trappiste Fabriek Company"
	company_message = span_bold("Supply Pod incoming please stand by")

/obj/item/choice_beacon/ntc/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"Takbok" = /obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/takbok,
		"Skild" = /obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/skild,
	)

	return selectable_gun_types



/obj/item/choice_beacon/station_magistrate
	name = "nanotrasen dignitaries weapon beacon"
	desc = "A single use beacon to deliver a weapon of your choice. Please only call this in your office"
	company_source = "Romulus Armoury"
	company_message = span_bold("Supply Pod incoming please stand by")

/obj/item/choice_beacon/station_magistrate/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"Energy Revolver" = /obj/item/gun/energy/e_gun/blueshield,
		".357 Romulus Revolver" = /obj/item/gun/ballistic/revolver/hos_revolver,
		".460 Rowland Magnum Pistol" = /obj/item/gun/ballistic/automatic/pistol/m45a5,
	)

	return selectable_gun_types

