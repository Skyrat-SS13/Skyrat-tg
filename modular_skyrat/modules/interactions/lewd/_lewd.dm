#define CUM_TARGET_MOUTH "mouth"
#define CUM_TARGET_THROAT "throat"
#define CUM_TARGET_VAGINA "vagina"
#define CUM_TARGET_ANUS "anus"
#define CUM_TARGET_HAND "hand"
#define CUM_TARGET_BREASTS "breasts"
#define CUM_TARGET_FEET "feet"
//Weird defines go here
#define CUM_TARGET_EARS "ears"
#define CUM_TARGET_EYES "eyes"
//
#define GRINDING_FACE_WITH_ANUS "faceanus"
#define GRINDING_FACE_WITH_FEET "facefeet"
#define GRINDING_MOUTH_WITH_FEET "mouthfeet"
#define THIGH_SMOTHERING "thigh_smother"
#define NUTS_TO_FACE "nut_face"

#define REQUIRE_NONE 0
#define REQUIRE_EXPOSED 1
#define REQUIRE_UNEXPOSED 2
#define REQUIRE_ANY 3

/*--------------------------------------------------
  -------------------MOB STUFF----------------------
  --------------------------------------------------
*/
//I'm sorry, lewd should not have mob procs such as life() and such in it. //NO SHIT IT SHOULDNT I REMOVED THEM

// Lewd interactions have a blacklist for certain mobs. When we evalute the user and target, both of
// their requirements must be satisfied, and the mob must not be of a blacklisted type.
// This should not be too weighty on the server, as the check is only run to generate the menu options.
/datum/interaction/lewd/evaluate_user(mob/living/user, silent, action_check)
	. = ..()
	if(.)
		if((user.stat == DEAD))
			return FALSE
		for(var/check in blacklisted_mobs)
			if(istype(user, check))
				return FALSE

/datum/interaction/lewd/evaluate_target(mob/living/user, mob/living/target, silent = TRUE)
	. = ..()
	if(.)
		if((target.stat == DEAD))
			return FALSE
		for(var/check in blacklisted_mobs)
			if(istype(target, check))
				return FALSE

/proc/playlewdinteractionsound(turf/turf_source, soundin, vol as num, vary, extrarange as num ,frequency, falloff, channel = 0, pressure_affected = TRUE, sound/S, envwet = -10000, envdry = 0, manual_x, manual_y)
	var/list/hearing_mobs
	for(var/mob/H in get_hearers_in_view(4, turf_source))
		LAZYADD(hearing_mobs, H)
	for(var/mob/H in hearing_mobs)
		H.playsound_local(turf_source, soundin, vol, vary, frequency, falloff)

/mob/living
	var/has_penis = FALSE
	var/has_vagina = FALSE
	var/has_breasts = FALSE
	var/anus_exposed = FALSE
	var/last_partner
	var/last_orifice
	var/obj/item/organ/last_genital
	var/lastmoan
	var/sexual_potency =  15
	var/lust_tolerance = 100
	var/lastlusttime = 0
	var/multiorgasms = 1
	var/refractory_period = 0
	var/last_interaction_time = 0
	var/datum/interaction/lewd/last_lewd_datum //Recording our last lewd datum allows us to do stuff like custom cum messages.
											   //Yes i feel like an idiot writing this.
	var/cleartimer //Timer for clearing the "last_lewd_datum". This prevents some oddities.

/mob/living/proc/clear_lewd_datum()
	last_lewd_datum = null
	last_genital = null

/mob/living/Initialize()
	. = ..()

/mob/living/proc/get_refraction_dif()
	var/dif = (refractory_period - world.time)
	if(dif < 0)
		return 0
	else
		return dif

/mob/living/proc/moan()
	var/moan = rand(1, 7)
	if(prob(src.arousal))
		if(moan == lastmoan)
			moan--
		if(!is_muzzled())
			visible_message(message = "<font color=purple><B>\The [src]</B> [pick("moans", "moans in pleasure")].</font>", ignored_mobs = get_unconsenting())
		if(is_muzzled())//immursion
			visible_message("<font color=purple><B>[src]</B> [pick("mimes a pleasured moan","moans in silence")].</font>")
		lastmoan = moan
	else
		return

/mob/living/proc/cum(mob/living/partner, target_orifice)
	var/message
	if(src != partner)
		if(!last_genital)
			if(has_penis())
				if(!istype(partner))
					target_orifice = null
				switch(target_orifice)
					if(CUM_TARGET_MOUTH)
						if(partner.has_mouth() && partner.mouth_is_free())
							message = "cums right in \the <b>[partner]</b>'s mouth."
						else
							message = "cums on \the <b>[partner]</b>'s face."
					if(CUM_TARGET_THROAT)
						if(partner.has_mouth() && partner.mouth_is_free())
							message = "shoves deep into \the <b>[partner]</b>'s throat and cums."
						else
							message = "cums on \the <b>[partner]</b>'s face."
					if(CUM_TARGET_VAGINA)
						if(partner.has_vagina(REQUIRE_EXPOSED))
							message = "cums in \the <b>[partner]</b>'s pussy."
						else
							message = "cums on \the <b>[partner]</b>'s belly."
					if(CUM_TARGET_ANUS)
						if(partner.has_anus(REQUIRE_EXPOSED))
							message = "cums in \the <b>[partner]</b>'s asshole."
						else
							message = "cums on \the <b>[partner]</b>'s backside."
					if(CUM_TARGET_HAND)
						if(partner.has_arms(REQUIRE_ANY))
							message = "cums in \the <b>[partner]</b>'s hand."
						else
							message = "cums on \the <b>[partner]</b>."
					if(CUM_TARGET_BREASTS)
						if(partner.has_breasts(REQUIRE_EXPOSED))
							message = "cums onto \the <b>[partner]</b>'s breasts."
						else
							message = "cums on \the <b>[partner]</b>'s chest and neck."
					if(NUTS_TO_FACE)
						if(partner.has_mouth() && partner.mouth_is_free())
							message = "vigorously ruts their nutsack into \the <b>[partner]</b>'s mouth before shooting their thick, sticky jizz all over their eyes and hair."
					if(THIGH_SMOTHERING)
						if(src.has_penis(REQUIRE_EXPOSED)) //it already checks for the cock before, why the hell would you do this redundant shit
							message = "keeps \the <b>[partner]</b> locked in their thighs as their cock throbs, dumping its heavy load all over their face."
						else
							message = "reaches their peak, locking their legs around \the <b>[partner]</b>'s head extra hard as they cum straight onto the head stuck between their thighs"
					if(CUM_TARGET_FEET)
						if(!last_lewd_datum.require_target_num_feet)
							if(partner.has_feet())
								message = "cums on \the <b>[partner]</b>'s [partner.has_feet() == 1 ? pick("foot", "sole") : pick("feet", "soles")]."
							else
								message = "cums on the floor!"
						else
							if(partner.has_feet())
								message = "cums on \the <b>[partner]</b>'s [last_lewd_datum.require_target_feet == 1 ? pick("foot", "sole") : pick("feet", "soles")]."
							else
								message = "cums on the floor!"
					//weird shit goes here
					if(CUM_TARGET_EARS)
						if(partner.has_ears())
							message = "cums inside \the <b>[partner]</b>'s ear."
						else
							message = "cums inside \the <b>[partner]</b>'s earsocket."
					if(CUM_TARGET_EYES)
						if(partner.has_eyes())
							message = "cums on \the <b>[partner]</b>'s eyeball."
						else
							message = "cums inside \the <b>[partner]</b>'s eyesocket."
					//

					else
						message = "cums on the floor!"
			else if(has_vagina())
				if(!istype(partner))
					target_orifice = null

				switch(target_orifice)
					if(CUM_TARGET_MOUTH)
						if(partner.has_mouth() && partner.mouth_is_free())
							message = "squirts right in \the <b>[partner]</b>'s mouth."
						else
							message = "squirts on \the <b>[partner]</b>'s face."
					if(CUM_TARGET_THROAT)
						if(partner.has_mouth() && partner.mouth_is_free())
							message = "rubs their vagina against \the <b>[partner]</b>'s mouth and cums."
						else
							message = "squirts on \the <b>[partner]</b>'s face."
					if(CUM_TARGET_VAGINA)
						if(partner.has_vagina(REQUIRE_EXPOSED))
							message = "squirts on \the <b>[partner]</b>'s pussy."
						else
							message = "squirts on \the <b>[partner]</b>'s belly."
					if(CUM_TARGET_ANUS)
						if(partner.has_anus(REQUIRE_EXPOSED))
							message = "squirts on \the <b>[partner]</b>'s asshole."
						else
							message = "squirts on \the <b>[partner]</b>'s backside."
					if(CUM_TARGET_HAND)
						if(partner.has_arms(REQUIRE_ANY))
							message = "squirts on \the <b>[partner]</b>'s hand."
						else
							message = "squirts on \the <b>[partner]</b>."
					if(CUM_TARGET_BREASTS)
						if(partner.has_breasts(REQUIRE_EXPOSED))
							message = "squirts onto \the <b>[partner]</b>'s breasts."
						else
							message = "squirts on \the <b>[partner]</b>'s chest and neck."
					if(NUTS_TO_FACE)
						if(partner.has_mouth() && partner.mouth_is_free())
							message = "vigorously ruts their clit into \the <b>[partner]</b>'s mouth before shooting their femcum all over their eyes and hair."
					if(THIGH_SMOTHERING)
						message = "keeps \the <b>[partner]</b> locked in their thighs as they orgasm, squirting over their face."
					if(CUM_TARGET_FEET)
						if(!last_lewd_datum.require_target_num_feet)
							if(partner.has_feet())
								message = "squirts on \the <b>[partner]</b>'s [partner.has_feet() == 1 ? pick("foot", "sole") : pick("feet", "soles")]."
							else
								message = "squirts on the floor!"
						else
							if(partner.has_feet())
								message = "squirts on \the <b>[partner]</b>'s [last_lewd_datum.require_target_feet == 1 ? pick("foot", "sole") : pick("feet", "soles")]."
							else
								message = "squirts on the floor!"
					//weird shit goes here
					if(CUM_TARGET_EARS)
						if(partner.has_ears())
							message = "squirts on \the <b>[partner]</b>'s ear."
						else
							message = "squirts on \the <b>[partner]</b>'s earsocket."
					if(CUM_TARGET_EYES)
						if(partner.has_eyes())
							message = "squirts on \the <b>[partner]</b>'s eyeball."
						else
							message = "squirts on \the <b>[partner]</b>'s eyesocket."
					else
						message = "squirts on the floor!"

			else
				message = pick("orgasms violently!", "twists in orgasm.")
		else
			switch(last_genital.type)
				if(/obj/item/organ/genital/penis)
					if(!istype(partner))
						target_orifice = null

					switch(target_orifice)
						if(CUM_TARGET_MOUTH)
							if(partner.has_mouth() && partner.mouth_is_free())
								message = "cums right in \the <b>[partner]</b>'s mouth."
							else
								message = "cums on \the <b>[partner]</b>'s face."
						if(CUM_TARGET_THROAT)
							if(partner.has_mouth() && partner.mouth_is_free())
								message = "shoves deep into \the <b>[partner]</b>'s throat and cums."
							else
								message = "cums on \the <b>[partner]</b>'s face."
						if(CUM_TARGET_VAGINA)
							if(partner.has_vagina(REQUIRE_EXPOSED))
								message = "cums in \the <b>[partner]</b>'s pussy."
							else
								message = "cums on \the <b>[partner]</b>'s belly."
						if(CUM_TARGET_ANUS)
							if(partner.has_anus(REQUIRE_EXPOSED))
								message = "cums in \the <b>[partner]</b>'s asshole."
							else
								message = "cums on \the <b>[partner]</b>'s backside."
						if(CUM_TARGET_HAND)
							if(partner.has_arms())
								message = "cums in \the <b>[partner]</b>'s hand."
							else
								message = "cums on \the <b>[partner]</b>."
						if(CUM_TARGET_BREASTS)
							if(partner.is_topless() && partner.has_breasts())
								message = "cums onto \the <b>[partner]</b>'s breasts."
							else
								message = "cums on \the <b>[partner]</b>'s chest and neck."
						if(NUTS_TO_FACE)
							if(partner.has_mouth() && partner.mouth_is_free())
								message = "vigorously ruts their nutsack into \the <b>[partner]</b>'s mouth before shooting their thick, sticky jizz all over their eyes and hair."
						if(THIGH_SMOTHERING)
							if(src.has_penis()) //it already checks for the cock before, why the hell would you do this redundant shit
								message = "keeps \the <b>[partner]</b> locked in their thighs as their cock throbs, dumping its heavy load all over their face."
							else
								message = "reaches their peak, locking their legs around \the <b>[partner]</b>'s head extra hard as they cum straight onto the head stuck between their thighs"
						if(CUM_TARGET_FEET)
							if(!last_lewd_datum || !last_lewd_datum.require_target_num_feet)
								if(partner.has_feet())
									message = "cums on \the <b>[partner]</b>'s [partner.has_feet() == 1 ? pick("foot", "sole") : pick("feet", "soles")]."
								else
									message = "cums on the floor!"
							else
								if(partner.has_feet())
									message = "cums on \the <b>[partner]</b>'s [last_lewd_datum.require_target_feet == 1 ? pick("foot", "sole") : pick("feet", "soles")]."
								else
									message = "cums on the floor!"
						//weird shit goes here
						if(CUM_TARGET_EARS)
							if(partner.has_ears())
								message = "cums inside \the <b>[partner]</b>'s ear."
							else
								message = "cums inside \the <b>[partner]</b>'s earsocket."
						if(CUM_TARGET_EYES)
							if(partner.has_eyes())
								message = "cums on \the <b>[partner]</b>'s eyeball."
							else
								message = "cums inside \the <b>[partner]</b>'s eyesocket."
						else
							message = "cums on the floor!"
				if(/obj/item/organ/genital/vagina)
					if(!istype(partner))
						target_orifice = null

					switch(target_orifice)
						if(CUM_TARGET_MOUTH)
							if(partner.has_mouth() && partner.mouth_is_free())
								message = "squirts right in \the <b>[partner]</b>'s mouth."
							else
								message = "squirts on \the <b>[partner]</b>'s face."
						if(CUM_TARGET_THROAT)
							if(partner.has_mouth() && partner.mouth_is_free())
								message = "rubs their vagina against \the <b>[partner]</b>'s mouth and cums."
							else
								message = "squirts on \the <b>[partner]</b>'s face."
						if(CUM_TARGET_VAGINA)
							if(partner.has_vagina(REQUIRE_EXPOSED))
								message = "squirts on \the <b>[partner]</b>'s pussy."
							else
								message = "squirts on \the <b>[partner]</b>'s belly."
						if(CUM_TARGET_ANUS)
							if(partner.has_anus(REQUIRE_EXPOSED))
								message = "squirts on \the <b>[partner]</b>'s asshole."
							else
								message = "squirts on \the <b>[partner]</b>'s backside."
						if(CUM_TARGET_HAND)
							if(partner.has_arms())
								message = "squirts on \the <b>[partner]</b>'s hand."
							else
								message = "squirts on \the <b>[partner]</b>."
						if(CUM_TARGET_BREASTS)
							if(partner.has_breasts(REQUIRE_EXPOSED))
								message = "squirts onto \the <b>[partner]</b>'s breasts."
							else
								message = "squirts on \the <b>[partner]</b>'s chest and neck."
						if(NUTS_TO_FACE)
							if(partner.has_mouth() && partner.mouth_is_free())
								message = "vigorously ruts their clit into \the <b>[partner]</b>'s mouth before shooting their femcum all over their eyes and hair."

						if(THIGH_SMOTHERING)
							message = "keeps \the <b>[partner]</b> locked in their thighs as they orgasm, squirting over their face."

						if(CUM_TARGET_FEET)
							if(!last_lewd_datum || !last_lewd_datum.require_target_num_feet)
								if(partner.has_feet())
									message = "squirts on \the <b>[partner]</b>'s [partner.has_feet() == 1 ? pick("foot", "sole") : pick("feet", "soles")]."
								else
									message = "squirts on the floor!"
							else
								if(partner.has_feet())
									message = "squirts on \the <b>[partner]</b>'s [last_lewd_datum.require_target_feet == 1 ? pick("foot", "sole") : pick("feet", "soles")]."
								else
									message = "squirts on the floor!"
						//weird shit goes here
						if(CUM_TARGET_EARS)
							if(partner.has_ears())
								message = "squirts on \the <b>[partner]</b>'s ear."
							else
								message = "squirts on \the <b>[partner]</b>'s earsocket."
						if(CUM_TARGET_EYES)
							if(partner.has_eyes())
								message = "squirts on \the <b>[partner]</b>'s eyeball."
							else
								message = "squirts on \the <b>[partner]</b>'s eyesocket."
						else
							message = "squirts on the floor!"
				else
					message = pick("orgasms violently!", "twists in orgasm.")
	else
		message = "cums all over themselves!"
	visible_message(message = "<span class='userlove'><b>\The [src]</b> [message]</span>", ignored_mobs = get_unconsenting())
	multiorgasms += 1
	src.climax()

/mob/living/proc/is_fucking(mob/living/partner, orifice)
	if(partner == last_partner && orifice == last_orifice)
		return TRUE
	return FALSE

/mob/living/proc/set_is_fucking(mob/living/partner, orifice, var/obj/item/organ/genital/genepool)
	last_partner = partner
	last_orifice = orifice
	last_genital = genepool

/*--------------------------------------------------
  ---------------LEWD PROCESS DATUM-----------------
  --------------------------------------------------
 */

/mob/living/proc/do_oral(mob/living/partner, var/fucktarget = "penis")
	var/message
	var/obj/item/organ/genital/peepee = null

	if(partner.is_fucking(src, CUM_TARGET_MOUTH))
		if(prob(partner.sexual_potency))
			if(istype(src, /mob/living)) // Argh.
				var/mob/living/H = src
				H.adjustOxyLoss(3)
			message = "goes in deep on \the <b>[partner]</b>."
		else
			var/improv = FALSE
			switch(fucktarget)
				if("vagina")
					if(partner.has_vagina())
						message = pick(
							"licks \the <b>[partner]</b>'s pussy.",
							"runs their tongue up the shape of \the <b>[partner]</b>'s pussy.",
							"traces \the <b>[partner]</b>'s slit with their tongue.",
							"darts the tip of their tongue around \the <b>[partner]</b>'s clit.",
							"laps slowly at \the <b>[partner]</b>.",
							"kisses \the <b>[partner]</b>'s delicate folds.",
							"tastes \the <b>[partner]</b>.",
						)
					else
						improv = TRUE
				if("penis")
					if(partner.has_penis())
						message = pick(
							"sucks \the <b>[partner]</b>'s off.",
							"runs their tongue up the shape of \the <b>[partner]</b>'s cock.",
							"traces \the <b>[partner]</b>'s cock with their tongue.",
							"darts the tip of their tongue around tip of \the <b>[partner]</b>'s cock.",
							"laps slowly at \the <b>[partner]</b>'s shaft.",
							"kisses the base of \the <b>[partner]</b>'s shaft.",
							"takes \the <b>[partner]</b> deeper into their mouth.",
						)
					else
						improv = TRUE
			if(improv)
				// get confused about how to do the sex
				message = pick(
					"licks \the <b>[partner]</b>.",
					"looks a little unsure of where to lick \the <b>[partner]</b>.",
					"runs their tongue between \the <b>[partner]</b>'s legs.",
					"kisses \the <b>[partner]</b>'s thigh.",
					"tries their best with \the <b>[partner]</b>.",
				)
	else
		var/improv = FALSE
		switch(fucktarget)
			if("vagina")
				if(partner.has_vagina())
					message = pick(
						"buries their face in \the <b>[partner]</b>'s pussy.",
						"nuzzles \the <b>[partner]</b>'s wet sex.",
						"finds their face caught between \the <b>[partner]</b>'s thighs.",
						"kneels down between \the <b>[partner]</b>'s legs.",
						"grips \the <b>[partner]</b>'s legs, pushing them apart.",
						"sinks their face in between \the <b>[partner]</b>'s thighs.",
					)
				else
					improv = TRUE
			if("penis")
				if(partner.has_penis())
					message = pick(
						"takes \the <b>[partner]</b>'s cock into their mouth.",
						"wraps their lips around \the <b>[partner]</b>'s cock.",
						"finds their face between \the <b>[partner]</b>'s thighs.",
						"kneels down between \the <b>[partner]</b>'s legs.",
						"grips \the <b>[partner]</b>'s legs, kissing at the tip of their cock.",
						"goes down on \the <b>[partner]</b>.",
					)
				else
					improv = TRUE
		if(improv)
			message = pick(
				"begins to lick \the <b>[partner]</b>.",
				"starts kissing \the <b>[partner]</b>'s thigh.",
				"sinks down between \the <b>[partner]</b>'s thighs.",
				"briefly flashes a puzzled look from between \the <b>[partner]</b>'s legs.",
				"looks unsure of how to handle \the <b>[partner]</b>'s lack of genitalia.",
				"seems like they were expecting \the <b>[partner]</b> to have a cock or a pussy or ... something.",
			)
			peepee = null
		else
			if(ishuman(partner))
				var/mob/living/carbon/human/pardner = partner
				switch(fucktarget)
					if("vagina")
						peepee = pardner.getorganslot(ORGAN_SLOT_VAGINA)
					if("penis")
						peepee = pardner.getorganslot(ORGAN_SLOT_PENIS)
		partner.set_is_fucking(src, CUM_TARGET_MOUTH, peepee)

	playlewdinteractionsound(get_turf(src), pick(	'modular_skyrat/modules/modular_items/lewd_items/sounds/bj1.ogg',
													'modular_skyrat/modules/modular_items/lewd_items/sounds/bj2.ogg',
													'modular_skyrat/modules/modular_items/lewd_items/sounds/bj3.ogg',
													'modular_skyrat/modules/modular_items/lewd_items/sounds/bj4.ogg',
													'modular_skyrat/modules/modular_items/lewd_items/sounds/bj5.ogg',
													'modular_skyrat/modules/modular_items/lewd_items/sounds/bj6.ogg',
													'modular_skyrat/modules/modular_items/lewd_items/sounds/bj7.ogg',
													'modular_skyrat/modules/modular_items/lewd_items/sounds/bj8.ogg',
													'modular_skyrat/modules/modular_items/lewd_items/sounds/bj9.ogg',
													'modular_skyrat/modules/modular_items/lewd_items/sounds/bj10.ogg',
													'modular_skyrat/modules/modular_items/lewd_items/sounds/bj11.ogg'), 50, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting())
	partner.handle_post_sex(CUM_TARGET_MOUTH, src)
	partner.dir = get_dir(partner,src)
	partner.adjustArousal(12)
	partner.adjustPleasure(9)

/mob/living/proc/do_facefuck(mob/living/partner, var/fucktarget = "penis")
	var/message
	var/obj/item/organ/genital/peepee = null
	var/retaliation_message = FALSE

	if(is_fucking(partner, CUM_TARGET_MOUTH))
		var/improv = FALSE
		switch(fucktarget)
			if("vagina")
				if(has_vagina())
					message = pick(
						"grinds their pussy into \the <b>[partner]</b>'s face.",
						"grips the back of \the <b>[partner]</b>'s head, forcing them onto their pussy.",
						"rolls their pussy against \the <b>[partner]</b>'s tongue.",
						"slides \the <b>[partner]</b>'s mouth between their legs.",
						"looks \the <b>[partner]</b>'s in the eyes as their pussy presses into a waiting tongue.",
						"sways their hips, pushing their sex into \the <b>[partner]</b>'s face.",
						)
				else
					improv = TRUE
			if("penis")
				if(has_penis())
					message = pick(
						"roughly fucks \the <b>[partner]</b>'s mouth.",
						"forces their cock down \the <b>[partner]</b>'s throat.",
						"pushes in against \the <b>[partner]</b>'s tongue until a tight gagging sound comes.",
						"grips \the <b>[partner]</b>'s hair and draws them to the base of the cock.",
						"looks \the <b>[partner]</b>'s in the eyes as their cock presses into a waiting tongue.",
						"rolls their hips hard, sinking into \the <b>[partner]</b>'s mouth.",
						)
				else
					improv = TRUE
		if(improv)
			message = pick(
				"grinds against \the <b>[partner]</b>'s face.",
				"feels \the <b>[partner]</b>'s face between bare legs.",
				"pushes in against \the <b>[partner]</b>'s tongue.",
				"grips \the <b>[partner]</b>'s hair, drawing them into the strangely sexless spot between their legs.",
				"looks \the <b>[partner]</b>'s in the eyes as they're caught beneath two thighs.",
				"rolls their hips hard against \the <b>[partner]</b>'s face.",
				)
	else
		var/improv = FALSE
		switch(fucktarget)
			if("vagina")
				if(has_vagina())
					message = "forces \the <b>[partner]</b>'s face into their pussy."
				else
					improv = TRUE
			if("penis")
				if(has_penis())
					if(is_fucking(partner, CUM_TARGET_THROAT))
						message = "retracts their cock from \the <b>[partner]</b>'s throat"
					else
						message = "shoves their cock into \the <b>[partner]</b>'s mouth"
				else
					improv = TRUE
		if(improv)
			message = "shoves their crotch into \the <b>[partner]</b>'s face."
		else
			if(ishuman(partner))
				var/mob/living/carbon/human/pardner = partner
				switch(fucktarget)
					if("vagina")
						peepee = pardner.getorganslot(ORGAN_SLOT_VAGINA)
					if("penis")
						peepee = pardner.getorganslot(ORGAN_SLOT_PENIS)
		set_is_fucking(partner , CUM_TARGET_MOUTH, peepee)

	playlewdinteractionsound(loc, pick(	'modular_skyrat/modules/modular_items/lewd_items/sounds/oral1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/oral2.ogg'), 70, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting())
	if(retaliation_message)
		visible_message(message = "<font color=red><b>\The <b>[partner]</b></b> [retaliation_message]</font>", ignored_mobs = get_unconsenting())
	handle_post_sex(CUM_TARGET_MOUTH, partner)
	partner.dir = get_dir(partner,src)
	partner.adjustArousal(8)
	partner.adjustPleasure(5)

/mob/living/proc/thigh_smother(mob/living/partner, var/fucktarget = "penis")

	var/message
	var/obj/item/organ/genital/peepee = null

	if(is_fucking(partner, THIGH_SMOTHERING))
		var/improv = FALSE
		switch(fucktarget)
			if("vagina")
				if(has_vagina())
					message = pick(list(
						"presses their weight down onto \the <b>[partner]</b>'s face, blocking their vision completely.",
						"rides \the <b>[partner]</b>'s face, grinding their wet pussy all over it."))
				else
					improv = TRUE
			if("penis")
				if(has_penis())
					message = pick(list("presses their weight down onto \the <b>[partner]</b>'s face, blocking their vision completely.",
						"forces their dick and nutsack into \the <b>[partner]</b>'s face as they're stuck locked in between their thighs.",
						"slips their cock into \the <b>[partner]</b>'s helpless mouth, keeping their shaft pressed hard into their face."))
				else
					improv = TRUE

		if(improv)
			message = "rubs their groin up and down \the <b>[partner]</b>'s face."

	else
		var/improv = FALSE
		switch(fucktarget)
			if("vagina")
				if(has_vagina())
					message = pick(list(
						"clambers over \the <b>[partner]</b>'s face and pins them down with their thighs, their moist slit rubbing all over \the <b>[partner]</b>'s mouth and nose.",
						"locks their legs around \the <b>[partner]</b>'s head before pulling it into their mound."))
				else
					improv = TRUE

			if("penis")
				if(has_penis())
					message = pick(list(
						"clambers over \the <b>[partner]</b>'s face and pins them down with their thighs, then slowly inching closer and covering their eyes and nose with their leaking erection.",
						"locks their legs around \the <b>[partner]</b>'s head before pulling it into their fat package, smothering them."))
				else
					improv = TRUE

		if(improv)
			message = "deviously locks their legs around \the <b>[partner]</b>'s head and smothers it in their thighs."
		else
			if(ishuman(partner))
				var/mob/living/carbon/human/pardner = partner
				switch(fucktarget)
					if("vagina")
						peepee = pardner.getorganslot(ORGAN_SLOT_VAGINA)
					if("penis")
						peepee = pardner.getorganslot(ORGAN_SLOT_PENIS)
		set_is_fucking(partner , THIGH_SMOTHERING, peepee)

	var file = pick('modular_skyrat/modules/modular_items/lewd_items/sounds/bj10.ogg',
					'modular_skyrat/modules/modular_items/lewd_items/sounds/bj3.ogg',
					'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_wet1.ogg',
					'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_dry3.ogg')

	playlewdinteractionsound(loc, file, 70, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting())
	handle_post_sex(THIGH_SMOTHERING, partner)
	partner.dir = get_dir(partner,src)
	playlewdinteractionsound(loc, pick(	'modular_skyrat/modules/modular_items/lewd_items/sounds/oral1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/oral2.ogg'), 70, 1, -1)
	handle_post_sex(CUM_TARGET_MOUTH, partner)
	partner.dir = get_dir(partner,src)
	partner.adjustArousal(12)
	partner.adjustPleasure(6)

/mob/living/proc/do_throatfuck(mob/living/partner)
	var/message
	var/obj/item/organ/genital/peepee = null
	var/retaliation_message = FALSE

	if(is_fucking(partner, CUM_TARGET_THROAT))
		message = "[pick(
			"brutally shoves their cock into  \the <b>[partner]</b>'s throat to make them gag.",
			"chokes \the <b>[partner]</b> on their dick, going in balls deep.",
			"slams in and out of \the <b>[partner]</b>'s mouth, their balls slapping off their face.")]"
		if(rand(3))
			partner.emote("chokes on \The [src]")
			if(prob(1) && istype(partner, /mob/living))
				var/mob/living/H = partner
				H.adjustOxyLoss(5)
	else if(is_fucking(partner, CUM_TARGET_MOUTH))
		message = "thrusts deeper into \the <b>[partner]</b>'s mouth and down their throat."
		if(ishuman(src))
			var/mob/living/carbon/human/coomer = partner
			peepee = coomer.getorganslot(ORGAN_SLOT_PENIS)
		set_is_fucking(partner , CUM_TARGET_THROAT, peepee)
	else
		message = "forces their dick deep down \the <b>[partner]</b>'s throat"
		if(ishuman(src))
			var/mob/living/carbon/human/coomer = partner
			peepee = coomer.getorganslot(ORGAN_SLOT_PENIS)
		set_is_fucking(partner , CUM_TARGET_THROAT, peepee)

	playlewdinteractionsound(loc, pick(	'modular_skyrat/modules/modular_items/lewd_items/sounds/oral1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/oral2.ogg'), 70, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting())
	if(retaliation_message)
		visible_message(message = "<font color=red><b>\The <b>[partner]</b></b> [retaliation_message]</font>", ignored_mobs = get_unconsenting())
	handle_post_sex(CUM_TARGET_THROAT, partner)
	partner.dir = get_dir(partner,src)
	partner.adjustArousal(6)
	partner.adjustPleasure(3)

/mob/living/proc/nut_face(var/mob/living/partner)
	var/message
	if(is_fucking(partner, NUTS_TO_FACE))
		message = pick(list(
			"grabs the back of <b>[partner]</b>'s head and pulls it into their crotch.",
			"jams their nutsack right into <b>[partner]</b>'s face.",
			"roughly grinds their fat nutsack into <b>[partner]</b>'s mouth.",
			"pulls out their saliva-covered nuts from <b>[partner]</b>'s violated mouth and then wipes off the slime onto their face."))
	else
		message = pick(list("wedges a digit into the side of <b>[partner]</b>'s jaw and pries it open before using their other hand to shove their whole nutsack inside!", "stands with their groin inches away from [partner]'s face, then thrusting their hips forward and smothering [partner]'s whole face with their heavy ballsack."))
		set_is_fucking(partner , NUTS_TO_FACE, getorganslot(ORGAN_SLOT_PENIS) ? getorganslot(ORGAN_SLOT_PENIS) : null)

	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting())
	handle_post_sex(CUM_TARGET_MOUTH, partner)
	partner.dir = get_dir(partner,src)
	partner.adjustArousal(6)
	partner.adjustPleasure(3)

/mob/living/proc/do_anal(mob/living/partner)
	var/message

	if(is_fucking(partner, CUM_TARGET_ANUS))
		message = "[pick(
			"thrusts in and out of \the <b>[partner]</b>'s ass.",
			"pounds \the <b>[partner]</b>'s ass.",
			"slams their hips up against \the <b>[partner]</b>'s ass hard.",
			"goes balls deep into \the <b>[partner]</b>'s ass over and over again.")]"
	else
		message = "[pick(
			"works their cock into \the <b>[partner]</b>'s asshole.",
			"grabs the base of their twitching cock and presses the tip into \the <b>[partner]</b>'s asshole.",
			"shoves their dick deep inside of \the <b>[partner]</b>'s ass, making their rear jiggle.")]"
		set_is_fucking(partner, CUM_TARGET_ANUS, getorganslot(ORGAN_SLOT_PENIS) ? getorganslot(ORGAN_SLOT_PENIS) : null)

	playlewdinteractionsound(loc, pick(	'modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg'), 70, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting())
	handle_post_sex(CUM_TARGET_ANUS, partner)
	partner.handle_post_sex(null, src)
	partner.dir = get_dir(src, partner)
	partner.adjustArousal(12)
	partner.adjustPleasure(9)
	src.adjustArousal(12)
	src.adjustPleasure(9)

/mob/living/proc/do_vaginal(mob/living/partner)
	var/message
	if(is_fucking(partner, CUM_TARGET_VAGINA))
		message = "[pick(
			"pounds \the <b>[partner]</b>'s pussy.",
			"shoves their dick deep into \the <b>[partner]</b>'s pussy",
			"thrusts in and out of \the <b>[partner]</b>'s cunt.",
			"goes balls deep into \the <b>[partner]</b>'s pussy over and over again.")]"
	else
		message = "slides their cock into \the <b>[partner]</b>'s pussy."
		set_is_fucking(partner, CUM_TARGET_VAGINA, getorganslot(ORGAN_SLOT_PENIS) ? getorganslot(ORGAN_SLOT_PENIS) : null)

	playlewdinteractionsound(loc, pick(	'modular_skyrat/modules/modular_items/lewd_items/sounds/champ1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/champ2.ogg'), 50, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting())
	handle_post_sex(CUM_TARGET_VAGINA, partner)
	partner.handle_post_sex(null, src)
	partner.dir = get_dir(partner,src)
	partner.adjustArousal(12)
	partner.adjustPleasure(9)
	src.adjustArousal(12)
	src.adjustPleasure(9)

/mob/living/proc/do_mount(mob/living/partner)
	var/message
	if(partner.is_fucking(src, CUM_TARGET_VAGINA))
		message = "[pick("rides \the <b>[partner]</b>'s dick.",
			"forces <b>[partner]</b>'s cock on their pussy")]"
	else
		message = "slides their pussy onto \the <b>[partner]</b>'s cock."
		partner.set_is_fucking(src, CUM_TARGET_VAGINA, partner.getorganslot(ORGAN_SLOT_PENIS) ? partner.getorganslot(ORGAN_SLOT_PENIS) : null)
	playlewdinteractionsound(loc, pick(	'modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg'), 70, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting())
	partner.handle_post_sex(CUM_TARGET_VAGINA, src)
	handle_post_sex(null, partner)
	partner.dir = get_dir(partner,src)
	partner.adjustArousal(12)
	partner.adjustPleasure(9)
	src.adjustArousal(12)
	src.adjustPleasure(9)

/mob/living/proc/do_mountass(mob/living/partner)
	var/message

	if(partner.is_fucking(src, CUM_TARGET_ANUS))
		message = "[pick("rides \the <b>[partner]</b>'s dick.",
			"forces <b>[partner]</b>'s cock on their ass")]"
	else
		message = "lowers their ass onto \the <b>[partner]</b>'s cock."
		partner.set_is_fucking(src, CUM_TARGET_ANUS, partner.getorganslot(ORGAN_SLOT_PENIS) ? partner.getorganslot(ORGAN_SLOT_PENIS) : null)
	playlewdinteractionsound(loc, pick(	'modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg'), 70, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting())
	partner.handle_post_sex(CUM_TARGET_ANUS, src)
	handle_post_sex(null, partner)
	partner.dir = get_dir(partner,src)
	partner.adjustArousal(12)
	partner.adjustPleasure(9)
	src.adjustArousal(12)
	src.adjustPleasure(9)

/mob/living/proc/do_tribadism(mob/living/partner)
	var/message
	if(partner.is_fucking(src, CUM_TARGET_VAGINA))
		message = "[pick("grinds their pussy against \the <b>[partner]</b>'s cunt.",
			"rubs their cunt against \the <b>[partner]</b>'s pussy.",
			"thrusts against \the <b>[partner]</b>'s pussy.",
			"humps \the <b>[partner]</b>, their pussies grinding against each other.")]"
	else
		message = "presses their pussy into \the <b>[partner]</b>'s own."
		partner.set_is_fucking(src, CUM_TARGET_VAGINA, partner.getorganslot(ORGAN_SLOT_VAGINA) ? partner.getorganslot(ORGAN_SLOT_VAGINA) : null)
	playlewdinteractionsound(loc, pick(	'modular_skyrat/modules/modular_items/lewd_items/sounds/squelch1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/squelch2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/squelch3.ogg'), 70, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting())
	partner.handle_post_sex(CUM_TARGET_VAGINA, src)
	handle_post_sex(null, partner)
	partner.dir = get_dir(partner,src)
	partner.adjustArousal(11)
	partner.adjustPleasure(7)
	src.adjustArousal(11)
	src.adjustPleasure(7)

/mob/living/proc/do_fingering(mob/living/partner)
	visible_message(message = "<font color=purple><b>\The [src]</b> [pick("fingers \the <b>[partner]</b>.",
		"fingers \the <b>[partner]</b>'s pussy.",
		"fingers \the <b>[partner]</b> hard.")]</font>", ignored_mobs = get_unconsenting())
	playlewdinteractionsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/champ_fingering.ogg', 50, 1, -1)
	partner.handle_post_sex(null, src)
	partner.dir = get_dir(partner, src)
	partner.adjustArousal(12)
	partner.adjustPleasure(8)

/mob/living/proc/do_fingerass(mob/living/partner)
	visible_message(message = "<font color=purple><b>\The [src]</b> [pick("fingers \the <b>[partner]</b>.",
		"fingers \the <b>[partner]</b>'s asshole.",
		"fingers \the <b>[partner]</b> hard.")]</font>", ignored_mobs = get_unconsenting())
	playlewdinteractionsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/champ_fingering.ogg', 50, 1, -1)
	partner.handle_post_sex(null, src)
	partner.dir = get_dir(partner, src)
	partner.adjustArousal(12)
	partner.adjustPleasure(8)

/mob/living/proc/do_rimjob(mob/living/partner)
	visible_message(message = "<font color=purple><b>\The [src]</b> licks \the <b>[partner]</b>'s asshole.</font>", ignored_mobs = get_unconsenting())
	playlewdinteractionsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/champ_fingering.ogg', 50, 1, -1)
	partner.handle_post_sex(null, src)
	partner.dir = get_dir(src, partner)
	partner.adjustArousal(12)
	partner.adjustPleasure(8)

/mob/living/proc/do_handjob(mob/living/partner)
	var/message
	if(partner.is_fucking(src, CUM_TARGET_HAND))
		message = "[pick("jerks \the <b>[partner]</b> off.",
			"works \the <b>[partner]</b>'s shaft.",
			"wanks \the <b>[partner]</b>'s cock hard.")]"
	else
		message = "[pick("wraps their hand around \the <b>[partner]</b>'s cock.",
			"starts playing with \the <b>[partner]</b>'s cock")]"
		partner.set_is_fucking(src, CUM_TARGET_HAND, partner.getorganslot(ORGAN_SLOT_PENIS) ? partner.getorganslot(ORGAN_SLOT_PENIS) : null)

	playlewdinteractionsound(loc, pick(	'modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg'), 70, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting())
	partner.handle_post_sex(CUM_TARGET_HAND, src)
	partner.dir = get_dir(partner,src)
	partner.adjustArousal(12)
	partner.adjustPleasure(8)

/mob/living/proc/do_breastfuck(mob/living/partner)
	var/message
	if(is_fucking(partner, CUM_TARGET_BREASTS))
		message = "[pick("fucks \the <b>[partner]</b>'s' breasts.",
			"grinds their cock between \the <b>[partner]</b>'s boobs.",
			"thrusts into \the <b>[partner]</b>'s tits.",
			"grabs \the <b>[partner]</b>'s breasts together and presses their dick between them.")]"
	else
		message = "pushes \the <b>[partner]</b>'s breasts together and presses their dick between them."
		set_is_fucking(partner , CUM_TARGET_BREASTS, getorganslot(ORGAN_SLOT_PENIS) ? getorganslot(ORGAN_SLOT_PENIS) : null)


	playlewdinteractionsound(loc, pick(	'modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/bang3.ogg'), 70, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting())
	handle_post_sex(CUM_TARGET_BREASTS, partner)
	partner.dir = get_dir(partner,src)
	partner.adjustArousal(9)
	partner.adjustPleasure(6)

/mob/living/proc/do_mountface(mob/living/partner)
	var/message

	if(is_fucking(partner, GRINDING_FACE_WITH_ANUS))
		message = "[pick("grinds their ass into \the <b>[partner]</b>'s face.",
			"shoves their ass into \the <b>[partner]</b>'s face.")]"
	else
		message = "[pick(
			"grabs the back of \the <b>[partner]</b>'s head and forces it into their asscheeks.",
			"squats down and plants their ass right on \the <b>[partner]</b>'s face")]"
		set_is_fucking(partner , GRINDING_FACE_WITH_ANUS, null)

	playlewdinteractionsound(loc, pick(	'modular_skyrat/modules/modular_items/lewd_items/sounds/squelch1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/squelch2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/squelch3.ogg'), 70, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting())
	handle_post_sex(null, src)
	partner.dir = get_dir(src, partner)
	partner.adjustArousal(6)
	partner.adjustPleasure(3)

/mob/living/proc/do_lickfeet(mob/living/partner)
	var/message

	if(partner.get_item_by_slot(ITEM_SLOT_FEET) != null)
		message = "licks \the <b>[partner]</b>'s [partner.get_shoes()]."
	else
		message = "licks \the <b>[partner]</b>'s [partner.has_feet() == 1 ? "foot" : "feet"]."

	playlewdinteractionsound(loc, 'modular_skyrat/modules/modular_items/lewd_items/sounds/champ_fingering.ogg', 50, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting())
	handle_post_sex(null, src)
	partner.dir = get_dir(src, partner)
	partner.adjustArousal(5)

/*Grinding YOUR feet in TARGET's face*/
/mob/living/proc/do_grindface(mob/living/partner)
	var/message

	if(is_fucking(partner, GRINDING_FACE_WITH_FEET))
		if(src.get_item_by_slot(ITEM_SLOT_FEET) != null)
			message = "[pick(list("grinds their [get_shoes()] into <b>[partner]</b>'s face.",
				"presses their footwear down hard on <b>[partner]</b>'s face.",
				"rubs off the dirt from their [get_shoes()] onto <b>[partner]</b>'s face."))]</span>"
		else
			message = "[pick(list("grinds their bare feet into <b>[partner]</b>'s face.",
				"deviously covers <b>[partner]</b>'s mouth and nose with their bare feet.",
				"runs the soles of their bare feet against <b>[partner]</b>'s lips."))]</span>"

	else if(is_fucking(partner, GRINDING_MOUTH_WITH_FEET))
		if(src.get_item_by_slot(ITEM_SLOT_FEET) != null)
			message = "[pick(list("pulls their [get_shoes()] out of <b>[partner]</b>'s mouth and puts them on their face.",
				"slowly retracts their [get_shoes()] from <b>[partner]</b>'s mouth, putting them on their face instead."))]</span>"
		else
			message = "[pick(list("pulls their bare feet out of <b>[partner]</b>'s mouth and rests them on their face instead.",
				"retracts their bare feet from <b>[partner]</b>'s mouth and grinds them into their face instead."))]</span>"

		set_is_fucking(partner , GRINDING_FACE_WITH_FEET, null)

	else
		if(src.get_item_by_slot(ITEM_SLOT_FEET) != null)
			message = "[pick(list("plants their [get_shoes()] ontop of <b>[partner]</b>'s face.",
				"rests their [get_shoes()] on <b>[partner]</b>'s face and presses down hard.",
				"harshly places their [get_shoes()] atop <b>[partner]</b>'s face."))]</span>"
		else
			message = "[pick(list("plants their bare feet ontop of <b>[partner]</b>'s face.",
				"rests their feet on <b>[partner]</b>'s face, smothering them.",
				"positions their bare feet atop <b>[partner]</b>'s face."))]</span>"

		set_is_fucking(partner, GRINDING_FACE_WITH_FEET, null)

	playlewdinteractionsound(loc, pick(	'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_dry1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_dry2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_dry3.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_dry4.ogg'), 70, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting())
	partner.handle_post_sex(null, src)
	partner.dir = get_dir(src, partner)
	partner.adjustArousal(5)

/*Grinding YOUR feet in TARGET's mouth*/
/mob/living/proc/do_grindmouth(mob/living/partner)
	var/message
	if(is_fucking(partner, GRINDING_MOUTH_WITH_FEET))
		if(src.get_item_by_slot(ITEM_SLOT_FEET) != null)
			message = "[pick(list("roughly shoves their [get_shoes()] deeper into <b>[partner]</b>'s mouth.",
				"harshly forces another inch of their [get_shoes()] into <b>[partner]</b>'s mouth.",
				"presses their weight down, their [get_shoes()] prying deeper into <b>[partner]</b>'s mouth."))]</span>"
		else
			message = "[pick(list("wiggles their toes deep inside <b>[partner]</b>'s mouth.",
				"crams their barefeet down deeper into <b>[partner]</b>'s mouth, making them gag.",
				"roughly grinds their feet on <b>[partner]</b>'s tongue."))]</span>"

	else if(is_fucking(partner, GRINDING_FACE_WITH_FEET))
		if(src.get_item_by_slot(ITEM_SLOT_FEET) != null)
			message = "[pick(list("decides to force their [get_shoes()] deep into <b>[partner]</b>'s mouth.",
				"pressed the tip of their [get_shoes()] against <b>[partner]</b>'s lips and shoves inwards."))]</span>"
		else
			message = "[pick(list("pries open <b>[partner]</b>'s mouth with their toes and shoves their bare foot in.",
				"presses down their foot even harder, cramming their foot into <b>[partner]</b>'s mouth."))]</span>"

		set_is_fucking(partner , GRINDING_MOUTH_WITH_FEET, null)

	else
		if(src.get_item_by_slot(ITEM_SLOT_FEET) != null)
			message = "[pick(list("readies themselves and in one swift motion, shoves their [get_shoes()] into <b>[partner]</b>'s mouth.",
				"grinds the tip of their [get_shoes()] against <b>[partner]</b>'s mouth before pushing themselves in."))]</span>"
		else
			message = "[pick(list("rubs their dirty bare feet across <b>[partner]</b>'s face before prying them into their muzzle.",
				"forces their barefeet into <b>[partner]</b>'s mouth.",
				"covers <b>[partner]</b>'s mouth and nose with their foot until they gasp for breath, then shoves both feet inside before they can react."))]</span>"
		set_is_fucking(partner , GRINDING_MOUTH_WITH_FEET, null)

	playlewdinteractionsound(loc, pick(	'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_wet1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_wet2.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_wet3.ogg'), 70, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting())
	partner.handle_post_sex(null, src)
	partner.dir = get_dir(src, partner)
	partner.adjustArousal(5)

/mob/living/proc/do_footfuck(mob/living/partner)
	var/message

	if(is_fucking(src, CUM_TARGET_FEET))
		message = "[pick("fucks \the <b>[partner]</b>'s [partner.get_shoes() ? partner.get_shoes(TRUE) : pick("foot", "sole")].",
			"rubs their dick on \the <b>[partner]</b>'s [partner.get_shoes() ? partner.get_shoes(TRUE) : pick("foot", "sole")].",
			"grinds their cock on \the <b>[partner]</b>'s [partner.get_shoes() ? partner.get_shoes(TRUE) : pick("foot", "sole")].")]"
	else
		message = "[pick("positions their cock on \the <b>[partner]</b>'s [partner.get_shoes() ? partner.get_shoes(TRUE) : pick("foot", "sole")].",
			"positions their cock on \the <b>[partner]</b>'s [partner.get_shoes() ? partner.get_shoes(TRUE) : pick("foot","sole")].",
			"starts grinding their cock against \the <b>[partner]</b>'s [partner.get_shoes() ? partner.get_shoes(TRUE) : pick("foot", "sole")].")]"
		set_is_fucking(src, CUM_TARGET_FEET, getorganslot(ORGAN_SLOT_PENIS) ? getorganslot(ORGAN_SLOT_PENIS) : null)

	playlewdinteractionsound(loc, pick(	'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_dry1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_dry3.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_wet1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_wet2.ogg'), 70, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting())
	handle_post_sex(CUM_TARGET_FEET, src)
	partner.dir = get_dir(partner,src)
	partner.adjustArousal(5)

/mob/living/proc/do_dfootfuck(mob/living/partner)
	var/message
	if(is_fucking(src, CUM_TARGET_FEET))
		message = "[pick("fucks \the <b>[partner]</b>'s [partner.get_shoes() ? partner.get_shoes() : pick("feet", "soles")].",
			"rubs their dick between \the <b>[partner]</b>'s [partner.get_shoes() ? partner.get_shoes() : pick("feet", "soles")].",
			"thrusts their cock between \the <b>[partner]</b>'s [partner.get_shoes() ? partner.get_shoes() : pick("feet", "soles")].")]"
	else
		message = "[pick("positions their cock between \the <b>[partner]</b>'s [partner.get_shoes() ? partner.get_shoes() : pick("feet", "soles")].",
			"starts grinding their cock against \the <b>[partner]</b>'s [partner.get_shoes() ? partner.get_shoes() : pick("feet", "soles")].",
			"starts grinding their cock between \the <b>[partner]</b>'s [partner.get_shoes() ? partner.get_shoes() : pick("feet", "soles")].")]"
		set_is_fucking(src, CUM_TARGET_FEET, getorganslot(ORGAN_SLOT_PENIS) ? getorganslot(ORGAN_SLOT_PENIS) : null)

	playlewdinteractionsound(loc, pick(	'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_dry1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_dry3.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_wet1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_wet2.ogg'), 70, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting())
	handle_post_sex(CUM_TARGET_FEET, src)
	partner.dir = get_dir(partner,src)
	partner.adjustArousal(5)

/mob/living/proc/do_vfootfuck(mob/living/partner)
	var/message
	if(is_fucking(src, CUM_TARGET_FEET))
		message = "[pick("grinds their pussy against \the <b>[partner]</b>'s [partner.get_shoes() ? partner.get_shoes(TRUE) : pick("foot", "sole")].",
			"rubs their clit on \the <b>[partner]</b>'s [partner.get_shoes() ? partner.get_shoes(TRUE) : pick("foot", "sole")].",
			"ruts on \the <b>[partner]</b>'s [partner.get_shoes() ? partner.get_shoes(TRUE) : pick("foot", "sole")].")]"
	else
		message = "[pick("positions their vagina on \the <b>[partner]</b>'s [partner.get_shoes() ? partner.get_shoes(TRUE) : pick("foot", "sole")].",
			"positions their clit on \the <b>[partner]</b>'s [partner.get_shoes() ? partner.get_shoes(TRUE) : pick("foot","sole")].",
			"starts grinding their pussy against \the <b>[partner]</b>'s [partner.get_shoes() ? partner.get_shoes(TRUE) : pick("foot", "sole")].")]"
		set_is_fucking(src, CUM_TARGET_FEET, getorganslot(ORGAN_SLOT_VAGINA) ? getorganslot(ORGAN_SLOT_VAGINA) : null)

	playlewdinteractionsound(loc, pick(	'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_dry1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_dry3.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_wet1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_wet2.ogg'), 70, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting())
	handle_post_sex(CUM_TARGET_FEET, src)
	partner.dir = get_dir(partner,src)
	partner.adjustArousal(5)

/mob/living/proc/do_footjob(mob/living/partner)
	var/message
	if(partner.is_fucking(src, CUM_TARGET_FEET))
		message = "[pick("jerks \the <b>[partner]</b> off with their [get_shoes() ? get_shoes(TRUE) : pick("foot", "sole")].",
			"rubs their [get_shoes() ? get_shoes(TRUE) : pick("foot", "sole", "toes")] on \the <b>[partner]</b>'s shaft.",
			"works their [get_shoes() ? get_shoes(TRUE) : pick("foot", "sole")] up and down on \the <b>[partner]</b>'s cock.")]"
	else
		message = "[pick("[get_shoes() ? "positions their [get_shoes(TRUE)] on" :"positions their foot on"] \the <b>[partner]</b>'s cock.",
			"starts playing around with \the <b>[partner]</b>'s cock, using their [get_shoes() ? get_shoes(TRUE) :"foot"].")]"
		partner.set_is_fucking(src, CUM_TARGET_FEET, partner.getorganslot(ORGAN_SLOT_PENIS) ? partner.getorganslot(ORGAN_SLOT_PENIS) : null)

	playlewdinteractionsound(loc, pick(	'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_dry1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_dry3.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_wet1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_wet2.ogg'), 70, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting())
	partner.handle_post_sex(CUM_TARGET_FEET, src)
	partner.dir = get_dir(partner,src)
	partner.adjustArousal(5)

/mob/living/proc/do_dfootjob(mob/living/partner)
	var/message
	if(partner.is_fucking(src, CUM_TARGET_FEET))
		message = "[pick("jerks \the <b>[partner]</b> off with their [get_shoes() ? get_shoes() : pick("feet", "soles")].",
			"rubs their [get_shoes() ? get_shoes() : pick("feet", "soles")] on \the <b>[partner]</b>'s shaft.",
			"rubs [get_shoes() ? "their [get_shoes()]" : "all of their toes"] on \the <b>[partner]</b>'s cock.",
			"works their [get_shoes() ? get_shoes() : pick("feet", "soles")] up and down on \the <b>[partner]</b>'s cock.")]"
	else
		message = "[pick("[get_shoes() ? "wraps their [get_shoes()] around" : "wraps their [pick("feet", "soles")] around"] \the <b>[partner]</b>'s cock.",
			"starts playing around with \the <b>[partner]</b>'s cock, using their [get_shoes() ? get_shoes() : "feet"].")]"
		partner.set_is_fucking(src, CUM_TARGET_FEET, partner.getorganslot(ORGAN_SLOT_PENIS) ? partner.getorganslot(ORGAN_SLOT_PENIS) : null)

	playlewdinteractionsound(loc, pick(	'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_dry1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_dry3.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_wet1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_wet2.ogg'), 70, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting())
	partner.handle_post_sex(CUM_TARGET_FEET, src)
	partner.dir = get_dir(partner,src)
	partner.adjustArousal(5)

/mob/living/proc/do_footjob_v(mob/living/partner)
	var/message

	if(partner.is_fucking(src, CUM_TARGET_FEET))
		message = "[pick("rubs \the <b>[partner]</b> clit with their [get_shoes() ? get_shoes(TRUE) : pick("foot", "sole")].",
			"rubs their [get_shoes() ? get_shoes(TRUE) : pick("foot", "sole", "toes")] on \the <b>[partner]</b>'s coochie.",
			"rubs their [get_shoes() ? get_shoes(TRUE) : pick("foot", "sole", "toes")] on \the <b>[partner]</b>'s vagina.",
			"rubs their foot up and down on \the <b>[partner]</b>'s pussy.")]"
	else
		message = "[pick("[get_shoes() ? "positions their [get_shoes(TRUE)] on" : "positions their foot on"] \the <b>[partner]</b>'s pussy.",
			"starts playing around with \the <b>[partner]</b>'s pussy, using their [get_shoes() ? get_shoes(TRUE) : "foot"].")]"
		partner.set_is_fucking(src, CUM_TARGET_FEET, partner.getorganslot(ORGAN_SLOT_VAGINA) ? partner.getorganslot(ORGAN_SLOT_VAGINA) : null)

	playlewdinteractionsound(loc, pick(	'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_dry1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_dry3.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_wet1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/foot_wet2.ogg'), 70, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting())
	partner.handle_post_sex(CUM_TARGET_FEET, src)
	partner.dir = get_dir(partner,src)
	partner.adjustArousal(5)

/mob/living/proc/get_shoes(var/singular = FALSE)
	var/obj/A = get_item_by_slot(ITEM_SLOT_FEET)
	if(A)
		var/txt = A.name
		if(findtext (A.name,"the"))
			txt = copytext(A.name, 5, length(A.name)+1)
			if(singular)
				txt = copytext(A.name, 5, length(A.name))
			return txt
		else
			if(singular)
				txt = copytext(A.name, 1, length(A.name))
			return txt

/mob/living/proc/handle_post_sex(orifice, mob/living/partner)
	if(stat != CONSCIOUS)
		return
	if(pleasure >= 100 && src.is_having_sex())
		if(prob(10))
			to_chat(src, "<b>You struggle to not orgasm!</b>")
			return
		else
			cum(partner, orifice)

/mob/living/proc/get_unconsenting(var/extreme = FALSE, var/list/ignored_mobs)
	var/list/nope = list()
	nope += ignored_mobs
	for(var/mob/M in range(7, src))
		if(M.client)
			var/client/cli = M.client
			if(extreme && (cli.prefs.extreme_lewd == "No"))
				nope += M
		else
			nope += M
	return nope

//Yep, weird shit goes down here.
/mob/living/proc/do_eyefuck(mob/living/partner)
	var/message

	if(is_fucking(partner, CUM_TARGET_EYES))
		message = "[pick(
			"pounds into \the <b>[partner]</b>'s [has_eyes() ? "eye":"eyesocket"].",
			"shoves their dick deep into \the <b>[partner]</b>'s skull",
			"thrusts in and out of \the <b>[partner]</b>'s [has_eyes() ? "eye":"eyesocket"].",
			"goes balls deep into \the <b>[partner]</b>'s cranium over and over again.")]"
		var/client/cli = partner.client
		var/mob/living/carbon/C = partner
		if(cli && istype(C))
			if(cli.prefs.extreme_lewd != "No")
				if(prob(15))
					C.bleed(2)
				if(prob(25))
					C.adjustOrganLoss(ORGAN_SLOT_EYES,rand(3,7))
					C.adjustOrganLoss(ORGAN_SLOT_BRAIN, rand(3,7))
	else
		message = "forcefully slides their cock inbetween \the <b>[partner]</b>'s [has_eyes() ? "eyelid":"eyesocket"]."
		set_is_fucking(partner, CUM_TARGET_EYES, getorganslot(ORGAN_SLOT_PENIS) ? getorganslot(ORGAN_SLOT_PENIS) : null)

	playlewdinteractionsound(loc, pick(	'modular_skyrat/modules/modular_items/lewd_items/sounds/champ1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/champ2.ogg'), 50, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting(TRUE))
	handle_post_sex(CUM_TARGET_EYES, partner)
	partner.handle_post_sex(null, src)
	partner.dir = get_dir(partner,src)
	partner.adjustPain(10)

/mob/living/proc/do_earfuck(mob/living/partner)
	var/message

	if(is_fucking(partner, CUM_TARGET_EARS))
		message = "[pick(
			"pounds into \the <b>[partner]</b>'s [has_eyes() ? "ear":"earsocker"].",
			"shoves their dick deep into \the <b>[partner]</b>'s skull",
			"thrusts in and out of \the <b>[partner]</b>'s [has_eyes() ? "ear":"eyesocket"].",
			"goes balls deep into \the <b>[partner]</b>'s cranium over and over again.")]"
		var/client/cli = partner.client
		var/mob/living/carbon/C = partner
		if(cli && istype(C))
			if(cli.prefs.extreme_lewd != "No")
				if(prob(15))
					C.bleed(2)
				if(prob(25))
					C.adjustOrganLoss(ORGAN_SLOT_EARS, rand(3,7))
					C.adjustOrganLoss(ORGAN_SLOT_BRAIN, rand(3,7))
	else
		message = "forcefully slides their cock inside \the <b>[partner]</b>'s [has_ears() ? "ear":"earsocket"]."
		set_is_fucking(partner, CUM_TARGET_EARS, getorganslot(ORGAN_SLOT_PENIS) ? getorganslot(ORGAN_SLOT_PENIS) : null)

	playlewdinteractionsound(loc, pick(	'modular_skyrat/modules/modular_items/lewd_items/sounds/champ1.ogg',
										'modular_skyrat/modules/modular_items/lewd_items/sounds/champ2.ogg'), 50, 1, -1)
	visible_message(message = "<font color=purple><b>\The [src]</b> [message]</font>", ignored_mobs = get_unconsenting(TRUE))
	handle_post_sex(CUM_TARGET_EARS, partner)
	partner.handle_post_sex(null, src)
	partner.dir = get_dir(partner,src)
	partner.adjustPain(10)
