/obj/item/minespawner/explosive
	name = "deactivated explosive landmine"
	desc = "When activated, will deploy into a highly explosive mine after 3 seconds passes, perfect for lazy militarymen looking to cover their fortifications with no effort."
	icon = 'modular_skyrat/modules/aesthetics/landmine/mines.dmi'
	icon_state = "uglymine"

	mine_type = /obj/effect/mine/explosive

/obj/item/minespawner/explosive/nri

	mine_type = /obj/effect/mine/explosive/nri

/// A nerfed down version of a landmine I really should've done a long time ago but only did it now.
/obj/effect/mine/explosive/nri
	name = "explosive mine"
	range_devastation = 0
	range_heavy = 0
	range_light = 2
	range_flame = 1
	range_flash = 3
	/// Stun time after an activation.
	var/stun_time = 100

/obj/effect/mine/explosive/nri/mineEffect(mob/living/victim)
	explosion(src, range_devastation, range_heavy, range_light, range_flame, range_flash)
	if(isliving(victim))
		victim.Paralyze(stun_time)
