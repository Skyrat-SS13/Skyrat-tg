/// One random selection of some materials, heavily weighted for common drops
/obj/effect/spawner/lootdrop/material
	lootcount = 1
	loot = list(
		/obj/item/stack/sheet/iron{amount = 15} = 50,
		/obj/item/stack/sheet/glass{amount = 15} = 15,
		/obj/item/stack/sheet/mineral/silver{amount = 10} = 15,
		/obj/item/stack/sheet/mineral/diamond{amount = 5} = 5,
		/obj/item/stack/sheet/mineral/uranium{amount = 5} = 5,
		/obj/item/stack/sheet/mineral/plasma{amount = 5} = 5,
		/obj/item/stack/sheet/mineral/titanium{amount = 5} = 5,
		/obj/item/stack/sheet/mineral/gold{amount = 5} = 5,
		/obj/item/stack/ore/bluespace_crystal{amount = 1} = 2
	)

//Really low amounts/chances of materials
/obj/effect/spawner/lootdrop/material_scarce
	lootcount = 1
	loot = list(
		/obj/item/stack/sheet/iron{amount = 5} = 60,
		/obj/item/stack/sheet/glass{amount = 5} = 20,
		/obj/item/stack/sheet/mineral/silver{amount = 3} = 15,
		/obj/item/stack/sheet/mineral/diamond{amount = 2} = 5,
		/obj/item/stack/sheet/mineral/uranium{amount = 2} = 5,
		/obj/item/stack/sheet/mineral/plasma{amount = 2} = 5,
		/obj/item/stack/sheet/mineral/titanium{amount = 2} = 5,
		/obj/item/stack/sheet/mineral/gold{amount = 2} = 5,
		/obj/item/stack/ore/bluespace_crystal{amount = 1} = 1
	)

/// One random selection of some ore, heavily weighted for common drops
/obj/effect/spawner/lootdrop/ore
	lootcount = 1
	loot = list(
		/obj/item/stack/ore/iron{amount = 15} = 50,
		/obj/item/stack/ore/glass{amount = 15} = 15,
		/obj/item/stack/ore/silver{amount = 10} = 15,
		/obj/item/stack/ore/diamond{amount = 5} = 5,
		/obj/item/stack/ore/uranium{amount = 5} = 5,
		/obj/item/stack/ore/plasma{amount = 5} = 5,
		/obj/item/stack/ore/titanium{amount = 5} = 5,
		/obj/item/stack/ore/gold{amount = 5} = 5,
		/obj/item/stack/ore/bluespace_crystal{amount = 1} = 2
	)

/obj/effect/spawner/lootdrop/ore_scarce
	lootcount = 1
	loot = list(
		/obj/item/stack/ore/iron{amount = 5} = 50,
		/obj/item/stack/ore/glass{amount = 5} = 15,
		/obj/item/stack/ore/silver{amount = 3} = 15,
		/obj/item/stack/ore/diamond{amount = 2} = 5,
		/obj/item/stack/ore/uranium{amount = 2} = 5,
		/obj/item/stack/ore/plasma{amount = 2} = 5,
		/obj/item/stack/ore/titanium{amount = 2} = 5,
		/obj/item/stack/ore/gold{amount = 2} = 5,
		/obj/item/stack/ore/bluespace_crystal{amount = 1} = 2
	)
