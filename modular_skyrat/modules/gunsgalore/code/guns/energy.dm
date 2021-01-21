/obj/item/gun/energy/laser
	name = "\improper Allstar SC-1 Laser Carbine"
	desc = "An energy-based laser carbine that fires concentrated beams of light which pass through glass and thin metal."
	cell_type = /obj/item/stock_parts/cell/upgraded //2500 now.

/obj/item/gun/energy/e_gun
	name = "\improper Allstar SC-2 Energy Carbine"
	desc = "A basic hybrid energy carbine with two settings: disable and kill."
	cell_type = /obj/item/stock_parts/cell/upgraded //2500 now.

/obj/projectile/beam/laser/accelerator
	damage = 30

/obj/item/gun/energy/lasercannon/afterattack(atom/target, mob/living/user, flag, params)
	playsound(src, 'modular_skyrat/modules/gunsgalore/sound/guns/fire/laser_cannon_charge.ogg', fire_sound_volume)
	to_chat(user, "<span class='notce'>You begin charging up a shot!</span>")
	if(!do_after(user, 6))
		to_chat(user, "<span class='warning'>You fail to fire the shot!</span>")
		return
	. = ..()
