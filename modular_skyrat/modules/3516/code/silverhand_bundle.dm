/obj/item/storage/backpack/duffelbag/syndie/loadout/robohand/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/j3516(src)
	new /obj/item/ammo_box/magazine/m14mm(src)
	new /obj/item/ammo_box/magazine/m14mm(src)
	new /obj/item/ammo_box/magazine/m14mm(src)
	new /obj/item/ammo_box/magazine/m14mm(src)
	new /obj/item/storage/belt/military(src)
	new /obj/item/clothing/under/pants/black/robohand(src)
	new /obj/item/clothing/gloves/combat(src)
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/glasses/sunglasses/robohand(src)
	new /obj/item/clothing/suit/armor/bulletproof(src)
	new /obj/item/autosurgeon/bodypart/r_arm_robotic(src)
	new /obj/item/autosurgeon/organ/syndicate/esword_arm(src)
	new /obj/item/autosurgeon/organ/syndicate/nodrop(src)


/obj/item/autosurgeon/organ/syndicate/esword_arm
	starting_organ = /obj/item/organ/cyberimp/arm/esword

/obj/item/clothing/under/pants/black/robohand
	armor = list(MELEE = 20, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 20, BIO = 0, RAD = 0, FIRE = 0, ACID = 0, WOUND = 5)

/obj/item/autosurgeon/organ/syndicate/nodrop
	starting_organ = /obj/item/organ/cyberimp/brain/anti_drop

//What do you mean glasses don't protect your head? Of course they do. Cyberpunk has flying cars(mostly intentional)!
/obj/item/clothing/glasses/sunglasses/robohand
	name = "badass sunglasses"
	desc = "Strangely ancient technology used to help provide rudimentary eye cover. Enhanced shielding blocks flashes. These ones seem to be bulletproof?"
	body_parts_covered = HEAD
	armor = list(MELEE = 20, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 20, BIO = 0, RAD = 0, FIRE = 0, ACID = 0, WOUND = 5)
