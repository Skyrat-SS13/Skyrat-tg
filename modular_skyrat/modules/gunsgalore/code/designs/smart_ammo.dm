/datum/techweb_node/peacekeeper_ammo_advanced
	display_name = "Experimental SMARTGUN Ammunition"
	description = "Standard ammo for a non-standard SMARTGUN."
	prereq_ids = list("weaponry"  , "adv_weaponry", "advanced_peacekeeper_ammo")
	design_ids = list("smartgun")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3000)

/datum/design/smartgun
	name = "\improper S.M.A.R.T. Rifle Shock-Rails"
	id = "smartgun"
	build_type = PROTOLATHE
	materials = list(/datum/material/silver = 10000, /datum/material/gold = 10000, /datum/material/glass = 10000)
	build_path = /obj/item/ammo_box/advanced/smartgun
	category = list(RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/obj/item/ammo_box/advanced/smartgun
	name = "5mm shock-rail box"
	icon = 'modular_skyrat/master_files/icons/obj/guns/ammoboxes.dmi'
	icon_state = "smartgun_chain"
	ammo_type = /obj/item/ammo_casing/smartgun
	multiple_sprites = AMMO_BOX_PER_BULLET
	max_ammo = 4
