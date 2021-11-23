/obj/item/ammo_casing/energy/laser/advanced
	name = "advanced energy lens"
	projectile_type = /obj/projectile/beam/laser/hardlight_bullet
	e_cost = 83 // 12 shots with a normal cell.
	select_name = "laser"
	fire_sound = 'sound/weapons/gun/pistol/shot.ogg'

 // Not a real bullet, but visually looks like one. For the aesthetic of bullets, while keeping the balance intact.
 // Every piece of armor in the game is currently balanced around "sec has lasers, syndies have bullets". This allows us to keep that balance
 // without sacrificing the bullet aesthetic.
/obj/projectile/beam/laser/advanced
	name = "laser"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/projectiles.dmi'
