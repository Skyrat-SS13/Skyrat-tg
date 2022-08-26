/// SKYRAT MODULE SKYRAT_XENO_REDO

/mob/living/carbon/alien/humanoid/skyrat/spitter
	name = "alien spitter"
	caste = "spitter"
	maxHealth = 300
	health = 300
	icon_state = "alienspitter"
	melee_damage_lower = 15
	melee_damage_upper = 20

/mob/living/carbon/alien/humanoid/skyrat/spitter/Initialize(mapload)
	. = ..()

	add_movespeed_modifier(/datum/movespeed_modifier/alien_heavy)

	REMOVE_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/carbon/alien/humanoid/skyrat/spitter/create_internal_organs()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel
	internal_organs += new /obj/item/organ/internal/alien/neurotoxin/spitter
	..()

/datum/action/cooldown/alien/acid/skyrat/spread
	name = "Spit Neurotoxin Spread"
	desc = "Spits a spread neurotoxin at someone, exhausting them."
	plasma_cost = 50
	acid_projectile = null
	acid_casing = /obj/item/ammo_casing/caseless/xenospit
	spit_sound = 'modular_skyrat/modules/xenos_skyrat_redo/sound/alien_spitacid2.ogg'
	cooldown_time = 10 SECONDS

/obj/item/ammo_casing/caseless/xenospit //This is probably really bad, however I couldn't find any other nice way to do this
	name = "big glob of neurotoxin"
	projectile_type = /obj/projectile/neurotoxin/skyrat/spitter_spread
	pellets = 5
	variance = 20

/obj/item/ammo_casing/caseless/xenospit/tk_firing(mob/living/user, atom/fired_from)
	return FALSE

/obj/projectile/neurotoxin/skyrat/spitter_spread //Slightly nerfed because its a shotgun spread of these
	name = "neurotoxin spit"
	icon_state = "neurotoxin"
	damage = 30

/datum/action/cooldown/alien/acid/skyrat/spread/lethal
	name = "Spit Acid Spread"
	desc = "Spits a spread of acid at someone, burning them."
	acid_projectile = null
	acid_casing = /obj/item/ammo_casing/caseless/xenospit/spread/lethal
	button_icon_state = "acidspit_0"
	projectile_name = "acid"
	button_base_icon = "acidspit"

/obj/item/ammo_casing/caseless/xenospit/spread/lethal
	name = "big glob of acid"
	projectile_type = /obj/projectile/neurotoxin/skyrat/acid/spitter_spread
	pellets = 6
	variance = 25

/obj/projectile/neurotoxin/skyrat/acid/spitter_spread
	name = "acid spit"
	icon_state = "toxin"
	damage = 20
	damage_type = BURN

/obj/item/organ/internal/alien/neurotoxin/spitter
	name = "large neurotoxin gland"
	icon_state = "neurotox"
	zone = BODY_ZONE_PRECISE_MOUTH
	slot = ORGAN_SLOT_XENO_NEUROTOXINGLAND
	actions_types = list(
		/datum/action/cooldown/alien/acid/skyrat/spread,
		/datum/action/cooldown/alien/acid/skyrat/spread/lethal,
		/datum/action/cooldown/alien/acid/corrosion,
	)
