/obj/item/clothing/under/misc/stripper
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	name = "pink stripper outfit"
	icon_state = "stripper_p"
	body_parts_covered = CHEST|GROIN
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/misc/stripper/green
	name = "green stripper outfit"
	icon_state = "stripper_g"

/obj/item/clothing/under/misc/stripper/mankini
	name = "pink mankini"
	icon_state = "mankini"

/obj/item/clothing/under/misc/stripper/bunnysuit
	name = "bunny suit"
	desc = "Makes the wearer more attractive, even men."
	icon_state = "bunnysuit"
	can_adjust = TRUE
	alt_covers_chest = FALSE

/obj/item/clothing/under/misc/stripper/bunnysuit/white
	name = "white bunny suit"
	icon_state = "whitebunnysuit"
	can_adjust = FALSE

/obj/item/clothing/under/misc/gear_harness
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	name = "gear harness"
	desc = "A simple, inconspicuous harness replacement for a jumpsuit."
	icon_state = "gear_harness"
	body_parts_covered = CHEST|GROIN
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/misc/colourable_kilt
	name = "colourable kilt"
	desc = "It's not a skirt!"
	icon_state = "kilt"
	greyscale_config = /datum/greyscale_config/kilt
	greyscale_config_worn = /datum/greyscale_config/kilt/worn
	greyscale_colors = "#008000#777777"
	flags_1 = IS_PLAYER_COLORABLE_1
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/misc/countess
	name = "countess dress"
	desc = "A wide flowing dress fitting for a countess, maybe not for anyone who enjoys a dress that doesn't catch on things."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "countess_s"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	flags_inv = HIDESHOES

/obj/item/clothing/under/misc/peakyblinder
	name = "birmingham bling"
	desc = "A grey suit with a white vest, maybe you run a whiskey plant, maybe you have a frenemy relationship with that guy out of that one film, whatever it is, it's still a nice looking suit."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "peakyblinder"

/obj/item/clothing/under/misc/taccas
	name = "tacticasual uniform"
	desc = "A white wifebeater on top of some cargo pants. For when you need to carry various beers."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "tac_s"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/misc/bluetracksuit //ORION TODO: sort out a recolorable solution to this? (Upstream? They have trackpants already...)
	name = "blue tracksuit"
	desc = "Found on a dead homeless man squatting in an alleyway, the classic design has been mass produced to bring terror to the galaxy."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "tracksuit_blue"

/obj/item/clothing/under/tachawaiian
	name = "orange tactical hawaiian outfit"
	desc = "Clearly the wearer didn't know if they wanted to invade a country or lay on a nice Hawaiian beach."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "tacticool_hawaiian_orange"
	supports_variations_flags = NONE

/obj/item/clothing/under/tachawaiian/blue
	name = "blue tactical hawaiian outfit"
	icon_state = "tacticool_hawaiian_blue"

/obj/item/clothing/under/tachawaiian/purple
	name = "purple tactical hawaiian outfit"
	icon_state = "tacticool_hawaiian_purple"

/obj/item/clothing/under/tachawaiian/green
	name = "green tactical hawaiian outfit"
	icon_state = "tacticool_hawaiian_green"

/obj/item/clothing/under/texas
	name = "texan formal outfit"
	desc = "A premium quality shirt and pants combo straight from Texas."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "texas"
	supports_variations_flags = NONE

/obj/item/clothing/under/doug_dimmadome
	name = "dimmadome formal outfit"
	desc = "A tight fitting suit with a belt that is surely made out of gold."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "doug_dimmadome"
	supports_variations_flags = NONE

/obj/item/clothing/under/misc/gear_harness/eve
	name = "collection of leaves"
	desc = "Three leaves, designed to cover the nipples and genetalia of the wearer. A foe so proud will first the weaker seek."
	icon_state = "eve"

/obj/item/clothing/under/misc/gear_harness/adam
	name = "leaf"
	desc = "A single leaf, designed to cover the genitalia of the wearer. Seek not temptation."
	icon_state = "adam"
	body_parts_covered = GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/peacekeeper/trousers
	name = "peacekeeper's trousers"
	desc = "Some light blue combat trousers, however you get protected by these, I have no idea."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "workpants_blue"
	body_parts_covered = GROIN
	can_adjust = FALSE
	supports_variations_flags = NONE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/peacekeeper/trousers/red
	name = "security officer's trousers"
	desc = "Some red combat trousers, however you get protected by these, I have no idea."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "workpants_red"
