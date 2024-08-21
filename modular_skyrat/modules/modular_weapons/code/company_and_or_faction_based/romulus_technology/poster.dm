/obj/structure/sign/poster/official/idmarecruit
	name = "Romulus Federation Marine Corp - Enlist Today"
	desc = "This poster depicts a RomFed Marine in their full gear. It is printed on some sort of space resistant paper."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/poster.dmi'
	icon_state = "idmarecruit"

/obj/structure/sign/poster/official/idmarecruit/examine_more(mob/user)
	. = ..()

	. += "Join the Romulus Federation Marine Corp Today! \
		Service will ensure welfare, long term position as security consultant in many company \
		And even opportunity to join Sol Galactic Peacekeeping Program \
		What are you waiting for!?"

	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/idmarecruit, 32)

/obj/structure/sign/poster/official/flech_rifle
	name = "Weapon of the Future"
	desc = "This poster depicts the CMG-1, a standard issue rifle in the RomFed Military. \
		It claims that this rifle can defeat any body armour currently available, sounds utterlry insane right?"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/poster.dmi'
	icon_state = "cmg1"

/obj/structure/sign/poster/official/flech_rifle/examine_more(mob/user)
	. = ..()

	. += "Small text details that certain types of magazines may not be available in your \
		region depending on local weapons regulations. Suspiciously, however, if you squint at \
		it a bit, the background colors of the image come together vaguely in the shape of \
		a computer board and a multitool. What did they mean by this?"

	return .

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/poster/official/carwo_magazine, 32)
