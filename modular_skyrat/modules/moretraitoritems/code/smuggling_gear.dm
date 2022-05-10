///syndicate prototype for smuggling missions
/obj/item/gun/syringe/syndicate/prototype
	name = "prototype dart pistol"
	desc = "Cybersun Industries prototype dart pistols. Delivering the syringes at the same \
	speed in a smaller weapon proved to be a surprisingly complicated task."
	syringes = list()

///syndicate prototype for smuggling missions
/obj/item/pen/edagger/prototype
	name = "odd pen"
	desc = "It's an abnormal black ink pen, with weird chunks of metal sticking out of it..."
	hidden_name = "prototype hardlight dagger"
	hidden_desc = "Waffle Corp R&D's prototype for energy daggers. Hardlight may be inferior \
	to energy weapons, but it's still surprisingly deadly."
	hidden_icon = "eprototypedagger"

//smuggling container
/obj/item/reagent_containers/glass/bottle/ritual_wine
	name = "ritual wine bottle"
	desc = "Contains an incredibly potent mix of various hallucinogenics, herbal extracts, and hard drugs. \
	the Tiger Cooperative praises it as a link to higher powers, but for all intents and purposes this should \
	not be consumed."
	list_reagents = list(
		//changeling adrenals part
		/datum/reagent/drug/methamphetamine = 5,
		//hallucinations part
		/datum/reagent/drug/mushroomhallucinogen = 35,
		//alcoholic part, plus more hallucinations lel
		/datum/reagent/consumable/ethanol/ritual_wine = 10,
	)
