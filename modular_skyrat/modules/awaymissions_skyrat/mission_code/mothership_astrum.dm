///// AREAS, None of these should need power or lighting. I'd sooner die than hand-light this entire map

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
	requires_power = FALSE

/area/awaymission/mothership_astrum/deck5
	name = "Mothership Astrum Beach Holodeck"
	icon_state = "away5"
	requires_power = FALSE
	dynamic_lighting = FALSE

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

//Simplemobs
//MELEE
/mob/living/simple_animal/hostile/abductor
	name = "Abductor Scientist"
	desc = "From the depths of space."
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/abductors.dmi'
	icon_state = "abductor_scientist"
	icon_living = "abductor_scientist"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	speak_chance = 0
	turns_per_move = 5
	speed = 0
	stat_attack = HARD_CRIT
	robust_searching = 1
	maxHealth = 100
	health = 100
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/weapons/punch1.ogg'
	combat_mode = TRUE
	loot = list(/obj/effect/gibspawner/generic, /obj/effect/spawner/lootdrop/astrum/sciloot)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 7.5
	faction = list(ROLE_ABDUCTOR)
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = 1
	dodging = TRUE
	rapid_melee = 2
	footstep_type = FOOTSTEP_MOB_SHOE

/mob/living/simple_animal/hostile/abductor/melee //dude with a melee weapon
	melee_damage_lower = 5
	melee_damage_upper = 15
	icon_state = "abductor_scientist_melee"
	icon_living = "abductor_scientist_melee"
	loot = list(/obj/effect/gibspawner/generic, /obj/effect/spawner/lootdrop/astrum/sciloot)
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH
	status_flags = 0
	var/projectile_deflect_chance = 0

/mob/living/simple_animal/hostile/abductor/agent
	name = "Abductor Agent"
	melee_damage_lower = 10
	melee_damage_upper = 30
	icon_state = "abductor_agent"
	icon_living = "abductor_agent"
	maxHealth = 200
	health = 200
	loot = list(/obj/effect/gibspawner/generic, /obj/effect/spawner/lootdrop/astrum/agentloot)

//RANGED

/mob/living/simple_animal/hostile/abductor/ranged
	name = "Abductor Scientist"
	ranged = 1
	retreat_distance = 5
	minimum_distance = 5
	icon_state = "abductor_scientist_gun"
	icon_living = "abductor_scientist_gun"
	maxHealth = 100
	health = 100
	projectiletype = /obj/projectile/beam/laser
	projectilesound = 'sound/weapons/laser.ogg'
	loot = list(/obj/effect/gibspawner/generic, /obj/effect/spawner/lootdrop/astrum/sciloot)

/mob/living/simple_animal/hostile/abductor/ranged/agent
	name = "Abductor Combat Specialist"
	icon_state = "abductor_agent_combat_gun"
	icon_living = "abductor_agent_combat_gun"
	maxHealth = 170
	health = 170
	loot = list(/obj/effect/gibspawner/generic, /obj/effect/spawner/lootdrop/astrum/agentloot)

//GHOSTROLE TIME

/obj/effect/mob_spawn/human/lobotomite
	name = "lobotomite containment tube"
	desc = "A pod containing a sleeping experiment, peering through the frost reveals a sleeping human."
	mob_name = "Lobotomite"
	icon = 'icons/obj/machines/nanite_chamber.dmi'
	icon_state = "nanite_chamber_occupied"
	density = TRUE
	roundstart = FALSE
	death = FALSE
	mob_species = /datum/species/human
	outfit = /datum/outfit/lobotomite
	short_desc = "You are a lobotomite, an experiment of those who took you away from... why can't you remember?"
	flavour_text = "Your head hurts, something feels different, you want to go home. \
	Thinking about home, you can't remember where that is, or if it even existed. \
	Your goal is to find out who you are, and escape from this place, work with anyone friendly you can find."
	assignedrole = "Lobotomite"

/datum/outfit/lobotomite
	name = "Abductor lobotomite"
	uniform = /obj/item/clothing/under/color/white
	mask = /obj/item/clothing/mask/breath/medical
	back = /obj/item/tank/internals/anesthetic

//LOOT

/obj/item/crowbar/freeman
	name = "Blood Soaked Crowbar"
	desc = "A weapon wielded by an ancient physicist, the blood of hundreds seeps through this rod of iron and malice."
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/freeman.dmi'
	icon_state = "crowbar"
	force = 30
	throwforce = 42

/obj/effect/spawner/lootdrop/astrum
	name = "astrum low"
	loot = list(/obj/item/storage/firstaid/regular = 45,
				/obj/item/storage/firstaid/toxin = 35,
				/obj/item/dnainjector/thermal = 5,
				/obj/item/storage/firstaid/brute = 27,
				/obj/item/storage/firstaid/fire = 27,
				/obj/item/storage/toolbox/syndicate = 12,
				/obj/item/clothing/under/chameleon = 13,
				/obj/item/clothing/shoes/chameleon/noslip = 10)

/obj/effect/spawner/lootdrop/astrum/mid
	name = "astrum mid"
	loot = list(/obj/item/storage/firstaid/tactical = 20,
				/obj/item/shield/riot/tele = 12,
				/obj/item/dnainjector/shock = 10,
				/obj/item/pneumatic_cannon = 15,
				/obj/item/melee/transforming/energy/sword = 7,
				/obj/item/book/granter/spell/summonitem = 20,	
				/obj/item/storage/backpack/holding = 12,
				/obj/item/melee/classic_baton/telescopic = 12,)

/obj/effect/spawner/lootdrop/astrum/sciloot
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
				/obj/effect/gibspawner/generic = 20)

/obj/effect/spawner/lootdrop/astrum/agentloot
	name = "abductor agent loot"
	loot = list(/obj/item/gun/energy/alien/astrum = 10,
				/obj/item/clothing/suit/armor/abductor/astrum = 5,
				/obj/item/clothing/head/helmet/abductor = 5,
				/obj/item/organ/cyberimp/arm/armblade = 1)

/obj/item/gun/energy/alien/astrum
	name = "alien energy pistol"
	desc = "A seemingly complicated gun, that isn't so complicated after all."
	ammo_type = list(/obj/item/ammo_casing/energy/laser)
	pin = /obj/item/firing_pin
	icon_state = "alienpistol"
	inhand_icon_state = "alienpistol"
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL

/obj/item/clothing/suit/armor/abductor/astrum
	name = "agent vest"
	desc = "You feel like you're wearing the suit wrong, but you have no idea how to operate it's systems."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "vest_combat"
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	armor = list(MELEE = 40, BULLET = 40, LASER = 40, ENERGY = 40, BOMB = 40, BIO = 50, RAD = 50, FIRE = 90, ACID = 90)

/obj/item/clothing/head/helmet/abductor
	name = "agent headgear"
	desc = "Prevents digital tracking, probably? You're not sure if you're using it right."
	icon_state = "alienhelmet"
	inhand_icon_state = "alienhelmet"
	blockTracking = TRUE
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT

// FUCK NANITES
/obj/machinery/scanner_gate/anti_nanite
	name = "Advanced Scanner Gate"
	desc = "This gate seems to be highly modified with odd markings."
	resistance_flags = INDESTRUCTIBLE
	use_power = NO_POWER_USE
	flags_1 = NODECONSTRUCT_1

/obj/machinery/scanner_gate/anti_nanite/perform_scan(mob/living/M)
	if(SEND_SIGNAL(M, COMSIG_HAS_NANITES))
		SEND_SIGNAL(M, COMSIG_NANITE_DELETE)
		to_chat(M, "<span class='warning'>You feel an electrical charge run throughout your entire body as your nanites are vaporized!</span>")

/obj/machinery/scanner_gate/anti_nanite/emag_act(mob/user)
	to_chat(user, "<span class='notice'>This gate has advanced security measures!</span>")
	return

/obj/machinery/scanner_gate/anti_nanite/attackby(obj/item/W, mob/user, params)
	return

/obj/machinery/scanner_gate/anti_nanite/examine(mob/user)
	return list("This gate seems to be highly modified with odd markings.")

//Elite Fauna (I AM STEALING SO MUCH CODE FOR THIS I AM SORRY)

/mob/living/simple_animal/hostile/asteroid/elite/pandora/abductor
	name = "Abductor Captain"
	desc = "The one you've come here for, finish this."
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/abductors.dmi'
	icon_state = "abductor_agent_combat"
	icon_living = "abductor_agent_combat"
	icon_aggro = "abductor_agent_combat"
	icon_dead = "pandora_dead"
	icon_gib = "syndicate_gib"
	health_doll_icon = "pandora"
	maxHealth = 1500
	health = 1500
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_verb_continuous = "attacked"
	attack_verb_simple = "attacks"
	attack_sound = 'sound/weapons/sonic_jackhammer.ogg'
	throw_message = "doesn't do anything to"
	speed = 4
	move_to_delay = 8
	mouse_opacity = MOUSE_OPACITY_ICON
	deathsound = 'sound/magic/repulse.ogg'
	deathmessage = "falls to their knees, before exploding into a ball of gore."
	
/mob/living/simple_animal/hostile/asteroid/elite/pandora/abductor/bullet_act(obj/projectile/P)
	apply_damage(P.damage, P.damage_type)
	return // no more reduction

/mob/living/simple_animal/hostile/asteroid/elite/pandora/abductor/death(gibbed)
	spawn_gibs()
	spawn_gibs()
	new /obj/item/key/gateway/home(src.loc)
	qdel(src)
