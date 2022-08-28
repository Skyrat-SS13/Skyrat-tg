/datum/cultural_info/culture/generic
	name = "Other Culture"
	description = "You are from one of the many small, relatively unknown cultures scattered across the galaxy."
	additional_langs = list(/datum/language/spacer, /datum/language/yangyu)

/datum/cultural_info/culture/vatgrown
	name = "Vat Grown"
	description = "You were not born like most of the people, instead grown and raised in laboratory conditions, either as clone, gene-adapt or some experiment. Your outlook diverges from baseline humanity accordingly."
	additional_langs = list(/datum/language/spacer)

/datum/cultural_info/culture/spacer_core
	name = "Spacer, Core Systems"
	description = "You are from the void between worlds, though close to home. You are from one of the myriad space stations, orbital platforms, long haul freighters, \
	gateway installations or other facilities that occupy the vastness of space. Spacers near the core worlds are accustomed to life in the fast lane, constantly moving between \
	places, meeting a myriad of people and experiencing many of the cultures and worlds close to humanity's home. As such, Spacers of the core systems tend to be busy, sociable and \
	mobile, rarely satisfied with settled life. They almost universally know how to live and work in the void and take to such jobs more readily than their planet-bound counterparts."
	additional_langs = list(/datum/language/spacer, /datum/language/yangyu)

/datum/cultural_info/culture/spacer_frontier
	name = "Spacer, Frontier"
	description =  "You are from the void between worlds, though you are in the distant, vast frontier of SCG space and beyond. Out here things like national identity and culture mean less; \
	those who live so far from anything only look to their close family and friends rather than any larger group. Raised on one of the long haul freighters that move between frontier worlds delivering \
	vital goods, a lonely outpost on the edge of a dreary backwater, such people are raised in small, confined environments with few others, and tend to be most familiar with older, reliable but outdated \
	technology. An independent sort, people on the frontier are more likely to be isolationist and self-driven."
	economic_power = 0.9
	additional_langs = list(/datum/language/spacer)

/datum/cultural_info/culture/generic_human
	name = "Humankind"
	description = "You are from one of various planetary cultures of humankind."
	additional_langs = list(/datum/language/neorusskya, /datum/language/gutter, /datum/language/spacer, /datum/language/yangyu, /datum/language/selenian, /datum/language/arabic)

/datum/cultural_info/culture/martian_surfacer
	name = "Martian, Surfacer"
	description = "You are from the surface of Mars. Raised in one of the many farming communities or one of the great cities such as Olympus. Most of the surfacers \
	are known as Monsians, the largest cultural group on the planet. Most Surfacers have had a decent upbringing and represent the \
	average level of comfort expected in Sol space. Most surfacers are like many across the galaxy, though a few harbour rivalries with other Martian cultural \
	groups or are generally overly proud of their heritage, as is the case with the Gideons, to the point that they constantly refer to it."

/datum/cultural_info/culture/martian_tunneller
	name = "Martian, Tunneler"
	description = "You are one of the people of the UnderCities of Mars. The UnderCities, originally built as 'temporary' living space while the cities above them \
	were constructed, have since grown far beyond their original scope and have now spread out underneath the red planet. Tunnellers, despite typically having access \
	to the same amenities and services as Surfacers are somewhat poorer than their aboveground brethren as a result of their less desirable locale as well as a strong \
	criminal presence stemming from centuries of poor policing and a focus on the surface by the martian government. Most Tunnellers are resilient, though distrusting \
	and wary of outsiders, and tend to strongly dislike non-Martians."
	economic_power = 0.9

/datum/cultural_info/culture/earthling
	name = "Earth"
	description = "You are from Earth, home of humanity. Earth culture is much as it has been for centuries, with the old nation states, while no longer politically important, still \
	culturally significant to many humans across the galaxy, as all trace their roots to somewhere on the planet. While not as geographically diverse as they were in the past, most \
	countries have at least two arcologies which make up much of the population, with the remaining humans living in small villages or from one of the many nature preserve communes. \
	The long recovery period of Earth has resulted in much of the population being environmentally aware and heavily conservationist, eager to avoid past mistakes. Most Earthers are \
	a content folk who see themselves as close to nature and keepers of the heritage of humanity."
	economic_power = 1.1
	additional_langs = list(/datum/language/yangyu)

/datum/cultural_info/culture/luna_poor
	name = "Luna, Lower Class"
	description = "You are from Luna, a natural satellite of Earth and home to some of the richest, mostly highly cultured or influential people humanity has. Unfortunately, you are most certainly not one of them. \
	While Luna is known for its richness, the arts, culture and old money, it is also home to a sizeable population of working poor or middle-lower income persons. Typically the corporate employees \
	of one of the various corporations, persons hired in service roles in one of the many prefectures or a resident of New Vegas. The 'poor' of Luna typically resent the rich because of their \
	financial, cultural and political power and influence over their lives."
	economic_power = 1

/datum/cultural_info/culture/luna_rich
	name = "Luna, Upper Class"
	description = "You are from Luna, Earths only natural satellite and home to some of the richest, most highly cultured, or influential people of humanity. Fortunately for you, you are one of this elite and well \
	off class of people. The rich of Luna are politically and economically influential not just in Luna, but in the various corporations, organizations and government bodies of the SCG. \
	Luna's upper class isn't equal; generally divided between new, corporate money and old, dynastic money; many members of the old dynasties look down on the newly wealthy. \
	Much of the elite of Luna is embroiled in 'The Game' a state of political manoeuvring and intrigue among various factions and persons of influence and power \
	with implications far beyond the squabbles of the prefectures."
	economic_power = 1.3

/datum/cultural_info/culture/terran
	name = "Terran"
	description = "You are from Terra (not Earth), in the Gilgamesh system. The capital world of the Gilgamesh Colonial Confederation, your people embody what it means to be a part of the GCC. \
	Unfortunately, the years since the war have not been easy on Terra and the long period of economic recovery has not made life easy. The people of Terra are typically employed \
	in the military, industrial, government or service sectors, with an emphasis being placed on military service. Terrans today are generally poor, bitter and a somewhat broken people angry and \
	resentful about their loss in the Gaia Conflict. An upbringing on Terra emphasises an odd mix of service to the state, liberalism and militarism."
	required_lang = /datum/language/neorusskya
	economic_power = 0.9

/datum/cultural_info/culture/venusian_upper
	name = "Venusian, Zoner"
	description = "You are from one of the many zones of Venus. Floating high above the ground of the planet on massive platforms, you are one of the many who live on one of the most decadent locations in the \
	SCG. As a Venusian, you know luxury, wealth and entertainment. Primarily a tourist destination, many of the permanent residents work in the tourism industry and are notably middle-income. \
	Those above are exceptionally wealthy, being hotel, casino, resort owners, politicians, bankers or rich retirees."
	economic_power = 1.4

/datum/cultural_info/culture/venusian_surfacer
	name = "Venusian, Surfacer"
	description = "You are from the surface of Venus, one of many employed in mining, industry and services industries. Venusian Surfacers are fairly poor, especially compared to Zoners and \
	have far lower standards of living than those above. A hardy people who spend much of their time working in mostly unpleasant conditions in order to prop up the society above, \
	surfacers are a people who value hard work, solidarity, unity and democracy. Unfortunately, while they support noble ideals, the reality of their situation does not always \
	match them, and much of the surface of Venus finds itself rife with organised crime, separatist groups and other criminal organisations."
	economic_power = 0.9

/datum/cultural_info/culture/belter
	name = "Belter"
	description = "You are from Ceres. The people of Ceres and the wider asteroid belt are colloquially known as 'Belters.' Traditionally a people rooted in the mining industry, \
	the belters of today are primarily engaged in the mechanical services, engineering, shipbuilding and maintenance industries. Belters are quite varied, and something of a melting \
	pot owing to the sheer number of transient workers, hauler crews and government and corporate employees basing themselves around the great shipyards of Ceres. This has led to belter \
	culture being mainly about embracing change, new people and new experiences, as well as a sense of pride in their work, as the reputation of Ceres shipbuilding is widely known across \
	human space."
	economic_power = 1

/datum/cultural_info/culture/plutonian
	name = "Plutionian"
	description = "You are from Pluto, one of many denizens of this cruel and unforgiving world. For centuries Pluto has been in a slow state of decay and decline, resulting in \
	much of the planet's infrastructure being unstable or outright falling apart. This, coupled with rampant corruption and the large influence of criminal organisations across much of \
	the planet has led to the people of Pluto having something of a seedy reputation, its citizens being viewed with disrepute. The people themselves, however, are usually \
	just happy to get off the rock and to healthier locales. Unfortunately, despite the efforts of the wider SCG, many Plutonians tend to maintain criminal ties, even offworld."
	economic_power = 0.8
	additional_langs = list(/datum/language/neorusskya, /datum/language/gutter, /datum/language/spacer, /datum/language/yangyu)

/datum/cultural_info/culture/ceti
	name = "Cetite"
	description = "You are from Ceti Epsilon, the technical hub of the SCG. As a Cetite you are no stranger to the cutting edge of technology present in Sol space. \
	Putting education and the latest tech at the forefront of their priorities the people of Ceti are some of the brightest or tech savvy around. \
	This has afforded those from the system or planet a reputation as being a cut above the rest in technical matters, with those who attended the Ceti Institute of Technology \
	being considered some of the best qualified technical specialists in humanity. Recently there has been a rising transhumanist element in Ceti society resulting in a large \
	cybernetics culture; it is not uncommon to see many Cetites sporting some chrome."
	economic_power = 1.1

/datum/cultural_info/culture/zolmalchi
	name = "Zolmalchi"
	description =  "You are from any number of shadowy fleets, tumultuous colonies, or starless pocket dimensions alien beings called 'Demons' typically reside in. \
	These places tend to enjoy high levels of technology and denizens of quick wit, but often get stuck in battling with deeply ingrained archaic customs and obscure norms. \
	Many of these cultures have strict interpersonal hierarchies, though their dwellers are no stranger to betrayal and climbing up the social ladder with blood-stained hands is often the way to go. \
	A common philosophy in these oft-clashing places is the simple phrase, 'Do as thou wilt'."
	economic_power = 1
	additional_langs = list(/datum/language/yangyu)

