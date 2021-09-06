/obj/item/storage/belt/military/rocket
	name = "rocket storage rig"
	desc = "A storage rig configured to hold up to seven of your most valued rockets!"
	icon_state = "explorer2"
	worn_icon_state = "explorer2"

/obj/item/storage/belt/military/rocket/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 7
	STR.display_numerical_stacking = TRUE
	STR.max_combined_w_class = 30
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.set_holdable(list(
		/obj/item/ammo_casing/caseless/rocket
		))

/obj/item/storage/belt/military/rocket/full/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_casing/caseless/rocket/smoke = 2,
		/obj/item/ammo_casing/caseless/rocket/sabot = 2,
		/obj/item/ammo_casing/caseless/rocket/smoke/phosphor = 1,
		/obj/item/ammo_casing/caseless/rocket/smoke/sleeping = 1,
		/obj/item/ammo_casing/caseless/rocket/emp = 1,
	), src)

/obj/item/ammo_casing/caseless/rocket/sabot
	name = "\improper BLUNT"
	desc = "One step away from an immovable rod."
	icon = 'modular_skyrat/modules/rocket-launcher/icon/rocketsec-ammo.dmi'
	icon_state = "84mm-sabot"
	projectile_type = /obj/projectile/bullet/a84mm/sabot
	w_class = WEIGHT_CLASS_BULKY

/obj/item/ammo_casing/caseless/rocket/emp
	name = "\improper GLEMPS"
	desc = "This rocket seems to be packed full of machinery and a special chemical mix that makes a large emp on impact."
	icon = 'modular_skyrat/modules/rocket-launcher/icon/rocketsec-ammo.dmi'
	icon_state = "84mm-emp"
	projectile_type = /obj/projectile/bullet/a84mm/emp
	w_class = WEIGHT_CLASS_BULKY

/obj/item/ammo_casing/caseless/rocket/smoke
	name = "\improper HVSD"
	desc = "The acronym stands for 'high velocity smoke deployment', surely that makes it non-lethal, right?"
	icon = 'modular_skyrat/modules/rocket-launcher/icon/rocketsec-ammo.dmi'
	icon_state = "84mm-smoke"
	projectile_type = /obj/projectile/bullet/a84mm/smoke
	w_class = WEIGHT_CLASS_BULKY

/obj/item/ammo_casing/caseless/rocket/smoke/phosphor
	name = "\improper HVWP"
	desc = "Good old fashioned white phosphorus, don't tell anyone that we still use these."
	icon = 'modular_skyrat/modules/rocket-launcher/icon/rocketsec-ammo.dmi'
	icon_state = "84mm-coldsmoke"
	projectile_type = /obj/projectile/bullet/a84mm/smoke/phosphor

/obj/item/ammo_casing/caseless/rocket/smoke/sleeping
	name = "\improper RCSD"
	desc = "It had a warning label, but it was covered by a big arrow pointing toward the tip that says, 'Graytide in this direction'."
	icon = 'modular_skyrat/modules/rocket-launcher/icon/rocketsec-ammo.dmi'
	icon_state = "84mm-sleepsmoke"
	projectile_type = /obj/projectile/bullet/a84mm/smoke/sleeping

/obj/item/ammo_box/magazine/internal/rocketlauncher/smoke
	ammo_type = /obj/item/ammo_casing/caseless/rocket/smoke

/obj/item/gun/ballistic/rocketlauncher/security
	name = "\improper Panzerfaust-99"
	desc = "A futuristic recreation of a classic problem solver..."
	icon = 'modular_skyrat/modules/rocket-launcher/icon/rocketlaunchersec.dmi'
	righthand_file = 'modular_skyrat/modules/rocket-launcher/icon/rocketsec-right.dmi'
	lefthand_file = 'modular_skyrat/modules/rocket-launcher/icon/rocketsec-left.dmi'
	icon_state = "rocketlauncher-sec"
	inhand_icon_state = "rocketlauncher-sec"
	pin = /obj/item/firing_pin/implant/mindshield
	mag_type = /obj/item/ammo_box/magazine/internal/rocketlauncher/smoke

/// Tacticool (Useless) ammo for the PML and subtypes
/obj/projectile/bullet/a84mm/sabot
	name = "\improper Panzerfaust-BLUNT"
	desc = "Pray this isn't coming straight at you."
	icon = 'modular_skyrat/modules/rocket-launcher/icon/rocketsec-project.dmi'
	icon_state = "84mm-sabot"
	damage = 150
	anti_armour_damage = 200
	wound_bonus = 50
	projectile_piercing = PASSMOB //Look up modern tank APFSDS shells to see why for this one
	ricochets_max = 5
	ricochet_chance = 120
	ricochet_auto_aim_range = 3
	ricochet_incidence_leeway = 70
	knockdown = 100

/obj/projectile/bullet/a84mm/sabot/do_boom(atom/target)
	explosion(target, flash_range = 2) //Shells so goddamn powerful, they create a flash of light with everything they impact

/obj/projectile/bullet/a84mm/emp
	name = "\improper GLEMPS missile"
	desc = "Point at ai, fire, pray."
	icon = 'modular_skyrat/modules/rocket-launcher/icon/rocketsec-project.dmi'
	icon_state = "84mm-emp"
	damage = 30
	anti_armour_damage = 0
	dismemberment = 0
	knockdown = 50

/obj/projectile/bullet/a84mm/emp/do_boom(atom/target)
	empulse(target, 2, 5)

/obj/projectile/bullet/a84mm/smoke
	name = "\improper HVSD missile"
	desc = "Tactically fast smoke in 30 minutes or its free!"
	icon = 'modular_skyrat/modules/rocket-launcher/icon/rocketsec-project.dmi'
	icon_state = "84mm-smoke"
	damage = 40 //Fuckin' ow dude, you just got direct hit by a rocket
	anti_armour_damage = 0
	dismemberment = 0 //You aren't going to be delimbed by a really fast smoke grenade
	knockdown = 100 //You have been direct hit by a missile

/obj/projectile/bullet/a84mm/smoke/do_boom(atom/target)
	playsound(src, 'sound/effects/smoke.ogg', 50, TRUE, -3)
	var/datum/effect_system/smoke_spread/bad/smoke = new
	smoke.set_up(7, src) //Big smoke, you're using a rocket for a reason
	smoke.start()
	qdel(smoke)

/obj/projectile/bullet/a84mm/smoke/phosphor
	name = "\improper HVWP missile"
	desc = "Nothing beats the smell."
	icon = 'modular_skyrat/modules/rocket-launcher/icon/rocketsec-project.dmi'
	icon_state = "84mm-coldsmoke"

/obj/projectile/bullet/a84mm/smoke/phosphor/do_boom(atom/target)
	playsound(src, 'sound/effects/smoke.ogg', 50, TRUE, -3)
	var/datum/effect_system/smoke_spread/freezing/smoke = new
	smoke.set_up(7, src)
	smoke.start()
	qdel(smoke)
	explosion(target, flame_range = 7, flash_range = 2)

/obj/projectile/bullet/a84mm/smoke/sleeping
	name = "\improper RCSD missile"
	desc = "What's this sleep gas stuff made of anyway?"
	icon = 'modular_skyrat/modules/rocket-launcher/icon/rocketsec-project.dmi'
	icon_state = "84mm-sleepsmoke"

/obj/projectile/bullet/a84mm/smoke/sleeping/do_boom(atom/target)
	playsound(src, 'sound/effects/smoke.ogg', 50, TRUE, -3)
	var/datum/effect_system/smoke_spread/sleeping/smoke = new
	smoke.set_up(5, src)
	smoke.start()
	qdel(smoke)

/datum/design/rocket
	name = "Panzerfaust-BLUNT"
	desc = "A special missile that doesn't need to explode."
	id = "rocket_sabot"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 7000, /datum/material/glass = 2000, /datum/material/plasma = 5000, /datum/material/silver = 3000)
	build_path = /obj/item/ammo_casing/caseless/rocket/sabot
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/rocket/emp
	name = "GLEMPS"
	desc = "Custom made missile that creates a large emp in the area it is fired upon."
	id = "rocket_emp"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 7000, /datum/material/glass = 2000, /datum/material/plasma = 5000, /datum/material/uranium = 2000)
	build_path = /obj/item/ammo_casing/caseless/rocket/sabot
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/rocket/smoke
	name = "HVSD"
	desc = "Basic missile that creates a cloud of vision blocking smoke on impact."
	id = "rocket_smoke"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 7000, /datum/material/glass = 2000, /datum/material/plasma = 5000)
	build_path = /obj/item/ammo_casing/caseless/rocket/smoke
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/rocket/smoke/phosphor
	name = "HVWP"
	desc = "Dangerous missile that creates a flash of fire and smoke upon detonation."
	id = "rocket_smoke_phosphor"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 7000, /datum/material/glass = 10000, /datum/material/plasma = 10000)
	build_path = /obj/item/ammo_casing/caseless/rocket/smoke/phosphor
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/datum/design/rocket/smoke/sleeping
	name = "RCSD"
	desc = "Riot control grade missile that quickly puts an upset crowd to rest."
	id = "rocket_smoke_sleep"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 7000, /datum/material/glass = 2000, /datum/material/plasma = 10000, /datum/material/silver = 4000)
	build_path = /obj/item/ammo_casing/caseless/rocket/smoke/sleeping
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
