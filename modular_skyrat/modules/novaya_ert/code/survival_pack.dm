/obj/item/storage/box/nri_survival_pack
	name = "NRI survival pack"
	desc = "A box filled with useful emergency items, supplied by the NRI."
	icon_state = "survival_pack"
	icon = 'modular_skyrat/modules/exp_corps/icons/survival_pack.dmi'
	illustration = null

/obj/item/storage/box/nri_survival_pack/PopulateContents()
	new /obj/item/storage/box/mothic_rations(src)
	new /obj/item/tank/internals/emergency_oxygen/double(src)
	new /obj/item/reagent_containers/hypospray/medipen(src)
	new /obj/item/reagent_containers/hypospray/medipen/oxandrolone(src)
	new /obj/item/reagent_containers/hypospray/medipen/salacid(src)
	new /obj/item/reagent_containers/hypospray/medipen/salbutamol(src)
	new /obj/item/reagent_containers/hypospray/medipen/blood_loss(src)
