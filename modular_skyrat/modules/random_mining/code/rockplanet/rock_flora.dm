//*******************Contains everything related to the flora on Rockplanet.*******************************
//Similar to the Lavaland file, this includes: the structures, their produce, their seeds and any related recipes

//////////////
//WILD FLORA
/obj/structure/flora/ash/rockplanet //Yes, I made them ash subtypes. It gives me juicy harvest-related variables.
	icon = 'modular_skyrat/modules/random_mining/code/rockplanet/icons/rock_flora.dmi'
	needs_sharp_harvest = FALSE
	number_of_variants = 1	//Can be changed later :)

/obj/structure/flora/ash/rockplanet/coyote	//((Coyote Tobacco, Nicotiana attenuata)
	name = "leafy coyote"
	desc = "A coyote plant more accustomed to drier climates, with flourishing green tobacco leaves."
	harvested_name = "plucked coyote"
	harvested_desc = "A plucked coyote plant, more accustomed to the drier climates. Small buds are growing along it."
	icon_state = "wild_coyote"
	harvest = /obj/item/food/grown/rock_flora/coyote
	harvest_amount_high = 6
	harvest_time = 15
	harvest_message_low = "You pick a coyote leaf."
	harvest_message_med = "You pick several coyote leaves."
	harvest_message_high = "You cleanly pick the whole stem of coyote leaves."
	regrowth_time_low = 5200
	regrowth_time_high = 8400

/obj/structure/flora/ash/rockplanet/yucca //(Dagger Plant, Yucca aloifolia)
	name = "fruiting dagger-yucca"
	desc = "A Yucca plant acclimated to the dry climate, with large purple fruits hanging off of it.."
	harvested_name = "dagger-yucca"
	harvested_desc = "A plucked Yucca plant acclimated to the dry climate, the stem beggining to blossom with small buds."
	icon_state = "wild_yucca"
	harvest = /obj/item/food/grown/rock_flora/yucca
	harvest_amount_high = 3
	harvest_time = 10
	harvest_message_low = "You pick a yucca fruit."
	harvest_message_med = "You pick two yucca fruits."
	harvest_message_high = "You pull off three yucca fruits."
	regrowth_time_low = 4800
	regrowth_time_high = 7200

/obj/structure/flora/ash/rockplanet/yucca/harvest(user)
	. = ..()
	if(prob(20))
		for(var/i in 1 to rand(3))	//Im sure there's a better way to randomly spawn 1 to 3 yucca roots, but plants dont support 2 drops PERIOD so this whole thing is crummy code
			new /obj/item/food/grown/rock_flora/yuccaroot(get_turf(src))
	return
//[FUCK] THIS MIGHT ONLY APPLY TO THE RANDOM-GEN PLANT, NOT THE BOTANY ONE. FIND A SOLUTION!!!!! WE NEED OUR SOAP!!!!!!!!!!


/obj/structure/flora/ash/rockplanet/agaricus //(Wine-colored Agaricus, Agaricus subrutilescens)
	name = "blooming agaricus"
	desc = "A palm-sized, brown-ish mushroom cap. The bottomside is almost wine-red."
	harvested_name = "budding agaricus"
	harvested_desc = "Small brown-capped mushrooms seem to be sprouting here, though they're too small to be of use right now."
	icon_state = "wild_agaricus"
	harvest = /obj/item/food/grown/rock_flora/agaricus
	harvest_amount_high = 4
	harvest_time = 10
	harvest_message_low = "You pick a mushroom or two."
	harvest_message_med = "You pick a few mushrooms."
	harvest_message_high = "You pick several mushrooms."
	regrowth_time_low = 6000
	regrowth_time_high = 9000

//////////////
//FOOD ITEMS
/obj/item/food/grown/rock_flora
	name = "rockplanet grown item"
	desc = "(THIS IS BROKEN - PLEASE REPORT HOW YOU GOT IT, THEN CONVERT IT INTO A SEED)"
	icon = 'modular_skyrat/modules/random_mining/code/rockplanet/icons/rock_flora.dmi'
	icon_state = "no name"
	resistance_flags = FLAMMABLE
	max_integrity = 100
	seed = /obj/item/seeds/rockplanet/coyote	//If the item is somehow found, it can't be re-created
	wine_power = 20	//Inherited by all the types

/obj/item/food/grown/rock_flora/coyote
	name = "coyote tobacco"
	desc = "Dry them out to make some smokes."	//Same description as normal tobacco, and to non-botanists it'll seem to just be the same
	icon_state = "coyote_tobacco"
	seed = /obj/item/seeds/rockplanet/coyote

	dry_grind = TRUE
	distill_reagent = /datum/reagent/consumable/ethanol/sotol_coyote

	special_desc_requirement = EXAMINE_CHECK_JOB
	special_desc_jobs = list("Botanist")
	special_desc = "Tobacco like this commonly sees medicinal use as a painkiller due to its chemical contents. This particular strain could also substitute Dasylirion Cedrosanum in making mild alcohol..."

/obj/item/food/grown/rock_flora/yucca
	name = "purple yucca fruit"
	desc = "A deep purple fruit with hard ridges. The inside is a pale white."
	icon_state = "yucca_fruit"
	seed = /obj/item/seeds/rockplanet/yucca

	special_desc_requirement = EXAMINE_CHECK_JOB
	special_desc_jobs = list("Botanist")
	special_desc = "Aside from these edible fruits, the plant's roots can be scraped and made into a cleaning solution!"

/obj/item/food/grown/rock_flora/agaricus
	name = "wine-colored agaricus"
	desc = "Average-sized mushrooms, the undersides of the caps are wine-red."
	icon_state = "agaricus_shrooms"
	seed = /obj/item/seeds/rockplanet/agaricus

	special_desc_requirement = EXAMINE_CHECK_JOB
	special_desc_jobs = list("Botanist")
	special_desc = "This mushroom is regarded simultaneously as edible, inedible, and responsible for causing gastric upset."	//The wikipedia said pretty much the same thing. Its funny, I'm keeping it like this

//////////////
//SEED ITEMS
/obj/item/seeds/rockplanet
	name = "rockplanet seeds"
	desc = "(You should never see this. If you do, report the issue and... uh, throw it in disposals? Burn it?)"
	icon = 'modular_skyrat/modules/random_mining/code/rockplanet/icons/rock_flora.dmi'
	growing_icon = 'modular_skyrat/modules/random_mining/code/rockplanet/icons/rock_flora.dmi'
	lifespan = 50
	endurance = 35
	maturation = 8
	production = 4
	yield = 4
	potency = 15
	growthstages = 4
	rarity = 25
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1)
	species = "coyote" //silence unit test (like the lavaland ones needed)

/obj/item/seeds/rockplanet/coyote
	name = "pack of coyote tobacco seeds"
	desc = "These seeds grow into Coyote Tobacco."
	icon_state = "seeds-coyote"
	species = "coyote"
	plantname = "Coyote Tobacco"
	product = /obj/item/food/grown/rock_flora/coyote
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/drug/nicotine = 0.03, /datum/reagent/consumable/nutriment = 0.01, /datum/reagent/medicine/granibitaluri = 0.03)	//Acts as a mild painkiller. Balance debate pending.

/obj/item/seeds/rockplanet/yucca
	name = "pack of dagger-yucca seeds"
	desc = "These seeds grow into Dagger-Plant Yucca."
	icon_state = "seed-yucca"
	species = "yucca"
	plantname = "Dagger-Yucca"
	product = /obj/item/food/grown/rock_flora/yucca
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.02)	//Find a secondary chem? MAKE a secondary chem?

/obj/item/seeds/rockplanet/agaricus
	name = "pack of agaricus mycelium"
	desc = "This mycelium grows into agaricus mushrooms, specifically wine-colored agaricus. Technically edible, but very unappetizing..."
	icon_state = "mycelium-agaricus"
	species = "agaricus"
	plantname = "Agaricus Mushrooms"
	maturation = 4
	growthstages = 2
	product = /obj/item/food/grown/rock_flora/agaricus
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism)
	reagents_add = list(/datum/reagent/toxin/mushroom_powder = 0.1, /datum/reagent/medicine/insulin = 0.1, /datum/reagent/yuck = 0.1)	//Could be of value for the insulin (Yes, I looked it up, agaricus can help improve the bodies use of insulin)

//////////////
//CRAFTED ITEMS
/datum/reagent/consumable/ethanol/sotol_coyote
	name = "Sotol Coyote"
	description = "A cleverly-recreated recipe, using fermented Coyote Tobacco sourced from LV-669. In exchange for the accessible ingredients, its minerality is replaced with - tobacco-ality.?"
	color = "#60745c"
	boozepwr = 30
	quality = DRINK_GOOD
	taste_description = "sweet hazelnut with a hint of tobacco"
	glass_icon = 'modular_skyrat/modules/random_mining/code/rockplanet/icons/rock_flora.dmi'
	glass_icon_state = "sotol_coyote_glass"
	glass_name = "Sotol Coyote"
	glass_desc = "A cleverly-recreated recipe, almost impossible to distinguish from the original. It's adorned with... a tobacco leaf?"
	chemical_flags = NONE	//Only way to get this is fermenting
	glass_price = DRINK_PRICE_HIGH
	liquid_fire_power = 2

//Grinding the yuccaroot is good mmkay
/obj/item/food/grown/rock_flora/yuccaroot
	name = "yucca root"
	desc = "A greenish-brownish root, taken from a yucca plant."
	icon_state = "yuccaroot"
	seed = /obj/item/seeds/rockplanet/yucca
	grind_results = list(/datum/reagent/space_cleaner/yucca_soap = 10)

	special_desc_requirement = EXAMINE_CHECK_JOB
	special_desc_jobs = list("Botanist","Chemist")
	special_desc = "Full of saponin, an all-natural cleaning solution!"

/datum/reagent/space_cleaner/yucca_soap
	name = "Yucca root Soap"
	description = "Concentrated saponin, which as an antibacterial/antifungal soap. Most effective mixed with water."
	color = "#88967f"	//Its a green, earthy color
	taste_description = "earthy sourness"
	reagent_weight = 0.7 //Doesnt spray quite as far
	chemical_flags = NONE //Only way to get this is cutting root from the seed (idk if it doesnt make sense) and then grinding it
