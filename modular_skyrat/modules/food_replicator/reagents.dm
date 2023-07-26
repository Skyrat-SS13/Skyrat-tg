/datum/reagent/consumable/powdered_tea
	name = "Powdered Tea"
	description = "Tea in its powdered form. As good as the normal one, just dehydrated."
	color = "#3a3a03" // rgb: 16, 16, 0
	nutriment_factor = 0
	taste_description = "bitter powder"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	default_container = /obj/item/reagent_containers/cup/glass/mug/tea

/datum/reagent/consumable/powdered_tea/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	affected_mob.adjust_dizzy(-2 SECONDS * REM * seconds_per_tick)
	affected_mob.adjust_drowsiness(-1 SECONDS * REM * seconds_per_tick)
	affected_mob.adjust_jitter(-3 SECONDS * REM * seconds_per_tick)
	affected_mob.AdjustSleeping(-10 * REM * seconds_per_tick)
	if(affected_mob.getToxLoss() && SPT_PROB(5, seconds_per_tick))
		affected_mob.adjustToxLoss(-0.5, FALSE, required_biotype = affected_biotype)
	..()
	. = TRUE

/datum/chemical_reaction/food/unpowdered_tea
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/consumable/powdered_tea = 1)
	results = list(/datum/reagent/consumable/tea = 2)
	mix_message = "The mixture instantly heats up."
	reaction_flags = REACTION_INSTANT

/datum/reagent/consumable/powdered_coffee
	name = "Powdered Coffee"
	description = "Americano in its powdered form. Quite an ordinary thing to be honest."
	color = "#101000" // rgb: 16, 16, 0
	nutriment_factor = 0
	overdose_threshold = 40 //Realistically speaking, it's concentrated; of course it'll be strong.
	taste_description = "very bitter powder"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	default_container = /obj/item/reagent_containers/cup/glass/coffee

/datum/reagent/consumable/powdered_coffee/overdose_process(mob/living/affected_mob, seconds_per_tick, times_fired)
	affected_mob.set_jitter_if_lower(15 SECONDS * REM * seconds_per_tick)
	..()

/datum/reagent/consumable/powdered_coffee/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	affected_mob.adjust_dizzy(-5 SECONDS * REM * seconds_per_tick)
	affected_mob.adjust_drowsiness(-3 SECONDS * REM * seconds_per_tick)
	affected_mob.AdjustSleeping(-20 * REM * seconds_per_tick)
	//310.15 is the normal bodytemp.
	affected_mob.adjust_bodytemperature(12 * REM * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, affected_mob.get_body_temp_normal())
	if(holder.has_reagent(/datum/reagent/consumable/frostoil))
		holder.remove_reagent(/datum/reagent/consumable/frostoil, 2 * REM * seconds_per_tick)
	..()
	. = TRUE

/datum/chemical_reaction/food/unpowdered_coffee
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/consumable/powdered_coffee = 1)
	results = list(/datum/reagent/consumable/coffee = 2)
	mix_message = "The mixture instantly heats up."
	reaction_flags = REACTION_INSTANT

/datum/reagent/consumable/powdered_coco
	name = "Powdered Coco"
	description = "Made with love (citation needed)! And reclaimed biomass."
	nutriment_factor = 0
	color = "#403010" // rgb: 64, 48, 16
	taste_description = "creamy'ish dry chocolate"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	default_container = /obj/item/reagent_containers/cup/glass/mug/coco

/datum/reagent/consumable/powdered_coco/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	affected_mob.adjust_bodytemperature(2.5 * REM * TEMPERATURE_DAMAGE_COEFFICIENT * seconds_per_tick, 0, affected_mob.get_body_temp_normal())
	if(affected_mob.getBruteLoss() && SPT_PROB(5, seconds_per_tick))
		affected_mob.heal_bodypart_damage(0.5, 0)
		. = TRUE
	if(holder.has_reagent(/datum/reagent/consumable/capsaicin))
		holder.remove_reagent(/datum/reagent/consumable/capsaicin, 1 * REM * seconds_per_tick)
	..()

/datum/chemical_reaction/food/unpowdered_coco
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/consumable/powdered_coco = 1)
	results = list(/datum/reagent/consumable/hot_coco = 2)
	mix_message = "The mixture instantly heats up."
	reaction_flags = REACTION_INSTANT

/datum/reagent/consumable/powdered_lemonade
	name = "Powdered Lemonade"
	description = "Sweet, tangy base of a lemonade. Would be good if you'd mix it with water."
	nutriment_factor = 0
	color = "#FFE978"
	taste_description = "intensely sour and sweet lemon powder"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	default_container = /obj/item/reagent_containers/cup/soda_cans/lemon_lime

/datum/chemical_reaction/food/unpowdered_lemonade
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/consumable/powdered_lemonade = 1)
	results = list(/datum/reagent/consumable/lemonade = 2)
	mix_message = "The mixture instantly cools down."
	reaction_flags = REACTION_INSTANT

/datum/reagent/consumable/powdered_milk
	name = "Powdered Milk"
	description = "An opaque white powder produced by the biomass restructurizers of certain machines."
	nutriment_factor = 0
	color = "#DFDFDF"
	taste_description = "sweet dry milk"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	default_container = /obj/item/reagent_containers/condiment/milk

/datum/reagent/consumable/powdered_milk/on_hydroponics_apply(obj/machinery/hydroponics/mytray, mob/user)
	mytray.adjust_waterlevel(round(volume * 0.15))
	var/obj/item/seeds/myseed = mytray.myseed
	if(isnull(myseed) || myseed.get_gene(/datum/plant_gene/trait/plant_type/fungal_metabolism))
		return
	myseed.adjust_potency(-round(volume * 0.25))

/datum/reagent/consumable/powdered_milk/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	if(affected_mob.getBruteLoss() && SPT_PROB(5, seconds_per_tick))
		affected_mob.heal_bodypart_damage(0.5,0)
		. = TRUE
	if(holder.has_reagent(/datum/reagent/consumable/capsaicin))
		holder.remove_reagent(/datum/reagent/consumable/capsaicin, 0.5 * seconds_per_tick)
	..()

/datum/chemical_reaction/food/unpowdered_milk
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/consumable/powdered_milk = 1)
	results = list(/datum/reagent/consumable/milk = 2)
	mix_message = "The mixture cools down."
	reaction_flags = REACTION_INSTANT
