/obj/projectile/bullet/p50
	name =".416 Stabilis bullet"
	speed = 0.2   //This means it's insanely fast, not insanely slow
	damage = 110  //You have 135 health, which does not make this an instant crit
	paralyze = 0 //Knocks you on your ass hard enough as-is, we won't need the paralyze stat
	dismemberment = 30
	armour_penetration = 61 //Bulletproof armor alone will not stop this
	wound_bonus = 90 //Theoretically guaranteed wound

/obj/projectile/bullet/p50/soporific
	name = ".416 Stabilis tranquilizer casing"
	damage_type = STAMINA
	dismemberment = 0
	catastropic_dismemberment = FALSE
	object_damage = 0

/obj/projectile/bullet/p50/soporific/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if((blocked != 100) && isliving(target))
		var/mob/living/living_guy = target
		living_guy.Sleeping(40 SECONDS) //Yes, its really 40 seconds of sleep, I hope you had your morning coffee.

