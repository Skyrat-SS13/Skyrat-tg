/obj/item/clothing/mask/ballgag
	var/list/moans ///phrases to be said when the player attempts to talk when speech modification / voicebox is enabled.
	var/list/moans_alt ///lower probability phrases to be said when talking.
	var/moans_alt_probability ///probability for alternative sounds to play.

/obj/item/clothing/mask/ballgag
	w_class = WEIGHT_CLASS_SMALL
	clothing_flags = VOICEBOX_TOGGLABLE
	modifies_speech = TRUE
	flags_cover = MASKCOVERSMOUTH

/obj/item/clothing/mask/ballgag/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_MESSAGE] = pick((prob(moans_alt_probability) && LAZYLEN(moans_alt)) ? moans_alt : moans)

/obj/item/clothing/mask/ballgag
	name = "Ball gag"
	desc = "Prevents wearer from speaking"
	icon_state = "ballgag"
	inhand_icon_state = "blindfold"
	gas_transfer_coefficient = 0.9
	equip_delay_other = 40
	moans = list("Mmmph...", "Hmmphh", "Mmmfhg", "Gmmmh...")
	moans_alt = list("Mhgm...", "Hmmmp!...", "GMmmhp!")
	moans_alt_probability = 5