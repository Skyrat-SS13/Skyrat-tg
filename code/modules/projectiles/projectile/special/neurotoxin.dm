/obj/projectile/neurotoxin
	name = "neurotoxin spit"
	icon_state = "neurotoxin"
	//damage = 5		// SKYRAT EDIT: Original line.
	//damage_type = TOX	// SKYRAT EDIT: Original line.
	damage = 50
	damage_type = STAMINA
	nodamage = TRUE		// SKYRAT EDIT: Original line.
	//nodamage = FALSE	// SKYRAT EDIT
	//paralyze = 100	// SKYRAT EDIT: Original line.
	paralyze = 5		// SKYRAT EDIT
	knockdown = 10		// SKYRAT EDIT
	flag = BIO
	impact_effect_type = /obj/effect/temp_visual/impact_effect/neurotoxin

/obj/projectile/neurotoxin/on_hit(atom/target, blocked = FALSE)
	if(isalien(target))
		paralyze = 0
		nodamage = TRUE
	return ..()
