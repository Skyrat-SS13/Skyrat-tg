/obj/item/storage/backpack/duffelbag/synth_trauma_kit
	name = "synthetic trauma kit"
	desc = "A \"surgical\" duffel bag containing everything you need to treat the worst and <i>best</i> of inorganic wounds."

	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_righthand.dmi'
	icon_state = "duffel_robo"
	inhand_icon_state = "duffel_robo"

/obj/item/storage/backpack/duffelbag/synth_trauma_kit/PopulateContents() // yes, this is all within the storage capacity
	new /obj/item/stack/cable_coil(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/wirecutters(src)

	new /obj/item/weldingtool/largetank(src)
	new /obj/item/screwdriver(src)

	new /obj/item/clothing/head/utility/welding(src)
	new /obj/item/clothing/gloves/color/black(src)

	new /obj/item/reagent_containers/spray/hercuri/chilled(src)

	new /obj/item/clothing/glasses/hud/diagnostic(src)

	new /obj/item/stack/medical/gauze/twelve(src)
	new /obj/item/healthanalyzer(src)
	new /obj/item/healthanalyzer/simple(src)

	new /obj/item/bonesetter(src)

	new /obj/item/stack/medical/bone_gel(src)
	new /obj/item/plunger(src)
