/obj/item/ammo_box/advanced
	w_class = WEIGHT_CLASS_BULKY
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/datum/techweb_node/peacekeeper_ammo
	id = "advanced_peacekeeper_ammo"
	display_name = "Advanced Peaeckeeper Ammunition"
	description = "Alternate round types for the peacekeeper weapon designs."
	prereq_ids = list("weaponry"  , "adv_weaponry")
	design_ids = list("b6mm_ihdf","b9mm_hollowpoint","b9mm_ihdf","b10mm_hollowpoint","b10mm_ihdf","b12mm_hollowpoint")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 4000)

/datum/techweb_node/peacekeeper_ammo_advanced
	display_name = "Experimental SMARTGUN Ammunition"
	description = "Standard ammo for a non-standard SMARTGUN."
	prereq_ids = list("weaponry"  , "adv_weaponry", "advanced_peacekeeper_ammo")
	design_ids = list("smartgun")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3000)

//////////////////////
//6mm
//////////////////////
/datum/design/b6mm
	name = "Peacekeeper Ammo Box (6mm)"
	id = "b6mm"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 30000)
	build_path = /obj/item/ammo_box/advanced/b6mm
	category = list("intial", "Security", "Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/obj/item/ammo_box/advanced/b6mm
	name = "peacekeeper ammo box (6mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box10mm"
	ammo_type = /obj/item/ammo_casing/b6mm
	max_ammo = 30

/datum/design/b6mm/rubber
	name = "Peacekeeper Ammo Box (6mm rubber)"
	id = "b6mm_rubber"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 15000)
	build_path = /obj/item/ammo_box/advanced/b6mm/rubber
	category = list("intial", "Security", "Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/obj/item/ammo_box/advanced/b6mm/rubber
	name = "ammo box (6mm rubber)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box10mm-rubber"
	ammo_type = /obj/item/ammo_casing/b6mm/rubber

/datum/design/b6mm/ihdf
	name = "Peacekeeper Ammo Box (6mm ihdf)"
	id = "b6mm_ihdf"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 15000, /datum/material/gold = 15000)
	build_path = /obj/item/ammo_box/advanced/b6mm/ihdf
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/obj/item/ammo_box/advanced/b6mm/ihdf
	name = "peacekeeper ammo box (6mm ihdf)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box10mm-hv"
	ammo_type = /obj/item/ammo_casing/b6mm/ihdf

//////////////////////
//9mm
//////////////////////
/datum/design/b9mm
	name = "Peacekeeper Ammo Box (9mm)"
	id = "b9mm"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 30000)
	build_path = /obj/item/ammo_box/advanced/b9mm
	category = list("intial", "Security", "Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/obj/item/ammo_box/advanced/b9mm
	name = "peacekeeper ammo box (9mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "pistol_l"
	ammo_type = /obj/item/ammo_casing/b9mm
	max_ammo = 30

/datum/design/b9mm/rubber
	name = "Peacekeeper Ammo Box (9mm rubber)"
	id = "b9mm_rubber"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 15000)
	build_path = /obj/item/ammo_box/advanced/b9mm/rubber
	category = list("intial", "Security", "Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/obj/item/ammo_box/advanced/b9mm/rubber
	name = "ammo box (9mm rubber)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "pistol_r"
	ammo_type = /obj/item/ammo_casing/b9mm/rubber

/datum/design/b9mm/hp
	name = "Peacekeeper Ammo Box (9mm hollowpoint)"
	id = "b9mm_hollowpoint"
	build_type = PROTOLATHE
	materials = list(/datum/material/silver = 10000, /datum/material/iron = 10000, /datum/material/glass = 10000)
	build_path = /obj/item/ammo_box/advanced/b9mm/hp
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/obj/item/ammo_box/advanced/b9mm/hp
	name = "peacekeeper ammo box (9mm hollowpoint)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "pistol"
	ammo_type = /obj/item/ammo_casing/b9mm/hp

/datum/design/b9mm/ihdf
	name = "Peacekeeper Ammo Box (9mm ihdf)"
	id = "b9mm_ihdf"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 15000, /datum/material/gold = 15000)
	build_path = /obj/item/ammo_box/advanced/b9mm/ihdf
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/obj/item/ammo_box/advanced/b9mm/ihdf
	name = "peacekeeper ammo box (9mm ihdf)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "pistol_hv"
	ammo_type = /obj/item/ammo_casing/b9mm/ihdf

//////////////////////
//10mm
//////////////////////
/datum/design/b10mm
	name = "Peacekeeper Ammo Box (10mm)"
	id = "b10mm"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 30000)
	build_path = /obj/item/ammo_box/advanced/b10mm
	category = list("intial", "Security", "Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/obj/item/ammo_box/advanced/b10mm
	name = "peacekeeper ammo box (10mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box50"
	ammo_type = /obj/item/ammo_casing/b10mm
	max_ammo = 30

/datum/design/b10mm/rubber
	name = "Peacekeeper Ammo Box (10mm rubber)"
	id = "b10mm_rubber"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 15000)
	build_path = /obj/item/ammo_box/advanced/b10mm/rubber
	category = list("intial", "Security", "Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/obj/item/ammo_box/advanced/b10mm/rubber
	name = "peacekeeper ammo box (10mm rubber)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box50-rubber"
	ammo_type = /obj/item/ammo_casing/b10mm/rubber

/datum/design/b10mm/hp
	name = "Peacekeeper Ammo Box (10mm hollowpoint)"
	id = "b10mm_hollowpoint"
	build_type = PROTOLATHE
	materials = list(/datum/material/silver = 10000, /datum/material/iron = 10000, /datum/material/glass = 10000)
	build_path = /obj/item/ammo_box/advanced/b10mm/hp
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/obj/item/ammo_box/advanced/b10mm/hp
	name = "peacekeeper ammo box (10mm hollowpoint)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box50-lethal"
	ammo_type = /obj/item/ammo_casing/b10mm/hp

/datum/design/b10mm/ihdf
	name = "Peacekeeper Ammo Box (10mm ihdf)"
	id = "b10mm_ihdf"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 15000, /datum/material/gold = 15000)
	build_path = /obj/item/ammo_box/advanced/b10mm/ihdf
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/obj/item/ammo_box/advanced/b10mm/ihdf
	name = "peacekeeper ammo box (10mm ihdf)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box50-hv"
	ammo_type = /obj/item/ammo_casing/b10mm/ihdf

//////////////////////
//12mm
//////////////////////
/datum/design/b12mm
	name = "Peacekeeper Ammo Box (12mm)"
	id = "b12mm"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 30000)
	build_path = /obj/item/ammo_box/advanced/b12mm
	category = list("intial", "Security", "Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/obj/item/ammo_box/advanced/b12mm
	name = "peacekeeper ammo box (12mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "magnum_l"
	ammo_type = /obj/item/ammo_casing/b12mm
	max_ammo = 15

/datum/design/b12mm/rubber
	name = "Peacekeeper Ammo Box (12mm rubber)"
	id = "b12mm_rubber"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 15000)
	build_path = /obj/item/ammo_box/advanced/b12mm/rubber
	category = list("intial", "Security", "Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/obj/item/ammo_box/advanced/b12mm/rubber
	name = "peacekeeper ammo box (12mm rubber)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "magnum_r"
	ammo_type = /obj/item/ammo_casing/b12mm/rubber

/datum/design/b12mm/hp
	name = "Peacekeeper Ammo Box (12mm hollowpoint)"
	id = "b12mm_hollowpoint"
	build_type = PROTOLATHE
	materials = list(/datum/material/silver = 10000, /datum/material/iron = 10000, /datum/material/glass = 10000)
	build_path = /obj/item/ammo_box/advanced/b12mm/hp
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/obj/item/ammo_box/advanced/b12mm/hp
	name = "peacekeeper ammo box (12mm hollowpoint)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "magnum_p"
	ammo_type = /obj/item/ammo_casing/b12mm/hp

//////////////////////
//SMARTGUN
//////////////////////
/datum/design/smartgun
	name = "Peacekeeper Ammo Box (SMARTGUN)"
	id = "smartgun"
	build_type = PROTOLATHE
	materials = list(/datum/material/silver = 10000, /datum/material/gold = 10000, /datum/material/glass = 10000)
	build_path = /obj/item/ammo_box/advanced/smartgun
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/obj/item/ammo_box/advanced/smartgun
	name = "peacekeeper ammo box (smartgun)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "smartgun_chain"
	ammo_type = /obj/item/ammo_casing/smartgun
	multiple_sprites = AMMO_BOX_PER_BULLET
	max_ammo = 4

////////////////////
//MULTI SPRITE MAGS
///////////////////
/obj/item/ammo_box/magazine/multi_sprite
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	desc = "An advanced magazine with smart type displays. Alt+click to reskin it."
	w_class = WEIGHT_CLASS_SMALL
	item_flags = NO_MAT_REDEMPTION
	var/round_type = AMMO_TYPE_LETHAL
	var/base_name = ""
	var/list/possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_HOLLOWPOINT, AMMO_TYPE_RUBBER, AMMO_TYPE_IHDF)

/obj/item/ammo_box/magazine/multi_sprite/Initialize()
	. = ..()
	base_name = name
	name = "[base_name] [round_type]"
	update_icon()

/obj/item/ammo_box/magazine/multi_sprite/AltClick(mob/user)
	. = ..()
	var/new_type = input("Please select a magazine type to reskin to:", "Reskin", null, null) as null|anything in sortList(possible_types)
	if(!new_type)
		new_type = AMMO_TYPE_LETHAL
	round_type = new_type
	name = "[base_name] [round_type]"
	update_icon()

/obj/item/ammo_box/magazine/multi_sprite/update_icon()
	. = ..()
	var/shells_left = stored_ammo.len
	switch(multiple_sprites)
		if(AMMO_BOX_PER_BULLET)
			icon_state = "[initial(icon_state)]_[round_type]-[shells_left]"
		if(AMMO_BOX_FULL_EMPTY)
			icon_state = "[initial(icon_state)]_[round_type]-[shells_left ? "[max_ammo]" : "0"]"
		if(AMMO_BOX_FULL_EMPTY_BASIC)
			icon_state = "[initial(icon_state)]_[round_type]-[shells_left ? "full" : "empty"]"
	desc = "[initial(desc)] There [(shells_left == 1) ? "is" : "are"] [shells_left] shell\s left!"
	if(length(bullet_cost))
		var/temp_materials = custom_materials.Copy()
		for (var/material in bullet_cost)
			var/material_amount = bullet_cost[material]
			material_amount = (material_amount*stored_ammo.len) + base_cost[material]
			temp_materials[material] = material_amount
		set_custom_materials(temp_materials)

/obj/item/ammo_box/revolver
	name = "speed loader"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	desc = "Designed to quickly reload revolvers."
	icon_state = "speedloader"
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	var/round_type = AMMO_TYPE_LETHAL
	var/list/possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_HOLLOWPOINT, AMMO_TYPE_RUBBER, AMMO_TYPE_IHDF)
	start_empty = TRUE //SOmething strange going on with refills.

/obj/item/ammo_box/revolver/AltClick(mob/user)
	. = ..()
	var/new_type = input("Please select a magazine type to reskin to:", "Reskin", null, null) as null|anything in sortList(possible_types)
	if(!new_type)
		new_type = AMMO_TYPE_LETHAL
	round_type = new_type
	name = "[initial(name)] [round_type]"
	update_appearance()

/obj/item/ammo_box/revolver/update_overlays()
	. = ..()
	if(stored_ammo.len)
		. += "[initial(icon_state)]_[round_type]"
