/obj/item/storage/backpack/duffelbag/synth_treatment_kit
	name = "synthetic treatment kit"
	desc = "A \"surgical\" duffel bag containing everything you need to treat the worst and <i>best</i> of inorganic wounds."

	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_righthand.dmi'
	icon_state = "duffel_robo"
	inhand_icon_state = "duffel_robo"

/obj/item/storage/backpack/duffelbag/synth_treatment_kit/PopulateContents() // yes, this is all within the storage capacity
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

// a treatment kit with extra space and more tools/upgraded tools, like a crowbar, insuls, a reinforced plunger, a crowbar and wrench
/obj/item/storage/backpack/duffelbag/synth_treatment_kit/trauma
	name = "synthetic trauma kit"
	desc = "A \"surgical\" duffel bag containing everything you need to treat the worst and <i>best</i> of inorganic wounds. This one has extra tools and space \
	for treatment of the WORST of the worst! However, it's highly specialized interior means it can ONLY hold synthetic repair tools."

	storage_type = /datum/storage/duffel/synth_trauma_kit

/datum/storage/duffel/synth_trauma_kit
	exception_max = 6
	max_slots = 27
	max_total_storage = 35

/datum/storage/duffel/synth_trauma_kit/New(atom/parent, max_slots, max_specific_storage, max_total_storage, numerical_stacking, allow_quick_gather, allow_quick_empty, collection_mode, attack_hand_interact)
	. = ..()

	var/static/list/exception_cache = typecacheof(list(
		/obj/item/stack/cable_coil,
		/obj/item/stack/medical/gauze,
		/obj/item/reagent_containers/spray,
		/obj/item/stack/medical/bone_gel,
		/obj/item/rcd_ammo,
		/obj/item/storage/pill_bottle,
	))

	var/static/list/can_hold_list = list(
		/obj/item/stack/cable_coil,
		/obj/item/stack/medical/gauze,
		/obj/item/reagent_containers/spray,
		/obj/item/stack/medical/bone_gel,
		/obj/item/storage/pill_bottle,

		/obj/item/screwdriver,
		/obj/item/wrench,
		/obj/item/crowbar,
		/obj/item/weldingtool,
		/obj/item/bonesetter,
		/obj/item/wirecutters,
		/obj/item/hemostat,
		/obj/item/retractor,
		/obj/item/cautery,
		/obj/item/plunger,

		/obj/item/construction/rcd,
		/obj/item/rcd_ammo,

		/obj/item/clothing/gloves,
		/obj/item/clothing/glasses/hud/health,
		/obj/item/clothing/glasses/hud/diagnostic,
		/obj/item/clothing/glasses/welding,
		/obj/item/clothing/head/utility/welding,
		/obj/item/clothing/mask/gas/welding,

		/obj/item/reagent_containers/pill,

		/obj/item/healthanalyzer,
	)
	exception_hold = exception_cache

	// We keep the type list and the typecache list separate...
	var/static/list/can_hold_cache = typecacheof(can_hold_list)
	can_hold = can_hold_cache

	//...So we can run this without it generating a line for every subtype.
	can_hold_description = generate_hold_desc(can_hold_list)

/obj/item/storage/backpack/duffelbag/synth_treatment_kit/trauma/PopulateContents() // yes, this is all within the storage capacity
	new /obj/item/stack/cable_coil(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/wirecutters(src)

	new /obj/item/weldingtool/hugetank(src)
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/crowbar(src)

	new /obj/item/clothing/head/utility/welding(src)
	new /obj/item/clothing/gloves/color/black(src)
	new /obj/item/clothing/gloves/color/yellow(src)

	new /obj/item/reagent_containers/spray/hercuri/chilled(src)

	new /obj/item/clothing/glasses/hud/diagnostic(src)

	new /obj/item/stack/medical/gauze/twelve(src)
	new /obj/item/healthanalyzer(src)
	new /obj/item/healthanalyzer/simple(src)

	new /obj/item/bonesetter(src)

	new /obj/item/stack/medical/bone_gel(src)
	new /obj/item/plunger/reinforced(src)

// advanced tools, an RCD, chems, etc etc. dont give this one to the crew early in the round
/obj/item/storage/backpack/duffelbag/synth_treatment_kit/trauma/advanced
	name = "advanced synth trauma kit"
	desc = "An \"advanced\" \"surgical\" duffel bag containing <i>absolutely</i> everything you need to treat the worst and <i>best</i> of inorganic wounds. \
	This one has extra tools and space for treatment of the ones even <i>worse</i> than the WORST of the worst! However, it's highly specialized interior \
	means it can ONLY hold synthetic repair tools."

	storage_type = /datum/storage/duffel/synth_trauma_kit/advanced

/datum/storage/duffel/synth_trauma_kit/advanced
	exception_max = 10
	max_slots = 31
	max_total_storage = 48

/obj/item/storage/backpack/duffelbag/synth_treatment_kit/trauma/advanced/PopulateContents() // yes, this is all within the storage capacity
	new /obj/item/stack/cable_coil(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/crowbar/power(src) // jaws of life

	new /obj/item/weldingtool/experimental(src)
	new /obj/item/screwdriver/power(src) // drill
	new /obj/item/construction/rcd/loaded(src) // lets you instantly heal T3 blunt step 1

	new /obj/item/clothing/head/utility/welding(src)
	new /obj/item/clothing/gloves/combat(src) // insulated AND heat-resistant

	new /obj/item/reagent_containers/spray/hercuri/chilled(src)
	new /obj/item/reagent_containers/spray/hercuri/chilled(src) // 2 of them

	new /obj/item/clothing/glasses/hud/diagnostic(src)

	new /obj/item/stack/medical/gauze/twelve(src)
	new /obj/item/healthanalyzer/advanced(src)
	new /obj/item/healthanalyzer/simple(src)

	new /obj/item/storage/pill_bottle/nanite_slurry(src)
	new /obj/item/storage/pill_bottle/liquid_solder(src)
	new /obj/item/storage/pill_bottle/system_cleaner(src)

	new /obj/item/bonesetter(src)

	new /obj/item/stack/medical/bone_gel(src)
	new /obj/item/plunger/reinforced(src)

/obj/item/storage/backpack/duffelbag/synth_treatment_kit/trauma/advanced/unzipped
	zipped_up = FALSE
