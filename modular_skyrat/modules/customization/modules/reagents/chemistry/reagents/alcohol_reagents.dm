// Modular Booze REAGENTS, see the following file for the mixes: modular_skyrat\modules\customization\modules\food_and_drinks\recipes\drinks_recipes.dm

/datum/reagent/consumable/ethanol/whiskey
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC //let's not force the detective to change his alcohol brand

// ROBOT ALCOHOL PAST THIS POINT
// WOOO!

/datum/reagent/consumable/ethanol/synthanol
	name = "Synthanol"
	description = "A runny liquid with conductive capacities. Its effects on synthetics are similar to those of alcohol on organics."
	color = "#1BB1FF"
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC
	boozepwr = 50
	quality = DRINK_NICE
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi' // This should cover anything synthanol related. Will have to individually tag others unless we make an object path for skyrat drinks.
	glass_icon_state = "synthanolglass"
	glass_name = "Glass of Synthanol"
	glass_desc = "The equivalent of alcohol for synthetic crewmembers. They'd find it awful if they had tastebuds too."
	taste_description = "motor oil"

/datum/reagent/consumable/ethanol/synthanol/on_mob_life(mob/living/carbon/C)
	if(!(C.mob_biotypes & MOB_ROBOTIC))
		C.reagents.remove_reagent(type, 3.6) //gets removed from organics very fast
		if(prob(25))
			C.vomit(5, FALSE, FALSE)
	return ..()

/datum/reagent/consumable/ethanol/synthanol/expose_mob(mob/living/carbon/C, method=TOUCH, volume)
	. = ..()
	if(C.mob_biotypes & MOB_ROBOTIC)
		return
	if(method == INGEST)
		to_chat(C, pick("<span class = 'danger'>That was awful!</span>", "<span class = 'danger'>That was disgusting!</span>"))

/datum/reagent/consumable/ethanol/synthanol/robottears
	name = "Robot Tears"
	description = "An oily substance that an IPC could technically consider a 'drink'."
	color = "#363636"
	boozepwr = 25
	glass_icon_state = "robottearsglass"
	glass_name = "Glass of Robot Tears"
	glass_desc = "No robots were hurt in the making of this drink."
	taste_description = "existential angst"

/datum/reagent/consumable/ethanol/synthanol/trinary
	name = "Trinary"
	description = "A fruit drink meant only for synthetics, however that works."
	color = "#ADB21f"
	boozepwr = 20
	glass_icon_state = "trinaryglass"
	glass_name = "Glass of Trinary"
	glass_desc = "Colorful drink made for synthetic crewmembers. It doesn't seem like it would taste well."
	taste_description = "modem static"

/datum/reagent/consumable/ethanol/synthanol/servo
	name = "Servo"
	description = "A drink containing some organic ingredients, but meant only for synthetics."
	color = "#5B3210"
	boozepwr = 25
	glass_icon_state = "servoglass"
	glass_name = "Glass of Servo"
	glass_desc = "Chocolate - based drink made for IPCs. Not sure if anyone's actually tried out the recipe."
	taste_description = "motor oil and cocoa"

/datum/reagent/consumable/ethanol/synthanol/uplink
	name = "Uplink"
	description = "A potent mix of alcohol and synthanol. Will only work on synthetics."
	color = "#E7AE04"
	boozepwr = 15
	glass_icon_state = "uplinkglass"
	glass_name = "Glass of Uplink"
	glass_desc = "An exquisite mix of the finest liquoirs and synthanol. Meant only for synthetics."
	taste_description = "a GUI in visual basic"

/datum/reagent/consumable/ethanol/synthanol/synthncoke
	name = "Synth 'n Coke"
	description = "The classic drink adjusted for a robot's tastes."
	color = "#7204E7"
	boozepwr = 25
	glass_icon_state = "synthncokeglass"
	glass_name = "Glass of Synth 'n Coke"
	glass_desc = "Classic drink altered to fit the tastes of a robot, contains de-rustifying properties. Bad idea to drink if you're made of carbon."
	taste_description = "fizzy motor oil"

/datum/reagent/consumable/ethanol/synthanol/synthignon
	name = "Synthignon"
	description = "Someone mixed wine and alcohol for robots. Hope you're proud of yourself."
	color = "#D004E7"
	boozepwr = 25
	glass_icon_state = "synthignonglass"
	glass_name = "Glass of Synthignon"
	glass_desc = "Someone mixed good wine and robot booze. Romantic, but atrocious."
	taste_description = "fancy motor oil"

// Other Booze

/datum/reagent/consumable/ethanol/gunfire
	name = "Gunfire"
	description = "A drink that tastes like tiny explosions."
	color = "#e4830d"
	boozepwr = 40
	quality = DRINK_GOOD
	taste_description = "tiny explosions"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "gunfire"
	glass_name = "Gunfire"
	glass_desc = "It pops constantly as you look at it, giving off tiny sparks."

/datum/reagent/consumable/ethanol/gunfire/on_mob_life(mob/living/carbon/M)
	if (prob(3))
		to_chat(M,"<span class='notice'>You feel the gunfire pop in your mouth.</span>")
	return ..()

/datum/reagent/consumable/ethanol/hellfire
	name = "Hellfire"
	description = "A nice drink that isn't quite as hot as it looks."
	color = "#fb2203"
	boozepwr = 60
	quality = DRINK_VERYGOOD
	taste_description = "cold flames that lick at the top of your mouth"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "hellfire"
	glass_name = "Hellfire"
	glass_desc = "An amber colored drink that isn't quite as hot as it looks."

/datum/reagent/consumable/ethanol/hellfire/on_mob_life(mob/living/carbon/M)
	M.adjust_bodytemperature(30 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, BODYTEMP_NORMAL + 30)
	return ..()

/datum/reagent/consumable/ethanol/sins_delight
	name = "Sin's Delight"
	description = "The drink smells like the seven sins."
	color = "#330000"
	boozepwr = 66
	quality = DRINK_FANTASTIC
	taste_description = "sin"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "sins_delight"
	glass_name = "Sin's Delight"
	glass_desc = "You can smell the seven sins rolling off the top of the glass."

/datum/reagent/consumable/ethanol/strawberry_daiquiri
	name = "Strawberry Daiquiri"
	description = "Pink looking alcoholic drink."
	boozepwr = 20
	color = "#FF4A74"
	quality = DRINK_NICE
	taste_description = "sweet strawberry, lime and the ocean breeze"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "strawberry_daiquiri"
	glass_name = "Strawberry Daiquiri"
	glass_desc = "Pink looking drink with flowers and a big straw to sip it. Looks sweet and refreshing, perfect for warm days."

/datum/reagent/consumable/ethanol/liz_fizz
	name = "Liz Fizz"
	description = "Triple citrus layered with some ice and cream."
	boozepwr = 0
	color = "#D8FF59"
	taste_description = "brain freezing sourness"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "liz_fizz"
	glass_name = "Liz Fizz"
	glass_desc = "Looks like a citrus sherbet seperated in layers? Why would anyone want that is beyond you."

/datum/reagent/consumable/ethanol/miami_vice
	name = "Miami Vice"
	description = "A drink layering Pina Colada and Strawberry Daiquiri"
	boozepwr = 30
	color = "#D8FF59"
	quality = DRINK_FANTASTIC
	taste_description = "sweet and refreshing flavor, complemented with strawberries and coconut, and hints of citrus"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "miami_vice"
	glass_name = "Miami Vice"
	glass_desc = "Strawberries and coconut, like yin and yang."

/datum/reagent/consumable/ethanol/malibu_sunset
	name = "Malibu Sunset"
	description = "A drink consisting of creme de coconut and tropical juices"
	boozepwr = 20
	color = "#FF9473"
	quality = DRINK_NICE
	taste_description = "coconut, with orange and grenadine accents"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "malibu_sunset"
	glass_name = "Malibu Sunset"
	glass_desc = "Tropical looking drinks, with ice cubes hovering on the surface and grenadine coloring the bottom."

/datum/reagent/consumable/ethanol/hotlime_miami
	name = "Hotlime Miami"
	description = "The essence of the 90's, if they were a bloody mess that is."
	boozepwr = 40
	color = "#A7FAE8"
	quality = DRINK_FANTASTIC
	taste_description = "coconut and aesthetic violence"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "hotlime_miami"
	glass_name = "Hotlime Miami"
	glass_desc = "This looks very aesthetically pleasing."

/datum/reagent/consumable/ethanol/hotlime_miami/on_mob_life(mob/living/carbon/M)
	M.set_drugginess(50)
	M.adjustStaminaLoss(-2)
	return ..()
