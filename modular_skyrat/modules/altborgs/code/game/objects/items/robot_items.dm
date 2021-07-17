/obj/item/dogborg_tongue
	name = "synthetic tongue"
	desc = "Useful for slurping mess off the floor before affectionally licking the crew members in the face."
	icon = 'modular_skyrat/modules/altborgs/icons/mob/robot_items.dmi'
	icon_state = "synthtongue"
	hitsound = 'sound/effects/attackblob.ogg'
	desc = "For giving affectionate kisses."
	item_flags = NOBLUDGEON

/obj/item/dogborg_tongue/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity || !isliving(target))
		return
	var/mob/living/silicon/robot/borg = user
	var/mob/living/mob = target

	if(check_zone(borg.zone_selected) == "head")
		borg.visible_message("<span class='warning'>\the [borg] affectionally licks \the [mob]'s face!</span>", "<span class='notice'>You affectionally lick \the [mob]'s face!</span>")
		playsound(borg, 'sound/effects/attackblob.ogg', 50, 1)
	else
		borg.visible_message("<span class='warning'>\the [borg] affectionally licks \the [mob]!</span>", "<span class='notice'>You affectionally lick \the [mob]!</span>")
		playsound(borg, 'sound/effects/attackblob.ogg', 50, 1)

/obj/item/dogborg_nose
	name = "boop module"
	desc = "The BOOP module"
	icon = 'modular_skyrat/modules/altborgs/icons/mob/robot_items.dmi'
	icon_state = "nose"
	flags_1 = CONDUCT_1|NOBLUDGEON
	force = 0

/obj/item/dogborg_nose/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	do_attack_animation(target, null, src)
	user.visible_message("<span class='notice'>[user] [pick("nuzzles", "pushes", "boops")] \the [target.name] with their nose!</span>")
