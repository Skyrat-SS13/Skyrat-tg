//////////////////////9MM
/datum/design/b9mm
	name = "Peacekeeper Ammo Box (9mm)"
	id = "b9mm"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 30000)
	build_path = /obj/item/ammo_box/b9mm
	category = list("Security")

/obj/item/ammo_box/b9mm
	name = "peacekeeper ammo box (9mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "pistol_l"
	ammo_type = /obj/item/ammo_casing/b9mm
	max_ammo = 30
	weight

/datum/design/b9mm/rubber
	name = "Peacekeeper Ammo Box (9mm rubber)"
	id = "b9mm_r"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 15000)
	build_path = /obj/item/ammo_box/b9mm/rubber
	category = list("Security")

/obj/item/ammo_box/b9mm/rubber
	name = "ammo box (9mm rubber)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "pistol_r"
	ammo_type = /obj/item/ammo_casing/b9mm/rubber
	max_ammo = 30

/datum/design/b9mm/hp
	name = "Peacekeeper Ammo Box (9mm hollowpoint)"
	id = "b9mm_hp"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 15000)
	build_path = /obj/item/ammo_box/b9mm/hp
	category = list("hacked", "Security")

/obj/item/ammo_box/b9mm/hp
	name = "peacekeeper ammo box (9mm hollowpoint)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "pistol"
	ammo_type = /obj/item/ammo_casing/b9mm/hp
	max_ammo = 30

/datum/design/b9mm/ihdf
	name = "Peacekeeper Ammo Box (9mm ihdf)"
	id = "b9mm_ihdf"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 15000)
	build_path = /obj/item/ammo_box/b9mm/ihdf
	category = list("hacked", "Security")

/obj/item/ammo_box/b9mm/ihdf
	name = "peacekeeper ammo box (9mm ihdf)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "pistol_hv"
	ammo_type = /obj/item/ammo_casing/b9mm/ihdf
	max_ammo = 30

//////////////////////10MM
/datum/design/b10mm
	name = "Peacekeeper Ammo Box (10mm)"
	id = "b10mm"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 30000)
	build_path = /obj/item/ammo_box/b10mm
	category = list("Security")

/obj/item/ammo_box/b10mm
	name = "peacekeeper ammo box (10mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box50"
	ammo_type = /obj/item/ammo_casing/b10mm
	max_ammo = 30

/datum/design/b10mm/rubber
	name = "Peacekeeper Ammo Box (10mm rubber)"
	id = "b10mm_r"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 15000)
	build_path = /obj/item/ammo_box/b10mm/rubber
	category = list("Security")

/obj/item/ammo_box/b10mm/rubber
	name = "peacekeeper ammo box (10mm rubber)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box50-rubber"
	ammo_type = /obj/item/ammo_casing/b10mm/rubber
	max_ammo = 30

/datum/design/b10mm/hp
	name = "Peacekeeper Ammo Box (10mm hollowpoint)"
	id = "b10mm_hp"
	build_type = PROTOLATHE
	materials = list(/datum/material/silver = 10000, /datum/material/iron = 10000, /datum/material/glass = 10000)
	build_path = /obj/item/ammo_box/b10mm/hp
	category = list("hacked", "Security")

/obj/item/ammo_box/b10mm/hp
	name = "peacekeeper ammo box (10mm hollowpoint)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box50-lethal"
	ammo_type = /obj/item/ammo_casing/b10mm/hp
	max_ammo = 30

/datum/design/b10mm/ihdf
	name = "Peacekeeper Ammo Box (10mm ihdf)"
	id = "b10mm_ihdf"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 15000, /datum/material/gold = 15000)
	build_path = /obj/item/ammo_box/b10mm/ihdf
	category = list("hacked", "Security")

/obj/item/ammo_box/b10mm/ihdf
	name = "peacekeeper ammo box (10mm ihdf)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box50-hv"
	ammo_type = /obj/item/ammo_casing/b10mm/ihdf
	max_ammo = 30


////////////////////
//MULTI SPRITE MAGS
///////////////////
/obj/item/ammo_box/magazine
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/magazine/multi_sprite
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	desc = "An advanced magazine with smart type displays. Alt+click to reskin it."
	var/round_type = AMMO_TYPE_LETHAL
	var/base_name = ""
	var/list/possible_types = list("lethal" = AMMO_TYPE_LETHAL, "hollowpoint" = AMMO_TYPE_HOLLOWPOINT, "rubber" = AMMO_TYPE_RUBBER, "ihdf" = AMMO_TYPE_IHDF)

/obj/item/ammo_box/magazine/multi_sprite/Initialize()
	. = ..()
	base_name = name
	name = "[base_name] [round_type]"
	update_icon()

/obj/item/ammo_box/magazine/multi_sprite/AltClick(mob/user)
	. = ..()
	var/new_type = input("Please select a magazine type to reskin to:", "Reskin", null, null) as null|anything in sortList(possible_types)
	round_type = new_type
	name = "[base_name] [round_type]"
	update_icon()

/obj/item/ammo_box/magazine/multi_sprite/update_icon()
	var/shells_left = stored_ammo.len
	switch(multiple_sprites)
		if(AMMO_BOX_PER_BULLET)
			icon_state = "[initial(icon_state)]_[round_type]-[shells_left]"
		if(AMMO_BOX_FULL_EMPTY)
			icon_state = "[initial(icon_state)]_[round_type]-[shells_left ? "[max_ammo]" : "0"]"
	desc = "[initial(desc)] There [(shells_left == 1) ? "is" : "are"] [shells_left] shell\s left!"
	if(length(bullet_cost))
		var/temp_materials = custom_materials.Copy()
		for (var/material in bullet_cost)
			var/material_amount = bullet_cost[material]
			material_amount = (material_amount*stored_ammo.len) + base_cost[material]
			temp_materials[material] = material_amount
		set_custom_materials(temp_materials)
