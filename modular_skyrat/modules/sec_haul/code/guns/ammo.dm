/obj/item/ammo_box/advanced
	w_class = WEIGHT_CLASS_BULKY
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/datum/techweb_node/peacekeeper_ammo_advanced
	display_name = "Experimental SMARTGUN Ammunition"
	description = "Standard ammo for a non-standard SMARTGUN."
	prereq_ids = list("weaponry"  , "adv_weaponry", "advanced_peacekeeper_ammo")
	design_ids = list("smartgun")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3000)

//////////////////////
//6mm
//////////////////////

/obj/item/ammo_box/advanced/b6mm
	name = "peacekeeper ammo box (6mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box10mm"
	ammo_type = /obj/item/ammo_casing/b6mm
	max_ammo = 30

/obj/item/ammo_box/advanced/b6mm/rubber
	name = "ammo box (6mm rubber)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box10mm-rubber"
	ammo_type = /obj/item/ammo_casing/b6mm/rubber

/obj/item/ammo_box/advanced/b6mm/ihdf
	name = "peacekeeper ammo box (6mm ihdf)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box10mm-hv"
	ammo_type = /obj/item/ammo_casing/b6mm/ihdf

//////////////////////
//9mm
//////////////////////

/obj/item/ammo_box/advanced/b9mm
	name = "peacekeeper ammo box (9mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "pistol_l"
	ammo_type = /obj/item/ammo_casing/b9mm
	max_ammo = 30

/obj/item/ammo_box/advanced/b9mm/hp
	name = "peacekeeper ammo box (9mm hollowpoint)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "pistol"
	ammo_type = /obj/item/ammo_casing/b9mm/hp

/obj/item/ammo_box/advanced/b9mm/rubber
	name = "ammo box (9mm rubber)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "pistol_r"
	ammo_type = /obj/item/ammo_casing/b9mm/rubber

/obj/item/ammo_box/advanced/b9mm/ihdf
	name = "peacekeeper ammo box (9mm ihdf)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "pistol_hv"
	ammo_type = /obj/item/ammo_casing/b9mm/ihdf

//////////////////////
//10mm
//////////////////////

/obj/item/ammo_box/advanced/b10mm
	name = "peacekeeper ammo box (10mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box50"
	ammo_type = /obj/item/ammo_casing/b10mm
	max_ammo = 30

/obj/item/ammo_box/advanced/b10mm/hp
	name = "peacekeeper ammo box (10mm hollowpoint)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box50-lethal"
	ammo_type = /obj/item/ammo_casing/b10mm/hp

/obj/item/ammo_box/advanced/b10mm/rubber
	name = "peacekeeper ammo box (10mm rubber)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box50-rubber"
	ammo_type = /obj/item/ammo_casing/b10mm/rubber

/obj/item/ammo_box/advanced/b10mm/ihdf
	name = "peacekeeper ammo box (10mm ihdf)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box50-hv"
	ammo_type = /obj/item/ammo_casing/b10mm/ihdf

//////////////////////
//12mm
//////////////////////

/obj/item/ammo_box/advanced/b12mm
	name = "peacekeeper ammo box (12mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "magnum_l"
	ammo_type = /obj/item/ammo_casing/b12mm
	max_ammo = 15

/obj/item/ammo_box/advanced/b12mm/rubber
	name = "peacekeeper ammo box (12mm rubber)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "magnum_r"
	ammo_type = /obj/item/ammo_casing/b12mm/rubber

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
	if(possible_types.len <= 1)
		return
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
