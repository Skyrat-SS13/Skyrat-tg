/datum/reagent/consumable/nutriment/soup
	nutriment_factor = 20 // Upped to counter the loss of random ingredients.
	//Some soups will create between 30-60u to counter the loss of additional reagents.

/datum/chemical_reaction/food/soup
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

// Meatball Soup
/datum/chemical_reaction/food/soup/meatballsoup
	results = list(
		/datum/reagent/consumable/nutriment/soup/meatball_soup = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/vegetable_soup
	results = list(
		/datum/reagent/consumable/nutriment/soup/vegetable_soup = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/nettlesoup
	results = list(
		/datum/reagent/consumable/nutriment/soup/nettle = 30
	)
	ingredient_reagent_multiplier = 0.0 // No more acid!
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/wingfangchu
	results = list(
		/datum/reagent/consumable/nutriment/soup/wingfangchu = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/hotchili
	results = list(
		/datum/reagent/consumable/nutriment/soup/hotchili = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/coldchili
	results = list(
		/datum/reagent/consumable/nutriment/soup/coldchili = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/clownchili
	results = list(
		/datum/reagent/consumable/nutriment/soup/clownchili = 60
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/chili_sin_carne
	results = list(
		/datum/reagent/consumable/nutriment/soup/chili_sin_carne = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/tomatosoup
	results = list(
		/datum/reagent/consumable/nutriment/soup/tomato = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/eyeballsoup
	results = list(
		/datum/reagent/consumable/nutriment/soup/eyeball = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/misosoup
	results = list(
		/datum/reagent/consumable/nutriment/soup/miso = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/bloodsoup
	results = list(
		// Blood tomatos will give us like 30u blood, so just add in the 10 from the recipe
		/datum/reagent/blood = 10
	)

/datum/chemical_reaction/food/soup/slimesoup
	results = list(
		/datum/reagent/consumable/nutriment/soup/slime = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/clownstears
	results = list(
		/datum/reagent/consumable/nutriment/soup/clown_tears = 60
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/monkey
	results = list(
		/datum/reagent/consumable/nutriment/soup/monkey = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/mushroomsoup
	results = list(
		/datum/reagent/consumable/nutriment/soup/mushroom = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/beetsoup
	results = list(
		/datum/reagent/consumable/nutriment/soup/white_beet = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/stew
	results = list(
		/datum/reagent/consumable/nutriment/soup/stew = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/sweetpotatosoup
	results = list(
		/datum/reagent/consumable/nutriment/soup/sweetpotato = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/redbeetsoup
	results = list(
		/datum/reagent/consumable/nutriment/soup/red_beet = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/onionsoup
	results = list(
		/datum/reagent/consumable/nutriment/soup/french_onion = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/bisque
	results = list(
		/datum/reagent/consumable/nutriment/soup/bisque = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/bungocurry
	results = list(
		/datum/reagent/consumable/nutriment/soup/bungo = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/electron
	results = list(
		/datum/reagent/consumable/nutriment/soup/electrons = 20,
		/datum/reagent/consumable/liquidelectricity/enriched = 10
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/peasoup
	results = list(
		/datum/reagent/consumable/nutriment/soup/pea = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/indian_curry
	results = list(
		/datum/reagent/consumable/nutriment/soup/indian_curry = 60,
		// Due to changes, makes DOUBLE instead of lots of random reagents.
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/oatmeal
	results =  list(
		/datum/reagent/consumable/nutriment/soup/oatmeal = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/zurek
	results = list(
		/datum/reagent/consumable/nutriment/soup/zurek = 30,
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/cullen_skink
	results = list(
		/datum/reagent/consumable/nutriment/soup/cullen_skink = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/chicken_noodle_soup
	results = list(
		/datum/reagent/consumable/nutriment/soup/chicken_noodle_soup = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/corn_chowder
	results = list(
		/datum/reagent/consumable/nutriment/soup/corn_chowder = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

//Limzard stoofs

/datum/chemical_reaction/food/soup/atrakor_dumplings
	results = list(
		/datum/reagent/consumable/nutriment/soup/atrakor_dumplings = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/meatball_noodles
	results = list(
		/datum/reagent/consumable/nutriment/soup/meatball_noodles = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/black_broth
	results = list(
		/datum/reagent/consumable/nutriment/soup/black_broth = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/jellyfish_stew
	results = list(
		/datum/reagent/consumable/nutriment/soup/jellyfish = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/rootbread_soup
	results = list(
		/datum/reagent/consumable/nutriment/soup/rootbread = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

//MOFF-MOFF-MOFF!

/datum/chemical_reaction/food/soup/cottonball
	results = list(
		/datum/reagent/consumable/nutriment/soup/cottonball = 30,
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/cheese
	results = list(
		/datum/reagent/consumable/nutriment/soup/cheese = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/seed
	results = list(
		/datum/reagent/consumable/nutriment/soup/seed = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/beans
	results = list(
		/datum/reagent/consumable/nutriment/soup/beans = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/moth_oats
	results = list(
		/datum/reagent/consumable/nutriment/soup/moth_oats = 30,
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/fire_soup
	results = list(
		/datum/reagent/consumable/nutriment/soup/fire_soup = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/rice_porridge
	results = list(
		/datum/reagent/consumable/nutriment/soup/rice_porridge = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/cornmeal_porridge
	results = list(
		/datum/reagent/consumable/nutriment/soup/cornmeal_porridge = 30,
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/cheese_porridge
	results = list(
		/datum/reagent/consumable/nutriment/soup/cheese_porridge = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/toechtauese_rice_porridge
	results = list(
		/datum/reagent/consumable/nutriment/soup/toechtauese_rice_porridge = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/red_porridge
	results = list(
		/datum/reagent/consumable/nutriment/soup/red_porridge = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

//Martian FUUD

/datum/chemical_reaction/food/soup/shoyu_ramen
	results = list(
		/datum/reagent/consumable/nutriment/soup/shoyu_ramen = 60
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/gyuramen
	results = list(
		/datum/reagent/consumable/nutriment/soup/gyuramen = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/new_osaka_sunrise
	results = list(
		/datum/reagent/consumable/nutriment/soup/new_osaka_sunrise = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/satsuma_black
	results = list(
		/datum/reagent/consumable/nutriment/soup/satsuma_black = 45
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/dragon_ramen
	results = list(
		/datum/reagent/consumable/nutriment/soup/dragon_ramen = 45
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/hong_kong_borscht
	results = list(
		/datum/reagent/consumable/nutriment/soup/hong_kong_borscht = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/hong_kong_macaroni
	results = list(
		/datum/reagent/consumable/nutriment/soup/hong_kong_macaroni = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/foxs_prize_soup
	results = list(
		/datum/reagent/consumable/nutriment/soup/foxs_prize_soup = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/secret_noodle_soup
	results = list(
		/datum/reagent/consumable/nutriment/soup/secret_noodle_soup = 30
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0

/datum/chemical_reaction/food/soup/budae_jjigae
	results = list(
		/datum/reagent/consumable/nutriment/soup/budae_jjigae = 60
	)
	ingredient_reagent_multiplier = 0.0
	percentage_of_nutriment_converted = 1.0
