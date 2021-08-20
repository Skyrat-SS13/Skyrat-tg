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
	special_desc = "Aside from these edible fruits, the plant's seeds can be used in soap and shampoo!" //(grind seeds for somewhat hard to get soap ingredient(?)) Craft the soap with the seeds as an item?(?)

/obj/item/food/grown/rock_flora/agaricus
	name = "wine-colored agaricus"
	desc = "Average-sized mushrooms, the undersides of the caps are wine-red."
	icon_state = "agaricus_shrooms"
	seed = /obj/item/seeds/rockplanet/agaricus

	special_desc_requirement = EXAMINE_CHECK_JOB
	special_desc_jobs = list("Botanist")
	special_desc = "This mushroom is regarded simultaneously as edible, inedible, and responsible for causing gastric upset."	//The wikipedia said pretty much the same thing. Its funny, I'm keeping it like this
	//TO-DO: INDUCES VOMIT

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
	reagents_add = list(/datum/reagent/consumable/tinlux = 0.04, /datum/reagent/consumable/nutriment/vitamin = 0.02)	//CHANGE THIS

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
	reagents_add = list(/datum/reagent/toxin/mushroom_powder = 0.1, /datum/reagent/medicine/coagulant/seraka_extract = 0.02)	//CHANGE THIS

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
	chemical_flags = NONE	//Only way to get this is fermenting, so no flag for it being mixable.
	glass_price = DRINK_PRICE_HIGH
	liquid_fire_power = 2

/obj/item/soap/homemade/yucca
	desc = "A homemade bar of soap. Has a nice earthy scent."
	icon = 'modular_skyrat/modules/random_mining/code/rockplanet/icons/rock_flora.dmi'
	icon_state = "yucca_soap"
	cleanspeed = 30 //faster to reward chemists (and botanists in this case!) for going to the effort

/obj/item/soap/homemade/yucca/ComponentInitialize()
	return	//Yucca soap is gritty and doesn't slip (So botanists can't mass-produce slip items)
	/*
	Also, this may cause issues with the item having zero components?
	I dont know, it didnt look like /obj/item had any components unless they were under special conditions, and this doesnt have any of those conditions..
	If this causes future issues, now we know why. If not, then hopefully this comment can be removed in the future.
	*/

//////////////
//CRAFTING RECIPES

//TODO:
//recipe for yucca soap that somehow puts their seeds to use. Can you grind seeds? Should it just be a misc crafting? Maybe pouring a mix onto the seed pack?
//(how would that last one prevent whole tiles of seedpacks getting affected? idk its 2am)


/*
Do I actually need this for Sotol Coyote? It comes from fermenting the coyote leaves in a barrel, so its not a recipe per-se...
Should it ever need a recipe, this template is here. If its decided its not necessary, then this comment will be removed.

/datum/chemical_reaction/drink/sotol_coyote
	results = list(/datum/reagent/consumable/ethanol/sotol_coyote = 3)
	required_reagents = list([reagents here])
*/
