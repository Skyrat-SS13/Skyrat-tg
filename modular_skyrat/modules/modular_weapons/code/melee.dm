// Cargo Sabres
/obj/item/storage/belt/sabre/cargo
	desc = "An ornate black sheath designed to hold an officer's bladesss."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'

/obj/item/storage/belt/sabre/PopulateContents()
	new /obj/item/melee/sabre/cargo(src)
	update_appearance()

/obj/item/melee/sabre/cargo
	block_chance = 20
	armour_penetration = 25
