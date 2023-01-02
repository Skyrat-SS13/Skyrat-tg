
// Checks plants for broken tray icons. Use Advanced Proc Call to activate.
// Maybe some day it would be used as unit test.
// -------- IT IS NOW!
/datum/unit_test/plantgrowth/Run()
<<<<<<< HEAD
	var/list/states = icon_states('icons/obj/hydroponics/growing.dmi')
	states |= icon_states('icons/obj/hydroponics/growing_fruits.dmi')
	states |= icon_states('icons/obj/hydroponics/growing_flowers.dmi')
	states |= icon_states('icons/obj/hydroponics/growing_mushrooms.dmi')
	states |= icon_states('icons/obj/hydroponics/growing_vegetables.dmi')
	states |= icon_states('modular_skyrat/master_files/icons/obj/hydroponics/growing.dmi') // SKYRAT ADDITION
	states |= icon_states('modular_skyrat/modules/xenoarch/icons/growing.dmi') // SKYRAT ADDITION
=======
>>>>>>> cb3f60ec350 ((Hopefully) makes the `plantgrowth_test` not actually garbage (#72402))
	var/list/paths = subtypesof(/obj/item/seeds) - /obj/item/seeds - typesof(/obj/item/seeds/sample) - /obj/item/seeds/lavaland

	for(var/seedpath in paths)
		var/obj/item/seeds/seed = new seedpath

		for(var/i in 1 to seed.growthstages)
			if(icon_exists(seed.growing_icon, "[seed.icon_grow][i]"))
				continue
			TEST_FAIL("[seed.name] ([seed.type]) lacks the [seed.icon_grow][i] icon!")

		if(!(icon_exists(seed.growing_icon, seed.icon_dead)))
			TEST_FAIL("[seed.name] ([seed.type]) lacks the [seed.icon_dead] icon!")

		if(seed.icon_harvest) // mushrooms have no grown sprites, same for items with no product
			if(!(icon_exists(seed.growing_icon, seed.icon_harvest)))
				TEST_FAIL("[seed.name] ([seed.type]) lacks the [seed.icon_harvest] icon!")
