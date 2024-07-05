/*
*	QM Sporter Rifle
*/

/obj/item/gun/ballistic/rifle/boltaction/sporterized
	name = "\improper Rengo Precision Rifle"
	desc = "A heavily modified Sakhno rifle, parts made by Xhihao light arms based around Jupiter herself. \
		Has a higher capacity than standard Sakhno rifles, fitting ten .310 cartridges."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/xhihao_light_arms/guns40x.dmi'
	icon_state = "rengo"
	worn_icon_state = "enchanted_rifle" // Not actually magical looking, just looks closest to this one
	inhand_icon_state = "enchanted_rifle"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/bubba
	can_be_sawn_off = FALSE

/obj/item/gun/ballistic/rifle/boltaction/sporterized/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/scope, range_modifier = 1.5)

/obj/item/gun/energy/recharge/ebow/add_bayonet_point()
	AddComponent(/datum/component/bayonet_attachable, offset_x = 35)

/obj/item/gun/ballistic/rifle/boltaction/sporterized/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_XHIHAO)

/obj/item/gun/ballistic/rifle/boltaction/sporterized/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")

/obj/item/gun/ballistic/rifle/boltaction/sporterized/examine_more(mob/user)
	. = ..()

	. += "The Xhihao 'Rengo' conversion rifle. Came as parts sold in a single kit by Xhihao Light Arms, \
		which can be swapped out with many of the outdated or simply old parts on a typical Sakhno rifle. \
		While not necessarily increasing performance in any way, the magazine is slightly longer. The weapon \
		is also overall a bit shorter, making it easier to handle for some people. Cannot be sawn off, cutting \
		really any part of this weapon off would make it non-functional."

	return .

/obj/item/gun/ballistic/rifle/boltaction/sporterized/empty
	bolt_locked = TRUE // so the bolt starts visibly open
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/boltaction/bubba/empty

/obj/item/ammo_box/magazine/internal/boltaction/bubba
	name = "Sakhno extended internal magazine"
	desc = "How did you get it out?"
	ammo_type = /obj/item/ammo_casing/strilka310
	caliber = CALIBER_STRILKA310
	max_ammo = 8

/obj/item/ammo_box/magazine/internal/boltaction/bubba/empty
	start_empty = TRUE

/*
*	Box that contains Sakhno rifles, but less soviet union since we don't have one of those
*/

/obj/item/storage/toolbox/guncase/soviet/sakhno
	desc = "A weapon's case. This one is green and looks pretty old, but is otherwise in decent condition."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/cases.dmi'
	material_flags = NONE // ????? Why do these have materials enabled??
