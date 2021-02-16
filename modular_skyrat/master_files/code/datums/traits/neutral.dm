//SKYRAT NEUTRAL TRAITS
/datum/quirk/excitable
	name = "Excitable!"
	desc = "Head patting makes your tail wag! You're very excitable! WAG WAG."
	gain_text = "<span class='notice'>You crave for some headpats!</span>"
	lose_text = "<span class='notice'>You no longer care for headpats all that much.</span>"
	medical_record_text = "Patient seems to get excited easily."
	value = 0
	mob_trait = TRAIT_EXCITABLE

/datum/quirk/ironass
	name = "Iron Ass"
	desc = "Your ass is incredibly firm, so firm infact that anyone slapping it will suffer grave injuries."
	gain_text = "<span class='notice'>Your ass feels solid!</span>"
	lose_text = "<span class='notice'>Your ass doesn't feel so solid anymore.</span>"
	medical_record_text = "Patient's ass seems incredibly solid."
	value = 0
	mob_trait = TRAIT_IRONASS

/datum/quirk/dnc
	name = "Do Not Clone"
	desc = "For whatever reason, you cannot be cloned in any way. You can still be revived in other ways, <b><i>but medical doctors are not always required to revive you.</i></b>"
	gain_text = "<span class='notice'>Your feel your soul binding itself to your body.</span>"
	lose_text = "<span class='notice'>You can feel your spirit detach from your body.</span>"
	medical_record_text = "Patient's anatomy is incompatible with conventional cloning techniques."
	value = 0
	mob_trait = TRAIT_DNC

/datum/quirk/dnr
	name = "Do Not Revive"
	desc = "For whatever reason, you cannot be revived in any way."
	gain_text = "<span class='notice'>Your spirit gets too scarred to accept revival.</span>"
	lose_text = "<span class='notice'>You can feel your soul healing again.</span>"
	medical_record_text = "Patient is a DNR, and cannot be revived in any way."
	value = 0
	mob_trait = TRAIT_DNR

//Speech impediments
/datum/quirk/speech_impediment_rl
	name = "Speech impediment (r as l)"
	desc = "You mispronounce \"r\" as \"l\""
	value = 0
	medical_record_text = "Patient experiences difficulty in pronouncing certain phonemes."

/datum/quirk/speech_impediment_rl/add()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.enable_speech_mod(/datum/speech_mod/impediment_rl)

/datum/quirk/speech_impediment_rl/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.disable_speech_mod(/datum/speech_mod/impediment_rl)


/datum/quirk/speech_impediment_lw
	name = "Speech impediment (l as w)"
	desc = "You mispronounce \"l\" as \"w\""
	value = 0
	medical_record_text = "Patient experiences difficulty in pronouncing certain phonemes."

/datum/quirk/speech_impediment_lw/add()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.enable_speech_mod(/datum/speech_mod/impediment_lw)

/datum/quirk/speech_impediment_lw/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.disable_speech_mod(/datum/speech_mod/impediment_lw)


/datum/quirk/speech_impediment_rw
	name = "Speech impediment (r as w)"
	desc = "You mispronounce \"r\" as \"w\""
	value = 0
	medical_record_text = "Patient experiences difficulty in pronouncing certain phonemes."

/datum/quirk/speech_impediment_rw/add()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.enable_speech_mod(/datum/speech_mod/impediment_rw)

/datum/quirk/speech_impediment_rw/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.disable_speech_mod(/datum/speech_mod/impediment_rw)

/datum/quirk/speech_impediment_rw_lw
	name = "Speech impediment (r and l as w)"
	desc = "You mispronounce \"r\" and \"l\" as \"w\""
	value = 0
	medical_record_text = "Patient experiences difficulty in pronouncing certain phonemes."

/datum/quirk/speech_impediment_rw_lw/add()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.enable_speech_mod(/datum/speech_mod/impediment_rw_lw)

/datum/quirk/speech_impediment_rw_lw/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.disable_speech_mod(/datum/speech_mod/impediment_rw_lw)
