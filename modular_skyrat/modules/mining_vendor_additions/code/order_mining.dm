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

/// Allows a user to exchange their crusher for a glaive or vice versa, for no statistical benefits whatsoever other than optimizing style.
/obj/machinery/computer/order_console/mining/proc/exchange_crusher(obj/item/kinetic_crusher/crusher, mob/redeemer)
	if(length(crusher.trophies))
		balloon_alert(redeemer, "remove trophies first!")
		return
	var/drip_or_drown = list(
		"Exchange for glaive" = image(icon = 'modular_skyrat/master_files/icons/obj/kinetic_glaive.dmi', icon_state = "crusher-glaive"),
		"Exchange for crusher" = image(icon = 'icons/obj/mining.dmi', icon_state = "crusher"),
	)
	var/selection = show_radial_menu(redeemer, src, drip_or_drown, require_near = TRUE, tooltips = TRUE)
	if(!selection || !Adjacent(redeemer) || QDELETED(crusher) || crusher.loc != redeemer)
		return
	var/drop_location = drop_location()
	var/obj/item/kinetic_crusher/exchanged_for
	redeemer.visible_message(span_notice("[redeemer] waves [crusher] in front of [src], and a flimsy-looking crane plucks it out of [redeemer.p_their()] hands."), \
	span_notice("As you wave [crusher] in front of [src], a flimsy-looking crane flicks out and plucks it out of your hands, dispensing its replacement."), \
	span_notice("You hear the whirring of a flimsy-sounding crane grab something out of someone's hand."))
	switch(selection)
		if("Exchange for glaive")
			exchanged_for = new /obj/item/kinetic_crusher/glaive(drop_location)
		if("Exchange for crusher")
			exchanged_for = new /obj/item/kinetic_crusher(drop_location)
	qdel(crusher)
	try_put_in_hand(exchanged_for, redeemer)

/obj/item/kinetic_crusher/glaive
	name = "proto-kinetic glaive"
	desc = "A modified proto-kinetic crusher, it is still little more than various mining tools cobbled together \
	into a high-tech knife on a stick with a handguard and goliath-leather grip. While equally as effective as its unmodified compatriots, \
	it still does little to aid any but the most skilled - or suicidal."
	attack_verb_continuous = list("slices", "slashes", "cleaves", "chops", "stabs")
	attack_verb_simple = list("slice", "slash", "cleave", "chop", "stab")
	icon = 'modular_skyrat/master_files/icons/obj/kinetic_glaive.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	lefthand_file = 'modular_skyrat/master_files/icons/mob/64x64_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/64x64_righthand.dmi'
	icon_state = "crusher-glaive"
