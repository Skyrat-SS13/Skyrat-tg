/obj/item/storage/box/nri_survival_pack
	name = "NRI survival pack"
	desc = "A box filled with useful emergency items, supplied by the NRI."
	icon_state = "survival_pack"
	icon = 'modular_skyrat/modules/exp_corps/icons/survival_pack.dmi'
	illustration = null

/obj/item/storage/box/nri_survival_pack/PopulateContents()
	new /obj/item/storage/box/rations(src)
	new /obj/item/flashlight/glowstick(src)
	new /obj/item/tank/internals/emergency_oxygen/double(src)
	new /obj/item/reagent_containers/food/drinks/waterbottle(src)
	new /obj/item/reagent_containers/blood/o_minus(src)
	new /obj/item/reagent_containers/syringe(src)
	new /obj/item/storage/pill_bottle/multiver(src)

/obj/item/storage/box/rations
	name = "box of rations"
	desc = "A box containing ration packs!"

/obj/item/storage/box/rations/PopulateContents()
	new /obj/item/food/rationpack(src)
	new /obj/item/food/rationpack(src)
	new /obj/item/food/rationpack(src)
	new /obj/item/food/rationpack(src)
	new /obj/item/food/rationpack(src)
	new /obj/item/food/rationpack(src)
