//Security Crafting Recipe

/datum/crafting_recipe/sol_rifle_carbine_kit
	name = "Sol Carbine Conversion"
	result = /obj/item/gun/ballistic/automatic/rom_carbine
	reqs = list(
		/obj/item/gun/ballistic/automatic/sol_rifle = 1,
		/obj/item/weaponcrafting/gunkit/sol_rifle_carbine_kit = 1,
	)
	time = 10 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/sol_smg_rapidfire_kit
	name = "Sol SMG Conversion"
	result = /obj/item/gun/ballistic/automatic/rom_smg
	reqs = list(
		/obj/item/gun/ballistic/automatic/sol_smg = 1,
		/obj/item/weaponcrafting/gunkit/sol_smg_rapidfire_kit = 1,
	)
	time = 10 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/sol_bolt_to_rifle
	name = "Sol Battle Rifle Conversion"
	result = /obj/item/gun/ballistic/automatic/sol_rifle
	reqs = list(
		/obj/item/gun/ballistic/rifle/carwil = 1,
		/obj/item/weaponcrafting/gunkit/sol_bolt_to_rifle = 1,
	)
	time = 10 SECONDS
	category = CAT_WEAPON_RANGED

//Generic Gun Resource here
