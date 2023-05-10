///This is the standard 'baseline' NIF model.
/obj/item/organ/internal/cyberimp/brain/nif/standard
	name = "Standard Type NIF"
	desc = "'Standard-Type' is a classification for high-quality Nanite Implant Frameworks. This category primarily includes Framework patterns with high reliability, seamless bonding with a user, and a combination of storage space and processing power to run a wide array of programs."
	manufacturer_notes = "While countless manufacturers produce their own implementation of NIFs, open-source or not, there's less than a thousand Standard-Type models out there in the galaxy. These are the results of almost five years of improvements on older models of Frameworks, and are rather coveted due to being extremely difficult to 'homebrew."

/obj/item/organ/internal/cyberimp/brain/nif/roleplay_model
	name = "Econo-Deck Type NIF"
	desc = "'Econo-Deck' is a classification for lower-quality Nanite Implant Frameworks. Typically, these are off-brand 'economical' bootlegs of higher-quality Frameworks featuring lower-grade power cells, outdated and risky construction patterns, and far rougher calibration with a user."
	manufacturer_notes = "Most webspaces for hobbyists or hardcore users, Corpo neurologists, and developers of 'softs such as the Altspace Coven recommend against their purchase. Despite their affordability by the layman, it's a common notion in Framework user circles that a device directly hooked into a user's nervous system is never something which should be skimped on; hence, Econo-Decks typically find themselves in the hands of the truly desperate, criminals, or coming out of workshops as 'homebrews.'"

	max_power_level = 500
	max_nifsofts = 3
	calibration_time = 1 MINUTES
	max_durability = 50
	death_durability_loss = 10


/obj/item/organ/internal/cyberimp/brain/nif/roleplay_model/cheap
	name = "Trial-Lite Type NIF"
	desc = "'Trial-Lite' is a classification for temporary Nanite Implant Frameworks. These are typically distributed at promotional events, for the use of single-purpose NIFsofts, or at some Corporate dealerships to offer prospective users a look into the scene. Normally, Trial-Lite frameworks do not actually 'bond' with their user, forming an extremely loose connection before dissolving into scattered and dead nanomachines within a few hours, typically exhaled."
	manufacturer_notes = "Normally, Trial-Lite frameworks do not actually 'bond' with their user, forming an extremely loose connection before dissolving into scattered and dead nanomachines within a few hours, typically exhaled. It's so far been impossible to extend the lifespan of a Trial-Lite NIF, owing to their far inferior construction and programming."
	nif_persistence = FALSE

/obj/item/autosurgeon/organ/nif/disposable //Disposable, as in the fact that this only lasts for one shift
	name = "Econo-Deck Type Autosurgeon"
	starting_organ = /obj/item/organ/internal/cyberimp/brain/nif/roleplay_model/cheap
	uses = 1

/obj/item/organ/internal/cyberimp/brain/nif/standard/ghost_role
	nif_persistence = FALSE
	is_calibrated = TRUE

/obj/item/autosurgeon/organ/nif/ghost_role
	name = "Enhanced Standard Type NIF Autosurgeon"
	starting_organ = /obj/item/organ/internal/cyberimp/brain/nif/standard/ghost_role
	uses = 1
