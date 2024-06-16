//These are static plaques, they are made of gold and start engraved with a title and description.

/obj/structure/plaque/static_plaque
	engraved = TRUE

/obj/structure/plaque/static_plaque/atmos
	name = "\improper FEA Atmospherics Division plaque"
	desc = "This plaque commemorates the fall of the Atmos FEA division. For all the charred, dizzy, and brittle men who have died in its hands."

/obj/structure/plaque/static_plaque/thunderdome
	name = "Thunderdome Plaque"
	desc = "This plaque commemorates those who have fallen in glorious combat.  For all the charred, dizzy, and beaten men who have died in its hands."

/obj/structure/plaque/static_plaque/golden
	name = "The Most Robust Men Award for Robustness"
	desc = "To be Robust is not an action or a way of life, but a mental state. Only those with the force of Will strong enough to act during a crisis, saving friend from foe, are truly Robust. Stay Robust my friends."
	icon_state = "goldenplaque"

/obj/structure/plaque/static_plaque/golden/captain
	name = "The Most Robust Captain Award for Robustness"

/obj/structure/plaque/static_plaque/tram
	/// The tram we have info about
	var/specific_transport_id = TRAMSTATION_LINE_1
	/// Weakref to the tram we have info about
	var/datum/weakref/transport_ref
	/// Serial number of the tram
	var/tram_serial
	name = "\improper tram information plate"
	icon_state = "commission_tram"
	custom_materials = list(/datum/material/titanium = SHEET_MATERIAL_AMOUNT)
	layer = SIGN_LAYER

/obj/structure/plaque/static_plaque/tram/Initialize(mapload)
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/plaque/static_plaque/tram/LateInitialize()
	link_tram()
	set_tram_serial()

/obj/structure/plaque/static_plaque/tram/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(isnull(held_item))
		context[SCREENTIP_CONTEXT_LMB] = "View details"
		return CONTEXTUAL_SCREENTIP_SET

/obj/structure/plaque/static_plaque/tram/proc/link_tram()
	for(var/datum/transport_controller/linear/tram/tram as anything in SStransport.transports_by_type[TRANSPORT_TYPE_TRAM])
		if(tram.specific_transport_id == specific_transport_id)
			transport_ref = WEAKREF(tram)
			break

/obj/structure/plaque/static_plaque/tram/proc/set_tram_serial()
	var/datum/transport_controller/linear/tram/tram = transport_ref?.resolve()
	if(isnull(tram) || isnull(tram.tram_registration))
		return

	tram_serial = tram.tram_registration.serial_number
	desc = "A plate showing details from the manufacturer about this Nakamura Engineering SkyyTram Mk VI, serial number [tram_serial].<br><br>We are not responsible for any injuries or fatalities caused by usage of the tram. \
	Using the tram carries inherent risks, and we cannot guarantee the safety of all passengers. By using the tram, you assume, acknowledge, and accept all the risks and responsibilities. <br><br>\
	Please be aware that riding the tram can cause a variety of injuries, including but not limited to: slips, trips, and falls; collisions with other passengers or objects; strains, sprains, and other musculoskeletal injuries; \
	cuts, bruises, and lacerations; and more severe injuries such as head trauma, spinal cord injuries, and even death. These injuries can be caused by a variety of factors, including the movements of the tram, the behaviour \
	of other passengers, and unforeseen circumstances such as foul play or mechanical issues.<br><br>\
	By entering the tram, guideway, or crossings you agree Nanotrasen is not liable for any injuries, damages, or losses that may occur. If you do not agree to these terms, please do not use the tram.<br>"

/obj/structure/plaque/static_plaque/tram/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TramPlaque")
		ui.autoupdate = FALSE
		ui.open()

/obj/structure/plaque/static_plaque/tram/ui_static_data(mob/user)
	var/datum/transport_controller/linear/tram/tram = transport_ref?.resolve()
	var/list/data = list()
	var/list/current_tram = list()
	var/list/previous_trams = list()

	current_tram += list(list(
		"serialNumber" = tram.tram_registration.serial_number,
		"mfgDate" = tram.tram_registration.mfg_date,
		"distanceTravelled" = tram.tram_registration.distance_travelled,
		"tramCollisions" = tram.tram_registration.collisions,
	))

	for(var/datum/tram_mfg_info/previous_tram as anything in tram.tram_history)
		previous_trams += list(list(
		"serialNumber" = previous_tram.serial_number,
		"mfgDate" = previous_tram.mfg_date,
		"distanceTravelled" = previous_tram.distance_travelled,
		"tramCollisions" = previous_tram.collisions,
	))

	data["currentTram"] = current_tram
	data["previousTrams"] = previous_trams
	return data

// Commission plaques, to give a little backstory to the stations. Commission dates are date of merge (or best approximation, in the case of Meta) + 540 years to convert to SS13 dates.
// Where PRs are available, I've linked them. Where they are unavailable, a git hash is provided instead for the direct commit that added/removed the map.
// Please enjoy this trip through SS13's history.

// Runtimestation: added Nov 11, 2016 (946ec1fec869eb59d6a84e32c90613af734fcd0e)
/obj/structure/plaque/static_plaque/golden/commission
	name = "Commission Plaque"
	desc = "Spinward Sector Station SS-13\n'Runtime' Class Outpost\nCommissioned 03/11/2556\n'Dedicated to the Pioneers'"
	icon_state = "commission_nt"
	layer = BELOW_OPEN_DOOR_LAYER

//Current stations

// Icebox Station: added May 13, 2020 (#51090)
/obj/structure/plaque/static_plaque/golden/commission/icebox
	desc = "Spinward Sector Station SS-13\n'Box' Class Outpost (Revision 2.2: 'Icebox')\nCommissioned 13/05/2560\n'Cold Reliable'"

// Metastation: added Mar 11, 2013 (best estimate, pre-git)
/obj/structure/plaque/static_plaque/golden/commission/meta
	desc = "Spinward Sector Station SS-13\n'Meta' Class Outpost\nCommissioned 11/03/2553\n'Theseus' Station'"

// Deltastation: added Dec 17, 2016 (#22066)
/obj/structure/plaque/static_plaque/golden/commission/delta
	desc = "Spinward Sector Station SS-13\n'Delta' Class Outpost\nCommissioned 17/12/2556\n'Efficiency Through Redundancy'"

// Tramstation: added Mar 11, 2021 (#56509)
/obj/structure/plaque/static_plaque/golden/commission/tram
	desc = "Spinward Sector Station SS-13\n'Tram' Class Outpost\nCommissioned 11/03/2561\n'Making Moves'"

// Wawastation: added add date here
/obj/structure/plaque/static_plaque/golden/commission/wawa
	desc = "Spinward Sector Station SS-13\n'Wawa' Class Outpost\nCommissioned 11/03/add here\n'Forever Vertical'"

// North Star: added Apr 13, 2023 (#74371)
/obj/structure/plaque/static_plaque/golden/commission/northstar
	desc = "Spinward Sector Ship SS-13\n'North Star' Class Vessel\nCommissioned 13/04/2563\n'New Opportunities'"

// Birdshot: added Apr 29, 2023 (#74371)
/obj/structure/plaque/static_plaque/golden/commission/birdshot
	desc = "Spinward Sector Station SS-13\n'Birdshot' Class Outpost\nCommissioned 29/04/2563\n'Shooting for the Stars'"

//Removed stations

// Asteroidstation: added Oct 17, 2015 (169ab09f7b52254ee505e54cdea681fab287647b), removed Jun 19, 2016 (#18661)- 8 months, 2 days
/obj/structure/plaque/static_plaque/golden/commission/asteroid
	desc = "Spinward Sector Station SS-12\n'Asteroid' Class Outpost\nCommissioned 13/10/2555\nDecommissioned 19/06/2556\n'A Meteoric Success'"

// Birdboat Station: added Sep 17, 2015 (#11829), removed Feb 09, 2017 (#23754)- 1 year, 4 months, 23 days
/obj/structure/plaque/static_plaque/golden/commission/birdboat
	desc = "Spinward Sector Station SS-03\n'Birdboat' Class Outpost\nCommissioned 17/09/2555\nDecommissioned 09/02/2557\n'Rocking the Boat'"

// Boxstation: added Nov 15, 2010 (pre-git), removed Jul 06, 2020 (#52017)- 9 years, 7 months, 21 days
/obj/structure/plaque/static_plaque/golden/commission/box
	desc = "Spinward Sector Station SS-02\n'Box' Class Outpost\nCommissioned 15/11/2550\nDecommissioned 06/07/2560\n'Old Faithful'"

// Pubbystation: added Oct 19, 2016 (#20925), removed Dec 10, 2020 (#54588)- 4 years, 1 month, 21 days
/obj/structure/plaque/static_plaque/golden/commission/pubby
	desc = "Spinward Sector Station SS-06\n'Pubby' Class Outpost\nCommissioned 19/10/2556\nDecommissioned 10/12/2560\n'No Law But Ours'"

// Cerestation: added Mar 29, 2017 (#24665), removed Aug 26th, 2017 (#30196)- 4 months, 28 days
/obj/structure/plaque/static_plaque/golden/commission/cere
	desc = "Spinward Sector Station SS-10\n'Cere' Class Outpost\nCommissioned 29/03/2557\nDecommissioned 26/08/2557\n'Take a Hike'"

// Discstation: added Sep 21, 2015 (#11923), removed Jan 31, 2016 (#15069)- 4 months, 10 days
/obj/structure/plaque/static_plaque/golden/commission/disc
	desc = "Spinward Sector Station SS-05\n'Disc' Class Outpost\nCommissioned 21/09/2555\nDecommissioned 31/01/2556\n'Sleep Tight'"

// Donutstation: added Dec 16, 2018 (#41099), removed Apr 28, 2020 (#50730)- 1 year, 4 months, 12 days
/obj/structure/plaque/static_plaque/golden/commission/donut
	desc = "Spinward Sector Station SS-11\n'Donut' Class Outpost\nCommissioned 16/12/2558\nDecommissioned 28/04/2560\n'Hail the Lord'"

// Dreamstation: added Oct 06, 2015 (#12154), removed Dec 22, 2016 (#22305)- 1 year, 2 months, 16 days
/obj/structure/plaque/static_plaque/golden/commission/dream
	desc = "Spinward Sector Station SS-04\n'Dream' Class Outpost\nCommissioned 06/10/2555\nDecommissioned 22/12/2556\n'Aiming High'"

// Efficiencystation: added Jan 28, 2016 (46f64266cfb8b40e35faa8a4d9a2d3aeec689943), removed Dec 20, 2016 (#22306)- 10 months, 22 days
/obj/structure/plaque/static_plaque/golden/commission/efficiency
	desc = "Spinward Sector Station SS-07\n'Efficiency' Class Outpost\nCommissioned 28/01/2556\nDecommissioned 20/12/2556\n'Work Smarter, Not Harder'"

// Kilostation: added Nov 13, 2019 (#46968), removed
/obj/structure/plaque/static_plaque/golden/commission/kilo
	desc = "Spinward Sector Station SS-13\n'Kilo' Class Outpost\nCommissioned 13/11/2559\nDecommissioned \n'Forever Different'"

// Ministation: added Jan 29, 2014 (7a76e9456b782e6626bf81e27a912d8232c76b18), removed Dec 27, 2016 (#22453)- 2 years, 10 months, 28 days
/obj/structure/plaque/static_plaque/golden/commission/mini
	desc = "Spinward Sector Station SS-08\n'Mini' Class Outpost\nCommissioned 29/01/2554\nDecommissioned 27/12/2556\n'The Littlest Station'"

// Omegastation: added Dec 27, 2016 (#22453), removed Sep 20, 2018 (#40352)- 1 year, 8 months, 24 days
/obj/structure/plaque/static_plaque/golden/commission/omega
	desc = "Spinward Sector Station SS-09\n'Omega' Class Outpost\nCommissioned 27/12/2556\nDecommissioned 20/09/2558\n'Tiny Take Two'"

// Uterusstation: added Sep 03, 2011 (bbd6db9ce2d6341892b89a620593fc8877f5a817), removed Jun 21, 2012 (72d72f7ce522c2d2ad4863f44ee9f5054413c489)- 9 months, 18 days
/obj/structure/plaque/static_plaque/golden/commission/uterus
	desc = "Spinward Sector Station SS-01\n'Uterus' Class Outpost\nCommissioned 03/09/2551\nDecommissioned 21/06/2552\n'Humanity's Vanguard'"

// Other Stations

// Space Station 13, Developer Class Outpost, Station Commissioned 30.12.2322, For the Glory of the Workers of the Third Soviet Union
// The date for this station is exactly 4 centuries after the initial foundation of the (1st) Soviet Union. I have very little interest in tracking down the actual date of addition of Originalstation.
/obj/structure/plaque/static_plaque/golden/commission/ks13
	desc = "космическая-станция-13\nфорпост класса разработчика\nстанция сдана 30.12.2322\nво славу тружеников третьего советского союза"
	icon_state = "commission_commie"

//These are plaques that aren't made of metal, so we'll just consider them signs. Those are made of plastic (default) or wood, not gold.
//See: code>game>objects>structures>signs>_signs.dm

/obj/structure/sign/plaques/kiddie
	name = "\improper AI developers plaque"
	desc = "Next to the extremely long list of names and job titles, there is a drawing of a little child. The child appears to be disabled. Beneath the image, someone has scratched the word \"PACKETS\"."
	icon_state = "kiddieplaque"

/obj/structure/sign/plaques/kiddie/devils_tooth
	name = "\improper Devil's Tooth Plaque"
	desc = "A plaque commemorating the fallen souls who had to die tunneling out this segment of the frozen ice planet that surrounds it. It's named \"Devil's Tooth\" because those who laid down their life here surely thought they were in hell."

/obj/structure/sign/plaques/kiddie/badger
	name = "\improper Remembrance Plaque"
	desc = "A plaque commemorating the fallen, may they rest in peace, forever asleep amongst the stars. Someone has drawn a picture of a crying badger at the bottom."

/obj/structure/sign/plaques/kiddie/library
	name = "\improper Library Rules Sign"
	desc = "A long list of rules to be followed when in the library, extolling the virtues of being quiet at all times and threatening those who would dare eat hot food inside."

/obj/structure/sign/plaques/kiddie/perfect_man
	name = "\improper 'Perfect Man' sign"
	desc = "A guide to the exhibit, explaining how recent developments in mindshield implant and cloning technologies by Nanotrasen Corporation have led to the development and the effective immortality of the 'perfect man', the loyal Nanotrasen Employee."

/obj/structure/sign/plaques/kiddie/perfect_drone
	name = "\improper 'Perfect Drone' sign"
	desc = "A guide to the drone shell dispenser, detailing the constructive and destructive applications of modern repair drones, as well as the development of the incorruptible cyborg servants of tomorrow, available today."

/obj/structure/sign/plaques/kiddie/gameoflife
	name = "\improper Conway's The Game Of Life plaque"
	desc = "A plaque detailing the historical significance of The Game Of Life in the field of computer science, and that the mural underfoot is a representation of the game in action."
