//--- BOWIE'S KNIFE (bowie knife)---\\\


/obj/item/melee/knife/bowie
	name = "Bowie Knife"
	desc = "A frontierman's classic, closer to a shortsword then a knife, with a full-tanged build, brass handguard and pommel, a wicked sharp point, and a large, heavy blade, it's almost everything you could want in a knife, besides portability."
	icon = 'modular_skyrat/modules/knives/icons/bowie.dmi'
  	iconstate = 'bowie'
	lefthand_file = 'modular_skyrat/modules/knives/icons/bowie_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/knives/icons/bowie_righthand.dmi'
  	worn_icon_state = "knife"
	force = 20 // Zoowee Momma!
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 15
	wound_bonus = -15
	bare_wound_bonus = 20

  
  /obj/item/storage/bag/bowiesheathe
	name = "Bowie Knife sheathe"
	desc = "A dressed up leather sheathe, featuring a bass tip, and a large pocket clip right in the center, for ease of carrying an otherwise burdersome knife."
	icon = 'modular_skyrat/modules/knives/icons/bowie.dmi'
	icon_state = "bowiesheathe2"
	slot_flags = ITEM_SLOT_POCKETS
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FLAMMABLE
	
/obj/item/storage/bag/bowiesheathe/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 1
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.set_holdable(list(
		/obj/item/melee/knife/bowie
		))

  /obj/item/storage/bag/bowiesheathe/PopulateContents()
	new /obj/item/melee/knife/bowie(src)
	update_appearance()

