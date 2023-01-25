/obj/item/dogborg_tongue
	name = "synthetic tongue"
	desc = "Useful for slurping mess off the floor before affectionally licking the crew members in the face."
	icon = 'modular_skyrat/modules/altborgs/icons/robot_items.dmi'
	icon_state = "synthtongue"
	hitsound = 'sound/effects/attackblob.ogg'
	desc = "For giving affectionate kisses."
	item_flags = NOBLUDGEON

/obj/item/dogborg_tongue/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity || !isliving(target))
		return
	var/mob/living/silicon/robot/borg = user
	var/lick_verb = pick("lick", "mlem", "slurp")

	if(iscarbon(target)) // Is the target carbon?
		var/mob/living/carbon/carbon = target // This allows us to check several things about a carbon target, such as their combat_mode state

		if(HAS_TRAIT(carbon, TRAIT_DONOTLICK)) // Does the target have the Do Not Lick trait?

			if(carbon.combat_mode && (!HAS_TRAIT(carbon, TRAIT_PACIFISM)) && (carbon.stat != UNCONSCIOUS) && (!carbon.handcuffed)) // Combat mode slap - must be conscious, unpacified and uncuffed
				borg.visible_message(span_danger("\the [borg] tries to lick \the [carbon], but they get slapped instead!"),
				span_danger("You try to lick \the [carbon], but they slap you!"),
				"You hear a slap.", ignored_mobs = list(carbon))
				playsound(carbon.loc, 'sound/effects/snap.ogg', 50, TRUE, -1)
				to_chat(carbon, span_danger("\the [borg] tries to lick you, but you slap them!"))
				return
			else // If the carbon is unable to counter slap, simply prevent the cyborg from proceeding
				borg.visible_message(span_warning("\the [borg] tries to lick \the [carbon], but they're stopped by their subroutines!"),
				span_warning("\the [carbon] is on the do-not-lick index!"),, ignored_mobs = list(carbon))
				to_chat(carbon, span_warning("\the [borg] tries to lick you, but they're stopped by their subroutines!"))
				return

		else // If the carbon does NOT have the Do Not Lick trait, proceed as normal

			if(check_zone(borg.zone_selected) == "head")
				borg.visible_message(span_notice("\the [borg] affectionately [lick_verb]s \the [carbon]'s face!"),
				span_notice("You affectionately [lick_verb] \the [carbon]'s face!"))
			else
				borg.visible_message(span_notice("\the [borg] affectionately [lick_verb]s \the [carbon]!"),
				span_notice("You affectionately [lick_verb] \the [carbon]!"))

		playsound(borg, 'sound/effects/attackblob.ogg', 50, 1)

	else // Target is not a carbon, so set a /mob/living variable. This ensures that cyborgs can still lick things like medibots
		var/mob/living/mobtarget = target

		if(check_zone(borg.zone_selected) == "head")
			borg.visible_message(span_notice("\the [borg] affectionately [lick_verb]s \the [mobtarget]'s face!"),
			span_notice("You affectionally [lick_verb] \the [mobtarget]'s face!"))
		else
			borg.visible_message(span_notice("\the [borg] affectionately [lick_verb]s \the [mobtarget]!"),
			span_notice("You affectionately [lick_verb] \the [mobtarget]!"))

		playsound(borg, 'sound/effects/attackblob.ogg', 50, 1)

/obj/item/dogborg_nose
	name = "boop module"
	desc = "The BOOP module"
	icon = 'modular_skyrat/modules/altborgs/icons/robot_items.dmi'
	icon_state = "nose"
	flags_1 = CONDUCT_1
	item_flags = NOBLUDGEON
	force = 0

/obj/item/dogborg_nose/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	do_attack_animation(target, null, src)
	user.visible_message(span_notice("[user] [pick("nuzzles", "pushes", "boops")] \the [target.name] with their nose!"))
