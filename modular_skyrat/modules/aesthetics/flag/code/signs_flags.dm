/obj/structure/sign/flag
	name = "blank flag"
	desc = "The flag of nothing. It has nothing on it. Magnificient."
	icon = 'modular_skyrat/modules/aesthetics/flag/icons/flags.dmi'
	icon_state = "flag_coder"
	buildable_sign = FALSE
	custom_materials = null
	var/item_flag = /obj/item/sign/flag

/obj/structure/sign/flag/wrench_act(mob/living/user, obj/item/wrench/I)
	return

/obj/structure/sign/flag/welder_act(mob/living/user, obj/item/I)
	return

/obj/structure/sign/flag/mouse_drop_dragged(atom/over, mob/user, src_location, over_location, params)
	if(over == user && Adjacent(user))
		if(!item_flag || src.obj_flags & NO_DEBRIS_AFTER_DECONSTRUCTION)
			return
		if(!user.can_perform_action(src, NEED_DEXTERITY))
			return
		user.visible_message(span_notice("[user] grabs and folds \the [src.name]."), span_notice("You grab and fold \the [src.name]."))
		var/obj/item/flag_item = new item_flag(loc)
		TransferComponents(flag_item)
		user.put_in_hands(flag_item)
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
	name = "flag of the Republic of Northern Moghes"
	desc = "The flag of the Great Republic of Northern Moghes. Depending on who you ask, it represents strength or being an ant in the hive."
	icon_state = "flag_tizira"
	item_flag = /obj/item/sign/flag/tizira

/obj/structure/sign/flag/mothic
	name = "flag of the Grand Nomad Fleet"
	desc = "The flag of the Mothic Grand Nomad Fleet. A classic naval ensign, its use has superceded the old national flag which can be seen in its canton."
	icon_state = "flag_mothic"
	item_flag = /obj/item/sign/flag/mothic

/obj/structure/sign/flag/mars
	name = "flag of the Teshari League for Self-Determination"
	desc = "The flag of the Teshari League for Self-Determination. Originally a revolutionary flag during the time of the Republic of the Golden Feather, it has since been adopted as the official flag of the planet, as a reminder of how Teshari fought for representation and independence."
	icon_state = "flag_mars"
	item_flag = /obj/item/sign/flag/mars

/obj/structure/sign/flag/terragov
	name = "flag of Sol Federation"
	desc = "The flag of Sol Federation. It's a symbol of humanity no matter where they go, or how much they wish it wasn't."
	icon_state = "flag_solfed"
	item_flag = /obj/item/sign/flag/terragov

/obj/structure/sign/flag/nri
	name = "flag of the Novaya Rossiyskaya Imperiya"
	desc = "The flag of the Novaya Rossiyskaya Imperiya. The yellow, black and white colours represent its sovereignity, spirituality and pureness."
	icon_state = "flag_nri"
	item_flag = /obj/item/sign/flag/nri

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/nri, 32)

/obj/structure/sign/flag/azulea
	name = "flag of the Azulean Nation"
	desc = "The foundations of this banner stretch back almost a millennium, devised by the first King among the Azulean people to unite them under it. \n\
		Dark blue, representing the seas of Azulean worlds, and light blue, representing the seas inbetween. \
		Both make waves on each other, but both are pulled in and swallowed by all of the people of Agurkrral coming together as one; as one violent, restless maelstrom. \n\n\
		It's common to see this banner just about everywhere in both the Old and New Principalities, reminding all of their purpose and unity."
	icon_state = "flag_azulea"
	item_flag = /obj/item/sign/flag/azulea

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/azulea, 32)

/// Please, for the love of God, use this in Black Mesa ONLY. NOWHERE ELSE. It's the only reason it was allowed in the game.
/obj/structure/sign/flag/usa
	name = "flag of the United States of America"
	desc = "'Stars and Stripes', the flag of the United States of America. Its red color represents endurance and valor; blue one shows diligence, vigilance and justice, and the white one signs at pureness. Its thirteen red-and-white stripes show the initial thirteen founding colonies, and fifty stars designate the current fifty states."
	icon_state = "flag_usa"
	item_flag = /obj/item/sign/flag/usa

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/flag/usa, 32)

/obj/structure/sign/flag/syndicate
	name = "flag of the Syndicate"
	desc = "The flag of the Sothran Syndicate. Previously used by the Sothran people as a way of declaring opposition against the Nanotrasen, now it became an intergalactic symbol of the same, yet way more skewed purpose, as more groups of interest have joined the rebellion's side for their own gain."
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

///Since all of the signs rotate themselves on initialisation, this made folded flags look ugly (and more importantly rotated).
///And thus, it gets removed to make them aesthetically pleasing once again.
/obj/item/sign/flag/Initialize(mapload)
	. = ..()
	var/matrix/rotation_reset = matrix()
	rotation_reset.Turn(0)
	transform = rotation_reset

/obj/item/sign/flag/welder_act(mob/living/user, obj/item/I)
	return

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
	name = "folded flag of the Sol Federation"
	desc = "The folded flag of Sol Federation."
	icon_state = "folded_solfed"
	sign_path = /obj/structure/sign/flag/terragov

/obj/item/sign/flag/tizira
	name = "folded flag of the Republic of Northern Moghes"
	desc = "The folded flag of the Republic of Northern Moghes."
	icon_state = "folded_tizira"
	sign_path = /obj/structure/sign/flag/tizira

/obj/item/sign/flag/mothic
	name = "folded flag of the Grand Nomad Fleet"
	desc = "The folded flag of the Grand Nomad Fleet."
	icon_state = "folded_mothic"
	sign_path = /obj/structure/sign/flag/mothic

/obj/item/sign/flag/mars
	name = "folded flag of the Teshari League for Self-Determination"
	desc = "The folded flag of the Teshari League for Self-Determination."
	icon_state = "folded_mars"
	sign_path = /obj/structure/sign/flag/mars

/obj/item/sign/flag/nri
	name = "folded flag of the Novaya Rossiyskaya Imperiya"
	desc = "The folded flag of the Novaya Rossiyskaya Imperiya."
	icon_state = "folded_nri"
	sign_path = /obj/structure/sign/flag/nri

/obj/item/sign/flag/azulea
	name = "folded flag of Azulea"
	desc = "The folded flag of the Akulan nation Azulea."
	icon_state = "folded_azulea"
	sign_path = /obj/structure/sign/flag/azulea

/// Please, for the love of God, use this in Black Mesa ONLY. NOWHERE ELSE. It's the only reason it was allowed in the game.
/obj/item/sign/flag/usa
	name = "folded flag of the United States of America"
	desc = "The folded flag of the United States of America."
	icon_state = "folded_usa"
	sign_path = /obj/structure/sign/flag/usa

/obj/item/sign/flag/syndicate
	name = "folded flag of the Syndicate"
	desc = "The folded flag of the Sothran Syndicate."
	icon_state = "folded_syndi"
	sign_path = /obj/structure/sign/flag/syndicate
