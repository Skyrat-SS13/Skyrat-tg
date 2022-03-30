/mob/living/simple_animal/hostile/blackmesa/xen/headcrab
	name = "headcrab"
	desc = "Don't let it latch onto your hea-... hey, that's kinda cool."
	icon = 'modular_skyrat/master_files/icons/mob/blackmesa.dmi'
	icon_state = "headcrab"
	icon_living = "headcrab"
	icon_dead = "headcrab_dead"
	icon_gib = null
	mob_biotypes = list(MOB_ORGANIC, MOB_BEAST)
	speak_chance = 1
	speak_emote = list("growls")
	speed = 1
	emote_taunt = list("growls", "snarls", "grumbles")
	taunt_chance = 100
	turns_per_move = 7
	maxHealth = 100
	health = 100
	harm_intent_damage = 15
	melee_damage_lower = 17
	melee_damage_upper = 17
	attack_sound = 'sound/weapons/bite.ogg'
	gold_core_spawnable = HOSTILE_SPAWN
	loot = list(/obj/item/stack/sheet/bone)
	alert_sounds = list(
		'modular_skyrat/master_files/sound/blackmesa/headcrab/alert1.ogg'
	)
	var/is_zombie = FALSE
	var/mob/living/carbon/human/oldguy
	/// Charging ability
	var/datum/action/cooldown/mob_cooldown/charge/basic_charge/charge

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab/Initialize(mapload)
	. = ..()
	charge = new /datum/action/cooldown/mob_cooldown/charge/basic_charge()
	charge.Grant(src)

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab/Destroy()
	QDEL_NULL(charge)
	return ..()

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab/OpenFire()
	if(client)
		return
	charge.Trigger(target)

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab/death(gibbed)
	. = ..()
	playsound(src, pick(list(
		'modular_skyrat/master_files/sound/blackmesa/headcrab/die1.ogg',
		'modular_skyrat/master_files/sound/blackmesa/headcrab/die2.ogg'
	)), 100)

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(hit_atom && stat != DEAD)
		if(ishuman(hit_atom))
			var/mob/living/carbon/human/human_to_dunk = hit_atom
			if(!human_to_dunk.get_item_by_slot(ITEM_SLOT_HEAD) && prob(50)) //Anything on de head stops the head hump
				if(zombify(human_to_dunk))
					to_chat(human_to_dunk, span_userdanger("[src] latches onto your head as it pierces your skull, instantly killing you!"))
					playsound(src, 'modular_skyrat/master_files/sound/blackmesa/headcrab/headbite.ogg', 100)
					human_to_dunk.death(FALSE)

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab/proc/zombify(mob/living/carbon/human/zombified_human)
	if(is_zombie)
		return FALSE
	is_zombie = TRUE
	if(zombified_human.wear_suit)
		var/obj/item/clothing/suit/armor/zombie_suit = zombified_human.wear_suit
		maxHealth += zombie_suit.armor.melee //That zombie's got armor, I want armor!
	maxHealth += 40
	health = maxHealth
	name = "zombie"
	desc = "A shambling corpse animated by a headcrab!"
	mob_biotypes |= MOB_HUMANOID
	melee_damage_lower += 8
	melee_damage_upper += 11
	obj_damage = 21 //now that it has a corpse to puppet, it can properly attack structures
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	movement_type = GROUND
	icon_state = ""
	zombified_human.hairstyle = null
	zombified_human.update_hair()
	zombified_human.forceMove(src)
	oldguy = zombified_human
	update_appearance()
	visible_message(span_warning("The corpse of [zombified_human.name] suddenly rises!"))
	return TRUE

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab/death(gibbed)
	. = ..()
	if(oldguy)
		oldguy.forceMove(loc)
		oldguy = null
	if(is_zombie)
		if(prob(30))
			new /mob/living/simple_animal/hostile/blackmesa/xen/headcrab(loc) //OOOO it unlached!
			qdel(src)
			return
		cut_overlays()
		update_appearance()

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab/update_overlays()
	. = ..()
	if(is_zombie)
		copy_overlays(oldguy, TRUE)
		var/mutable_appearance/blob_head_overlay = mutable_appearance('modular_skyrat/master_files/icons/mob/blackmesa.dmi', "headcrab_zombie")
		add_overlay(blob_head_overlay)

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab/fast
	speed = -2
