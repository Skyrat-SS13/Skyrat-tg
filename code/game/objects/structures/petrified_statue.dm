/obj/structure/statue/petrified
	name = "statue"
	desc = "An incredibly lifelike marble carving."
	icon_state = "human_male"
	density = TRUE
	anchored = TRUE
	max_integrity = 200
	// Should we leave a brain behind when the statue is wrecked?
	var/brain = TRUE
	var/timer = 480 //eventually the person will be freed
	var/mob/living/petrified_mob

/obj/structure/statue/petrified/relaymove()
	return

/obj/structure/statue/petrified/Initialize(mapload, mob/living/L, statue_timer, save_brain)
	. = ..()
	if(statue_timer)
		timer = statue_timer
	if(save_brain)
		brain = save_brain
	if(L)
		petrified_mob = L
		if(L.buckled)
			L.buckled.unbuckle_mob(L,force=1)
		L.visible_message(span_warning("[L]'s skin rapidly turns to marble!"), span_userdanger("Your body freezes up! Can't... move... can't... think..."))
		L.forceMove(src)
		ADD_TRAIT(L, TRAIT_MUTE, STATUE_MUTE)
		L.faction |= FACTION_MIMIC //Stops mimics from instaqdeling people in statues
		L.status_flags |= GODMODE
		atom_integrity = L.health + 100 //stoning damaged mobs will result in easier to shatter statues
		max_integrity = atom_integrity
		START_PROCESSING(SSobj, src)

/obj/structure/statue/petrified/process(seconds_per_tick)
	if(!petrified_mob)
		STOP_PROCESSING(SSobj, src)
	timer -= seconds_per_tick
	petrified_mob.Stun(40) //So they can't do anything while petrified
	if(timer <= 0)
		STOP_PROCESSING(SSobj, src)
		qdel(src)

/obj/structure/statue/petrified/contents_explosion(severity, target)
	return

/obj/structure/statue/petrified/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == petrified_mob)
		petrified_mob = null

/obj/structure/statue/petrified/Destroy()

	if(istype(src.loc, /mob/living/basic/statue))
		var/mob/living/basic/statue/S = src.loc
		forceMove(S.loc)
		if(S.mind)
			if(petrified_mob)
				S.mind.transfer_to(petrified_mob)
				petrified_mob.Paralyze(100)
				to_chat(petrified_mob, span_notice("You slowly come back to your senses. You are in control of yourself again!"))
		qdel(S)

	for(var/obj/O in src)
		O.forceMove(loc)

	if(petrified_mob)
		petrified_mob.status_flags &= ~GODMODE
		REMOVE_TRAIT(petrified_mob, TRAIT_MUTE, STATUE_MUTE)
		REMOVE_TRAIT(petrified_mob, TRAIT_NOBLOOD, MAGIC_TRAIT)
		petrified_mob.take_overall_damage((petrified_mob.health - atom_integrity + 100)) //any new damage the statue incurred is transferred to the mob
		petrified_mob.faction -= FACTION_MIMIC
		petrified_mob.forceMove(loc)
	return ..()

/obj/structure/statue/petrified/atom_deconstruct(disassembled = TRUE)
	var/destruction_message = "[src] shatters!"
	if(!disassembled)
		if(petrified_mob)
			petrified_mob.investigate_log("has been dusted by statue deconstruction.", INVESTIGATE_DEATHS)
			if(iscarbon(petrified_mob) && brain)
				var/mob/living/carbon/petrified_carbon = petrified_mob
				var/obj/item/organ/internal/brain/carbon_brain = petrified_carbon.get_organ_slot(ORGAN_SLOT_BRAIN)
				carbon_brain.Remove(petrified_carbon)
				carbon_brain.forceMove(get_turf(src))
				carbon_brain.name = "petrified [carbon_brain.name]"
				carbon_brain.desc = "[carbon_brain.desc] This one seems a bit more... smooth than a normal brain. Probably'd still work."
				carbon_brain.add_atom_colour(list(rgb(77,77,77), rgb(150,150,150), rgb(28,28,28), rgb(0,0,0)), FIXED_COLOUR_PRIORITY)
				destruction_message = "[src] shatters, a solid brain tumbling out!"
			petrified_mob.dust()
	visible_message(span_danger(destruction_message))

/obj/structure/statue/petrified/animate_atom_living(mob/living/owner)
	if(isnull(petrified_mob))
		return ..()
	var/mob/living/basic/statue/new_statue = new(drop_location())
	new_statue.name = "statue of [petrified_mob.name]"
	if(owner)
		new_statue.befriend(owner)
	new_statue.icon = icon
	new_statue.icon_state = icon_state
	new_statue.copy_overlays(src, TRUE)
	new_statue.atom_colours = atom_colours.Copy()
	petrified_mob.mind?.transfer_to(new_statue)
	to_chat(new_statue, span_userdanger("You are an animate statue. You cannot move when monitored, but are nearly invincible and deadly when unobserved! [owner ? "Do not harm [owner], your creator" : ""]."))
	forceMove(new_statue)


/mob/proc/petrify(statue_timer)
	return

/mob/living/carbon/human/petrify(statue_timer, save_brain, colorlist)
	if(!isturf(loc))
		return FALSE
	var/obj/structure/statue/petrified/S = new(loc, src, statue_timer, save_brain)
	S.name = "statue of [name]"
	ADD_TRAIT(src, TRAIT_NOBLOOD, MAGIC_TRAIT)
	S.copy_overlays(src)
	var/newcolor = list(rgb(77,77,77), rgb(150,150,150), rgb(28,28,28), rgb(0,0,0))
	if(colorlist)
		newcolor = colorlist
	S.add_atom_colour(newcolor, FIXED_COLOUR_PRIORITY)
	return TRUE

/mob/living/basic/pet/dog/corgi/petrify(statue_timer)
	if(!isturf(loc))
		return FALSE
	var/obj/structure/statue/petrified/S = new (loc, src, statue_timer)
	S.name = "statue of a corgi"
	S.icon_state = "corgi"
	S.desc = "If it takes forever, I will wait for you..."
	return TRUE
