//simplemob plushie that can be controlled by players
/mob/living/simple_animal/pet/plushie
	name = "Plushie"
	desc = "A living plushie!"
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "plushie_fox"
	icon_living = "plushie_fox"
	icon_dead = "plushie_fox"
	speak_emote = list("squeaks")
	maxHealth = 50
	health = 50
	density = FALSE
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	mob_biotypes = MOB_ORGANIC
	verb_say = "squeaks"
	verb_ask = "squeaks inquisitively"
	verb_exclaim = "squeaks intensely"
	verb_yell = "squeaks intensely"
	attack_sound = 'sound/items/toysqueak1.ogg'
	attacked_sound = 'sound/items/toysqueak1.ogg'
	melee_damage_type = STAMINA
	melee_damage_lower = 0
	melee_damage_upper = 1
	attack_verb_continuous = "squeaks"
	attack_verb_simple = "squeak"
	death_message = "lets out a faint squeak as the glint in its eyes disappears"
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	pressure_resistance = 200

/mob/living/simple_animal/pet/plushie/Initialize()
	. = ..()
//	AddElement(/datum/element/mob_holder, "plushie")

//shell that lets people turn into the plush or poll for ghosts
/obj/item/toy/plushie_shell
	name = "Plushie Shell"
	desc = "A plushie. Its eyes seem to be staring right back at you. Something isn't quite right."
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "robotcorgi"
	var/obj/item/toy/plush/stored_plush = null

//attacking yourself transfers your mind into the plush!
/obj/item/toy/plushie_shell/attack_self(mob/user)
	if(user.mind)
		var/safety = alert(user, "The plushie is staring back at you intensely, it seems cursed! (Permanently become a plushie)", "Hugging this is a bad idea.", "Hug it!", "Cancel")
		if(safety == "Cancel" || !in_range(src, user))
			return
		to_chat(user, "<span class='userdanger'>You hug the strange plushie. You fool.</span>")

		//setup the mob
		var/mob/living/simple_animal/pet/plushie/new_plushie = new /mob/living/simple_animal/pet/plushie/(user.loc)
		new_plushie.icon = src.icon
		new_plushie.icon_living = src.icon_state
		new_plushie.icon_dead = src.icon_state
		new_plushie.icon_state = src.icon_state
		new_plushie.name = src.name

		//make the mob sentient
		user.mind.transfer_to(new_plushie)

		//add sounds to mob
		new_plushie.AddComponent(/datum/component/squeak, stored_plush.squeak_override)
		if(length(stored_plush.squeak_override) > 0)
			new_plushie.attack_sound = stored_plush.squeak_override[1]
			new_plushie.attacked_sound = stored_plush.squeak_override[1]

		//take care of the user's old body and the old shell
		//user.dust(drop_items = TRUE)
/*
		for(var/obj/item/W in affected_mob.get_equipped_items(TRUE))
			affected_mob.dropItemToGround(W)
		for(var/obj/item/I in affected_mob.held_items)
			affected_mob.dropItemToGround(I)
*/
		qdel(src)

//low regen over time
/mob/living/simple_animal/pet/plushie/Life(delta_time = SSMOBS_DT, times_fired) //yes i stole this from butter bear
	if(stat)
		return
	if(health < maxHealth)
		heal_overall_damage(5 * delta_time) //Fast life regen, makes it hard for you to get eaten to death.
