/// Given to Nuke Ops members.
/obj/item/modular_computer/tablet/nukeops/Initialize(mapload)
	. = ..()
	install_component(new /obj/item/computer_hardware/battery(src, /obj/item/stock_parts/cell/computer))
	install_component(new /obj/item/computer_hardware/hard_drive/small/nukeops)
<<<<<<< HEAD
	install_component(new /obj/item/computer_hardware/network_card)

//Borg Built-in tablet
/obj/item/modular_computer/tablet/integrated/Initialize(mapload)
	. = ..()
	install_component(new /obj/item/computer_hardware/network_card/integrated)
=======
>>>>>>> 7c990173e0b (Removes network cards and printers from tablets (#70110))
