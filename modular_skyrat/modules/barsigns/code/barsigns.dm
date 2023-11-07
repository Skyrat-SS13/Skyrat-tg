// Modularly set the correct icon file
/obj/machinery/barsign/set_sign(datum/barsign/sign)
	// uses tg icon file
	if(!istype(sign, /datum/barsign/skyrat))
		icon = initial(icon)
		return ..()

	// uses modular icon file
	if(istype(sign, /datum/barsign/skyrat/large))
		icon = 'modular_skyrat/modules/barsigns/icons/barsigns96x96.dmi'
	else
		icon = 'modular_skyrat/modules/barsigns/icons/barsigns.dmi'

	return ..()

/datum/barsign/skyrat/topmen
	name = "Top Men"
	icon_state = "topmen"
	neon_color = "#C2AACA"

/datum/barsign/skyrat/spaceballgrille
	name = "Spaceball Grille"
	icon_state = "spaceballgrille"
	neon_color = "#827973"

/datum/barsign/skyrat/clubee
	name = "Club Bee"
	icon_state = "clubee"
	neon_color = "#F2EEEE"

/datum/barsign/skyrat/thesun
	name = "The Sun"
	icon_state = "thesun"
	neon_color = "#F8F0B8"

/datum/barsign/skyrat/limbo
	name = "The Limbo"
	icon_state = "limbo"
	desc = "A popular haunt for lost souls. The mood lighting is killer!"
	neon_color = "#777777"

/datum/barsign/skyrat/meadbay
	name = "Meadbay"
	icon_state = "meadbay"
	neon_color = "#EBB823"

/datum/barsign/skyrat/cindikate
	name = "Cindi Kate's"
	icon_state = "cindikate"
	neon_color = "#FF3403"

/datum/barsign/skyrat/theclownshead
	name = "The Clown's Head"
	icon_state = "theclownshead"
	desc = "Home of Headdy, the honking clown head!"
	neon_color = "#FFD800"

/datum/barsign/skyrat/theorchard
	name = "The Orchard"
	icon_state = "theorchard"
	neon_color = "#CFFF47"

/datum/barsign/skyrat/thesaucyclown
	name = "The Saucy Clown"
	icon_state = "thesaucyclown"
	desc = "A known gathering site for the annual clown courtship rituals."
	neon_color = "#FF66CC"

/datum/barsign/skyrat/thedamnwall
	name = "The Damn Wall"
	icon_state = "thedamnwall"
	desc = "When you're up against a wall, it's best to have stout friends and stout liquor right there beside you."
	neon_color = "#CC3333"

/datum/barsign/skyrat/whiskeyimplant
	name = "Whiskey Implant"
	icon_state = "whiskeyimplant"
	neon_color = "#E9F517"

/datum/barsign/skyrat/carpecarp
	name = "Carpe Carp"
	icon_state = "carpecarp"
	neon_color = "#C717FE"

/datum/barsign/skyrat/robustroadhouse
	name = "Robust Roadhouse"
	icon_state = "robustroadhouse"
	neon_color = "#F7A804"

/datum/barsign/skyrat/theredshirt
	name = "The Redshirt"
	icon_state = "theredshirt"
	neon_color = "#FF92E0"

/datum/barsign/skyrat/maltesefalconmk2
	name = "Maltese Falcon MK2"
	icon_state = "maltesefalconmk2"
	desc = "The Maltese Falcon mark two, now extra hard boiled."
	neon_color = "#E30000"

/datum/barsign/skyrat/thecavernmk2
	name = "The Cavern MK2"
	icon_state = "thecavernmk2"
	desc = "Fine drinks while listening to some fine tunes."
	neon_color = "#AA9393"

/datum/barsign/skyrat/lv426
	name = "LV-426"
	icon_state = "lv426"
	desc = "Drinking with fancy facemasks is clearly more important than going to medbay."
	neon_color = "#00F206"

/datum/barsign/skyrat/zocalo
	name = "Zocalo"
	icon_state = "zocalo"
	desc = "Anteriormente ubicado en Spessmerica."
	neon_color = "#E5AF1C"

/datum/barsign/skyrat/fourtheemprah
	name = "4 The Emprah"
	icon_state = "4theemprah"
	desc = "Enjoyed by fanatics, heretics, and brain-damaged patrons alike."
	neon_color = "#E5AF1C"

/datum/barsign/skyrat/ishimura
	name = "Ishimura"
	icon_state = "ishimura"
	desc = "Well known for their quality brownstar and delicious crackers."
	neon_color = "#FF0000"

/datum/barsign/skyrat/tardis
	name = "Tardis"
	icon_state = "tardis"
	desc = "This establishment has been through at least 5,343 iterations."
	neon_color = "#2739AA"

/datum/barsign/skyrat/quarks
	name = "Quark's"
	icon_state = "quarks"
	desc = "Frequenters of this establishment are often seen wearing meson scanners; how quaint."
	neon_color = "#10E500"

/datum/barsign/skyrat/tenforward
	name = "Ten Forward"
	icon_state = "tenforward"
	neon_color = "#E5AF1C"

/datum/barsign/skyrat/thepranicngpony
	name = "The Prancing Pony"
	icon_state = "theprancinggpony"
	desc = "Ok, we don't take to kindly to you short folk pokin' round looking for some ranger scum."
	neon_color = "#FF9100"

/datum/barsign/skyrat/vault13
	name = "Vault 13"
	icon_state = "vault13"
	desc = "Coincidence is intentional."
	neon_color = "#FFA800"

/datum/barsign/skyrat/thehive
	name = "The Hive"
	icon_state = "thehive"
	neon_color = "#FFC62A"

/datum/barsign/skyrat/cantina
	name = "Chalmun's Cantina"
	icon_state = "cantina"
	desc = "The bar was founded on the principles of originality; they have the same music playing 24/7."
	neon_color = "#0078FF"

/datum/barsign/skyrat/milliways42
	name = "Milliways 42"
	icon_state = "milliways42"
	desc = "It's not really the end; it's the beginning, meaning, and answer for all your beverage needs."
	neon_color = "#FF00F6"

/datum/barsign/skyrat/timeofeve
	name = "The Time of Eve"
	icon_state = "thetimeofeve"
	desc = "Vintage drinks from 2453!."
	neon_color = "#EB52F8"

/datum/barsign/skyrat/spaceasshole
	name = "Space Asshole"
	icon_state = "spaceasshole"
	desc = "Open since 2125, Not much has changed since then; the engineers still release the singulo and the damn miners still are more likely to cave your face in that deliver ores."
	neon_color = "#FF0000"

/datum/barsign/skyrat/birdcage
	name = "The Bird Cage"
	icon_state = "birdcage"
	desc = "Caw."
	neon_color = "#FFD21E"

/datum/barsign/skyrat/narsie
	name = "Narsie Bistro"
	icon_state = "narsiebistro"
	desc = "The last pub before the World's End."
	neon_color = "#FF0000"

/datum/barsign/skyrat/fallout
	name = "The Booze Bunker"
	icon_state = "boozebunker"
	desc = "Never duck for cover without a drink!"
	neon_color = "#FCC41B"

/datum/barsign/skyrat/brokendreams
	name = "The Cafe of Broken Dreams"
	icon_state = "brokendreams"
	desc = "Try our new dogmeat sliders!"
	neon_color = "#E8E8A5"

/datum/barsign/skyrat/toolboxtavern
	name = "Toolbox Tavern"
	icon_state = "toolboxtavern"
	desc = "Free lodging with every Screwdriver purchased!"
	neon_color = ""

/datum/barsign/skyrat/blueoyster
	name = "The Blue Oyster"
	icon_state = "blueoyster"
	desc = "The totally heterosexual bar for totally heterosexual men, just come inside and see."
	neon_color = ""

/datum/barsign/skyrat/foreign
	name = "Foreign Food Sign"
	icon_state = "foreign"
	desc = "A sign written in some dead language advertising some non-descript foreign food."
	neon_color = ""

/datum/barsign/skyrat/commie
	name = "Prole's Preferred"
	icon_state = "commie"
	desc = "The only bar you will ever need, comrade!"
	neon_color = "#E46F6F"

/datum/barsign/skyrat/brokenheros
	name = "The Bar of Broken Heros"
	icon_state = "brokenheros"
	desc = "Do you enjoy hurting other people?"
	neon_color = ""

/datum/barsign/skyrat/sociallubricator
	name = "The Social Lubricator"
	icon_state = "sociallubricator"
	desc = "The perfect thing to make you like people you hate."
	neon_color = ""

/datum/barsign/skyrat/chemlab
	name = "The Chem Lab"
	icon_state = "chemlab"
	desc = "Try our new plasma martinis!"
	neon_color = ""

/datum/barsign/skyrat/mime
	name = "Moonshine Mime"
	icon_state = "mime"
	desc = "Silent, not stirred."
	neon_color = ""

/datum/barsign/skyrat/clown
	name = "Honking Clown"
	icon_state = "clown"
	desc = "Bananas not included."
	neon_color = ""

/datum/barsign/skyrat/progressive
	name = "A Modern and Progressive Tavern"
	icon_state = "progressive"
	desc = "Whatever that means."
	neon_color = "#DB9B9A"

/datum/barsign/skyrat/va11halla
	name = "VA-11 HALL-A"
	icon_state = "va11halla"
	desc = "Not as dangerous as N1-RV Ann-A."
	neon_color = "#FB3F7D"

/datum/barsign/skyrat/squatopia
	name = "Squatopia"
	icon_state = "squatopia"
	desc = "The crystal belonged to my father. He was murdered."
	neon_color = "#CC0033"

/datum/barsign/skyrat/bug
	name = "The Hungry Bug"
	icon_state = "hungrybug"
	desc = "Stop by and enjoy some of the Hole's famous gyoza!"
	neon_color = "#E2B001"

// 96x96 signs

/datum/barsign/skyrat/large/cyberslyph
	name = "Cyberslyph"
	icon_state = "cyberslyph"
	neon_color = "#00FFFF"
