/obj/item/ammo_casing/energy/laser/advanced
	name = "advanced energy lens"
	projectile_type = /obj/projectile/beam/laser/advanced
	e_cost = 100 // 10 shots with a normal cell.
	select_name = "laser"
	fire_sound = 'modular_skyrat/modules/microfusion/sound/incinerate.ogg'

 // Not a real bullet, but visually looks like one. For the aesthetic of bullets, while keeping the balance intact.
 // Every piece of armor in the game is currently balanced around "sec has lasers, syndies have bullets". This allows us to keep that balance
 // without sacrificing the bullet aesthetic.
/obj/projectile/beam/laser/advanced
	name = "laser"
	icon = 'modular_skyrat/modules/microfusion/icons/projectiles.dmi'
