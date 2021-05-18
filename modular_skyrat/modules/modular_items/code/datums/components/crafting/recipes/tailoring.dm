/datum/crafting_recipe/trickblindfold
	name = "Fake Blindfold"
	result = /obj/item/clothing/glasses/trickblindfold
	time = 20
	tool_behaviors = list(TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/blindfold = 1)
	category = CAT_CLOTHING

/datum/crafting_recipe/crusader_belt
	name = "Crusader Belt and Sheath"
	result = /obj/item/storage/belt/crusader
	reqs = list(/obj/item/storage/belt/utility = 1, /obj/item/stack/sheet/leather = 3, /obj/item/stack/sheet/cloth = 2, /obj/item/stack/sheet/mineral/gold = 1)
	tool_behaviors = list(TOOL_WIRECUTTER, TOOL_SCREWDRIVER, TOOL_WELDER)	//To cut the leather and fasten/weld the sheath detailing
	time = 30
	category = CAT_CLOTHING

/datum/crafting_recipe/crusader_satchel
	name = "Crusader Satchel"
	result = /obj/item/storage/backpack/satchel/crusader
	reqs = list(/obj/item/stack/sheet/cloth = 2, /obj/item/stack/sheet/leather = 1)	//Cheap because its really just a re-texture of the satchel
	tool_behaviors = list(TOOL_WIRECUTTER)
	time = 15
	category = CAT_CLOTHING

/datum/crafting_recipe/medpatch
	name = "Medical Eyepatch HUD"
	result = /obj/item/clothing/glasses/hud/eyepatch/med
	reqs = list(/obj/item/clothing/glasses/hud/health = 1, /obj/item/clothing/glasses/eyepatch = 1, /obj/item/stack/cable_coil = 5)
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER) //has same values as converting regular huds to sunglass huds//
	time = 20
	category = CAT_CLOTHING

/datum/crafting_recipe/medpatchremoval
	name = "Medical Eyepatch HUD removal"
	result = /obj/item/clothing/glasses/eyepatch
	reqs = list(/obj/item/clothing/glasses/hud/eyepatch/med = 1)
	tool_behaviors = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	category = CAT_CLOTHING
