//////////////////////9MM
/datum/design/b9mm
	name = "Ammo Box (9mm)"
	id = "b9mm"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 30000)
	build_path = /obj/item/ammo_box/b9mm
	category = list("hacked", "Security")

/obj/item/ammo_box/b9mm
	name = "ammo box (9mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "pistol_l"
	ammo_type = /obj/item/ammo_casing/b9mm
	max_ammo = 30

/datum/design/b9mm/rubber
	name = "Ammo Box (9mm rubber)"
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
	name = "Ammo Box (9mm hollowpoint)"
	id = "b9mm_hp"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 15000)
	build_path = /obj/item/ammo_box/b9mm/hp
	category = list("hacked", "Security")

/obj/item/ammo_box/b9mm/hp
	name = "ammo box (9mm hollowpoint)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "pistol"
	ammo_type = /obj/item/ammo_casing/b9mm/hp
	max_ammo = 30

/datum/design/b9mm/ihdf
	name = "Ammo Box (9mm ihdf)"
	id = "b9mm_ihdf"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 15000)
	build_path = /obj/item/ammo_box/b9mm/ihdf
	category = list("hacked", "Security")

/obj/item/ammo_box/b9mm/ihdf
	name = "ammo box (9mm ihdf)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "pistol_hv"
	ammo_type = /obj/item/ammo_casing/b9mm/ihdf
	max_ammo = 30

//////////////////////10MM
/datum/design/b10mm
	name = "Ammo Box (10mm)"
	id = "b10mm"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 30000)
	build_path = /obj/item/ammo_box/b10mm
	category = list("hacked", "Security")

/obj/item/ammo_box/b10mm
	name = "ammo box (10mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box50"
	ammo_type = /obj/item/ammo_casing/b10mm
	max_ammo = 30

/datum/design/b10mm/rubber
	name = "Ammo Box (10mm rubber)"
	id = "b10mm_r"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 15000)
	build_path = /obj/item/ammo_box/b10mm/rubber
	category = list("Security")

/obj/item/ammo_box/b10mm/rubber
	name = "ammo box (10mm rubber)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box50-rubber"
	ammo_type = /obj/item/ammo_casing/b10mm/rubber
	max_ammo = 30

/datum/design/b10mm/hp
	name = "Ammo Box (10mm hollowpoint)"
	id = "b10mm_hp"
	build_type = PROTOLATHE
	materials = list(/datum/material/silver = 10000, /datum/material/iron = 10000, /datum/material/glass = 10000)
	build_path = /obj/item/ammo_box/b10mm/hp
	category = list("hacked", "Security")

/obj/item/ammo_box/b10mm/hp
	name = "ammo box (10mm hollowpoint)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box50-lethal"
	ammo_type = /obj/item/ammo_casing/b10mm/hp
	max_ammo = 30

/datum/design/b10mm/ihdf
	name = "Ammo Box (10mm ihdf)"
	id = "b10mm_ihdf"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 15000, /datum/material/gold = 15000)
	build_path = /obj/item/ammo_box/b10mm/ihdf
	category = list("hacked", "Security")

/obj/item/ammo_box/b10mm/ihdf
	name = "ammo box (10mm ihdf)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammoboxes.dmi'
	icon_state = "box50-hv"
	ammo_type = /obj/item/ammo_casing/b10mm/ihdf
	max_ammo = 30
