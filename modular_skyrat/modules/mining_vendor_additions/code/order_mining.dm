/datum/orderable_item/mining/survival_bodybag
	item_path = /obj/item/bodybag/environmental
	cost_per_order = 500

/datum/orderable_item/mining/suit_voucher
	item_path = /obj/item/suit_voucher
	cost_per_order = 2000

/datum/orderable_item/mining/kinetic_glaive
	item_path = /obj/item/kinetic_crusher/glaive
	desc = "A modified proto-kinetic crusher. Settles the debate on axe or club by being a third option; a knife. Has a cool goliath-hide grip, and no differences in performance."
	cost_per_order = 2250

/obj/item/kinetic_crusher/glaive
	name = "proto-kinetic glaive"
	desc = "A modified proto-kinetic crusher, it is still little more than a combination of various mining tools cobbled together \
	into a high-tech knife on a stick. While equally as effective as its unmodified compatriots, it still does little to aid any but the \
	most skilled - or suicidal."
	attack_verb_continuous = list("slices", "slashes", "cleaves", "chops", "stabs")
	attack_verb_simple = list("slice", "slash", "cleave", "chop", "stab")
	icon = 'modular_skyrat/master_files/icons/obj/kinetic_glaive.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/weapons/hammers_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/weapons/hammers_righthand.dmi'
	icon_state = "crusher-glaive"
