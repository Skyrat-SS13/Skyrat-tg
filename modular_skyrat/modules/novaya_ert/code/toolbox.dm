/obj/item/storage/toolbox/ammo
	desc = "It contains a few clips."

/obj/item/storage/toolbox/ammo/PopulateContents()
	return

/obj/item/storage/toolbox/ammo/mosin
	name = "ammo box (Sportiv)"
	desc = "It contains a few clips."

/obj/item/storage/toolbox/ammo/mosin/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_box/a762(src)

/obj/item/storage/toolbox/ammo/krinkov
	name = "ammo box (Krinkov)"
	desc = "It contains a few magazines."

/obj/item/storage/toolbox/ammo/krinkov/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_box/magazine/akm(src)

/obj/item/storage/toolbox/ammo/krinkov_xeno
	name = "ammo box (Krinkov, anti-acid)"
	desc = "It contains a few magazines."

/obj/item/storage/toolbox/ammo/krinkov_xeno/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_box/magazine/akm/xeno(src)

/obj/item/storage/toolbox/ammo/bison
	name = "ammo box (PP-95)"
	desc = "It contains a few magazines."

/obj/item/storage/toolbox/ammo/bison/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/plastikov9mm(src)

/obj/item/storage/toolbox/ammo/bison/ert/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_box/magazine/plastikov9mm(src)

/obj/item/storage/toolbox/ammo/makarov
	name = "ammo box (Makarov)"
	desc = "It contains a few magazines."

/obj/item/storage/toolbox/ammo/makarov/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_box/magazine/m9mm(src)

/obj/item/storage/toolbox/ammo/aps
	name = "ammo box (Szabo-Ivanek/APS)"
	desc = "It contains a few magazines."

/obj/item/storage/toolbox/ammo/aps/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_box/magazine/m9mm_aps(src)
