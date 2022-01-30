//Trek Jacket(s?)
/obj/item/clothing/suit/storage/fluff/fedcoat
	name = "Federation uniform jacket"
	desc = "A uniform jacket from the United Federation. Set phasers to awesome."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	mutant_variants = NONE
	icon_state = "fedcoat"
	inhand_icon_state = "fedcoat"
	body_parts_covered = CHEST|GROIN|ARMS
	allowed = list(
				/obj/item/tank/internals/emergency_oxygen,
				/obj/item/flashlight,
				/obj/item/analyzer,
				/obj/item/radio,
				/obj/item/gun,
				/obj/item/melee/baton,
				/obj/item/restraints/handcuffs,
				/obj/item/reagent_containers/hypospray,
				/obj/item/hypospray,
				/obj/item/healthanalyzer,
				/obj/item/reagent_containers/syringe,
				/obj/item/reagent_containers/glass/vial,
				/obj/item/reagent_containers/glass/beaker,
				/obj/item/storage/pill_bottle,
				/obj/item/taperecorder)
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0, WOUND = 0)
	var/unbuttoned = 0

//This makes the fed coats button and unbuttonable. Doesn't aply to modern fedcoats.
/obj/item/clothing/suit/storage/fluff/fedcoat/verb/toggle()
	set name = "Toggle coat buttons"
	set category = "Object"
	set src in usr

	var/mob/living/I = usr
	if(!istype(I))
		return FALSE

	switch(unbuttoned)
		if(0)
			icon_state = "[initial(icon_state)]_open"
			inhand_icon_state = "[initial(inhand_icon_state)]_open"
			unbuttoned = 1
			to_chat(usr,"You unbutton the coat.")
		if(1)
			icon_state = "[initial(icon_state)]"
			inhand_icon_state = "[initial(inhand_icon_state)]"
			unbuttoned = 0
			to_chat(usr,"You button up the coat.")
	usr.update_inv_wear_suit()

/obj/item/clothing/suit/storage/fluff/fedcoat/medsci
	icon_state = "fedblue"
	inhand_icon_state = "fedblue"

/obj/item/clothing/suit/storage/fluff/fedcoat/eng
	icon_state = "fedeng"
	inhand_icon_state = "fedeng"

/obj/item/clothing/suit/storage/fluff/fedcoat/capt
	icon_state = "fedcapt"
	inhand_icon_state = "fedcapt"

//fedcoat but modern
/obj/item/clothing/suit/storage/fluff/mfedcoat
	name = "modern Federation uniform jacket"
	desc = "A modern uniform jacket from the United Federation."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	mutant_variants = NONE
	icon_state = "fedmodern"
	inhand_icon_state = "fedmodern"
	body_parts_covered = CHEST|GROIN|ARMS
	allowed = list(
			/obj/item/tank/internals/emergency_oxygen,
			/obj/item/flashlight,
			/obj/item/analyzer,
			/obj/item/radio,
			/obj/item/gun,
			/obj/item/melee/baton,
			/obj/item/restraints/handcuffs,
			/obj/item/reagent_containers/hypospray,
			/obj/item/hypospray,
			/obj/item/healthanalyzer,
			/obj/item/reagent_containers/syringe,
			/obj/item/reagent_containers/glass/vial,
			/obj/item/reagent_containers/glass/beaker,
			/obj/item/storage/pill_bottle,
			/obj/item/taperecorder)
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0, WOUND = 0)


/obj/item/clothing/suit/storage/fluff/mfedcoat/medsci
	name = "modern medsci Federation jacket"
	icon_state = "fedmodernblue"
	inhand_icon_state = "fedmodernblue"

/obj/item/clothing/suit/storage/fluff/mfedcoat/eng
	name = "modern eng Federation jacket"
	icon_state = "fedmoderneng"
	inhand_icon_state = "fedmoderneng"

/obj/item/clothing/suit/storage/fluff/mfedcoat/sec
	name = "modern sec Federation jacket"
	icon_state = "fedmodernsec"
	inhand_icon_state = "fedmodernsec"
