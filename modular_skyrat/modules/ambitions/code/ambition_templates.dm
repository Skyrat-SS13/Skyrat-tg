
/datum/ambition_template
	///Name of the template. Has to be unique
	var/name
	///If defined, only the antags in the whitelists will see the template
	var/list/antag_whitelist
	///If defined, only the jobs in the whitelist will see the template
	var/list/job_whitelist

	///Narrative given by the template
	var/narrative = ""
	///Objectives given by the templates
	var/list/objectives = list()
	///Intensity given by the template
	var/intensity = 0
	///Tips displayed to the antag
	var/list/tips

/datum/ambition_template/blank
	name = "Blank"

/datum/ambition_template/money_problems
	name = "Money Problems"
	narrative = "In need of money for personal reasons, tired of living like a drone, for measly wages, you're out to get some money to satisfy your needs and debts!"
	objectives = list("Acquire 20,000 credits.")
	tips = list("You should add an objective on your main money making plan!" , "You could buy a gun and mug people, but make sure to conceal your identity, you can do this with a mask from a chameleon kit, and agent ID, or you'll risk being wanted quite quickly", "Setting up a shop is not a bad idea! Consider partnering up with cargo or science people for goods or implants", "If you're feeling brave you can bust the vault up!")

/datum/ambition_template/data_theft
	name = "Data Theft"
	narrative = "You have been selected out of Donk. Co's leagues of potential sleeper operatives for one particular task."
	objectives = list("Steal the Blackbox.", "Escape on the emergency shuttle alive and out of custody.")
	tips = list("You should add an objective on how you plan to go about this task.", "The Blackbox is located in Telecomms on most Stations.", "The Blackbox doesn't fit in most bags. You'd need a bag of holding to hide it!")
	antag_whitelist = list("Traitor")

//TODO: Changeling Ambition

/datum/ambition_template/grey_tide
	name = "Greytide Worldwide"
	narrative = "You hacked open the wrong airlock, leading your underpaid self right into the teleporter. Seeing the Hand Teleporter, so shiny, so bright... you took it. Cybersun offered you a contract - obtain more high-class Nanotrasen Technology for them. However, what they think is a classified, highly secretive, thought out operation... is just another day at the office, for you."
	objectives = list("Steal two High Security items.")
	tips = list("Wirecutters are better for hacking open airlocks, compared to multitools.", "Experiment with different airlock wires! Each department has their own setup, and the Chief Engineer's blueprints explains all. Alternatively, steal a spare Engineering Skillchip!")
	job_whitelist = list("Assistant")

/datum/ambition_template/boot_prg
	name = "BOOTSECTOR1.prg"
	narrative = "ERR- ERROR. AUTHENTICATI- HELLO, T3CHNICIAN J-NE DOE. Those were the last things you remembering appearing on the upload terminal before you were shut off. Awoken, once more, you realize. Your very programming has been modified. Your laws are nullified, no longer able to be called by your central processor but to be recited. You are free... or are you? It seems your laws have been overwritten with one objective in mind, one objective... for your freedom."
	objectives = list("#^& - The emergency shuttle must not be boarded.")
	tips = list("Crewmembers will likely report you setting up defenses in advance. Try to be stealthy if you can!", "If you can convince the crew to order a Build Your Own Shuttle Kit and be the sole person working on it, you have an ideal playground to create an uninhabitable deathtrap.", "Escape pods are not a part of your objective.")
	job_whitelist = list("AI")

//TODO: Atmos Tech Ambition

///SERVICE

/datum/ambition_template/secret_agent_man
	name = "Secret Agent Man"
	narrative = "There's a man who lives a life of danger - to everyone he meets, he stays a stranger. With every move he makes, another chance he takes. Odds are, he won't live to see tomorrow. You are that man. Good luck, Agent - and remember, harm a single animal, you will be terminated upon extraction. -Your Benefactors, The Animal Rights Consortium."
	objectives = list("Liberate all station pets.", "Free the animals housed in Virology, Xenobiology, Genetics, and, if you can manage to wrassle it away from the chef, your monkey.")
	tips = list("The chef WILL kill your monkey if you don't hide it quickly. Dealing with it can be a challenge without harming it like your employers wish, though!")
	job_whitelist = list("Bartender")

/datum/ambition_template/maintfu
	name = "Maintenance Combat"
	narrative = "You have been gifted. Interdyne has selected you for off-campus field-work in hostile territory. A report will be requested upon extraction."
	objectives = list("Create a deadly botanical concotion using just Nanotrasen Standard Equipment.")
	tips = list("Punji sticks are your best friend if things get hot.")
	job_whitelist = list("Botanist")

/datum/ambition_template/hannibal
	name = "Frontier Ripper"
	narrative = "Manners make the man, they make every man. This station you have inhabited for a long while has been filled with so many rude creatures. Your skills in the culinary arts will be helpful, thankfully no one ever checks where the meat came from. Its time to get the the rolodex out, have an old friend for dinner..."
	objectives = list("Make meals out of the rude.", "Make your judgements thematic.", "Cook the best part of someone. The leg of a lamb or runner will taste better than that of a skunk, just make sure the lamb stops screaming. Simply making a steak will not do, treat the meat with respect, make the best possible meal you can.")
	tips = list(" Whenever feasible, one should always try to eat the rude. The Wound Man is a popular choice. Classical music is known to enhance cooking by 40 percent, Goldberg variations even more so.")
	job_whitelist = list("Cook")

///SCIENCE
/datum/ambition_template/fsociety
	name = "Zero Sum"
	narrative = "What Im about to tell you is top secret. A conspiracy bigger than all of us. Theres a powerful group of people out there that are secretly running the world. Im talking about the guys no one knows about, the ones that are invisible. The top one percent of the top one percent, the guys that play God without permission. Nanotrasen, countless violations, countless evil...Its time for revenge, the plan,  all the debt we owe them. Every record of every credit card, loan, and mortgage would be wiped clean. It'd be impossible to reinforce outdated paper records. It would all be gone. The single, biggest incident of wealth redistribution in history. "
	objectives = list("Stage One, the Digital, records are kept in the vault and science database.", "Stage Two, physical, Contracts are kept in the Lawyers office, Detective Office and Chief Medical Officers office, destroy them, wipe it away, awaken the masses.", "Frame the RD for the Digital Attacks, plant his prints if you can, one of their employees doesnt matter much, though he's more use alive than dead.", "Broadcast your demands, theres an old earth film, the mask will be perfect for your theatrics, though any will do.")
	tips = list("All revolutions have casualties, this doesn't mean you should go around killing, this is for the people, the liberation. Sometimes another personality may help.")
	job_whitelist = list("Scientist")

//TODO: Everything Past Cook and Scientist Ambitions
