#define RND_CATEGORY_NRI_FOOD "Provision"
#define RND_CATEGORY_NRI_MEDICAL "Medicine"
#define RND_CATEGORY_NRI_CLOTHING "Apparel"

/datum/design/test_food
	name = "mre that makes people mad"
	id = "fucking_mre"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 1)
	build_path = /obj/item/storage/box/nri_rations
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_NRI_FOOD)

/datum/design/test_med
	name = "adminodrazine pill"
	id = "fucking_med"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 2)
	build_path = /obj/item/reagent_containers/pill/adminordrazine
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_NRI_MEDICAL)

/datum/design/test_cloth
	name = "jabroni outfit"
	id = "fucking_cloth"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 2)
	build_path = /obj/item/clothing/under/costume/jabroni
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_NRI_CLOTHING)
