/datum/design/sutures
	name = "sutures"
	id = "slavic_suture"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/stack/medical/suture
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_NRI_MEDICAL)

/datum/design/mesh
	name = "regenerative mesh"
	id = "slavic_mesh"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/stack/medical/mesh
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_NRI_MEDICAL)

/datum/design/bruise_patch
	name = "bruise patch"
	id = "slavic_bruise"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 250)
	build_path = /obj/item/reagent_containers/pill/patch/libital
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_NRI_MEDICAL)

/datum/design/burn_patch
	name = "burn patch"
	id = "slavic_burn"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 250)
	build_path = /obj/item/reagent_containers/pill/patch/aiuri
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_NRI_MEDICAL)

/datum/design/gauze
	name = "medical gauze"
	id = "slavic_gauze"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/stack/medical/gauze
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_NRI_MEDICAL)

/datum/design/epi_pill
	name = "epinephrine pill"
	id = "slavic_epi"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/pill/epinephrine
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_NRI_MEDICAL)

/datum/design/salb_pill
	name = "salbutamol pill"
	id = "slavic_salb"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/pill/salbutamol
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_NRI_MEDICAL)

/datum/design/multiver_pill
	name = "multiver pill"
	id = "slavic_multiver"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 75)
	build_path = /obj/item/reagent_containers/pill/multiver
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_NRI_MEDICAL)

#undef RND_CATEGORY_NRI_FOOD
#undef RND_CATEGORY_NRI_MEDICAL
#undef RND_CATEGORY_NRI_CLOTHING
