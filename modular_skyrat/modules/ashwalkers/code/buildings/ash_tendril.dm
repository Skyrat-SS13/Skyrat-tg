//this is for revitalizing/preserving regen cores
/obj/structure/lavaland/ash_walker/attackby(obj/item/attacking_item, mob/living/user, params)
	if(istype(attacking_item, /obj/item/organ/internal/regenerative_core) && user.mind.has_antag_datum(/datum/antagonist/ashwalker))
		var/obj/item/organ/internal/regenerative_core/regen_core = attacking_item
		regen_core.preserved()
		playsound(src, 'sound/magic/demon_consume.ogg', 50, TRUE)
		balloon_alert_to_viewers("[src] revitalizes [regen_core]!")
		return
	return ..()

//this is for logging the destruction of the tendril
/obj/structure/lavaland/ash_walker/Destroy()
	var/compiled_string = "The [src] has been destroyed at [loc_name(src.loc)], nearest mobs are "
	var/found_anyone = FALSE
	for(var/mob/living/carbon/carbons_nearby in range(7))
		compiled_string += "[key_name(carbons_nearby)],"
		found_anyone = TRUE
	if(!found_anyone)
		compiled_string += "nobody."
	log_game(compiled_string)
	return ..()

//this is for transforming a person into an ashwalker
/obj/structure/lavaland/ash_walker/attack_hand(mob/living/user, list/modifiers)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/human_user = user
	if(istype(human_user.dna.species, /datum/species/lizard/ashwalker))
		return
	var/allow_transform = 0
	for(var/mob/living/carbon/human/count_human in range(2, src))
		if(!istype(count_human.dna.species, /datum/species/lizard/ashwalker))
			continue
		allow_transform++
	if(allow_transform < 2)
		balloon_alert_to_viewers("[src] rejects the request, not enough viewers!")
		playsound(src, 'sound/magic/demon_consume.ogg', 50, TRUE)
		human_user.adjustBruteLoss(10)
		return
	else
		balloon_alert_to_viewers("[src] reaches out to [human_user]...")
		var/choice = tgui_alert(human_user, "Become an Ashwalker? You will abandon your previous life and body.", "Major Choice", list("Yes", "No"))
		if(choice != "Yes")
			balloon_alert_to_viewers("[src] feels rejected and punishes [human_user]!")
			playsound(src, 'sound/magic/demon_consume.ogg', 50, TRUE)
			human_user.adjustBruteLoss(50)
			return
		balloon_alert_to_viewers("[src] rejoices and transforms [human_user]!")
		human_user.unequip_everything()
		human_user.set_species(/datum/species/lizard/ashwalker)
		human_user.underwear = "Nude"
		human_user.update_body()
		human_user.mind.add_antag_datum(/datum/antagonist/ashwalker)
		if(SSmapping.level_trait(human_user.z, ZTRAIT_ICE_RUINS_UNDERGROUND) || SSmapping.level_trait(human_user.z, ZTRAIT_ICE_RUINS_UNDERGROUND))
			ADD_TRAIT(human_user, TRAIT_NOBREATH, ROUNDSTART_TRAIT)
			ADD_TRAIT(human_user, TRAIT_RESISTCOLD, ROUNDSTART_TRAIT)
		ADD_TRAIT(human_user, TRAIT_PRIMITIVE, ROUNDSTART_TRAIT)
		playsound(src, 'sound/magic/demon_dies.ogg', 50, TRUE)
		meat_counter++
	return ..()

/obj/structure/lavaland/ash_walker/consume()
	for(var/mob/living/viewable_living in view(src, 1)) //Only for corpse right next to/on same tile
		if(!viewable_living.stat)
			continue
		for(var/obj/item/sacrifice_posession in viewable_living)
			if(!viewable_living.dropItemToGround(sacrifice_posession))
				qdel(sacrifice_posession)
		if(issilicon(viewable_living)) //no advantage to sacrificing borgs...
			viewable_living.gib()
			continue

		if(viewable_living.mind?.has_antag_datum(/datum/antagonist/ashwalker) && (viewable_living.key || viewable_living.get_ghost(FALSE, TRUE))) //special interactions for dead lava lizards with ghosts attached
			revive_ashwalker(viewable_living)
			continue

		if(ismegafauna(viewable_living))
			meat_counter += 20
		else
			meat_counter++
		playsound(get_turf(src),'sound/magic/demon_consume.ogg', 100, TRUE)
		var/delivery_key = viewable_living.fingerprintslast //key of whoever brought the body
		var/mob/living/delivery_mob = get_mob_by_key(delivery_key) //mob of said key
		//there is a 40% chance that the Lava Lizard unlocks their respawn with each sacrifice
		if(delivery_mob && (delivery_mob.mind?.has_antag_datum(/datum/antagonist/ashwalker)) && (delivery_key in ashies.players_spawned) && (prob(40)))
			to_chat(delivery_mob, span_warning("<b>The Necropolis is pleased with your sacrifice. You feel confident your existence after death is secure.</b>"))
			ashies.players_spawned -= delivery_key
		viewable_living.gib()
		atom_integrity = min(atom_integrity + max_integrity * 0.05, max_integrity) //restores 5% hp of tendril
		for(var/mob/living/living_observers in view(src, 5))
			if(living_observers.mind?.has_antag_datum(/datum/antagonist/ashwalker))
				living_observers.add_mood_event("oogabooga", /datum/mood_event/sacrifice_good)
			else
				living_observers.add_mood_event("oogabooga", /datum/mood_event/sacrifice_bad)

/obj/structure/lavaland/ash_walker/proc/revive_ashwalker(mob/living/carbon/human/revived_ashwalker)
	//spawn the egg we will move the body into
	var/obj/structure/reviving_ashwalker_egg/spawned_egg = new(get_step(loc, pick(GLOB.alldirs)))
	//move the body into the egg
	revived_ashwalker.forceMove(spawned_egg)
	to_chat(revived_ashwalker, span_warning("The tendril has decided to be merciful and revive you within a minute, have patience."))

/obj/structure/reviving_ashwalker_egg
	name = "occupied ashwalker egg"
	desc = "Past the typical appearance of the yellow, man-sized egg, there seems to be a body floating within!"
	icon = 'icons/mob/simple/lavaland/lavaland_monsters.dmi'
	icon_state = "large_egg"
	resistance_flags = LAVA_PROOF | FIRE_PROOF | FREEZE_PROOF
	max_integrity = 80

/obj/structure/reviving_ashwalker_egg/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, .proc/do_revive), 30 SECONDS)

/obj/structure/reviving_ashwalker_egg/proc/do_revive()
	//try to find the living thing inside
	var/mob/living/locate_living = locate() in contents
	//if we can't locate a living thing, just delete the egg, its useless
	if(!locate_living)
		qdel(src)
		return
	//fully revive, "brand-spanking new" ashwalker
	locate_living.revive(full_heal = TRUE, admin_revive = TRUE)
	//force move the body to the outside
	locate_living.forceMove(get_turf(src))
	//force the ghost to re-enter the body
	locate_living.mind.grab_ghost()
	//give a nice alert to the viewers
	locate_living.balloon_alert_to_viewers("[locate_living] breaks out of [src]!")
	//goodbye egg
	qdel(src)
