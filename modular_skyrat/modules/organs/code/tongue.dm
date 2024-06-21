/obj/item/organ/internal/tongue/copy_traits_from(obj/item/organ/internal/tongue/old_tongue, copy_actions = FALSE)
	. = ..()
	// make sure we get food preferences too, because those are now tied to tongues for some reason
	liked_foodtypes = old_tongue.liked_foodtypes
	disliked_foodtypes = old_tongue.disliked_foodtypes
	toxic_foodtypes = old_tongue.toxic_foodtypes

/obj/item/organ/internal/tongue/dog
	name = "long tongue"
	desc = "A long and wet tongue. It seems to jump when it's called good, oddly enough."
	say_mod = "woofs"
	icon_state = "tongue"
	modifies_speech = TRUE

/obj/item/organ/internal/tongue/dog/Insert(mob/living/carbon/signer, special = FALSE, movement_flags = DELETE_IF_REPLACED)
	. = ..()
	signer.verb_ask = "arfs"
	signer.verb_exclaim = "wans"
	signer.verb_whisper = "whimpers"
	signer.verb_yell = "barks"

/obj/item/organ/internal/tongue/dog/Remove(mob/living/carbon/speaker, special = FALSE)
	..()
	speaker.verb_ask = initial(verb_ask)
	speaker.verb_exclaim = initial(verb_exclaim)
	speaker.verb_whisper = initial(verb_whisper)
	speaker.verb_sing = initial(verb_sing)
	speaker.verb_yell = initial(verb_yell)

/obj/item/organ/internal/tongue/cat/Insert(mob/living/carbon/signer, special = FALSE, movement_flags = DELETE_IF_REPLACED)
	. = ..()
	signer.verb_ask = "mrrps"
	signer.verb_exclaim = "mrrowls"
	signer.verb_whisper = "purrs"
	signer.verb_yell = "yowls"

/obj/item/organ/internal/tongue/cat/Remove(mob/living/carbon/speaker, special = FALSE)
	. = ..()
	speaker.verb_ask = initial(verb_ask)
	speaker.verb_exclaim = initial(verb_exclaim)
	speaker.verb_whisper = initial(verb_whisper)
	speaker.verb_yell = initial(verb_yell)

/obj/item/organ/internal/tongue/avian
	name = "avian tongue"
	desc = "A short and stubby tongue that craves seeds."
	say_mod = "chirps"
	icon_state = "tongue"
	modifies_speech = TRUE

/obj/item/organ/internal/tongue/avian/Insert(mob/living/carbon/signer, special = FALSE, movement_flags = DELETE_IF_REPLACED)
	. = ..()
	signer.verb_ask = "peeps"
	signer.verb_exclaim = "squawks"
	signer.verb_whisper = "murmurs"
	signer.verb_yell = "shrieks"

/obj/item/organ/internal/tongue/avian/Remove(mob/living/carbon/speaker, special = FALSE)
	. = ..()
	speaker.verb_ask = initial(verb_ask)
	speaker.verb_exclaim = initial(verb_exclaim)
	speaker.verb_whisper = initial(verb_whisper)
	speaker.verb_sing = initial(verb_sing)
	speaker.verb_yell = initial(verb_yell)

/// This "human" tongue is only used in Character Preferences / Augmentation menu.
/// The base tongue class lacked a say_mod. With say_mod included it makes a non-Human user sound like a Human.
/obj/item/organ/internal/tongue/human
	say_mod = "says"

/obj/item/organ/internal/tongue/lizard/robot
	name = "robotic lizard voicebox"
	desc = "A lizard-like voice synthesizer that can interface with organic lifeforms."
	organ_flags = ORGAN_ROBOTIC
	icon_state = "tonguerobot"
	say_mod = "hizzes"
	attack_verb_continuous = list("beeps", "boops")
	attack_verb_simple = list("beep", "boop")
	modifies_speech = TRUE
	taste_sensitivity = 25 // not as good as an organic tongue
	voice_filter = "alimiter=0.9,acompressor=threshold=0.2:ratio=20:attack=10:release=50:makeup=2,highpass=f=1000"

/obj/item/organ/internal/tongue/lizard/robot/can_speak_language(language)
	return TRUE // THE MAGIC OF ELECTRONICS

/obj/item/organ/internal/tongue/lizard/robot/modify_speech(datum/source, list/speech_args)
	. = ..()
	speech_args[SPEECH_SPANS] |= SPAN_ROBOT

/obj/item/organ/internal/tongue/lizard/cybernetic
	name = "forked cybernetic tongue"
	icon = 'modular_skyrat/modules/organs/icons/cyber_tongue.dmi'
	icon_state = "cybertongue-lizard"
	desc =  "A fully-functional forked synthetic tongue, encased in soft silicone. Features include high-resolution vocals and taste receptors."
	organ_flags = ORGAN_ROBOTIC
	// Not as good as organic tongues, not as bad as the robotic voicebox.
	taste_sensitivity = 20
	modifies_speech = TRUE

/obj/item/organ/internal/tongue/cybernetic
	name = "cybernetic tongue"
	icon = 'modular_skyrat/modules/organs/icons/cyber_tongue.dmi'
	icon_state = "cybertongue"
	desc =  "A fully-functional synthetic tongue, encased in soft silicone. Features include high-resolution vocals and taste receptors."
	organ_flags = ORGAN_ROBOTIC
	say_mod = "says"
	// Not as good as organic tongues, not as bad as the robotic voicebox.
	taste_sensitivity = 20

/obj/item/organ/internal/tongue/vox
	name = "vox tongue"
	desc = "A fleshy muscle mostly used for skreeing."
	say_mod = "skrees"
	liked_foodtypes = MEAT | FRIED

/obj/item/organ/internal/tongue/dwarven
	name = "dwarven tongue"
	desc = "A fleshy muscle mostly used for bellowing."
	say_mod = "bellows"
	liked_foodtypes = ALCOHOL | MEAT | DAIRY //Dwarves like alcohol, meat, and dairy products.
	disliked_foodtypes = JUNKFOOD | FRIED | CLOTH //Dwarves hate foods that have no nutrition other than alcohol.

/obj/item/organ/internal/tongue/ghoul
	name = "ghoulish tongue"
	desc = "A fleshy muscle mostly used for rasping."
	say_mod = "rasps"
	liked_foodtypes = RAW | MEAT
	disliked_foodtypes = VEGETABLES | FRUIT | CLOTH
	toxic_foodtypes = DAIRY | PINEAPPLE

/obj/item/organ/internal/tongue/insect
	name = "insect tongue"
	desc = "A fleshy muscle mostly used for chittering."
	say_mod = "chitters"
	liked_foodtypes = GROSS | RAW | TOXIC | GORE
	disliked_foodtypes = CLOTH | GRAIN | FRIED
	toxic_foodtypes = DAIRY

/obj/item/organ/internal/tongue/xeno_hybrid
	name = "alien tongue"
	desc = "According to leading xenobiologists the evolutionary benefit of having a second mouth in your mouth is \"that it looks badass\"."
	icon_state = "tonguexeno"
	say_mod = "hisses"
	taste_sensitivity = 10
	liked_foodtypes = MEAT

/obj/item/organ/internal/tongue/xeno_hybrid/Initialize(mapload)
	. = ..()
	var/obj/item/organ/internal/tongue/alien/alien_tongue_type = /obj/item/organ/internal/tongue/alien
	voice_filter = initial(alien_tongue_type.voice_filter)

/obj/item/organ/internal/tongue/skrell
	name = "skrell tongue"
	desc = "A fleshy muscle mostly used for warbling."
	say_mod = "warbles"
