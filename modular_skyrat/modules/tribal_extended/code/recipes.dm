/datum/crafting_recipe/silkstring
	name = "Silk String"
	result = /obj/item/weaponcrafting/silkstring
	reqs = list(/obj/item/stack/sheet/cloth = 1)
	time = 5 SECONDS
	category = CAT_MISC

/datum/crafting_recipe/pipebow
	name = "Pipe Bow"
	result = /obj/item/gun/ballistic/bow/tribalbow/pipe
	reqs = list(
		/obj/item/pipe = 5,
		/obj/item/stack/sheet/plastic = 5,
		/obj/item/weaponcrafting/silkstring = 2,
	)
	time = 45 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/bone_arrow
	name = "Bone Arrow"
	result = /obj/item/ammo_casing/arrow/bone
	reqs = list(
		/obj/item/stack/sheet/bone = 1,
		/obj/item/ammo_casing/arrow/ash = 1,
	)
	time = 1.5 SECONDS
	category = CAT_WEAPON_AMMO

/datum/crafting_recipe/ashen_arrow
	name = "Ashen Arrow"
	result = /obj/item/ammo_casing/arrow/ash
	reqs = list(
		/obj/item/stack/rods = 2,
		/obj/item/stack/sheet/sinew = 1,
		/obj/item/stack/ore/glass/basalt = 10,
	)
	time = 1.5 SECONDS
	category = CAT_WEAPON_AMMO

/datum/crafting_recipe/bronze_arrow
	name = "Bronze arrow"
	result = /obj/item/ammo_casing/arrow/bronze
	reqs = list(
		/obj/item/ammo_casing/arrow/ash = 1,
		/obj/item/stack/tile/bronze = 1,
	)
	time = 1.5 SECONDS
	category = CAT_WEAPON_AMMO

/datum/crafting_recipe/goliathshield
	name = "Goliath shield"
	result = /obj/item/shield/goliath
	reqs = list(
		/obj/item/stack/sheet/bone = 4,
		/obj/item/stack/sheet/animalhide/goliath_hide = 3,
	)
	time = 6 SECONDS
	category = CAT_EQUIPMENT

/datum/crafting_recipe/bonesword
	name = "Bone Sword"
	result = /obj/item/claymore/bone
	reqs = list(
		/obj/item/stack/sheet/bone = 2,
		/obj/item/stack/sheet/sinew = 2,
	)
	time = 4 SECONDS
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED
	category = CAT_WEAPON_MELEE

/datum/crafting_recipe/quiver
	name = "Quiver"
	result = /obj/item/storage/bag/quiver
	reqs = list(
		/obj/item/stack/sheet/leather = 2,
		/obj/item/stack/sheet/sinew = 4,
	)
	time = 8 SECONDS
	category = CAT_WEAPON_AMMO

/datum/crafting_recipe/bone_bow
	name = "Bone Bow"
	result = /obj/item/gun/ballistic/bow/tribalbow/ashen
	reqs = list(
		/obj/item/stack/sheet/bone = 4,
		/obj/item/stack/sheet/sinew = 4,
	)
	time = 20 SECONDS
	category = CAT_WEAPON_RANGED
