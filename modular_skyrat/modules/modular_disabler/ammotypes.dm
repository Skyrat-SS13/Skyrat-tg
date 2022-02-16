/obj/item/ammo_casing/energy/
	var/upper_reload_speed = 25
	var/lower_reload_speed = 15

/obj/item/ammo_casing/energy/disabler/skyrat/ // Now 100% more modular! (Code-wise and ingame-wise!)
	e_cost = 1000
	projectile_type = /obj/projectile/beam/disabler/weak

/obj/item/ammo_casing/energy/disabler/skyrat/proto // Base two shot per reload ammo type.
	e_cost = 10000
	upper_reload_speed = 25
	lower_reload_speed = 15

/obj/item/ammo_casing/energy/disabler/skyrat/proto/bounce
	e_cost = 10000
	select_name = SHOT_BOUNCE
	heavy_metal = TRUE // bouncy?
	upper_reload_speed = 25
	lower_reload_speed = 15

/obj/item/ammo_casing/energy/disabler/skyrat/proto/disgust // Disgust Ammo
	projectile_type = /obj/projectile/beam/disabler/disgust
	select_name = "disgust"
	e_cost = 10000
	upper_reload_speed = 30
	lower_reload_speed = 20

/obj/item/ammo_casing/energy/laser/hardlight_bullet/disabler // Hardlight Bullets (fun for the whole family!)
	var/damage = 25
	e_cost = 20000
	select_name  = SHOT_HARDLIGHT
	upper_reload_speed = 60
	lower_reload_speed = 20

/obj/item/ammo_casing/energy/laser/scatter/disabler/skyrat // Our split beam! Guaranteed no brutality!
	e_cost = 20000
	pellets = 2
	variance = 15
	harmful = FALSE
	upper_reload_speed = 50
	lower_reload_speed = 30

/obj/item/ammo_casing/energy/disabler/skyrat/proto/warcrime // Potential Traitor Ammo Type
	projectile_type = /obj/projectile/beam/disabler/warcrime
	select_name = SHOT_WARCRIME
	e_cost = 20000
	upper_reload_speed = 60
	lower_reload_speed = 30

/obj/item/ammo_casing/energy/disabler/skyrat/proto/drowsy
	projectile_type = /obj/projectile/beam/disabler/drowsy
	select_name = SHOT_DISGUST
	e_cost = 20000
	upper_reload_speed = 45
	lower_reload_speed = 30

/obj/item/ammo_casing/energy/disabler/skyrat/proto/hallucinate
	projectile_type = /obj/projectile/beam/disabler/hallucinate
	select_name = SHOT_HALLUCINATE
	heavy_metal = TRUE // bouncy?
	e_cost = 20000
	upper_reload_speed = 45
	lower_reload_speed = 30
