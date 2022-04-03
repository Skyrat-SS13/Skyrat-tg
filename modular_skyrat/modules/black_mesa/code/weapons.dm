/obj/item/crowbar/freeman
	name = "blood soaked crowbar"
	desc = "A heavy handed crowbar, it drips with blood."
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/freeman.dmi'
	icon_state = "crowbar"
	force = 35
	throwforce = 45
	toolspeed = 0.1
	wound_bonus = 10
	hitsound = 'modular_skyrat/master_files/sound/weapons/crowbar2.ogg'
	mob_throw_hit_sound = 'modular_skyrat/master_files/sound/weapons/crowbar2.ogg'
	force_opens = TRUE

/obj/item/crowbar/freeman/ultimate
	name = "\improper Freeman's Crowbar"
	desc = "A weapon wielded by an ancient physicist, the blood of hundreds seeps through this rod of iron and malice."
	force = 45

/obj/item/crowbar/freeman/ultimate/Initialize(mapload)
	. = ..()
	add_filter("rad_glow", 2, list("type" = "outline", "color" = "#fbff1479", "size" = 2))
