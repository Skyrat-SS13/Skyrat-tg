/obj/item/crusher_trophy/gladiator
	name = "ashen bones"
	desc = "A set of soot-coated ribs from a worthy warrior. Suitable as a trophy for a kinetic crusher."
	icon_state = "demon_claws"
	gender = PLURAL
	denied_type = /obj/item/crusher_trophy/gladiator
	bonus_value = 10

/obj/item/crusher_trophy/gladiator/effect_desc()
	return "the crusher to have a <b>[bonus_value]%</b> chance to block incoming attacks."

/obj/item/crusher_trophy/gladiator/add_to(obj/item/kinetic_crusher/incomingchance, mob/living/user)
	. = ..()
	if(.)
		incomingchance.block_chance += bonus_value

/obj/item/crusher_trophy/gladiator/remove_from(obj/item/kinetic_crusher/incomingchance, mob/living/user)
	. = ..()
	if(.)
		incomingchance.block_chance -= bonus_value

/obj/item/claymore/agateram //it just works
	name = "ancient blade agateram"
	desc = "A millenia-old blade made from a material that you can't even begin to fathom. It flows with the power of the Marked One who once held it." //That thing was too big to be called a sword. Too big, too thick, too heavy, and too rough, it was more like a large hunk of iron.
	icon = 'modular_skyrat/master_files/icons/obj/agateram.dmi'
	icon_state = "demonsword"
	inhand_icon_state = "demonsword"
	lefthand_file = 'modular_skyrat/master_files/icons/mob/agateraminhandsleft.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/agateraminhandsright.dmi'
	hitsound = 'modular_skyrat/master_files/sound/weapons/bloodyslice.ogg'
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = null
	force = 20
	// This is a fuck off huge weapon that literally can only be held or dragged around, this is fine imho
	wound_bonus = 10
	bare_wound_bonus = 5
	resistance_flags = INDESTRUCTIBLE
	armour_penetration = 20
	block_chance = 30
	sharpness = SHARP_EDGED
	// aughhghghgh this really should be elementized but this works for now
	var/faction_bonus_force = 100
	var/static/list/nemesis_factions = list("mining", "boss")
	/// how much stamina does it cost to roll
	var/roll_stamcost = 15
	/// how far do we roll?
	var/roll_range = 3

/obj/item/claymore/agateram/attack(mob/living/target, mob/living/carbon/human/user)
	var/is_nemesis_faction = FALSE
	for(var/found_faction in target.faction)
		if(found_faction in nemesis_factions)
			is_nemesis_faction = TRUE
			force += faction_bonus_force
			break
	. = ..()
	if(is_nemesis_faction)
		force -= faction_bonus_force

/obj/item/claymore/agateram/afterattack_secondary(atom/target, mob/living/user, params) // dark souls
	if(!user.IsImmobilized()) // no free dodgerolls
		var/turf/where_to = get_turf(target)
		user.apply_damage(damage = roll_stamcost, damagetype = STAMINA)
		user.Immobilize(0.5 SECONDS) // you dont get to adjust your roll
		user.throw_at(where_to, range = roll_range, speed = 1, force = MOVE_FORCE_NORMAL)
		user.apply_status_effect(/datum/status_effect/dodgeroll_iframes)
		playsound(user, 'modular_skyrat/master_files/sound/effects/body-armor-rolling.wav', 50, FALSE)
	. = ..()

/datum/status_effect/dodgeroll_iframes
	id = "dodgeroll_dodging"
	alert_type = null
	status_type = STATUS_EFFECT_REFRESH
	duration = 1.5 SECONDS // todo: figure out how long the dodgeroll lasts

/datum/status_effect/dodgeroll_iframes/on_apply()
	RegisterSignal(owner, COMSIG_HUMAN_CHECK_SHIELDS, .proc/whiff)
	return TRUE

/datum/status_effect/dodgeroll_iframes/on_remove()
	UnregisterSignal(owner, list(
		COMSIG_HUMAN_CHECK_SHIELDS
		))
	return ..()

/datum/status_effect/dodgeroll_iframes/proc/whiff(
	mob/living/carbon/human/source,
	atom/movable/hitby,
	damage = 0,
	attack_text = "the attack",
	attack_type = MELEE_ATTACK,
	armour_penetration = 0,
)
	SIGNAL_HANDLER
	owner.balloon_alert_to_viewers("MISS!")
	playsound(src, 'sound/weapons/thudswoosh.ogg', 50, TRUE, -1)
	return SHIELD_BLOCK

/obj/structure/closet/crate/necropolis/gladiator
	name = "gladiator chest"

/obj/structure/closet/crate/necropolis/gladiator/crusher
	name = "dreadful gladiator chest"

/obj/structure/closet/crate/necropolis/gladiator/PopulateContents()
	new /obj/item/claymore/agateram(src)

/obj/structure/closet/crate/necropolis/gladiator/crusher/PopulateContents()
	new /obj/item/claymore/agateram(src)
	new /obj/item/crusher_trophy/gladiator(src)
