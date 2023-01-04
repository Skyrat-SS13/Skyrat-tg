/obj/item/storage/fish_case/donkfish
	name = "\improper Donk Co. promotional fish case"

/obj/item/storage/fish_case/donkfish/PopulateContents()
	. = ..()
	new /obj/item/fish/donkfish(src)
