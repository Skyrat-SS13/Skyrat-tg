/obj/item/storage/backpack/duffelbag/syndie/loadout/robohand/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/robohand(src)
	new /obj/item/ammo_box/magazine/m14mm(src)
	new /obj/item/ammo_box/magazine/m14mm(src)
	new /obj/item/ammo_box/magazine/m14mm(src)
	new /obj/item/ammo_box/magazine/m14mm(src)
	new /obj/item/ammo_box/magazine/m14mm(src)
	new /obj/item/ammo_box/magazine/m14mm(src)
	new /obj/item/storage/belt/military/assault(src)
	new /obj/item/clothing/under/pants/track/robohand(src)
	new /obj/item/clothing/gloves/combat(src)
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/glasses/sunglasses/robohand(src)
	new /obj/item/clothing/suit/armor/bulletproof/old/robohand(src)
	new /obj/item/autosurgeon/bodypart/l_arm_robotic(src)
	new /obj/item/autosurgeon/syndicate/nodrop(src)

/obj/item/autosurgeon/syndicate/esword_arm
	starting_organ = /obj/item/organ/internal/cyberimp/arm/esword

/obj/item/clothing/under/pants/track/robohand
	name = "rockerboy pants"
	desc = "Extremely comfortable pants custom-made in the memory of Johnny Robohand, padded with kevlar for your enjoyment."
	special_desc = "A unique cyberlink allows these pants to somehow protect most of your body, and a specialized weave makes them resistant to wounding attacks."
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc_affiliation = "memories of Johnny Robohand"
	armor = list(MELEE = 20, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 20, BIO = 0, FIRE = 0, ACID = 0, WOUND = 5)

/obj/item/autosurgeon/syndicate/nodrop
	starting_organ = /obj/item/organ/internal/cyberimp/brain/anti_drop

//What do you mean glasses don't protect your head? Of course they do. Cyberpunk has flying cars(mostly intentional)!
/obj/item/clothing/glasses/sunglasses/robohand
	name = "badass shades"
	desc = "An awesome pair of aviator shades that provide eye cover. Enhanced shielding blocks flashes, and a reinforced frame somehow makes these bullet-resistant!"
	special_desc = "Provides the exact same protection as a bulletproof helmet, and resists wounds for the wearer. You'd be a menace if you could find a helmet to wear WITH these, but you'd look less cool."
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc_affiliation = "memories of Johnny Robohand"
	body_parts_covered = HEAD
	armor = list(MELEE = 10, BULLET = 30, LASER = 10, ENERGY = 10, BOMB = 10, BIO = 0, FIRE = 0, ACID = 0, WOUND = 5)

//Again, not a bug, it's a feature. ALL PARTS COVERED!!
/obj/item/clothing/suit/armor/bulletproof/old/robohand
	name = "custom-fit ballistic vest"
	desc = "One of a kind bulletproof armor custom made to fit one person, Johnny Robohand. It seems that your arms are protected by it as well!"
	special_desc = "A damn badass vest that protects your arms and lower torso. Otherwise the exact same as a normal ballistic vest."
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc_affiliation = "memories of Johnny Robohand"
	body_parts_covered = CHEST|GROIN|ARMS
