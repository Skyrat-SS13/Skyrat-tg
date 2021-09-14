/obj/projectile/neurotoxin
	name = "neurotoxin spit"
	icon_state = "neurotoxin"
//	SKYRAT EDIT: Original Lines
//	damage = 5
//	damage_type = TOX
//	nodamage = FALSE
//	paralyze = 100
//	SKYRAT EDIT: START
	damage = 100
	damage_type = STAMINA
	nodamage = FALSE
	paralyze = 30
	knockdown = 100
//	SKYRAT EDIT: END
	flag = BIO
	impact_effect_type = /obj/effect/temp_visual/impact_effect/neurotoxin

/obj/projectile/neurotoxin/on_hit(atom/target, blocked = FALSE)
	if(isalien(target))
		paralyze = 0
		knockdown = 0	//SKYRAT EDIT
		damage = 0	//SKYRAT EDIT
		nodamage = TRUE
	return ..()
