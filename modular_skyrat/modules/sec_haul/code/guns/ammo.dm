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
	name = "6.3mm ammo box"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box10mm"
	ammo_type = /obj/item/ammo_casing/b6mm
	max_ammo = 30

/obj/item/ammo_box/advanced/b6mm/rubber
	name = "6.3mm dissuasive pellet box"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box10mm-rubber"
	ammo_type = /obj/item/ammo_casing/b6mm/rubber

/obj/item/ammo_box/advanced/b6mm/ihdf
	name = "6.3mm fragmentation pellet box"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box10mm-hv"
	ammo_type = /obj/item/ammo_casing/b6mm/ihdf

//////////////////////
//9mm
//////////////////////

/obj/item/ammo_box/advanced/b9mm
	name = "9x19mm FMJ box"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "pistol_l"
	ammo_type = /obj/item/ammo_casing/b9mm
	max_ammo = 30

/obj/item/ammo_box/advanced/b9mm/hp
	name = "9x19mm JHP box"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "pistol"
	ammo_type = /obj/item/ammo_casing/b9mm/hp

/obj/item/ammo_box/advanced/b9mm/rubber
	name = "9x19mm Rubber box"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "pistol_r"
	ammo_type = /obj/item/ammo_casing/b9mm/rubber

/obj/item/ammo_box/advanced/b9mm/ihdf
	name = "9x19mm IHDF box"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "pistol_hv"
	ammo_type = /obj/item/ammo_casing/b9mm/ihdf

//////////////////////
//10mm
//////////////////////

/obj/item/ammo_box/advanced/b10mm
	name = "10mm Auto box"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box50"
	ammo_type = /obj/item/ammo_casing/b10mm
	max_ammo = 30

/obj/item/ammo_box/advanced/b10mm/hp
	name = "10mm Auto JHP box"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box50-lethal"
	ammo_type = /obj/item/ammo_casing/b10mm/hp

/obj/item/ammo_box/advanced/b10mm/rubber
	name = "10mm Auto Rubber box"
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
	name = "12.7x30mm FMJ box"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "magnum_l"
	ammo_type = /obj/item/ammo_casing/b12mm
	max_ammo = 15

/obj/item/ammo_box/advanced/b12mm/rubber
	name = "12.7x30mm Beanbag box"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "magnum_r"
	ammo_type = /obj/item/ammo_casing/b12mm/rubber

/obj/item/ammo_box/advanced/b12mm/hp
	name = "12.7x30mm JHP box"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "magnum_p"
	ammo_type = /obj/item/ammo_casing/b12mm/hp

//////////////////////
//SMARTGUN
//////////////////////
/datum/design/smartgun
	name = "\improper S.M.A.R.T. Rifle Shock-Rails"
	id = "smartgun"
	build_type = PROTOLATHE
	materials = list(/datum/material/silver = 10000, /datum/material/gold = 10000, /datum/material/glass = 10000)
	build_path = /obj/item/ammo_box/advanced/smartgun
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/obj/item/ammo_box/advanced/smartgun
	name = "5mm Shock-Rail box"
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
	var/list/possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_HOLLOWPOINT, AMMO_TYPE_RUBBER, AMMO_TYPE_IHDF, AMMO_TYPE_INCENDIARY, AMMO_TYPE_AP)

/obj/item/ammo_box/magazine/multi_sprite/Initialize()
	. = ..()
	base_name = name
	name = "[base_name] [round_type]"
	update_icon()

/obj/item/ammo_box/magazine/multi_sprite/AltClick(mob/user)
	. = ..()
	if(possible_types.len <= 1)
		return
	var/new_type = input("Please select a magazine type to reskin to:", "Reskin", null, null) as null|anything in sort_list(possible_types)
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
	var/new_type = input("Please select a magazine type to reskin to:", "Reskin", null, null) as null|anything in sort_list(possible_types)
	if(!new_type)
		new_type = AMMO_TYPE_LETHAL
	round_type = new_type
	name = "[initial(name)] [round_type]"
	update_appearance()

/obj/item/ammo_box/revolver/update_overlays()
	. = ..()
	if(stored_ammo.len)
		. += "[initial(icon_state)]_[round_type]"

////////////////////////////
///////////14 GAUGE/////////
////////////////////////////

/obj/item/ammo_casing/s14gauge
	name = "14 gauge shotgun slug"
	desc = "A 14 gauge lead slug."
	icon_state = "blshell"
	worn_icon_state = "shell"
	caliber = CALIBER_14GAUGE
	custom_materials = list(/datum/material/iron=2000)
	projectile_type = /obj/projectile/bullet/s14gauge_slug

/obj/item/ammo_casing/s14gauge/beanbag
	name = "14 gauge beanbag slug"
	desc = "A weak beanbag slug for riot control."
	icon_state = "bshell"
	custom_materials = list(/datum/material/iron=250)
	projectile_type = /obj/projectile/bullet/s14gauge_beanbag
	harmful = FALSE

/obj/item/ammo_casing/s14gauge/buckshot
	name = "14 gauge buckshot shell"
	desc = "A 14 gauge  buckshot shell."
	icon_state = "gshell"
	projectile_type = /obj/projectile/bullet/pellet/s14gauge_buckshot
	pellets = 5
	variance = 25

/obj/item/ammo_casing/s14gauge/rubbershot
	name = "14 gauge rubber shot"
	desc = "A shotgun casing filled with densely-packed rubber balls, used to incapacitate crowds from a distance."
	icon_state = "bshell"
	projectile_type = /obj/projectile/bullet/pellet/s14gauge_rubbershot
	pellets = 5
	variance = 25
	custom_materials = list(/datum/material/iron=4000)
	harmful = FALSE //SKYRAT EDIT ADDITION //What? This is our own file.

/obj/item/ammo_casing/s14gauge/stunslug
	name = "14 gauge taser slug"
	desc = "A stunning taser slug."
	icon_state = "stunshell"
	projectile_type = /obj/projectile/bullet/s14gauge_stunslug
	custom_materials = list(/datum/material/iron=500,/datum/material/gold=100)
	harmful = FALSE

/obj/item/storage/box/rubbershot_14gauge
	name = "box of 14 gauge rubber shots"
	desc = "A box full of rubber shots, designed for riot shotguns."
	icon_state = "secbox_xl"
	illustration = "rubbershot"

/obj/item/storage/box/rubbershot_14gauge/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_casing/s14gauge/rubbershot(src)

/obj/item/storage/box/lethalshot_14gauge
	name = "box of lethal 14 gauge shotgun shots"
	desc = "A box full of lethal shots, designed for riot shotguns."
	icon_state = "secbox_xl"
	illustration = "buckshot"

/obj/item/storage/box/lethalshot_14gauge/PopulateContents()
	for(var/i in 1 to 7)
		new /obj/item/ammo_casing/s14gauge/buckshot(src)

/obj/item/storage/box/beanbag_14gauge
	name = "box of 14 gauge beanbags"
	desc = "A box full of beanbag shells."
	icon_state = "secbox_xl"
	illustration = "beanbag"

/obj/item/storage/box/beanbag_14gauge/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_casing/s14gauge/beanbag(src)
