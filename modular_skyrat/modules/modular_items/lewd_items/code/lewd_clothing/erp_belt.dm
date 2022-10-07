/obj/item/storage/belt/erpbelt
	name = "leather belt"
	desc = "Used to hold sex toys. Looks pretty good."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_belts.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_belts.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	icon_state = "erpbelt"
	inhand_icon_state = "erpbelt"
	worn_icon_state = "erpbelt"
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound =  'sound/items/handling/toolbelt_pickup.ogg'

/obj/item/storage/belt/erpbelt/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 21
	atom_storage.set_holdable(list(
						//toys
						/obj/item/clothing/sextoy/eggvib/signalvib,
						/obj/item/clothing/sextoy/buttplug,
						/obj/item/clothing/sextoy/nipple_clamps,
						/obj/item/clothing/sextoy/eggvib,
						/obj/item/clothing/sextoy/dildo/double_dildo,
						/obj/item/clothing/sextoy/vibroring,
						/obj/item/clothing/sextoy/condom,
						/obj/item/condom_pack,
						/obj/item/clothing/sextoy/dildo,
						/obj/item/clothing/sextoy/dildo/custom_dildo,
						/obj/item/tickle_feather,
						/obj/item/clothing/sextoy/fleshlight,
						/obj/item/kinky_shocker,
						/obj/item/clothing/mask/leatherwhip,
						/obj/item/clothing/sextoy/magic_wand,
						/obj/item/bdsm_candle,
						/obj/item/spanking_pad,
						/obj/item/clothing/sextoy/vibrator,
						/obj/item/restraints/handcuffs/lewd,
						/obj/item/reagent_containers/cup/lewd_filter,
						/obj/item/assembly/signaler, //because it's used for several toys

						//clothing
						/obj/item/clothing/mask/ballgag,
						/obj/item/clothing/mask/ballgag/choking,
						/obj/item/clothing/head/domina_cap,
						/obj/item/clothing/head/maid,
						/obj/item/clothing/glasses/blindfold/kinky,
						/obj/item/clothing/ears/kinky_headphones,
						/obj/item/clothing/suit/straight_jacket/latex_straight_jacket,
						/obj/item/clothing/mask/gas/bdsm_mask,
						/obj/item/clothing/head/helmet/space/deprivation_helmet,
						/obj/item/clothing/glasses/hypno,

						//neck
						/obj/item/clothing/neck/kink_collar,
						/obj/item/clothing/neck/kink_collar/locked,
						/obj/item/clothing/neck/mind_collar,
						/obj/item/electropack/shockcollar,

						//torso clothing
						/obj/item/clothing/suit/corset,
						/obj/item/clothing/under/misc/latex_catsuit,
						/obj/item/clothing/under/rank/civilian/janitor/maid,
						/obj/item/clothing/under/costume/lewdmaid,
						/obj/item/clothing/suit/straight_jacket/shackles,
						/obj/item/clothing/under/stripper_outfit,
						/obj/item/clothing/under/misc/gear_harness,

						//hands
						/obj/item/clothing/gloves/ball_mittens,
						/obj/item/clothing/gloves/latex_gloves,
						/obj/item/clothing/gloves/evening,

						//legs
						/obj/item/clothing/shoes/latex_socks,
						/obj/item/clothing/shoes/latex_heels,
						/obj/item/clothing/shoes/latex_heels/domina_heels,

						//belt
						/obj/item/clothing/strapon,

						//chems
						/obj/item/reagent_containers/pill/crocin,
						/obj/item/reagent_containers/pill/camphor,
						/obj/item/reagent_containers/cup/bottle/succubus_milk,
						/obj/item/reagent_containers/cup/bottle/incubus_draft,
						/obj/item/reagent_containers/pill/hexacrocin,
						/obj/item/reagent_containers/pill/pentacamphor,
						/obj/item/reagent_containers/cup/bottle/hexacrocin,
						/obj/item/reagent_containers/cup/bottle/pentacamphor))
