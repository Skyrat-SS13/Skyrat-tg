#define TRAIT_HYDRA_HEADS "hydrahead" // We still dont have a centralised trait file

// SKYRAT NEUTRAL TRAITS
/datum/quirk/excitable
	name = "Excitable!"
	desc = "Head patting makes your tail wag! You're very excitable! WAG WAG."
	gain_text = span_notice("You crave for some headpats!")
	lose_text = span_notice("You no longer care for headpats all that much.")
	medical_record_text = "Patient seems to get excited easily."
	value = 0
	mob_trait = TRAIT_EXCITABLE
	icon = "laugh-beam"

/datum/quirk/personalspace
	name = "Personal Space"
	desc = "You'd rather people keep their hands to themselves, and you won't let anyone touch your ass.."
	gain_text = span_notice("You'd like it if people kept their hands off your ass.")
	lose_text = span_notice("You're less concerned about people touching your ass.")
	medical_record_text = "Patient demonstrates negative reactions to their posterior being touched."
	value = 0
	mob_trait = TRAIT_PERSONALSPACE
	icon = "hand-paper"

/datum/quirk/dnr
	name = "Do Not Revive"
	desc = "For whatever reason, you cannot be revived in any way."
	gain_text = span_notice("Your spirit gets too scarred to accept revival.")
	lose_text = span_notice("You can feel your soul healing again.")
	medical_record_text = "Patient is a DNR, and cannot be revived in any way."
	value = 0
	mob_trait = TRAIT_DNR
	icon = "skull-crossbones"

// uncontrollable laughter
/datum/quirk/item_quirk/joker
	name = "Pseudobulbar Affect"
	desc = "At random intervals, you suffer uncontrollable bursts of laughter."
	value = 0
	medical_record_text = "Patient suffers with sudden and uncontrollable bursts of laughter."
	var/pcooldown = 0
	var/pcooldown_time = 60 SECONDS
	icon = "grin-squint-tears"

/datum/quirk/item_quirk/joker/add_unique()
	give_item_to_holder(/obj/item/paper/joker, list(LOCATION_BACKPACK = ITEM_SLOT_BACKPACK, LOCATION_HANDS = ITEM_SLOT_HANDS))

/obj/item/paper/joker
	name = "disability card"
	icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	icon_state = "joker"
	desc = "Smile, though your heart is aching."
	info = "<i>\
			<div style='border-style:solid;text-align:center;border-width:5px;margin: 20px;margin-bottom:0px'>\
			<div style='margin-top:20px;margin-bottom:20px;font-size:150%;'>\
			Forgive my laughter:<br>\
			I have a condition.\
			</div>\
			</div>\
			</i>\
			<br>\
			<center>\
			<b>\
			MORE ON BACK\
			</b>\
			</center>"
	var/info2 = "<i>\
			<div style='border-style:solid;text-align:center;border-width:5px;margin: 20px;margin-bottom:0px'>\
			<div style='margin-top:20px;margin-bottom:20px;font-size:100%;'>\
			<b>\
			It's a medical condition causing sudden,<br>\
			frequent and uncontrollable laughter that<br>\
			doesn't match how you feel.<br>\
			It can happen in people with a brain injury<br>\
			or certain neurological conditions.<br>\
			</b>\
			</div>\
			</div>\
			</i>\
			<br>\
			<center>\
			<b>\
			KINDLY RETURN THIS CARD\
			</b>\
			</center>"
	var/flipped = FALSE

/obj/item/paper/joker/update_icon()
	..()
	icon_state = "joker"

/obj/item/paper/joker/AltClick(mob/living/carbon/user, obj/item/card)
	if(flipped)
		info = initial(info)
		flipped = FALSE
	else
		info = info2
		flipped = TRUE
	balloon_alert(user, "card flipped")

/datum/quirk/item_quirk/joker/process()
	if(pcooldown > world.time)
		return
	pcooldown = world.time + pcooldown_time
	var/mob/living/carbon/human/user = quirk_holder
	if(user && istype(user))
		if(user.stat == CONSCIOUS)
			if(prob(20))
				user.emote("laugh")
				addtimer(CALLBACK(user, /mob/proc/emote, "laugh"), 5 SECONDS)
				addtimer(CALLBACK(user, /mob/proc/emote, "laugh"), 10 SECONDS)

/datum/quirk/feline_aspect
	name = "Feline Traits"
	desc = "You happen to act like a feline, for whatever reason."
	gain_text = span_notice("Nya could go for some catnip right about now...")
	lose_text = span_notice("You feel less attracted to lasers.")
	medical_record_text = "Patient seems to possess behavior much like a feline."
	value = 0
	mob_trait = TRAIT_FELINE
	icon = "cat"

/datum/quirk/item_quirk/canine
	name = "Canidae Traits"
	desc = "Bark. You seem to act like a canine for whatever reason."
	icon = "canine"
	value = 0
	medical_record_text = "Patient was seen digging through the trash can. Keep an eye on them."

/datum/quirk/item_quirk/canine/add_unique()
	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/organ/tongue/old_tongue = human_holder.getorganslot(ORGAN_SLOT_TONGUE)
	old_tongue.Remove(human_holder)
	qdel(old_tongue)

	var/obj/item/organ/tongue/dog/new_tongue = new(get_turf(human_holder))
	new_tongue.Insert(human_holder)
