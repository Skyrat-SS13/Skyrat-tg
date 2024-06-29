// Junk (Pipe Pistols and Pipeguns)

/obj/projectile/bullet/junk
	name = "junk bullet"
	icon_state = "trashball"
	damage = 30
	embedding = list(embed_chance=15, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)
	var/bane_mob_biotypes = MOB_ROBOTIC
	var/bane_multiplier = 1.5
	var/bane_added_damage = 0

/obj/projectile/bullet/junk/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/bane, mob_biotypes = bane_mob_biotypes, target_type = /mob/living, damage_multiplier = bane_multiplier, added_damage = bane_added_damage, requires_combat_mode = FALSE)

/obj/projectile/bullet/incendiary/fire/junk
	name = "burning oil"
	damage = 30
	fire_stacks = 5
	suppressed = SUPPRESSED_NONE

/obj/projectile/bullet/junk/phasic
	name = "junk phasic bullet"
	icon_state = "gaussphase"
	projectile_phasing =  PASSTABLE | PASSGLASS | PASSGRILLE | PASSCLOSEDTURF | PASSMACHINE | PASSSTRUCTURE | PASSDOORS

/obj/projectile/bullet/junk/shock
	name = "bundle of live electrical parts"
	icon_state = "tesla_projectile"
	damage = 15
	embedding = null
	shrapnel_type = null
	bane_multiplier = 3

/obj/projectile/bullet/junk/shock/on_hit(atom/target, blocked = 0, pierce_hit)
	. = ..()
	if(isliving(target))
		var/mob/living/victim = target
		victim.electrocute_act(damage, src, siemens_coeff = 1, flags = SHOCK_NOSTUN)

/obj/projectile/bullet/junk/hunter
	name = "junk hunter bullet"
	icon_state = "gauss"
	bane_mob_biotypes = MOB_ROBOTIC | MOB_BEAST | MOB_SPECIAL
	bane_multiplier = 0
	bane_added_damage = 50

/obj/projectile/bullet/junk/ripper
	name = "junk ripper bullet"
	icon_state = "redtrac"
	damage = 10
	embedding = list(embed_chance=100, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)
	wound_bonus = 10
	bare_wound_bonus = 30

/obj/projectile/bullet/junk/reaper
	name = "junk reaper bullet"
	tracer_type = /obj/effect/projectile/tracer/sniper
	impact_type = /obj/effect/projectile/impact/sniper
	muzzle_type = /obj/effect/projectile/muzzle/sniper
	hitscan = TRUE
	impact_effect_type = null
	hitscan_light_intensity = 3
	hitscan_light_range = 0.75
	hitscan_light_color_override = LIGHT_COLOR_DIM_YELLOW
	muzzle_flash_intensity = 5
	muzzle_flash_range = 1
	muzzle_flash_color_override = LIGHT_COLOR_DIM_YELLOW
	impact_light_intensity = 5
	impact_light_range = 1
	impact_light_color_override = LIGHT_COLOR_DIM_YELLOW
