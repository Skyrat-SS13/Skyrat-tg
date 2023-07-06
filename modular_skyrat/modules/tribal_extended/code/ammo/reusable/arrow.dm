/obj/projectile/bullet/arrow
	var/faction_bonus_force = 0 //Bonus force dealt against certain factions
	var/list/nemesis_path //Any mob with a faction that exists in this list will take bonus damage/effects

/obj/projectile/bullet/arrow/prehit_pierce(mob/living/target, mob/living/carbon/human/user)
	if(istype(target, nemesis_path))
		damage += faction_bonus_force
	.=..()

/obj/projectile/bullet/arrow/ash
	name = "ashen arrow"
	desc = "An arrow made of hardened ash."
	faction_bonus_force = 60
	damage = 15//lower me to 20 or 15
	nemesis_path = /mob/living/simple_animal/hostile/asteroid
	projectile_type = /obj/item/ammo_casing/arrow/ash

/obj/projectile/bullet/arrow/bone
	name = "bone arrow"
	desc = "An arrow made from bone and sinew."
	faction_bonus_force = 35
	damage = 35
	armour_penetration = 20
	wound_bonus = -30
	nemesis_path = /mob/living/simple_animal/hostile/asteroid
	projectile_type = /obj/item/ammo_casing/arrow/bone
	embedding = list(embed_chance=33, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=5)

/obj/projectile/bullet/arrow/bronze
	name = "bronze arrow"
	desc = "A bronze-tipped arrow."
	faction_bonus_force = 90
	damage = 30
	armour_penetration = 30
	nemesis_path = /mob/living/simple_animal/hostile/megafauna
	projectile_type = /obj/item/ammo_casing/arrow/bronze
