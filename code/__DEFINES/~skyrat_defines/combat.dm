#define TRAIT_ALREADYSTAMINAFLOORED    	"alreadystaminafloored" //Trait to keep track whether someone was floored recently by stamina damage.
#define STAMINA_KNOCKDOWN_COOLDOWN 10 SECONDS

#define MAX_HUMAN_LIFE 135

//APPLICATION OF STAM DAMAGE
//Should maybe wounds do it too?
//This one is applied on non-glancing melee attacks aswell as normal projectiles.
#define SIMPLE_MOB_TISSUE_DAMAGE_STAMINA_MULTIPLIER 1.7 //Fights with simple mobs are usually more sustained, so apply a bit less
#define BLUNT_TISSUE_DAMAGE_STAMINA_MULTIPLIER 1.8 //Brute that isnt sharp, knocks the wind outta you real good
#define OTHER_TISSUE_DAMAGE_STAMINA_MULTIPLIER 1.5 //Burns, sharp implements
#define PROJECTILE_TISSUE_DAMAGE_STAMINA_MULTIPLIER 1

//Glancing attacks happen when someone uses disarm intent with melee weaponry, aiming to disable a person instead
#define TISSUE_DAMAGE_GLANCING_DAMAGE_MULTIPLIER 0.5
#define BLUNT_TISSUE_DAMAGE_GLANCING_STAMINA_MULTIPLIER 4.2 //This is also multiplied by the glancing damage multiplier, so usually less
#define OTHER_TISSUE_DAMAGE_GLANCING_STAMINA_MULTIPLIER 3.6

#define PUNCH_STAMINA_MULTIPLIER 2.6

//STAMINA REGEN
#define STAMINA_STATIC_REGEN_MULTIPLIER 0.4
//Flat amount regenerated per 2 seconds, multiplied by a lot of variables
#define STAMINA_STATIC_REGEN_FLAT 1.8
//Extra flat of regeneration while we're in crit
#define STAMINA_EXTRA_FLAT_IN_CRIT 0.5
//This increases the multiplier in relation to current stamina (staminaloss/THIS)
#define STAMINALOSS_REGEN_COEFF 50

//Thresholds for detrimental effects from stamina
#define STAMINA_THRESHOLD_WEAK 60

#define STAMINA_THRESHOLD_KNOCKDOWN 120

#define STAMINA_THRESHOLD_SOFTCRIT 150

#define STAMINA_THRESHOLD_HARDCRIT 150

//Stamina threshold from which resisting a grab becomes hard
#define STAMINA_THRESHOLD_HARD_RESIST 80

//A coefficient for doing the change of random CC's on a person (staminaloss/THIS)
#define STAMINA_CROWD_CONTROL_COEFF 200

//Resting thresholds
#define STAMINA_THRESHOLD_MEDIUM_GET_UP 50
#define STAMINA_THRESHOLD_SLOW_GET_UP 100

//Standing times in seconds
#define GET_UP_FAST 0.6
#define GET_UP_MEDIUM 1.5
#define GET_UP_SLOW 3

//Stamina threshold for attacking slower with items
#define STAMINA_THRESHOLD_TIRED_CLICK_CD 120
#define CLICK_CD_MELEE_TIRED 11 //#define CLICK_CD_MELEE 8, so 38% slower
#define CLICK_CD_RANGE_TIRED 5 //#define CLICK_CD_RANGE 4, so 25% slower

#define STAMINA_THRESHOLD_MESSAGE_ACHE 40
#define STAMINA_THRESHOLD_MESSAGE_MILD 60
#define STAMINA_THRESHOLD_MESSAGE_MEDIUM 80
#define STAMINA_THRESHOLD_MESSAGE_HIGH 100
#define STAMINA_THRESHOLD_MESSAGE_SEVERE 120
#define STAMINA_THRESHOLD_MESSAGE_OHGOD 190

#define STAMINA_MESSAGE_COOLDOWN 20 SECONDS

//Grab breakout odds
#define OVERSIZED_GRAB_RESIST_BONUS 10 /// For those with the oversized trait, they get this.

// Damage modifiers
#define OVERSIZED_HARM_DAMAGE_BONUS 5 /// Those with the oversized trait do 5 more damage.

#define FILTER_STAMINACRIT filter(type="drop_shadow", x=0, y=0, size=-3, color="#04080F")

/mob/living/carbon
	var/next_stamina_message = 0

//Force mob to rest, does NOT do stamina damage.
//It's really not recommended to use this proc to give feedback, hence why silent is defaulting to true.
/mob/living/carbon/proc/KnockToFloor(silent = TRUE, ignore_canknockdown = FALSE, knockdown_amt = 1)
	if(!silent && body_position != LYING_DOWN)
		to_chat(src, span_warning("You are knocked to the floor!"))
	Knockdown(knockdown_amt, ignore_canknockdown)

/mob/living/proc/StaminaKnockdown(stamina_damage, disarm, brief_stun, hardstun, ignore_canknockdown = FALSE, paralyze_amount, knockdown_amt = 1)
	if(!stamina_damage)
		return
	return Paralyze((paralyze_amount ? paralyze_amount : stamina_damage))

/mob/living/carbon/StaminaKnockdown(stamina_damage, disarm, brief_stun, hardstun, ignore_canknockdown = FALSE, paralyze_amount, knockdown_amt = 1)
	if(!stamina_damage)
		return
	if(!ignore_canknockdown && !(status_flags & CANKNOCKDOWN))
		return FALSE
	if(istype(buckled, /obj/vehicle/ridden))
		buckled.unbuckle_mob(src)
	KnockToFloor(TRUE, ignore_canknockdown, knockdown_amt)
	adjustStaminaLoss(stamina_damage)
	if(disarm)
		drop_all_held_items()
	if(brief_stun)
		//Stun doesnt send a proper signal to stand up, so paralyze for now
		Paralyze(0.25 SECONDS)
	if(hardstun)
		Paralyze((paralyze_amount ? paralyze_amount : stamina_damage))

#define HEADSMASH_BLOCK_ARMOR 20

//TODO: Add a grab state check on the do_mobs
/datum/species/proc/try_grab_maneuver(mob/living/carbon/human/user, mob/living/carbon/human/target, modifiers)
	var/obj/item/bodypart/affecting = target.get_bodypart(ran_zone(user.zone_selected))
	if(!affecting)
		return FALSE
	. = FALSE
	if(HAS_TRAIT(user, TRAIT_PACIFISM)) //They're mostly violent acts
		return
	if(user.combat_mode)
		switch(user.zone_selected)
			if(BODY_ZONE_HEAD)
				//Head slam
				if(target.body_position == LYING_DOWN)
					. = TRUE
					var/time_doing = 4 SECONDS
					if(target.stat != CONSCIOUS)
						time_doing = 2 SECONDS
						target.visible_message(span_danger("[user.name] holds [target.name]'s head tight and slams it down!"), ignored_mobs=user)
						to_chat(user, span_danger("You grasp [target.name]'s head and slam it down!"))
					else
						target.visible_message(span_danger("[user.name] holds [target.name]'s head and tries to overpower [target.p_them()]!"), \
							span_userdanger("You struggle as [user.name] holds your head and tries to overpower you!"), ignored_mobs=user)
						to_chat(user, span_danger("You grasp [target.name]'s head and try to overpower [target.p_them()]..."))
					user.changeNext_move(time_doing)
					if(do_mob(user, target, time_doing))
						var/armor_block = target.run_armor_check(affecting, MELEE)
						var/head_knock = FALSE
						if(armor_block < HEADSMASH_BLOCK_ARMOR)
							head_knock = TRUE

						target.visible_message(span_danger("[user.name] violently slams [target.name]'s head into the floor!"), \
							span_userdanger("[user.name] slams your head against the floor!"), ignored_mobs=user)
						to_chat(user, span_danger("You slam [target.name] head against the floor!"))

						//Check to see if our head is protected by at least 20 melee armor
						if(head_knock)
							target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 15)

						target.apply_damage(15, BRUTE, affecting, armor_block)
						playsound(target, 'sound/effects/hit_kick.ogg', 70)
						log_combat(user, target, "headsmashes", "against the floor")

	//Chances are, no matter what you do on disarm you're gonna break your grip by accident because of shoving, let make a good use of disarm intent for maneuvers then
	if(modifiers && modifiers["right"])
		switch(user.zone_selected)
			if(BODY_ZONE_CHEST)
				if(istype(user.mind.martial_art, /datum/martial_art/cqc)) //If you know CQC, You can't suplex and instead have the ability to use the chokehold, Sorry.
					return
				//Suplex!
				. = TRUE
				user.changeNext_move(3 SECONDS)
				target.visible_message(span_danger("[user.name] holds [target.name] tight and starts lifting [target.p_them()] up!"), \
						span_userdanger("[user.name] holds you tight and lifts you up!"), ignored_mobs=user)
				to_chat(user, span_danger("You hold [target.name] tight and lift [target.p_them()] up..."))
				if(do_mob(user, target, 3 SECONDS))
					var/move_dir = get_dir(target, user)
					var/moved_turf = get_turf(target)
					for(var/i in 1 to 2)
						var/turf/next_turf = get_step(moved_turf, move_dir)
						if(IS_OPAQUE_TURF(next_turf))
							break
						moved_turf = next_turf
					target.visible_message(span_danger("[user.name] suplexes [target.name] down to the ground!"), \
						span_userdanger("[user.name] suplexes you!"), ignored_mobs=user)
					to_chat(user, span_danger("You suplex [target.name]!"))
					user.StaminaKnockdown(30, TRUE, TRUE)
					user.SpinAnimation(7,1)
					target.SpinAnimation(7,1)
					target.throw_at(moved_turf, 1, 1)
					target.StaminaKnockdown(80)
					target.Paralyze(2 SECONDS)
					log_combat(user, target, "suplexes", "down on the ground (knocking down both)")
			else
				var/datum/wound/blunt/blute_wound = affecting.get_wound_type(/datum/wound/blunt)
				if(blute_wound && blute_wound.severity >= WOUND_SEVERITY_MODERATE)
					//At this point we'll be doing the medical action that's not a grab manevour
					return
				//Dislocation
				. = TRUE
				user.changeNext_move(4 SECONDS)
				target.visible_message(span_danger("[user.name] twists [target.name]'s [affecting.name] violently!"), \
						span_userdanger("[user.name] twists your [affecting.name] violently!"), ignored_mobs=user)
				to_chat(user, span_danger("You start twisting [target.name]'s [affecting.name] violently!"))
				if(do_mob(user, target, 4 SECONDS))
					target.visible_message(span_danger("[user.name] dislocates [target.name]'s [affecting.name]!"), \
						span_userdanger("[user.name] dislocates your [affecting.name]!"), ignored_mobs=user)
					to_chat(user, span_danger("You dislocate [target.name]'s [affecting.name]!"))
					affecting.force_wound_upwards(/datum/wound/blunt/moderate)
					log_combat(user, target, "dislocates", "the [affecting.name]")

	if(.)
		user.changeNext_move(CLICK_CD_MELEE)
	return

#undef HEADSMASH_BLOCK_ARMOR
