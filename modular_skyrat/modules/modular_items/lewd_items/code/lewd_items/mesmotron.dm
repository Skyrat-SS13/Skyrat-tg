/obj/item/mesmotron
	name = "Hypnotic Pocketwatch"
	desc = "An elaberate gold etched pocket, with an enchanting face, and captivating mechanical tick"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/pocketwatch.dmi'
	icon_state = "pocketwatch"
	w_class = WEIGHT_CLASS_SMALL
	throw_range = 7
	throw_speed = 3
	var/mob/living/carbon/subject = null
	var/closed = FALSE
	var/response = null
// Hypnotize Someone

//Var T = Target
/obj/item/mesmotron/attack(mob/living/carbon/human/T, mob/living/user)
	if(!T.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		to_chat(user, span_danger("[T] doesn't want to be hypnotized."))
		return
	if(closed)
		return
	if(T.IsSleeping())
		to_chat(user, span_danger("You can't hypnotize [T] while they're sleeping!"))
		return
	if(!(user in view(1, loc)))
		return
	if(!do_mob(user, T, 12 SECONDS))
		return
	user.visible_message(span_warning("[user] begins to wave an golden etched watch in front of [T]'s face in a mesmorizing manner"))
	var/response = tgui_alert(T, "Do you want to fall asleep? (This will allow [user] to issue hypnotic suggestions)", "Hypnosis", list("Yes", "No"))

	if(response == "Yes")
		T.visible_message(span_purple("[T] falls into a deep, hypnotic slumber right at the snap of your finger"), span_purple("You suddenly fall limp at the snap of [user]'s fingers."))
		T.SetSleeping(1200)
		subject = T
		return

	if(response == "No")
		T.visible_message(span_warning("[T] Attention breaks despite your efforts. They clearly don't seem interested!"), span_danger("Your attention breaks as you realize that you don't want to listen to [user]'s suggestions"))
		return


/obj/item/mesmotron/attack_self(mob/user)
	if(closed)
		return
	if(!subject)
		return
	if(!subject.IsSleeping())
		subject = null
		to_chat(user, span_purple("[subject] seems to no longer be asleep "))
		return
	var/response = tgui_alert(user, "Would you like to release your subject or give them a suggestion?", "Hypnotic Pocketwatch", list("Suggestion", "Release"))

	if(response == "Suggestion")
		if(get_dist(user, subject) > 1)
			to_chat(span_purple("You must be in whisper range to [subject]"))
			return
		text = input("What would you like to suggest?", "Hypnotic Suggestion", null, null)
		text = sanitize_text(text)
		if(!text)
			return

		to_chat(user, span_purple("You whisper into [subject]'s ears in a smooth, calming voice"))
		to_chat(subject, span_hypnophrase("[text]"))
		return
	if(response == "Release")
		subject.visible_message(span_purple("[subject] wakes up from their slumber"), span_purple("You wake up from your deep, hypnotc slumber and the new compulsions settle into your mind"))
		subject.SetSleeping(0)
		subject = null

/obj/item/mesmotron/AltClick(mob/user)
	if(icon_state == "pocketwatch")
		icon_state = "pocketwatch_closed"
		desc = "An elaberate pocket watch with a gold etching. It's closed however and you can't see its face"
		closed = TRUE
		return
	else
		icon_state = "pocketwatch"
		desc = "An elaberate gold etched pocket, with an enchanting face, and captivating mechanical tick"
		closed = FALSE
