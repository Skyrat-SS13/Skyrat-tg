/datum/crafting_recipe/mop
	name = "Mop"
	result = /obj/item/mop
	reqs = list(/obj/item/stack/rods = 1,
				/obj/item/stack/sheet/cloth = 2,
				/obj/item/stack/cable_coil = 5)
	time = 3 SECONDS
	category = CAT_TOOLS

/datum/crafting_recipe/mop
	name = "Tribal Mop"
	result = /obj/item/mop/tribal
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/sheet/cloth = 2,
				/obj/item/stack/sheet/sinew = 1)
	time = 3 SECONDS
	category = CAT_TOOLS

/datum/crafting_recipe/doubletank
	name = "Double emergency oxygen tank"
	reqs = list(
		/obj/item/tank/internals/emergency_oxygen/engi = 2,
		/obj/item/stack/sticky_tape = 1,
	)
	result = /obj/item/tank/internals/emergency_oxygen/double/empty
	category = CAT_MISC
