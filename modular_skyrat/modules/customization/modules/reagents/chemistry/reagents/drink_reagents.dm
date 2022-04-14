// Modular DRINK REAGENTS, see the following file for the mixes: modular_skyrat\modules\customization\modules\food_and_drinks\recipes\drinks_recipes.dm

/datum/reagent/consumable/pinkmilk
	name = "Strawberry Milk"
	description = "A drink of a bygone era of milk and artificial sweetener back on a rock."
	color = "#f76aeb"//rgb(247, 106, 235)
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "pinkmilk"
	quality = DRINK_VERYGOOD
	taste_description = "sweet strawberry and milk cream"
	glass_name = "tall glass of strawberry milk"
	glass_desc = "Delicious flavored strawberry syrup mixed with milk."

/datum/reagent/consumable/pinkmilk/on_mob_life(mob/living/carbon/M)
	if(prob(15))
		to_chat(M, span_notice("[pick("You cant help to smile.","You feel nostalgia all of sudden.","You remember to relax.")]"))
	..()
	. = 1

/datum/reagent/consumable/pinktea //Tiny Tim song
	name = "Strawberry Tea"
	description = "A timeless classic!"
	color = "#f76aeb"//rgb(247, 106, 235)
	glass_icon_state = "pinktea"
	quality = DRINK_VERYGOOD
	taste_description = "sweet tea with a hint of strawberry"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_name = "mug of strawberry tea"
	glass_desc = "Delicious traditional tea flavored with strawberries."

/datum/reagent/consumable/pinktea/on_mob_life(mob/living/carbon/M)
	if(prob(10))
		to_chat(M, span_notice("[pick("Diamond skies where white deer fly.","Sipping strawberry tea.","Silver raindrops drift through timeless, Neverending June.","Crystal ... pearls free, with love!","Beaming love into me.")]"))
	..()
	. = TRUE

/datum/reagent/consumable/catnip_tea
	name = "Catnip Tea"
	description = "A sleepy and tasty catnip tea!"
	color = "#101000" // rgb: 16, 16, 0
	taste_description = "sugar and catnip"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "catnip_tea"
	glass_name = "glass of catnip tea"
	glass_desc = "A purrfect drink for a cat."

/datum/reagent/consumable/catnip_tea/on_mob_life(mob/living/carbon/M)
	M.adjustStaminaLoss(min(50 - M.getStaminaLoss(), 3))
	if(prob(20))
		M.emote("nya")
	if(prob(20))
		to_chat(M, span_notice("[pick("Headpats feel nice.", "Backrubs would be nice.", "Mew")]"))
	..()

/datum/reagent/consumable/milkshake
	name = "Milkshake"
	description = "A delicious, frozen treat!"
	color = "#ede9dd" //237, 233, 221
	taste_description = "richness and icecream"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "milkshake"
	glass_name = "plastic cup of milkshake"
	glass_desc = "Brings all the boys to the yard."

/datum/reagent/consumable/milkshake_strawberry
	name = "Strawberry Milkshake"
	description = "A delicious, fruity treat!"
	color = "#e39c91" //227, 156, 145
	taste_description = "strawberry and icecream"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "milkshake_strawberry"
	glass_name = "plastic cup of stawberry milkshake"
	glass_desc = "Best shared with friends."

/datum/reagent/consumable/milkshake_chocolate
	name = "Chocolate Milkshake"
	description = "Heaven-sent chocolatey elixir."
	color = "#997755" // 153,119,85
	taste_description = "richness and chocolate"
	glass_icon = 'modular_skyrat/master_files/icons/obj/drinks.dmi'
	glass_icon_state = "milkshake_chocolate"
	glass_name = "plastic cup of chocolate milkshake"
	glass_desc = "Reminds you of someone, oddly enough."

/datum/reagent/consumable/beerbatter
	name = "Beer Batter"
	description = "Probably not the greatest idea to drink...sludge."
	color = "#f5f4e9"
	taste_description = "flour and cheap booze"
	glass_icon_state = "chocolatepudding"
	glass_name = "glass of beer batter"
	glass_desc = "Used in cooking, pure cholesterol, Scottish people eat it."
