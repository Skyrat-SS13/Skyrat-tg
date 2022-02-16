/datum/design/disabler_upgrade
	name = "Prototype Disabler Upgrade Modkit"
	desc = "A disabler modkit suitable for security applications. Do not swallow."
	id = "proto_disabler"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/silver = 500, /datum/material/plasma = 500, /datum/material/titanium = 500)
	build_path = /obj/item/weaponcrafting/gunkit/disabler_upgrade
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
	autolathe_exportable = FALSE

/obj/item/weaponcrafting/gunkit/disabler_upgrade
	name = "advanced energy gun parts kit"
	desc = "A suitcase containing the necessary gun parts to tranform a standard energy gun into an advanced energy gun."

/datum/crafting_recipe/disabler_upgrade
	name = "Disabler Upgrade"
	tool_behaviors = list(TOOL_SCREWDRIVER)
	result = /obj/item/gun/energy/disabler/upgraded
	reqs = list(/obj/item/gun/energy/disabler = 1,
				/obj/item/weaponcrafting/gunkit/disabler_upgrade = 1)
	time = 200
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	New()
		..()
		blacklist += subtypesof(/obj/item/gun/energy/disabler)
