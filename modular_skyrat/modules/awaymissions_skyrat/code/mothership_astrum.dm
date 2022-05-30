/*
*	AREAS
*	None of these should need power or lighting
*	I'd sooner die than hand-light this entire map
*/

/area/awaymission/mothership_astrum/halls
	name = "Mothership Astrum Hallways"
	icon_state = "away1"
	requires_power = FALSE

/area/awaymission/mothership_astrum/deck1
	name = "Mothership Astrum Combat Holodeck"
	icon_state = "away2"
	requires_power = FALSE

/area/awaymission/mothership_astrum/deck2
	name = "Mothership Astrum Recreation Holodeck"
	icon_state = "away3"
	requires_power = FALSE

/area/awaymission/mothership_astrum/deck3
	name = "Mothership Astrum Frozen Holodeck"
	icon_state = "away4"
	requires_power = FALSE

/area/awaymission/mothership_astrum/deck4
	name = "Mothership Astrum Xeno Studies Holodeck"
	icon_state = "away4"
	static_lighting = FALSE
	base_lighting_alpha = 255
	base_lighting_color = COLOR_WHITE
	requires_power = FALSE

/area/awaymission/mothership_astrum/deck5
	name = "Mothership Astrum Beach Holodeck"
	icon_state = "away5"
	requires_power = FALSE
	static_lighting = FALSE

//Fluff Notes
/obj/item/paper/fluff/awaymissions/astrum1
	name = "Report: Combat Holodeck"
	icon_state = "alienpaper_words"
	show_written_words = FALSE
	info = {"While we've had problems integrating the primitives into other decks, the subjects of the Combat Deck have begun experiments without the usual issues.<br>
	Hypothesis: the subjects have a tendency for violence over a tendency for anything else? Perhaps it has something to do with their coloured uniforms.<br>"}

/obj/item/paper/fluff/awaymissions/astrum1/AltClick()
	return //no folding these

/obj/item/paper/fluff/awaymissions/astrum2
	name = "Report: Reproductive Studies"
	icon_state = "alienpaper_words"
	show_written_words = FALSE
	info = {"No matter WHAT we do, the primitives won't display their rituals for courtship, perhaps we've done something wrong with setting up the simulation?.<br>
	Thoughts: put out more ethanol-based liquids, the primitives seem to enjoy consuming it to lower their inhibitions.<br>"}

/obj/item/paper/fluff/awaymissions/astrum2/AltClick()
	return //no folding these

/obj/item/paper/fluff/awaymissions/astrum3
	name = "Report: Frozen Holodeck"
	icon_state = "alienpaper_words"
	show_written_words = FALSE
	info = {"Not much to be learned here, the primitives die when exposed to extremely cold temperatures and hostile fauna.<br>
	Conclusion: Replace Frozen Holodeck with something more condusive to our research, the chasm keeps killing the cleaning menials.<br>"}

/obj/item/paper/fluff/awaymissions/astrum3/AltClick()
	return //no folding these

/obj/item/paper/fluff/awaymissions/astrum4
	name = "Report: Xeno-studies Holodeck"
	icon_state = "alienpaper_words"
	show_written_words = FALSE
	info = {"Nope nope nope nope nope nope nope I am closing this experiment down NOW.<br>
	Conlusion: What does this have to do with studying primitives AT ALL?!<br>"}

/obj/item/paper/fluff/awaymissions/astrum4/AltClick()
	return //no folding these

/obj/item/paper/fluff/awaymissions/astrum5
	name = "Report: Beach Holodeck"
	icon_state = "alienpaper_words"
	show_written_words = FALSE
	info = {"Well, we've found little success here, primitives when introduced to a relaxing beach environment continue to scream and arm themselves.<br>
	Conclusion: We can't learn anything from this batch, make sure to dispose of them at some point and bring in new ones.<br>"}

/obj/item/paper/fluff/awaymissions/astrum5/AltClick()
	return //no folding these

/*
*	SIMPLEMOBS
*/

/*
*	MELEE
*/

/mob/living/simple_animal/hostile/abductor
	name = "Abductor Scientist"
	desc = "From the depths of space."
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/abductors.dmi'
	icon_state = "abductor_scientist"
	icon_living = "abductor_scientist"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	speak_chance = 0
	turns_per_move = 4
	speed = 2
	stat_attack = HARD_CRIT
	robust_searching = 1
	maxHealth = 120
	health = 120
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/weapons/punch1.ogg'
	combat_mode = TRUE
	loot = list(/obj/effect/gibspawner/generic, /obj/effect/spawner/random/astrum/sciloot, /obj/effect/spawner/random/astrum/sciloot)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 7.5
	faction = list(ROLE_ABDUCTOR)
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = 1
	dodging = TRUE
	rapid_melee = 2
	footstep_type = FOOTSTEP_MOB_SHOE

/mob/living/simple_animal/hostile/abductor/melee
	melee_damage_lower = 10
	melee_damage_upper = 20
	icon_state = "abductor_scientist_melee"
	icon_living = "abductor_scientist_melee"
	loot = list(/obj/effect/gibspawner/generic, /obj/effect/spawner/random/astrum/sciloot)
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	status_flags = 0
	var/projectile_deflect_chance = 0

/mob/living/simple_animal/hostile/abductor/agent
	name = "Abductor Agent"
	melee_damage_lower = 15
	melee_damage_upper = 22
	icon_state = "abductor_agent"
	icon_living = "abductor_agent"
	maxHealth = 160
	health = 160
	loot = list(/obj/effect/gibspawner/generic, /obj/effect/spawner/random/astrum/agentloot)

/*
*	RANGED
*/

/mob/living/simple_animal/hostile/abductor/ranged
	name = "Abductor Scientist"
	ranged = 1
	retreat_distance = 3
	minimum_distance = 3
	icon_state = "abductor_scientist_gun"
	icon_living = "abductor_scientist_gun"
	maxHealth = 120
	health = 120
	projectiletype = /obj/projectile/beam/laser
	projectilesound = 'sound/weapons/laser.ogg'
	loot = list(/obj/effect/gibspawner/generic, /obj/effect/spawner/random/astrum/sciloot)

/mob/living/simple_animal/hostile/abductor/ranged/agent
	name = "Abductor Combat Specialist"
	icon_state = "abductor_agent_combat_gun"
	icon_living = "abductor_agent_combat_gun"
	maxHealth = 140
	health = 140
	loot = list(/obj/effect/gibspawner/generic, /obj/effect/spawner/random/astrum/agentloot)

/*
*	GHOST ROLES
*/

/obj/effect/mob_spawn/ghost_role/human/lobotomite
	name = "lobotomite containment tube"
	prompt_name = "a lobotomite"
	desc = "A pod containing a sleeping experiment, peering through the frost reveals a sleeping human."
	mob_name = "Lobotomite"
	density = TRUE
	mob_species = /datum/species/human
	outfit = /datum/outfit/lobotomite
	you_are_text = "You are a lobotomite, an experiment of those who took you away from... why can't you remember?"
	flavour_text = "You are the Lobotomite. \
	Do not explore the gateway. \
	Do not touch anything in the gateway. \
	Do not use anything in the gateway.\
	This is not meant to be a protagonist or an antagonist.\
	You are meant to work with the exploration team.\
	Do not attack anything in the gateway except in self-defense.\
	DO NOT TOUCH ANYTHING IN THE GATEWAY."

/datum/outfit/lobotomite
	name = "Abductor lobotomite"
	uniform = /obj/item/clothing/under/color/white
	mask = /obj/item/clothing/mask/breath/medical
	back = /obj/item/tank/internals/anesthetic

/*
*	LOOT
*/

/obj/effect/spawner/random/astrum
	name = "astrum low"
	loot = list(/obj/item/storage/medkit/regular = 10,
				/obj/item/reagent_containers/syringe/penacid = 5,
				/obj/item/reagent_containers/syringe/salacid = 20,
				/obj/item/reagent_containers/syringe/oxandrolone = 20,
				/obj/item/stack/medical/suture/medicated = 21,
				/obj/item/stack/medical/mesh/advanced = 21,
				/obj/item/clothing/under/chameleon = 20,
				/obj/item/shield/riot/tele = 12,
				/obj/item/clothing/shoes/chameleon/noslip = 10)

/obj/effect/spawner/random/astrum/mid
	name = "astrum mid"
	loot = list(/obj/item/storage/medkit/expeditionary = 20,
				/obj/item/shield/riot/tele = 12,
				/obj/item/dnainjector/shock = 10,
				/obj/item/book/granter/spell/summonitem = 20,
				/obj/item/storage/backpack/holding = 12,
				/obj/item/dnainjector/thermal = 5,
				/obj/item/melee/baton/telescopic = 12)

/obj/effect/spawner/random/astrum/sciloot
	name = "abductor scientist loot"
	loot = list(/obj/item/circular_saw/alien = 10,
				/obj/item/retractor/alien = 10,
				/obj/item/scalpel/alien = 10,
				/obj/item/hemostat/alien = 10,
				/obj/item/crowbar/abductor = 10,
				/obj/item/screwdriver/abductor = 10,
				/obj/item/wrench/abductor = 10,
				/obj/item/weldingtool/abductor = 10,
				/obj/item/crowbar/abductor = 10,
				/obj/item/wirecutters/abductor = 10,
				/obj/item/multitool/abductor = 10,
				/obj/item/stack/cable_coil = 10,
				/obj/effect/gibspawner/generic = 30)

/obj/effect/spawner/random/astrum/agentloot
	name = "abductor agent loot"
	loot = list(/obj/item/organ/heart/cybernetic/tier3 = 10,
				/obj/item/clothing/suit/armor/abductor/astrum = 10,
				/obj/item/clothing/head/helmet/astrum = 10,
				/obj/item/organ/cyberimp/arm/armblade = 5,
				/obj/effect/gibspawner/generic = 10,
				/obj/item/organ/eyes/night_vision/alien = 5
				)

/obj/item/gun/energy/alien/zeta
	name = "Zeta Blaster"
	desc = "Having this too close to your face makes you start to taste blood, is this safe?"
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/alienblaster.dmi'
	lefthand_file = 'modular_skyrat/modules/awaymissions_skyrat/icons/alienhand.dmi'
	righthand_file = 'modular_skyrat/modules/awaymissions_skyrat/icons/alienhand2.dmi'
	icon_state = "alienblaster"
	inhand_icon_state = "alienblaster"
	pin = /obj/item/firing_pin
	selfcharge = 1

/obj/item/gun/energy/alien/astrum
	name = "alien energy pistol"
	desc = "A seemingly complicated gun, that isn't so complicated after all."
	ammo_type = list(/obj/item/ammo_casing/energy/laser)
	pin = /obj/item/firing_pin
	icon_state = "alienpistol"
	inhand_icon_state = "alienpistol"
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL
	cell_type = /obj/item/stock_parts/cell/pulse/pistol

/obj/item/clothing/suit/armor/abductor/astrum
	name = "agent vest"
	desc = "You feel like you're wearing the suit wrong, and you have no idea how to operate it's systems."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "vest_combat"
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	armor = list(MELEE = 40, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 20, BIO = 50, FIRE = 90, ACID = 90)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	allowed = list(
		/obj/item/melee,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/flashlight,
		/obj/item/gun,
		/obj/item/knife,
		/obj/item/reagent_containers,
		/obj/item/restraints/handcuffs,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman
		)

/obj/item/clothing/head/helmet/astrum
	name = "agent headgear"
	desc = "An exceptionally robust helmet. For alien standards, that is."
	icon_state = "alienhelmet"
	inhand_icon_state = "alienhelmet"
	blockTracking = TRUE
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	armor = list(MELEE = 40, BULLET = 30, LASER = 30,ENERGY = 40, BOMB = 50, BIO = 90, FIRE = 100, ACID = 100, WOUND = 15)
	resistance_flags = FIRE_PROOF | ACID_PROOF

/*
*	BOSS
*/

/mob/living/simple_animal/hostile/megafauna/hierophant/astrum
	name = "Abductor Captain"
	desc = "The one you've come here for, finish this."
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/abductors.dmi'
	icon_state = "abductor_agent_combat"
	icon_living = "abductor_agent_combat"
	icon_gib = "syndicate_gib"
	health = 1750
	maxHealth = 1750
	health_doll_icon = "pandora"
	attack_verb_continuous = "attacked"
	attack_verb_simple = "attacks"
	attack_sound = 'sound/weapons/sonic_jackhammer.ogg'
	mouse_opacity = MOUSE_OPACITY_ICON
	deathsound = 'sound/magic/repulse.ogg'
	deathmessage = "falls to their knees, before exploding into a ball of gore."
	gps_name = "Captain's Signal"

/mob/living/simple_animal/hostile/megafauna/hierophant/astrum/bullet_act(obj/projectile/P)
	apply_damage(P.damage, P.damage_type)
	return // no more reduction

/mob/living/simple_animal/hostile/megafauna/hierophant/astrum/death(gibbed)
	spawn_gibs()
	spawn_gibs()
	new /obj/item/key/gateway(src.loc)
	new/obj/item/gun/energy/alien/zeta(src.loc)
	qdel(src)
