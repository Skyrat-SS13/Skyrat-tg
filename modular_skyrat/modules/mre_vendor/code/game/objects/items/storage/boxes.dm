/obj/item/storage/box/mre // Placeholder item
	name = "MRE - Empty"
	desc = "Uh oh, this one's been eaten!"
	icon = 'modular_skyrat/modules/mre_vendor/icons/obj/mreicon.dmi'
	icon_state = "mre"
	var/unheated = TRUE

/obj/item/storage/box/mre/AltClick(mob/user)
	. = ..()
	if(unheated)
		unheated = FALSE
		to_chat(user, span_notice("The [src] hisses softly, its internal chemical heater heating up the food inside."))
		playsound(loc, 'sound/effects/fuse.ogg', 50, 1)

/obj/item/storage/box/mre/mre_spaghetti
	name = "MRE - Spaghetti and Meatballs"
	desc = "This MRE contains spaghetti and meatballs, along with a few sides. It's an okay meal."
	illustration = "burger"

/obj/item/storage/box/mre/mre_spaghetti/PopulateContents()
	new /obj/item/food/spaghetti/meatballspaghetti(src)
	new /obj/item/food/garlicbread(src)
	new /obj/item/food/cheese(src)
	new /obj/item/food/candy(src)
	new /obj/item/food/cracker(src)
	new /obj/item/food/bubblegum(src)
	new /obj/item/reagent_containers/food/drinks/coffee(src)

/obj/item/storage/box/mre/mre_hotdog
	name = "MRE - Ballpark Hotdog"
	desc = "This MRE contains a hot dog, along with a few sides. It's an okay meal."
	illustration = "burger"

/obj/item/storage/box/mre/mre_hotdog/PopulateContents()
	new /obj/item/food/hotdog(src)
	new /obj/item/food/nugget(src)
	new /obj/item/food/fries(src)
	new /obj/item/food/candy(src)
	new /obj/item/food/cracker(src)
	new /obj/item/food/bubblegum(src)
	new /obj/item/reagent_containers/food/drinks/coffee(src)

/obj/item/storage/box/mre/mre_cheeseburger
	name = "MRE - Cheeseburger"
	desc = "This MRE contains a cheeseburger, along with a few sides. It's an okay meal."
	illustration = "burger"

/obj/item/storage/box/mre/mre_cheeseburger/PopulateContents()
	new /obj/item/food/burger/cheese(src)
	new /obj/item/food/nugget(src)
	new /obj/item/food/fries(src)
	new /obj/item/food/candy(src)
	new /obj/item/food/cracker(src)
	new /obj/item/food/bubblegum(src)
	new /obj/item/reagent_containers/food/drinks/coffee(src)

/obj/item/storage/box/mre/mre_indian
	name = "MRE - Chicken Curry"
	desc = "This MRE contains curry, along with a few sides. It's an okay meal."
	illustration = "burger"

/obj/item/storage/box/mre/mre_indian/PopulateContents()
	new /obj/item/food/soup/indian_curry(src)
	new /obj/item/food/pizza/rustic_flatbread(src)
	new /obj/item/food/salad/boiledrice(src)
	new /obj/item/food/candy(src)
	new /obj/item/food/cracker(src)
	new /obj/item/food/bubblegum(src)
	new /obj/item/reagent_containers/food/drinks/coffee(src)

/obj/item/storage/box/mre/mre_cajun
	name = "MRE - Spicy Gumbo"
	desc = "This MRE contains gumbo, along with a few sides. It's an okay meal."
	illustration = "burger"

/obj/item/storage/box/mre/mre_cajun/PopulateContents()
	new /obj/item/food/salad/gumbo(src)
	new /obj/item/food/fried_chicken(src)
	new /obj/item/food/sausage(src)
	new /obj/item/food/candy(src)
	new /obj/item/food/cracker(src)
	new /obj/item/food/bubblegum(src)
	new /obj/item/reagent_containers/food/drinks/coffee(src)

/obj/item/storage/box/mre/mre_asian
	name = "MRE - Beef Noodle"
	desc = "This MRE contains beef noodles, along with a few sides. It's an okay meal."
	illustration = "burger"

/obj/item/storage/box/mre/mre_asian/PopulateContents()
	new /obj/item/food/spaghetti/beefnoodle(src)
	new /obj/item/food/chawanmushi(src)
	new /obj/item/food/crab_rangoon(src)
	new /obj/item/food/candy(src)
	new /obj/item/food/cracker(src)
	new /obj/item/food/bubblegum(src)
	new /obj/item/reagent_containers/food/drinks/coffee(src)

/obj/item/storage/box/mre/mre_breakfast
	name = "MRE - Eggs Benedict"
	desc = "This MRE contains eggs benedict, along with a few sides. It's an okay meal."
	illustration = "burger"

/obj/item/storage/box/mre/mre_breakfast/PopulateContents()
	new	/obj/item/food/benedict(src)
	new	/obj/item/food/butteredtoast(src)
	new	/obj/item/food/chococornet(src)
	new	/obj/item/food/candy(src)
	new	/obj/item/food/cracker(src)
	new	/obj/item/food/bubblegum(src)
	new	/obj/item/reagent_containers/food/drinks/coffee(src)


/obj/item/storage/box/mre/mre_carnivore
	name = "MRE - Meat Lovers"
	desc = "This MRE, designed to accommodate dietary restrictions, contains a large steak, along with a few meat based sides. It's an okay meal."
	illustration = "depband"

/obj/item/storage/box/mre/mre_carnivore/PopulateContents()
	new /obj/item/food/meat/steak(src)
	new /obj/item/food/fried_chicken(src)
	new /obj/item/food/sausage(src)
	new /obj/item/food/sosjerky(src)
	new /obj/item/food/cracker(src)
	new /obj/item/food/bubblegum(src)
	new /obj/item/reagent_containers/food/drinks/coffee(src)

/obj/item/storage/box/mre/mre_vegan
	name = "MRE - Fresh Vegan"
	desc = "This MRE, designed to accommodate dietary restrictions, contains a tofu pie, along with a few sides. It's an okay meal."
	illustration = "fruit"

/obj/item/storage/box/mre/mre_vegan/PopulateContents()
	new /obj/item/food/pie/tofupie(src)
	new /obj/item/food/soylenviridians(src)
	new /obj/item/food/soup/beet(src)
	new /obj/item/food/candy(src)
	new /obj/item/food/cracker(src)
	new /obj/item/food/bubblegum(src)
	new /obj/item/reagent_containers/food/drinks/coffee(src)

/obj/item/storage/box/mre/mre_lizard
	name = "MRE - Lizards' Dumpling"
	desc = "This MRE, designed for cultural sensitivity, contains atrakor dumpling soup, along with a few sides. It's an okay meal."
	illustration = "burger"

/obj/item/storage/box/mre/mre_lizard/PopulateContents()
	new /obj/item/food/soup/atrakor_dumplings(src)
	new /obj/item/food/emperor_roll(src)
	new /obj/item/food/moonfish_caviar(src)
	new /obj/item/food/candy(src)
	new /obj/item/food/cracker(src)
	new /obj/item/food/bubblegum(src)
	new /obj/item/reagent_containers/food/drinks/coffee(src)

/obj/item/storage/box/mre/mre_electric
	name = "MRE - Ethereals' Electric"
	desc = "This MRE, designed for cultural sensitivity, contains a plasma burger, along with a few sides. It's an okay meal. Written in bold text on the side are the words : NOT FIT FOR HUMAN CONSUMPTION. Good thing you can't read."
	illustration = "lighttube"

/obj/item/storage/box/mre/mre_electric/PopulateContents()
	new	/obj/item/food/burger/empoweredburger(src)
	new	/obj/item/food/soup/electron(src)
	new	/obj/item/reagent_containers/food/drinks/soda_cans/monkey_energy(src)
	new	/obj/item/food/candy(src)
	new	/obj/item/food/cracker(src)
	new	/obj/item/food/bubblegum(src)
	new	/obj/item/reagent_containers/food/drinks/coffee(src)

/obj/item/storage/box/mre/mre_moth
	name = "MRE - Moths' Special"
	desc = "This MRE, designed for cultural sensitivity, contains a freshly used jumpsuit, along with a few sides. It's an okay meal. Written in bold text on the side are the words : NOT FIT FOR HUMAN CONSUMPTION. Good thing you can't read."
	illustration = "burger"

/obj/item/storage/box/mre/mre_moth/PopulateContents()
	new	/obj/item/clothing/under/color/black(src)
	new	/obj/item/clothing/shoes/sneakers/black(src)
	new	/obj/item/food/muffin/moffin(src)
	new	/obj/item/food/candy(src)
	new	/obj/item/food/cracker(src)
	new	/obj/item/food/bubblegum(src)
	new	/obj/item/reagent_containers/food/drinks/coffee(src)

/obj/item/storage/box/mre/mre_sweet
	name = "MRE - Sweet Treats"
	desc = "This MRE contains a warm bowl of rice pudding, along with a few sugary sides. It's an okay meal."
	illustration = "heart"

/obj/item/storage/box/mre/mre_sweet/PopulateContents()
	new	/obj/item/food/salad/ricepudding(src)
	new	/obj/item/food/honeybun(src)
	new	/obj/item/food/branrequests(src)
	new	/obj/item/food/candy(src)
	new	/obj/item/food/fudgedice(src)
	new	/obj/item/food/bubblegum(src)
	new	/obj/item/reagent_containers/food/drinks/coffee(src)

/obj/item/storage/box/mre/mre_seafood
	name = "MRE - Seafood Surprise"
	desc = "This MRE contains a delicious moonfish demi-glace, along with a few sides. It's an okay meal."
	illustration = "burger"

/obj/item/storage/box/mre/mre_seafood/PopulateContents()
	new	/obj/item/food/moonfish_demiglace(src)
	new	/obj/item/food/soup/bisque(src)
	new	/obj/item/food/canned_jellyfish(src)
	new	/obj/item/food/candy(src)
	new	/obj/item/food/cracker(src)
	new	/obj/item/food/bubblegum(src)
	new	/obj/item/reagent_containers/food/drinks/coffee(src)

/obj/item/storage/box/mre/mre_coldweather
	name = "MRE - Cold Weather"
	desc = "This MRE contains a generous portion of poutine, along with a few other sides inspired by Earth's coldest regions. It's an okay meal."
	illustration = "burger"

/obj/item/storage/box/mre/mre_coldweather/PopulateContents()
	new	/obj/item/food/poutine(src)
	new	/obj/item/food/beef_stroganoff(src)
	new	/obj/item/food/khachapuri(src)
	new	/obj/item/food/candy(src)
	new	/obj/item/food/cracker(src)
	new	/obj/item/food/bubblegum(src)
	new	/obj/item/reagent_containers/food/drinks/coffee(src)

/obj/item/storage/box/mre/mre_gamer
	name = "MRE - Tactical Gamer"
	desc = "This MRE contains a slice of pizza, as well as other foods carefully selected to meet the nutritional needs of elite gamers everywhere. It's an okay meal."
	illustration = "burger"

/obj/item/storage/box/mre/mre_gamer/PopulateContents()
	new	/obj/item/food/pizzaslice/meat(src)
	new	/obj/item/food/dankpocket(src)
	new	/obj/item/food/cornchips(src)
	new	/obj/item/food/candy(src)
	new	/obj/item/food/cookie(src)
	new	/obj/item/reagent_containers/food/drinks/soda_cans/space_mountain_wind(src)
	new	/obj/item/reagent_containers/food/drinks/soda_cans/monkey_energy(src)

/obj/item/storage/box/mre/mre_fiesta
	name = "MRE - Spicy Fiesta"
	desc = "This MRE contains a spicy burrito, along with a few other sides. It's an okay meal."
	illustration = "burger"

/obj/item/storage/box/mre/mre_fiesta/PopulateContents()
	new	/obj/item/food/carneburrito(src)
	new	/obj/item/food/enchiladas(src)
	new	/obj/item/food/cheesynachos(src)
	new	/obj/item/food/candy(src)
	new	/obj/item/food/cracker(src)
	new	/obj/item/food/bubblegum(src)
	new	/obj/item/reagent_containers/food/drinks/coffee(src)

/obj/item/storage/box/mre/mre_continental
	name = "MRE - Continental Breakfast"
	desc = "This MRE contains a baguette, along with a few other sides inspired by Earth's European breakfasts. It's an okay meal."
	illustration = "burger"

/obj/item/storage/box/mre/mre_continental/PopulateContents()
	new	/obj/item/food/baguette(src)
	new	/obj/item/food/cheese(src)
	new	/obj/item/food/chococornet(src)
	new	/obj/item/food/donut/jelly/plain(src)
	new	/obj/item/food/branrequests(src)
	new	/obj/item/reagent_containers/food/drinks/bottle/orangejuice(src)
	new	/obj/item/reagent_containers/food/drinks/coffee(src)

/obj/item/storage/box/mre/mre_crayon
	name = "MRE - Comedians' Crayon"
	desc = "This strange looking MRE contains a box of crayons, except that it appears to have been tampered with. Strangely, the crayon pack is in original military packaging. A small pink crayon smiley face is drawn over the label. Is this someone's attempt at a joke? It's an okay meal."
	illustration = "clown"

/obj/item/storage/box/mre/mre_crayon/PopulateContents()
	new	/obj/item/storage/crayons(src)
	new	/obj/item/food/honkdae(src)
	new	/obj/item/food/pie/cream(src)
	new	/obj/item/food/candy(src)
	new	/obj/item/food/cookie(src)
	new	/obj/item/reagent_containers/food/condiment/pack/hotsauce(src)
	new	/obj/item/reagent_containers/food/drinks/coffee(src)

/obj/item/storage/box/mre/mre_unhappy
	name = "MRE - Unhappy Meal"
	desc = "This strange, suspicious looking MRE does not list its contents. Its packaging offers no hints to what it may contain, except for a long list of seemingly nonsensical names of people, jobs, and drinks. Written in bold text on the side are the words : DEFINITELY FIT FOR HUMAN CONSUMPTION. WE PROMISE."
	icon_state = "unhappy"

/obj/item/storage/box/mre/mre_unhappy/PopulateContents()
	new	/obj/item/food/spidereggsham(src)
	new	/obj/item/food/spiderlollipop(src)
	new	/obj/item/storage/fancy/cigarettes(src)
	new	/obj/item/reagent_containers/food/drinks/bottle/vodka(src)
	new	/obj/item/food/tatortot(src)
	new	/obj/item/food/bubblegum/happiness(src)
	new	/obj/item/coin/antagtoken(src)
