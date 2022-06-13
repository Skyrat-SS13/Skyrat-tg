/datum/martial_art/cqc/plus
	name = "CQC+"
	id = MARTIALART_CQC_PLUS
	block_chance = 85

/datum/martial_art/cqc/plus/on_projectile_hit(mob/living/hit_mob, obj/projectile/fired_projectile, def_zone)
	. = ..()
	if(hit_mob.incapacitated(FALSE, TRUE)) // NO STUN
		return BULLET_ACT_HIT
	if(!(hit_mob.mobility_flags & MOBILITY_USE)) // NO UNABLE TO USE
		return BULLET_ACT_HIT
	var/datum/dna/dna = hit_mob.has_dna()
	if(dna?.check_mutation(/datum/mutation/human/hulk)) // NO HULK
		return BULLET_ACT_HIT
	if(!isturf(hit_mob.loc)) // NO MOTHERFLIPPIN MECHS!
		return BULLET_ACT_HIT
	if(hit_mob.throw_mode)
		hit_mob.visible_message(span_danger("[hit_mob] effortlessly swats the projectile aside! They can block bullets with their bare hands!"), span_userdanger("You deflect the projectile!"))
		playsound(get_turf(hit_mob), pick('sound/weapons/bulletflyby.ogg', 'sound/weapons/bulletflyby2.ogg', 'sound/weapons/bulletflyby3.ogg'), 75, TRUE)
		fired_projectile.firer = hit_mob
		fired_projectile.set_angle(rand(0, 360))// SHING
		return BULLET_ACT_FORCE_PIERCE
	return BULLET_ACT_HIT

/obj/item/book/granter/martial/cqc/plus
	martial = /datum/martial_art/cqc/plus
	name = "old but gold manual"
	martialname = "close quarters combat plus"
	desc = "A small, black manual. There are drawn instructions of tactical hand-to-hand combat. This includes how to deflect projectiles too."
	greet = span_boldannounce("You've mastered the basics of CQC+.")
