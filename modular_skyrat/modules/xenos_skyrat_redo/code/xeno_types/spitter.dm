/mob/living/carbon/alien/humanoid/skyrat/spitter
	name = "alien spitter"
	caste = "spitter"
	maxHealth = 200
	health = 200
	icon_state = "alienspitter"
	melee_damage_lower = 10
	melee_damage_upper = 15

/mob/living/carbon/alien/humanoid/skyrat/spitter/create_internal_organs()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/small
	internal_organs += new /obj/item/organ/internal/alien/neurotoxin/spitter
	..()

/datum/action/cooldown/alien/acid/skyrat
	name = "Spit Neurotoxin"
	desc = "Spits neurotoxin at someone, exhausting and confusing them."
	icon_icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi'
	button_icon_state = "neurospit_0"
	plasma_cost = 25
	var/acid_projectile = /obj/projectile/neurotoxin/skyrat
	var/projectile_name = "neurotoxin" //Used in to_chat messages
	var/button_base_icon = "neurospit"
	shared_cooldown = MOB_SHARED_COOLDOWN_3
	cooldown_time = 5 SECONDS

/datum/action/cooldown/alien/acid/skyrat/IsAvailable()
	return ..() && isturf(owner.loc)

/datum/action/cooldown/alien/acid/skyrat/set_click_ability(mob/on_who)
	. = ..()
	if(!.)
		return

	to_chat(on_who, span_notice("You prepare your [projectile_name] gland. <B>Left-click to fire at a target!</B>"))

	button_icon_state = "[button_base_icon]_1"
	UpdateButtons()
	on_who.update_icons()

/datum/action/cooldown/alien/acid/skyrat/unset_click_ability(mob/on_who, refund_cooldown = TRUE)
	. = ..()
	if(!.)
		return

	if(refund_cooldown)
		to_chat(on_who, span_notice("You empty your [projectile_name] gland."))

	button_icon_state = "[button_base_icon]_0"
	UpdateButtons()
	on_who.update_icons()

/datum/action/cooldown/alien/acid/skyrat/InterceptClickOn(mob/living/caller, params, atom/target)
	. = ..()
	if(!.)
		unset_click_ability(caller, refund_cooldown = FALSE)
		return FALSE

	var/turf/user_turf = caller.loc
	var/turf/target_turf = get_step(caller, target.dir)
	if(!isturf(target_turf))
		return FALSE

	var/modifiers = params2list(params)
	caller.visible_message(
		span_danger("[caller] spits [projectile_name]!"),
		span_alertalien("You spit [projectile_name]."),
	)
	var/obj/projectile/spit_projectile = new acid_projectile(caller.loc)
	spit_projectile.preparePixelProjectile(target, caller, modifiers)
	spit_projectile.firer = caller
	spit_projectile.fire()
	caller.newtonian_move(get_dir(target_turf, user_turf))
	return TRUE

/datum/action/cooldown/alien/acid/skyrat/Activate(atom/target)
	return TRUE

/obj/projectile/neurotoxin/skyrat
	name = "neurotoxin spit"
	icon_state = "neurotoxin"
	damage = 30
	damage_type = STAMINA
	nodamage = FALSE
	armor_flag = BIO
	slur = 3 SECONDS

/obj/projectile/neurotoxin/on_hit(atom/target, blocked = FALSE)
	if(isalien(target))
		slur = 0
		nodamage = TRUE
	return ..()

/datum/action/cooldown/alien/acid/skyrat/lethal
	name = "Spit Acid"
	desc = "Spits neurotoxin at someone, burning them."
	acid_projectile = /obj/projectile/neurotoxin/skyrat/acid
	button_icon_state = "acidspit_0"
	projectile_name = "acid"
	button_base_icon = "acidspit"

/obj/projectile/neurotoxin/skyrat/acid
	name = "acid spit"
	icon_state = "toxin"
	damage = 20
	damage_type = BURN
	slur = 0 SECONDS

/obj/item/organ/internal/alien/neurotoxin/spitter
	name = "neurotoxin gland"
	icon_state = "neurotox"
	zone = BODY_ZONE_PRECISE_MOUTH
	slot = ORGAN_SLOT_XENO_NEUROTOXINGLAND
	actions_types = list(
		/datum/action/cooldown/alien/acid/skyrat,
		/datum/action/cooldown/alien/acid/skyrat/lethal,
	)
