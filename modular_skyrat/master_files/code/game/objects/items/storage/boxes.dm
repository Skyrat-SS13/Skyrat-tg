// Most of these are just additions to allow certain cargo packs to exist. More will be on the way on additional PR's

/obj/item/storage/box/techshell
	name = "box of unloaded techshell"
	desc = "A box of technological shells. These come unloaded and ready for custom shot loads."

/obj/item/storage/box/techshell/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_casing/shotgun/techshell(src)
