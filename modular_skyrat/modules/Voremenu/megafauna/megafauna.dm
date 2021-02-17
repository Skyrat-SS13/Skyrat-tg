/mob/living/simple_animal/hostile/megafauna/AttackingTarget()
	if(recovery_time >= world.time)
		return
	. = ..()
	if(. && isliving(target))
		var/mob/living/L = target
		if(L.stat != DEAD)
			if(!client && ranged && ranged_cooldown <= world.time)
				OpenFire()
			if(L.Adjacent(src) && (L.stat != CONSCIOUS))
				if(vore_active && CHECK_BITFIELD(L.vore_flags,DEVOURABLE))
					vore_attack(src,L,src)
					LoseTarget()
		else
			devour(L)
