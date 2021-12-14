//Datums for different companies that can be used by busy_space
/datum/lore/organization
	var/name = ""				// Organization's name
	var/short_name = ""			// Organization's shortname (NanoTrasen for "NanoTrasen Incorporated")
	var/desc = ""				// One or two paragraph description of the organization, but only current stuff.  Currently unused.
	var/history = ""			// Historical discription of the organization's origins  Currently unused.
	var/work = ""				// Short description of their work, eg "an arms manufacturer"
	var/headquarters = ""		// Location of the organization's HQ.  Currently unused.
	var/motto = ""				// A motto/jingle/whatever, if they have one.  Currently unused.

	var/list/ship_prefixes = list()	//Some might have more than one! Like NanoTrasen. Value is the mission they perform, e.g. ("ABC" = "mission desc")
	var/list/ship_names = list(		//Names of spaceships.  This is a mostly generic list that all the other organizations inherit from if they don't have anything better.
		"Kestrel",
		"Beacon",
		"Signal",
		"Freedom",
		"Glory",
		"Axiom",
		"Eternal",
		"Icarus",
		"Harmony",
		"Light",
		"Discovery",
		"Endeavour",
		"Explorer",
		"Swift",
		"Dragonfly",
		"Ascendant",
		"Tenacious",
		"Pioneer",
		"Hawk",
		"Haste",
		"Radiant",
		"Luminous"
		)
	var/list/destination_names = list()	//Names of static holdings that the organization's ships visit regularly.
	var/autogenerate_destination_names = TRUE

/datum/lore/organization/New()
	..()
	if(autogenerate_destination_names) // Lets pad out the destination names.
		var/i = rand(6, 10)
		var/list/star_names = list(
			/*"Sol", "Alpha Centauri", "Sirius", "Vega", "Regulus", "Vir", "Algol", "Aldebaran",
			"Delta Doradus", "Menkar", "Geminga", "Elnath", "Gienah", "Mu Leporis", "Nyx", "Tau Ceti",
			"Wazn", "Alphard", "Phact", "Altair"*/
			"Myril", "Hyperion", "Kestrel Ceti", "Andromeda Pass", "Alpheratz", "HH Andromedae", "Buna",
			"Mirach", "Nembus", "Sterrennacht", "Titawin", "Veritate", "Kappa Andromedae", "Verdun", "Salis Major",
			"Lyrisin Omega", "Incandesce Seconda", "Vivida Laetus", "Furioso", "Fanteriso")
		var/list/destination_types = list("dockyard", "station", "vessel", "waystation", "telecommunications satellite", "spaceport", "distress beacon", "anomaly", "colony", "outpost", "city-station", "megastructure", "temple of attunement", "gridlock station", "waypoint gate", "sector command")
		while(i)
			destination_names.Add("a [pick(destination_types)] in [pick(star_names)]")
			i--

//////////////////////////////////////////////////////////////////////////////////
/* Getting rid of non-lore appropriate stuff
// TSCs
/datum/lore/organization/nanotrasen
	name = "NanoTrasen Incorporated"
	short_name = "NanoTrasen"
	desc = "" // Todo: Write this.
	history = "" // This too.
	work = "research giant"
	headquarters = "Luna"
	motto = ""
	ship_prefixes = list("NSV" = "exploration", "NTV" = "hauling", "NDV" = "patrol", "NRV" = "emergency response")
	// Note that the current station being used will be pruned from this list upon being instantiated
	destination_names = list(
		"NSS Exodus in Nyx",
		"NCS Northern Star in Vir",
		"NCS Southern Cross in Vir",
		"NDV Icarus in Nyx",
		"NAS Vir Central Command",
		"a dockyard orbiting Sif",
		"an asteroid orbiting Kara",
		"an asteroid orbiting Rota",
		"Vir Interstellar Spaceport"
		)
/datum/lore/organization/hephaestus
	name = "Hephaestus Industries"
	short_name = "Hephaestus"
	desc = "Hephaestus Industries is the largest supplier of arms, ammunition, and small millitary vehicles in Sol space. \
	Hephaestus products have a reputation for reliability, and the corporation itself has a noted tendency to stay removed \
	from corporate politics. They enforce their neutrality with the help of a fairly large asset-protection contingent which \
	prevents any contracting polities from using their own materiel against them. SolGov itself is one of Hephastus� largest \
	bulk contractors owing to the above factors."
	history = ""
	work = "arms manufacturer"
	headquarters = ""
	motto = ""
	ship_prefixes = list("HTV" = "freight", "HTV" = "munitions resupply")
	destination_names = list(
		"a SolGov dockyard on Luna"
		)
/datum/lore/organization/vey_med
	name = "Vey Medical"
	short_name = "Vey Med"
	desc = "Vey-Med is one of the newer TSCs on the block and is notable for being largely owned and opperated by Skrell. \
	Despite the suspicion and prejudice leveled at them for their alien origin, Vey-Med has obtained market dominance in \
	the sale of medical equipment-- from surgical tools to large medical devices to the Oddyseus trauma response mecha \
	and everything in between. Their equipment tends to be top-of-the-line, most obviously shown by their incredibly \
	human-like FBP designs. Vey�s rise to stardom came from their introduction of ressurective cloning, although in \
	recent years they�ve been forced to diversify as their patents expired and NanoTrasen-made medications became \
	essential to modern cloning."
	history = ""
	work = "medical equipment supplier"
	headquarters = ""
	motto = ""
	ship_prefixes = list("VTV" = "transportation", "VMV" = "medical resupply")
	destination_names = list()
/datum/lore/organization/zeng_hu
	name = "Zeng-Hu pharmaceuticals"
	short_name = "Zeng-Hu"
	desc = "Zeng-Hu is an old TSC, based in the Sol system. Until the discovery of Phoron, Zeng-Hu maintained a stranglehold \
	on the market for medications, and many household names are patentted by Zeng-Hu-- Bicaridyne, Dylovene, Tricordrizine, \
	and Dexalin all came from a Zeng-Hu medical laboratory. Zeng-Hu�s fortunes have been in decline as Nanotrasen�s near monopoly \
	on phoron research cuts into their R&D and Vey-Med�s superior medical equipment effectively decimated their own equipment \
	interests. The three-way rivalry between these companies for dominance in the medical field is well-known and a matter of \
	constant economic speculation."
	history = ""
	work = "pharmaceuticals company"
	headquarters = ""
	motto = ""
	ship_prefixes = list("ZTV" = "transportation", "ZMV" = "medical resupply")
	destination_names = list()
/datum/lore/organization/ward_takahashi
	name = "Ward-Takahashi General Manufacturing Conglomerate"
	short_name = "Ward-Takahashi"
	desc = "Ward-Takahashi focuses on the sale of small consumer electronics, with its computers, communicators, \
	and even mid-class automobiles a fixture of many households. Less famously, Ward-Takahashi also supplies most \
	of the AI cores on which vital control systems are mounted, and it is this branch of their industry that has \
	led to their tertiary interest in the development and sale of high-grade AI systems. Ward-Takahashi�s economies \
	of scale frequently steal market share from Nanotrasen�s high-price products, leading to a bitter rivalry in the \
	consumer electronics market."
	history = ""
	work = "electronics manufacturer"
	headquarters = ""
	motto = ""
	ship_prefixes = list("WTV" = "freight")
	destination_names = list()
/datum/lore/organization/bishop
	name = "Bishop Cybernetics"
	short_name = "Bishop"
	desc = "Bishop�s focus is on high-class, stylish cybernetics. A favorite among transhumanists (and a b�te noire for \
	bioconservatives), Bishop manufactures not only prostheses but also brain augmentation, synthetic organ replacements, \
	and odds and ends like implanted wrist-watches. Their business model tends towards smaller, boutique operations, giving \
	it a reputation for high price and luxury, with Bishop cyberware often rivalling Vey-Med�s for cost. Bishop�s reputation \
	for catering towards the interests of human augmentation enthusiasts instead of positronics have earned it ire from the \
	Positronic Rights Group and puts it in ideological (but not economic) comptetition with Morpheus Cyberkinetics."
	history = ""
	work = "cybernetics and augmentation manufacturer"
	headquarters = ""
	motto = ""
	ship_prefixes = list("BTV" = "transportation")
	destination_names = list()
/datum/lore/organization/morpheus
	name = "Morpheus Cyberkinetics"
	short_name = "Morpheus"
	desc = "The only large corporation run by positronic intelligences, Morpheus caters almost exclusively to their sensibilities \
	and needs. A product of the synthetic colony of Shelf, Morpheus eschews traditional advertising to keep their prices low and \
	relied on word of mouth among positronics to reach their current economic dominance. Morpheus in exchange lobbies heavily for \
	positronic rights, sponsors positronics through their Jans-Fhriede test, and tends to other positronic concerns to earn them \
	the good-will of the positronics, and the ire of those who wish to exploit them."
	history = ""
	work = "cybernetics manufacturer"
	headquarters = ""
	motto = ""
	ship_prefixes = list("MTV" = "freight")
	// Culture names, because Anewbe told me so.
	ship_names = list(
		"Nervous Energy",
		"Prosthetic Conscience",
		"Revisionist",
		"Trade Surplus",
		"Flexible Demeanour",
		"Just Read The Instructions",
		"Limiting Factor",
		"Cargo Cult",
		"Gunboat Diplomat",
		"A Ship With A View",
		"Cantankerous",
		"I Thought He Was With You",
		"Never Talk To Strangers",
		"Sacrificial Victim",
		"Unwitting Accomplice",
		"Bad For Business",
		"Just Testing",
		"Size Isn't Everything",
		"Yawning Angel",
		"Liveware Problem",
		"Very Little Gravitas Indeed",
		"Zero Gravitas",
		"Gravitas Free Zone",
		"Absolutely No You-Know-What",
		"Existence Is Pain",
		"I'm Walking Here",
		"Screw Loose",
		"Of Course I Still Love You",
		"Limiting Factor",
		"So Much For Subtley",
		"Unfortunate Conflict Of Evidence",
		"Prime Mover",
		"It's One Of Ours",
		"Thank You And Goodnight",
		"Boo!",
		"Reasonable Excuse",
		"Honest Mistake",
		"Appeal To Reason",
		"My First Ship II",
		"Hidden Income",
		"Anything Legal Considered",
		"New Toy",
		"Me, I'm Always Counting",
		"Just Five More Minutes"
		)
	destination_names = list()
/datum/lore/organization/xion
	name = "Xion Manufacturing Group"
	short_name = "Xion"
	desc = "Xion, quietly, controls most of the market for industrial equipment. Their portfolio includes mining exosuits, \
	factory equipment, rugged positronic chassis, and other pieces of equipment vital to the function of the economy. Xion \
	keeps its control of the market by leasing, not selling, their equipment, and through infamous and bloody patent protection \
	lawsuits. Xion are noted to be a favorite contractor for SolGov engineers, owing to their low cost and rugged design."
	history = ""
	work = "industrial equipment manufacturer"
	headquarters = ""
	motto = ""
	ship_prefixes = list("XTV" = "hauling")
	destination_names = list()
// Governments
/datum/lore/organization/sifgov
	name = "Sif Governmental Authority"
	short_name = "SifGov"
	desc = "SifGov is the sole governing administration for the Vir system, based in New Reykjavik, Sif.  It is a representative \
	democratic government, and a fully recognized member of the Solar Confederate Government.  Anyone operating inside of Vir must \
	comply with SifGov's legislation and regulations."
	history = "" // Todo like the rest of them
	work = "governing body of Sif"
	headquarters = "New Reykjavik, Sif"
	motto = ""
	autogenerate_destination_names = FALSE
	ship_prefixes = list("SGA" = "hauling", "SGA" = "energy relay")
	destination_names = list(
						"New Reykjavik on Sif",
						"Radiance Energy Chain",
						"a dockyard orbiting Sif",
						"a telecommunications satellite",
						"Vir Interstellar Spaceport"
						)
/datum/lore/organization/solgov
	name = "Solar Confederate Government"
	short_name = "SolGov"
	desc = "SolGov is a decentralized confederation of human governmental entities based on Luna, Sol, which defines top-level law for their member states.  \
	Member states receive various benefits such as defensive pacts, trade agreements, social support and funding, and being able to participate \
	in the Colonial Assembly.  The majority, but not all human territories are members of SolGov.  As such, SolGov is a major power and \
	defacto represents humanity on the galatic stage."
	history = "" // Todo
	work = "governing polity of humanity's Confederation"
	headquarters = "Luna"
	motto = "Nil Mortalibus Ardui Est" // Latin, because latin.  Says 'Nothing is too steep for mortals'.
	autogenerate_destination_names = TRUE
	ship_prefixes = list("SCG-T" = "transportation", "SCG-D" = "diplomatic", "SCG-F" = "freight")
	destination_names = list(
						"Venus",
						"Earth",
						"Luna",
						"Mars",
						"Titan"
						)// autogen will add a lot of other places as well.
// Military
/datum/lore/organization/sif_guard
	name = "Sif Homeguard Forces" // Todo: Get better name from lorepeople.
	short_name = "SifGuard"
	desc = ""
	history = ""
	work = "Sif Governmental Authority's military"
	headquarters = "Sif" // Make this more specific later.
	motto = ""
	autogenerate_destination_names = FALSE // Kinda weird if SifGuard goes to Nyx.
	ship_prefixes = list("SGSC" = "military", "SGSC" = "patrol", "SGSC" = "rescue", "SGSC" = "emergency response") // Todo: Replace prefix with better one.
	destination_names = list(
						"a classified location in SolGov territory",
						"Sif orbit",
						"the rings of Kara",
						"the rings of Rota",
						"Firnir orbit",
						"Tyr orbit",
						"Magni orbit",
						"a wreck in SifGov territory",
						"a military outpost",
						)
*/
/datum/lore/organization/kinaris
	name = "Kinaris Colonization and Conversion LLC"
	short_name = "Kinaris"
	desc = "Kinaris is a bleeding-edge conversion effort based in Myril within the Andromeda Galaxy, which specializes on stabilizing the rights \
	and needs of any developing world. While many question the will and prowess in their technological religion referred to as Radiance, \
	there is no denying how powerful they've become with Weave-Attuned gifts unique to their intergalactic megacorporation. Despite only recently \
	setting a foothold within the Milky Way, their conversion efforts have briefly shaken the galaxy for a new light of change- one which Kinaris \
	willingly snuffed out after seeing the disarray and sin the newly-discovered Humanity was dwelling within; waiting for them to mature firsthand. \
	Most stable colonies, stations, civilizations, planets, or anywhere on the spectrum is often backed by the firm hand of Kinaris- underneath one rule: \
	Be Radiant."
	history = ""
	work = "Weave-research, conversion, and colony management"
	headquarters = "Holy City of Radiant Hearth, Myril"
	motto = "Be Radiant"

	ship_prefixes = list("KNS" = "freight", "KNS" = "rescue", "KNS" = "transportation", "KNCS" = "diplomatic", "KN-Star" = "research", "EKN" = "energy relay")
	ship_names = list(
		"Pillar of Light",
		"Virtue",
		"Incandescence Armara",
		"Evorsio Majora",
		"Constellation",
		"Ryynthal Lucerna",
		"Starlight",
		"Tempest",
		"Solar Hearth",
		"Firefly",
		"Evorsio",
		"Holy Skies",
		"Reverberation",
		"Harmony",
		"Ensamble",
		"Bravado"
		)

	autogenerate_destination_names = FALSE
	destination_names = list(
						"KNCS Hollow Point",
						"a gridlock station at Kestrel Ceti",
						"a waypoint gate at Andromeda Pass",
						"a ringworld at Incandesce Seconda",
						"a temple of attunement at Myril",
						"stellar Weave at Furioso",
						"Salis Major orbit",
						"a megastructure at Kappa Andromedae",
						"Radiant Hearth",
						"sector command at Vivida Laetus",
						"a dissonant tear at RR Lyra",
						"a city-station at Kappa Andromedae",
						"a city-station at Verdun",
						"a city-station at Alpheratz",
						"the rings of Layenia",
						"Dzar metalworking at Loto",
						"a classified location within the Weave",
						"a developing colony at Timber Hearth",
						"a distress signal in Manuel sector",//dammit what happened now
						"a gridlock station at Hyperion"//hey, that's CC!
						)

/datum/lore/organization/dzar
	name = "Dzar Underworks Metalworking"
	short_name = "Dzar"
	desc = "Dzar Underworks is a conglomerate of metalworking companies underneath the intergalactic umbrella of Kinaris, formed firstly in opposition of \
	Radiance in the past, and an ally now. They posess the unique engram of smithing highly-sophisticated metals and impossible materials from patented forges, \
	which is kept secret by the shareholders at Dzar. The unique way Dzar is able to manufacture metals have left them uncontested against many other companies, \
	leading them to a divine- if not pricey- hold on anyone who is interested in making high-grade vessels, colonies, megastructures, or plain-old appliances. \
	Dzar works side-by-side with Kinaris, where Radiant Technology is their reward in return for high-grade metals."
	history = ""
	work = "metalsmithing, mining, and material research"
	headquarters = "the hollow-world of Salis Major"
	motto = "in virtue we trust"

	ship_prefixes = list("DZ" = "hauling", "DZ" = "cargo", "DZA" = "asset security")
	ship_names = list(
		"Workhorse",
		"Dark Descent",
		"Vigilance",
		"Hellfire",
		"Steed",
		"Salisan",
		"Virtue",
		"Ram",
		"Gabbro",
		"Basalt",
		"Rieback",
		"Brimstone",
		"Ashen Scoria",
		"Forge-maiden",
		"Delta"
		)

	autogenerate_destination_names = FALSE
	destination_names = list(
						"KNCS Hollow Point",
						"a gridlock station at Kestrel Ceti",
						"a waypoint gate at Andromeda Pass",
						"a ringworld at Incandesce Seconda",
						"Salis Major orbit",
						"a megastructure at Kappa Andromedae",
						"the rings of Layenia",
						"Dzar metalworking at Loto",
						"a metalworking site at Salis Major",
						"a mining colony at Titawin",
						"a slag dump at Fanteriso",
						"the outer asteroid belt at Mirach",
						"a gas mining site at Lyrisin Omega",
						)

/datum/lore/organization/azuregov
	name = "Azurean Government"
	short_name = "AzureGov"
	desc = "The Azurean Government (also known as AzureGov, or Azurean Govern) is the leading spearhead into peace and tranquility within Andromeda; despite it's criticisms. \
	It governs and loosely controls the various megacorporations currently operating around Andromeda, but it's no secret that their power is limited in comparison to some \
	companies. Despite this, their operations in ensuring that the representation of anthromorphs and other sentient creatures can be seen in a better light to lesser civilizations, \
	such as humanity, given that the correct pacts can be agreed upon."
	history = ""
	work = "governing and representing anthro species intergalactically"
	headquarters = "KNCS Jul Ryynthal, Myril Majoris orbit"
	motto = "no soul left behind"

	ship_prefixes = list("AZ-T" = "transportation", "AZ-D" = "diplomatic", "AZ-F" = "freight")

	autogenerate_destination_names = TRUE

/datum/lore/organization/zaocorp
	name = "Zao Security and Protection"
	short_name = "ZaoCorp"
	desc = "ZaoCorp is a vigilant workhorse of stabilizing colonies with quick, effective, and calm policework. Their strict neurological persuit of hiring only the most fair \
	and levelheaded individuals leads them to establish peace among any colonies they're contracted at, making for an effective police force. Not only do they hire the best of \
	the best through genetic selection and splicing, they also manufacture bleeding-edge Nuovo-fabric exosuits, threaded to a casual and calm trenchcoat adorned in blue and beige. \
	This makes for an approachable, fair, and just police force that is capable of nonlethal apprehension where necessary. Trust is always locked in the hands of Zao; stifling any \
	concerns peacefully through vigilance."
	history = ""
	work = "contracted policework"
	headquarters = "Incandesce Seconda"
	motto = "secure the people, save the future"

	ship_prefixes = list("ZCO" = "transportation", "ZC" = "patrol")

	autogenerate_destination_names = TRUE
