/obj/item/gun/ballistic/automatic/hybrid
	name = "Experimental PDW"
	desc = "An experimental personal defense weapon designed to be able to switch between ballistic and energy-based ammo based on magazine"
	icon = 'modular_skyrat/modules/zosruin/icons/projectile.dmi'
	icon_state = "hybrid"
	inhand_icon_state = "arg"
	spawnwithmagazine = FALSE
	mag_type = /obj/item/ammo_box/magazine/hybrid
	fire_delay = 2
	can_suppress = FALSE
	burst_size = 0
	bolt_type = BOLT_TYPE_OPEN //this prevents someone from "accidentally" ejecting a loaded casing... From a gun with no cased bullets.
	actions_types = list()
	mag_display = TRUE
	mag_display_ammo = TRUE
	empty_indicator = TRUE
	casing_ejector = FALSE //this is 100% unneccisary but i'm gon' be honest, i thought this would fix the problem setting it to open bolt would.
