/obj/machinery/mineral/equipment_vendor/Initialize()
	prize_list += list(
		new /datum/data/mining_equipment("Kinetic Destroyer",/obj/item/kinetic_crusher/premiumcrusher,12000),
		new /datum/data/mining_equipment("Premium Accelerator",/obj/item/gun/energy/kinetic_accelerator/premiumka,8000),
		new /datum/data/mining_equipment("Precise Accelerator",/obj/item/gun/energy/kinetic_accelerator/premiumka/precise,10000),
		new /datum/data/mining_equipment("Rapid Accelerator",/obj/item/gun/energy/kinetic_accelerator/premiumka/rapid,10000),
		new /datum/data/mining_equipment("Heavy Accelerator",/obj/item/gun/energy/kinetic_accelerator/premiumka/heavy,10000),
		new /datum/data/mining_equipment("Modular Accelerator",/obj/item/gun/energy/kinetic_accelerator/premiumka/modular,15000),
		new /datum/data/mining_equipment("Build-your-own-KA kit",/obj/item/gun/energy/kinetic_accelerator/premiumka/byoka,30000),
		)
	return ..()
