// -------------- Sickshot -------------
/obj/item/gun/energy/sickshot
	name = "\improper MPA6 \'Sickshot\'"
	desc = "A device that can trigger convusions in specific areas to eject foreign material from a host. Must be used very close to a target. Not for Combat usage."

	icon_state = "dragnet"
	item_state = "dragnet"
	ammo_x_offset = 1
	ammo_type = list(/obj/item/ammo_casing/energy/sickshot)

/obj/item/ammo_casing/energy/sickshot
	projectile_type = /obj/item/projectile/sickshot
	e_cost = 100

//Projectile
/obj/item/projectile/sickshot
	name = "sickshot pulse"
	icon_state = "e_netting"
	damage = 0
	damage_type = STAMINA
	range = 2

/obj/item/projectile/sickshot/on_hit(var/atom/movable/target, var/blocked = 0)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/H = target
		if(prob(5))
			for(var/X in H.vore_organs)
				H.release_vore_contents()
				H.visible_message("<span class='danger'>[H] contracts strangely, spewing out contents on the floor!</span>", \
 						"<span class='userdanger'>You spew out everything inside you on the floor!</span>")
		return BULLET_ACT_HIT
