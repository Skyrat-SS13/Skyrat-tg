/obj/structure/sign/flag
	name = "blank flag"
	desc = "The flag of nothing. It has nothing on it. Magnificient."
	icon = 'modular_skyrat/modules/aesthetics/flag/icons/flags.dmi'
	icon_state = "flag_coder"
	buildable_sign = FALSE
	custom_materials = null
	var/item_flag = /obj/item/sign/flag

/obj/structure/sign/wrench_act(mob/living/user, obj/item/wrench/I)
	return

/obj/structure/sign/welder_act(mob/living/user, obj/item/I)
	return

/obj/item/sign/welder_act(mob/living/user, obj/item/I)
	return

/obj/structure/sign/flag/MouseDrop(over_object, src_location, over_location)
	. = ..()
	if(over_object == usr && Adjacent(usr))
		if(!item_flag || src.flags_1 & NODECONSTRUCT_1)
			return
		if(!usr.canUseTopic(src, BE_CLOSE, NO_DEXTERITY, FALSE, TRUE))
			return
		usr.visible_message(span_notice("[usr] grabs and folds \the [src.name]."), span_notice("You grab and fold \the [src.name]."))
		var/obj/item/C = new item_flag(loc)
		TransferComponents(C)
		usr.put_in_hands(C)
		qdel(src)

/obj/structure/sign/flag/ssc
	name = "flag of the Kingdom of Agurkrral"
	desc = "The flag of the Kingdom of Agurkrral."
	icon_state = "flag_agurk"
	item_flag = /obj/item/sign/flag/ssc

/obj/structure/sign/flag/nanotrasen
	name = "flag of Nanotrasen"
	desc = "The official corporate flag of Nanotrasen. Mostly flown as a ceremonial piece, or to mark land on a new frontier."
	icon_state = "flag_nt"
	item_flag = /obj/item/sign/flag/nanotrasen

/obj/structure/sign/flag/tizira
	name = "flag of the Tiziran Empire"
	desc = "The flag of the Great Empire of Tizira. Depending on who you ask, it represents strength or being stuck in the past."
	icon_state = "flag_tizira"
	item_flag = /obj/item/sign/flag/tizira

/obj/structure/sign/flag/mothic
	name = "flag of the Grand Nomad Fleet"
	desc = "The flag of the Mothic Grand Nomad Fleet. A classic naval ensign, its use has superceded the old national flag which can be seen in its canton."
	icon_state = "flag_mothic"
	item_flag = /obj/item/sign/flag/mothic

/obj/structure/sign/flag/mars
	name = "flag of the Martian Republic"
	desc = "The flag of Mars. Originally a revolutionary flag during the Martian Rebellions, it has since been adopted as the official flag of the planet, as a reminder of how Mars fought for representation and democracy."
	icon_state = "flag_mars"
	item_flag = /obj/item/sign/flag/mars

/obj/structure/sign/flag/terragov
	name = "flag of SolFed"
	desc = "The flag of SolFed. It's a symbol of humanity no matter where they go, or how much they wish it wasn't."
	icon_state = "flag_solfed"
	item_flag = /obj/item/sign/flag/terragov

/obj/structure/sign/flag/nri
	name = "flag of the Novaya Rossiyskaya Imperiya"
	desc = "The flag of the Novaya Rossiyskaya Imperiya. The yellow, black and white colours represent its sovereignity, spirituality and pureness."
	icon_state = "flag_nri"
	item_flag = /obj/item/sign/flag/nri

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/nri, 32)

/obj/structure/sign/flag/syndicate
	name = "flag of the Syndicate"
	desc = "The flag of the Syndicate. Previously used by the Sothran people as a way of declaring opposition against the Nanotrasen, now it became an intergalactic symbol of the same purpose, as more groups of interest have joined the rebellion's side."
	icon_state = "flag_syndi"
	item_flag = /obj/item/sign/flag/syndicate

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/syndicate, 32)

/obj/item/sign/flag
	name = "folded blank flag"
	desc = "The folded flag of nothing. It has nothing on it. Beautiful."
	icon = 'modular_skyrat/modules/aesthetics/flag/icons/flags.dmi'
	icon_state = "folded_coder"
	sign_path = /obj/structure/sign/flag
	is_editable = FALSE

/obj/item/sign/flag/nanotrasen
	name = "folded flag of the Nanotrasen"
	desc = "The folded flag of the Nanotrasen."
	icon_state = "folded_nt"
	sign_path = /obj/structure/sign/flag/nanotrasen

/obj/item/sign/flag/ssc
	name = "folded flag of the Kingdom of Agurkrral"
	desc = "The folded flag of the Kingdom of Agurkrral."
	icon_state = "folded_agurk"
	sign_path = /obj/structure/sign/flag/ssc

/obj/item/sign/flag/terragov
	name = "folded flag of the SolFed"
	desc = "The folded flag of SolFed."
	icon_state = "folded_solfed"
	sign_path = /obj/structure/sign/flag/terragov

/obj/item/sign/flag/tizira
	name = "folded flag of the Tiziran Empire"
	desc = "The folded flag of the Tiziran Empire."
	icon_state = "folded_tizira"
	sign_path = /obj/structure/sign/flag/tizira

/obj/item/sign/flag/mothic
	name = "folded flag of the Grand Nomad Fleet"
	desc = "The folded flag of the Grand Nomad Fleet."
	icon_state = "folded_mothic"
	sign_path = /obj/structure/sign/flag/mothic

/obj/item/sign/flag/mars
	name = "folded flag of the Martian Republic"
	desc = "The folded flag of the Martian Republic."
	icon_state = "folded_mars"
	sign_path = /obj/structure/sign/flag/mars

/obj/item/sign/flag/nri
	name = "folded flag of the Novaya Rossiyskaya Imperiya"
	desc = "The folded flag of the Novaya Rossiyskaya Imperiya."
	icon_state = "folded_nri"
	sign_path = /obj/structure/sign/flag/nri

/obj/item/sign/flag/syndicate
	name = "folded flag of the Syndicate"
	desc = "The folded flag of the United States of America."
	icon_state = "folded_syndi"
	sign_path = /obj/structure/sign/flag/syndicate
