//*******************Contains everything related to the flora on Rockplanet.*******************************
//Similar to the Lavaland file, this includes: the structures, their produce, their seeds and any related recipes

//////////////
//WILD FLORA
/obj/structure/flora/ash/rockplanet //Yes, I made them ash subtypes. It gives me juicy harvest-related variables.
	icon = 'modular_skyrat/modules/random_mining/code/rockplanet/icons/rock_flora.dmi'
	needs_sharp_harvest = FALSE

/obj/structure/flora/ash/rockplanet/coyote	//((Coyote Tobacco, Nicotiana attenuata)
	name = "leafy coyote"
	desc = ""
	harvested_name = "plucked coyote"
	harvested_desc = ""
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
	desc = ""
	harvested_name = "dagger-yucca"
	harvested_desc = ""
	icon_state = "wild_yucca"	//TO-DO: turn fruits purple (Dagger Plant, Yucca aloifolia)
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
	desc = ""
	harvested_name = "budding agaricus"
	harvested_desc = ""
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
/*
/obj/item/food/grown
	icon = 'icons/obj/hydroponics/harvest.dmi'
	worn_icon = 'icons/mob/clothing/head/hydroponics.dmi'
	name = "fresh produce" // so recipe text doesn't say 'snack'
	max_volume = 100
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FLAMMABLE
	/// The typepath made when the plant is splatted with liquid contents.
	var/splat_type = /obj/effect/decal/cleanable/food/plant_smudge
	/// If TRUE, this object needs to be dry to be ground up
	var/dry_grind = FALSE
	/// If FALSE, this object cannot be distilled into an alcohol.
	var/can_distill = TRUE
	/// The reagent this plant distill to. If NULL, it uses a generic fruit_wine reagent and adjusts its variables.
	var/distill_reagent
	/// Flavor of the plant's wine if NULL distll_reagent. If NULL, this is automatically set to the fruit's flavor.
	var/wine_flavor
	/// Boozepwr of the wine if NULL distill_reagent
	var/wine_power = 10
	/// Color of the grown object, for use in coloring greyscale splats.
	var/filling_color
*/
/obj/item/food/grown/rock_flora
	name = ""
	desc = ""
	icon = 'icons/obj/lavaland/ash_flora.dmi'	//CHANGE THIS
	icon_state = "" //ADD A NULL ICON
	resistance_flags = FLAMMABLE	//CHANGE THIS
	max_integrity = 100
	seed = /obj/item/seeds/rockplanet/coyote	//This is just here so code doesnt throw a fit - it's actually unobtainable
	wine_power = 20

/obj/item/food/grown/rock_flora/coyote
	name = "coyote tobacco"
	desc = ""
	icon_state = "coyote_tobacco"
	dry_grind = TRUE
	//distill_reagent =  //TO-DO: Sotol Coyote - "Sotol Coyote Durango has distinctive aromas of hazelnut and almond with notes of butter and yeast coming from the fermentation. On the palate, it is semi-sweet with medium intensity and slight minerality."
	//To-do: smoking it 'reduces throbbing from rattlesnake bites' (light painkiller? [(whatever i come up with)])
	seed = /obj/item/seeds/rockplanet/coyote

	special_desc_requirement = EXAMINE_CHECK_JOB
	special_desc_jobs = list("Botanist")
	special_desc = "Tobacco like this commonly sees medicinal use as (whatever i come up with9. This particular plant could also substitute Dasylirion Cedrosanum in making mild alcohol..."

/obj/item/food/grown/rock_flora/yucca
	name = "purple yucca fruit"
	desc = ""
	icon_state = "yucca_fruit"
	seed = /obj/item/seeds/rockplanet/yucca

	special_desc_requirement = EXAMINE_CHECK_JOB
	special_desc_jobs = list("Botanist")
	special_desc = "Aside from these edible fruits, the plant's seeds can be used in soap and shampoo!" //You can grind the seeds to get (somewhat hard to get soap ingredient(?)) Craft the soap with the seeds as an item?(?)

/obj/item/food/grown/rock_flora/agaricus
	name = "wine-colored agaricus"
	desc = ""
	icon_state = "agaricus_shrooms"
	seed = /obj/item/seeds/rockplanet/agaricus

	special_desc_requirement = EXAMINE_CHECK_JOB
	special_desc_jobs = list("Botanist")
	special_desc = "This mushroom is regarded simultaneously as edible, inedible, and responsible for causing gastric upset."	//The wikipedia said pretty much the same thing. Its funny, I'm keeping it like this - it explains enough too, it induces vomit (?)
	//TO-DO: INDUCES VOMIT

//////////////
//SEED ITEMS
/obj/item/seeds/rockplanet
	name = "rockplanet seeds"
	desc = "You should never see this."
	icon = 'icons/obj/hydroponics/growing_mushrooms.dmi'	//CHANGE THIS (same link as below)
	growing_icon = 'icons/obj/hydroponics/growing_mushrooms.dmi'	//CHANGE THIS (same link as above)
	lifespan = 50
	endurance = 35
	maturation = 8
	production = 4
	yield = 4
	potency = 15
	growthstages = 4
	rarity = 25
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.1)	//CHANGE THIS
	resistance_flags = FIRE_PROOF	//CHANGE THIS
	species = "coyote" //silence unit test
	genes = list(/datum/plant_gene/trait/fire_resistance)	//CHANGE THIS
	graft_gene = /datum/plant_gene/trait/fire_resistance	//CHANGE THIS

/obj/item/seeds/rockplanet/coyote
	name = "pack of coyote tobacco seeds"
	desc = ""
	icon_state = "seeds-coyote"
	species = "coyote"
	plantname = "Coyote Tobacco"
	product = /obj/item/food/grown/rock_flora/coyote
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/fire_resistance)	//CHANGE THIS
	reagents_add = list(/datum/reagent/toxin/mindbreaker = 0.04, /datum/reagent/consumable/entpoly = 0.08, /datum/reagent/drug/mushroomhallucinogen = 0.04)	//CHANGE THIS

/obj/item/seeds/rockplanet/yucca
	name = "pack of dagger-yucca seeds"
	desc = ""
	icon_state = "seed-yucca"
	species = "yucca"
	plantname = "Dagger-Yucca"
	product = /obj/item/food/grown/rock_flora/yucca
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/glow, /datum/plant_gene/trait/fire_resistance)	//CHANGE THIS
	reagents_add = list(/datum/reagent/consumable/tinlux = 0.04, /datum/reagent/consumable/nutriment/vitamin = 0.02, /datum/reagent/drug/space_drugs = 0.02)	//CHANGE THIS

/obj/item/seeds/rockplanet/agaricus
	name = "pack of agaricus mycelium"
	desc = ""
	icon_state = "mycelium-agaricus"
	species = "agaricus"
	plantname = "Agaricus Mushrooms"
	product = /obj/item/food/grown/rock_flora/agaricus
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism, /datum/plant_gene/trait/fire_resistance)	//CHANGE THIS
	reagents_add = list(/datum/reagent/toxin/mushroom_powder = 0.1, /datum/reagent/medicine/coagulant/seraka_extract = 0.02)	//CHANGE THIS

//////////////
//CRAFTED ITEMS
/datum/reagent/consumable/ethanol/sotol_coyote
	name = "Sotol Coyote"
	description = ""
	color = "#868f84"
	boozepwr = 30
	quality = DRINK_GOOD
	taste_description = ""
	icon = 'modular_skyrat/modules/random_mining/code/rockplanet/icons/rock_flora.dmi'
	glass_icon_state = "sotol_coyote_glass"
	glass_name = "Sotol Coyote"
	glass_desc = ""
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED	//CHANGE THIS
	glass_price = DRINK_PRICE_MEDIUM	//CHANGE THIS
	liquid_fire_power = 3 //SKYRAT EDIT ADDITION

/obj/item/soap/homemade/yucca
	desc = "A homemade bar of soap. Has a nice earthy scent."
	icon = 'modular_skyrat/modules/random_mining/code/rockplanet/icons/rock_flora.dmi'
	icon_state = "yucca_soap"
	cleanspeed = 30 //faster to reward chemists (and botanists in this case!) for going to the effort

//////////////
//CRAFTING RECIPES

//Do I actually need this for Sotol Coyote? It comes from fermenting the coyote leaves in a barrel, so its not a recipe per-se...
/*
/datum/chemical_reaction/drink/kamikaze
	results = list(/datum/reagent/consumable/ethanol/kamikaze = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 1, /datum/reagent/consumable/ethanol/triple_sec = 1, /datum/reagent/consumable/limejuice = 1)
*/
