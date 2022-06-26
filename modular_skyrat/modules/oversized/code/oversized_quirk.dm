#define OVERSIZED_SPEED_SLOWDOWN 0.5
#define OVERSIZED_HUNGER_MOD 1.5

/datum/quirk/oversized
	name = "Oversized"
	desc = "You, for whatever reason, are FAR too tall, and will encounter some rough situations because of it."
	gain_text = span_notice("That airlock looks small...")
	lose_text = span_notice("Is it still the same size...?") //Lol
	medical_record_text = "Patient is abnormally tall."
	value = 0
	mob_trait = TRAIT_OVERSIZED
	icon = "expand-arrows-alt"
	veteran_only = TRUE

/datum/quirk/oversized/add()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.dna.features["body_size"] = 2
	human_holder.maptext_height = 32 * human_holder.dna.features["body_size"] //Adjust runechat height
	human_holder.dna.update_body_size()
	human_holder.mob_size = MOB_SIZE_LARGE
	human_holder.dna.species.punchdamagelow += OVERSIZED_HARM_DAMAGE_BONUS
	human_holder.dna.species.punchdamagehigh += OVERSIZED_HARM_DAMAGE_BONUS
	human_holder.blood_volume_normal = BLOOD_VOLUME_OVERSIZED
	human_holder.physiology.hunger_mod *= OVERSIZED_HUNGER_MOD //50% hungrier
	var/speed_mod = human_holder.dna.species.speedmod + OVERSIZED_SPEED_SLOWDOWN
	human_holder.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/species, multiplicative_slowdown = speed_mod)
	var/obj/item/organ/internal/stomach/old_stomach = human_holder.getorganslot(ORGAN_SLOT_STOMACH)
	if(!(old_stomach.type == /obj/item/organ/internal/stomach))
		return
	old_stomach.Remove(human_holder, special = TRUE)
	qdel(old_stomach)
	var/obj/item/organ/internal/stomach/oversized/new_stomach = new //YOU LOOK HUGE, THAT MUST MEAN YOU HAVE HUGE GUTS! RIP AND TEAR YOUR HUGE GUTS!
	new_stomach.Insert(human_holder, special = TRUE)
	to_chat(human_holder, span_warning("You feel your massive stomach rumble!"))
	var/obj/item/organ/external/tail/current_tail = human_holder.getorganslot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(current_tail) //Does the oversized one even have tail?
		var/obj/effect/proc_holder/spell/aoe_turf/repulse/oversized/tail = new /obj/effect/proc_holder/spell/aoe_turf/repulse/oversized
		var/datum/sprite_accessory/tails/type = current_tail.sprite_datum
		if(type.general_type == "marine") //Is it sHaRk?
			tail.action_icon_state = "tailsweepshark"
			tail.sparkle_path = /obj/effect/temp_visual/dir_setting/oversizedtailshark 
			var/datum/action/spell_action/spell/button = tail.action
			button.button_icon_state = "tailsweepshark" //It didn't update for some reason and always equals "tailsweep", so I had to cheat
			human_holder.mind.AddSpell(tail)
			to_chat(human_holder, span_notice("Your tail feels powerful!"))
		else //No fishe?
			human_holder.mind.AddSpell(tail)
			to_chat(human_holder, span_notice("Your tail feels powerful!"))
	
/datum/quirk/oversized/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.dna.features["body_size"] = human_holder?.client?.prefs ?human_holder?.client?.prefs?.read_preference(/datum/preference/numeric/body_size) : 1
	human_holder.maptext_height = 32 * human_holder.dna.features["body_size"]
	human_holder.dna.update_body_size()
	human_holder.mob_size = MOB_SIZE_HUMAN
	human_holder.dna.species.punchdamagelow -= OVERSIZED_HARM_DAMAGE_BONUS
	human_holder.dna.species.punchdamagehigh -= OVERSIZED_HARM_DAMAGE_BONUS
	human_holder.blood_volume_normal = BLOOD_VOLUME_NORMAL
	human_holder.physiology.hunger_mod /= OVERSIZED_HUNGER_MOD
	var/speedmod = human_holder.dna.species.speedmod
	human_holder.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/species, multiplicative_slowdown=speedmod)
	var/obj/item/organ/external/tail/current_tail = human_holder.getorganslot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(current_tail) 
		human_holder.mind.RemoveSpell(/obj/effect/proc_holder/spell/aoe_turf/repulse/oversized)
		to_chat(human_holder, span_warning("Your tail feels... okay."))


#undef OVERSIZED_HUNGER_MOD
#undef OVERSIZED_SPEED_SLOWDOWN

/obj/effect/temp_visual/dir_setting/oversizedtailshark
	icon = 'modular_skyrat/modules/oversized/icons/effects.dmi'
	icon_state = "oversizedtailshark"
	duration = 4

/obj/effect/temp_visual/dir_setting/oversizedtail
	icon = 'modular_skyrat/modules/oversized/icons/effects.dmi'
	icon_state = "oversizedtail"
	duration = 4

/obj/effect/proc_holder/spell/aoe_turf/repulse/oversized //ctrl+c ctrl+v from xeno tail sweep
	name = "Tail Sweep"
	desc = "Throw back attackers with a sweep of your tail."
	sound = 'sound/magic/tail_swing.ogg'
	charge_max = 500 // 500 is enough I think
	clothes_req = FALSE
	range = 2 
	cooldown_min = 500
	invocation_type = INVOCATION_NONE
	sparkle_path = /obj/effect/temp_visual/dir_setting/oversizedtail
	action_icon = 'modular_skyrat/modules/oversized/icons/actions.dmi'
	action_icon_state = "tailsweep"
	action_background_icon_state = "bg_spell"
	antimagic_flags = NONE
	

/obj/effect/proc_holder/spell/aoe_turf/repulse/oversized/cast(list/targets, mob/user = usr)
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		C.spin(6,1)
		C.apply_damage(30, STAMINA, BODY_ZONE_CHEST)
	..(targets, user, 60)
