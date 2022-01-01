///////////////////
//    Clothing   //
///////////////////

/obj/item/clothing/under/rank/civilian/linen
	name = "linen shirt"
	desc = "A plain generic-looking linen shirt and trousers."
	icon = 'modular_skyrat/modules/modular_items/icons/modular_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/icons/modular_clothing_mob.dmi'
	icon_state = "burlap"
	alt_covers_chest = FALSE

/obj/item/clothing/under/rank/civilian/linen/slave
	name = "slave shirt"
	desc = "Something to cover up the body of a slave. It has irremovable sensors chips locked on tracking mode."
	has_sensor = LOCKED_SENSORS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	strip_delay = 50
// Prison clothing, but with slave flavour. Think 1800s colonial America. Drab-coloured flimsy clothing.

/obj/item/clothing/under/rank/security/bdu
	name = "battle dress uniform"
	desc = "An unassuming green shirt and tan trousers. Inside is a thin kevlar lining, it's marked as slash-resistant. Another tag says machine wash at 40C, 800RPM."
	icon = 'modular_skyrat/modules/modular_items/icons/modular_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/icons/modular_clothing_mob.dmi'
	icon_state = "fatigues"
	armor = list(MELEE = 10, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 30, ACID = 30, WOUND = 10)
	strip_delay = 50
	alt_covers_chest = FALSE
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
// This is equivalent to a security jumpsuit, it has a generic military colour scheme.

/obj/item/clothing/under/rank/civilian/skirt
	name = "fashionable skirt"
	desc = "A black skirt with a fashionable gold-ish yellow trim. It's tied up at the side. It doesn't cover up the chest..."
	icon = 'modular_skyrat/modules/modular_items/icons/modular_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/icons/modular_clothing_mob.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/icons/modular_clothing_mob.dmi'
	icon_state = "skirt"
	can_adjust = FALSE
	body_parts_covered = GROIN|LEGS
	fitted = FEMALE_UNIFORM_TOP

//NYI - Shipbreaker Softsuits
/obj/item/clothing/head/helmet/space/breaker
	name = "cutter's space helmet"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "space_breaker"
	desc = "A specially designed helmet with high-grade UV shielding, protecting the wearers eyes from the brightest arc-flashes. A worn-out tag on the side says " + span_engradio("\"Safety Second\"") + "."

/obj/item/clothing/head/helmet/space/breaker/alt
	icon_state = "space_breaker_alt"
	//Sadly, spacesuits already use alt-click, which would be used to reskin here. It'll be easier to just supply extras...

/obj/item/clothing/suit/space/breaker
	name = "cutter's space suit"
	desc = "A pressure-sealed suit adorned with high-vis strips and plenty of gear rigging. A worn-out tag on the side says " + span_engradio("\"Safety Second\"") + "."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "space_breaker"
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals)
	cell = /obj/item/stock_parts/cell/high/plus

/obj/item/clothing/suit/space/breaker/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", alpha = src.alpha)
	//This will apply to all of them perfectly, because its based off icon_state

/obj/item/clothing/suit/space/breaker/alt
	icon_state = "space_breaker_alt"
	//Sadly, spacesuits already use alt-click, which would be used to reskin here. It'll be easier to just supply extras...

/obj/item/clothing/suit/space/breaker/armored
	desc = "A pressure-sealed suit adorned with high-vis strips and plenty of gear rigging; additionally, this one's been fitted with an armored vest. A worn-out tag on the side says " + span_engradio("\"Safety Second\"") + "."
	icon_state = "space_breaker_armored"
	armor = list(MELEE = 35, BULLET = 30, LASER = 30, ENERGY = 40, BOMB = 25, BIO = 100, FIRE = 80, ACID = 70, WOUND = 10)
	/*For comparison, view the two references:
	/obj/item/clothing/suit/space: armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 100, FIRE = 80, ACID = 70)
	/obj/item/clothing/suit/armor: armor = list(MELEE = 35, BULLET = 30, LASER = 30, ENERGY = 40, BOMB = 25, BIO = 0, FIRE = 50, ACID = 50, WOUND = 10)
	*/
