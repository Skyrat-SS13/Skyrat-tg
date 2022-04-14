/datum/crafting_recipe/silkstring
	name = "Silk String"
	result = /obj/item/weaponcrafting/silkstring
	reqs = list(/obj/item/stack/sheet/cloth = 1)
	time = 50
	category = CAT_MISC

/datum/crafting_recipe/wood_bow
    name = "Wooden Bow"
    result = /obj/item/gun/ballistic/tribalbow
    reqs = list(/obj/item/stack/sheet/mineral/wood = 25,
                /obj/item/weaponcrafting/silkstring = 2)
    time = 300
    category = CAT_PRIMAL

/datum/crafting_recipe/pipebow
	name = "Pipe Bow"
	result = /obj/item/gun/ballistic/tribalbow/pipe
	reqs = list(/obj/item/pipe = 5,
				/obj/item/stack/sheet/plastic = 5,
				/obj/item/weaponcrafting/silkstring = 2)
	time = 450
	category = CAT_PRIMAL

/datum/crafting_recipe/arrow
	name = "Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/wood
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/sheet/cloth= 1,
				/obj/item/stack/rods = 1)
	time = 15
	category = CAT_PRIMAL

/datum/crafting_recipe/bone_arrow
	name = "Bone Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/bone
	reqs = list(/obj/item/stack/sheet/bone = 1,
				/obj/item/ammo_casing/caseless/arrow/ash = 1)
	time = 15
	category = CAT_PRIMAL

/datum/crafting_recipe/ashen_arrow
	name = "Ashen Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/ash
	reqs = list(/obj/item/stack/rods = 2,
				/obj/item/stack/sheet/sinew = 1,
				/obj/item/stack/ore/glass/basalt = 10)
	time = 15
	category = CAT_PRIMAL

/datum/crafting_recipe/bronze_arrow
	name = "Bronze arrow"
	result = /obj/item/ammo_casing/caseless/arrow/bronze
	reqs = list(/obj/item/ammo_casing/caseless/arrow/ash = 1,
				/obj/item/stack/tile/bronze = 1)
	time = 15
	category = CAT_PRIMAL

/datum/crafting_recipe/goliathshield
	name = "Goliath shield"
	result = /obj/item/shield/riot/goliath
	reqs = list(/obj/item/stack/sheet/bone = 4,
				/obj/item/stack/sheet/animalhide/goliath_hide = 3)
	time = 60
	category = CAT_PRIMAL

/datum/crafting_recipe/bonesword
	name = "Bone Sword"
	result = /obj/item/claymore/bone
	reqs = list(/obj/item/stack/sheet/bone = 2,
				/obj/item/stack/sheet/sinew = 2)
	time = 40
	always_available = FALSE
	category = CAT_PRIMAL

/datum/crafting_recipe/quiver
	name = "Quiver"
	result = /obj/item/storage/belt/quiver
	reqs = list(/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/sheet/sinew = 4)
	time = 80
	category = CAT_PRIMAL

/datum/crafting_recipe/bone_bow
	name = "Bone Bow"
	result = /obj/item/gun/ballistic/tribalbow/ashen
	reqs = list(/obj/item/stack/sheet/bone = 4,
				/obj/item/stack/sheet/sinew = 4)
	time = 200
	category = CAT_PRIMAL
