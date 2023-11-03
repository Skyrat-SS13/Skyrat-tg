#define AID_EMOTION_NEUTRAL "neutral"
#define AID_EMOTION_HAPPY "happy"
#define AID_EMOTION_WARN "cautious"
#define AID_EMOTION_ANGRY "angery"
#define AID_EMOTION_SAD "sad"

/obj/item/healthanalyzer/simple/sugar
	name = "blood sugar tester"
	desc = "Another one of MeLo-Tech's medsci scanners, the blood sugar tester was serendipitously developed when MeLo-Tech engineers accidentally realized that the included AI actually enjoyed drawing blood from patients. This one seems particularly happy to prick your finger!"

/obj/item/healthanalyzer/simple/sugar/attack(mob/living/carbon/patient, mob/living/carbon/human/user)
	if(!user.can_read(src) || user.is_blind())
		return

	add_fingerprint(user)
	user.visible_message(span_notice("[user] scans [patient]'s blood sugar levels."), span_notice("You scan [patient]'s blood sugar levels."))

	if(!istype(user))
		playsound(src, 'sound/machines/buzz-two.ogg', 30, TRUE)
		to_chat(user, span_notice("\The [src] makes a sad buzz and briefly displays a frowny face, indicating it can't scan [patient]."))
		emotion = AID_EMOTION_SAD
		update_appearance(UPDATE_OVERLAYS)
		return

	var/datum/reagent/sugar = patient.reagents.has_reagent(/datum/reagent/consumable/sugar)

	if((sugar != FALSE) && (sugar.volume > 9))
		playsound(src, 'sound/machines/synth_yes.ogg', 50, FALSE)
		to_chat(user, span_notice("\The [src] makes a happy ping and displays a blood sugar volume of [sugar.volume] (OK)."))
		emotion = AID_EMOTION_HAPPY
	else
		emotion = AID_EMOTION_WARN
		if(sugar == FALSE)
			playsound(src, 'sound/machines/twobeep.ogg', 50, FALSE)
			to_chat(user, span_notice("\The [src] beeps alarmingly and indicates depleted blood sugar!"))
		else
			playsound(src, 'sound/machines/synth_no.ogg', 50, FALSE)
			to_chat(user, span_notice("\The [src] beeps sadly and and displays a blood sugar volume of [sugar.volume] (LOW)."))

	update_appearance(UPDATE_OVERLAYS)
	flick(icon_state + "_pinprick", src)

#undef AID_EMOTION_NEUTRAL
#undef AID_EMOTION_HAPPY
#undef AID_EMOTION_WARN
#undef AID_EMOTION_ANGRY
#undef AID_EMOTION_SAD
