/obj/item/clothing/under/dress
	body_parts_covered = CHEST|GROIN	//For reference
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON	//For reference - keep in mind some dresses will need adjusted for digi thighs
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/skirts_dresses_digi.dmi'
	//God bless the skirt being a subtype of the dress, only need one worn_digi_icon definition

/obj/item/clothing/under/dress/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/skirts_dresses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/skirts_dresses.dmi'

/obj/item/clothing/under/dress/skirt/skyrat	//Just so they can stay under TG's skirts in case code needs subtypes of them (also SDMM dropdown looks nicer like this)

//TG's icons only have a dress.dmi, but that means its not ABC-sorted beside shorts_pants.dmi. So its skirts_dresses for us.

/*
*	Skirts
*/

/obj/item/clothing/under/pants/denimskirt
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	name = "denim skirt"
	desc = "These are really just a jean leg hole cut from a pair"
	icon_state = "denim_skirt"

/obj/item/clothing/under/dress/skirt/swept
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	name = "swept skirt"
	desc = "Formal skirt."
	icon_state = "skirt_swept"
	body_parts_covered = GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE

/obj/item/clothing/under/dress/littleblack
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	name = "short black dress"
	desc = "An extremely short black dress, for those with no shame."
	icon_state = "littleblackdress_s"
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE

/obj/item/clothing/under/dress/pinktutu
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	name = "pink tutu"
	desc = "A fluffy pink tutu."
	icon_state = "pinktutu_s"
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE

/*
*	Dresses
*/

/obj/item/clothing/under/dress/green
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	name = "green dress"
	desc = "A tight green dress"
	icon_state = "dress_green"
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE

/obj/item/clothing/under/dress/pink
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	name = "pink dress"
	desc = "A tight pink dress"
	icon_state = "dress_pink"
	body_parts_covered = CHEST|GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE

/obj/item/clothing/under/dress/flower
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	name = "flower dress"
	desc = "Lovely dress."
	icon_state = "flower_dress"
	inhand_icon_state = "sailordress"
	body_parts_covered = CHEST|GROIN|LEGS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE

/obj/item/clothing/under/misc/formaldressred
	name = "formal red dress"
	desc = "Not too wide flowing, but big enough to make an impression."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "formalred_s"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	flags_inv = HIDESHOES
