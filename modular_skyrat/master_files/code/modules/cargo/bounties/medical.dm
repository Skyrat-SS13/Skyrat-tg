/datum/bounty/item/medical/heart
	name = "Heart"
	description = "Commander Johnson is in critical condition after suffering yet another heart attack. Doctors say he needs a new heart fast. Ship one, pronto! We'll take a cybernetic one if need be, but only if it's upgraded."
	reward = CARGO_CRATE_VALUE * 5
	wanted_types = list(
		/obj/item/organ/internal/heart = TRUE,
		/obj/item/organ/internal/heart/synth = FALSE,
		/obj/item/organ/internal/heart/cybernetic = FALSE,
		/obj/item/organ/internal/heart/cybernetic/tier2 = TRUE,
		/obj/item/organ/internal/heart/cybernetic/tier3 = TRUE,
	)

/datum/bounty/item/medical/lung
	name = "Lungs"
	description = "A recent explosion at Central Command has left multiple staff with punctured lungs. Ship spare lungs to be rewarded. We'll take cybernetic ones if need be, but only if they're upgraded."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(
		/obj/item/organ/internal/lungs = TRUE,
		/obj/item/organ/internal/lungs/synth = FALSE,
		/obj/item/organ/internal/lungs/cybernetic = FALSE,
		/obj/item/organ/internal/lungs/cybernetic/tier2 = TRUE,
		/obj/item/organ/internal/lungs/cybernetic/tier3 = TRUE,
	)

/datum/bounty/item/medical/appendix
	name = "Appendix"
	description = "Chef Gibb of Central Command wants to prepare a meal using a very special delicacy: an appendix. If you ship one, he'll pay."
	reward = CARGO_CRATE_VALUE * 5 //there are no synthetic appendixes
	wanted_types = list(/obj/item/organ/internal/appendix = TRUE)

/datum/bounty/item/medical/ears
	name = "Ears"
	description = "Multiple staff at Station 12 have been left deaf due to unauthorized clowning. Ship them new ears. We'll take cybernetic ones if need be, but only if they're upgraded."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(
		/obj/item/organ/internal/ears = TRUE,
		/obj/item/organ/internal/ears/synth = FALSE,
		/obj/item/organ/internal/ears/cybernetic = FALSE,
		/obj/item/organ/internal/ears/cybernetic/upgraded = TRUE,
		/obj/item/organ/internal/ears/cybernetic/whisper = TRUE,
		/obj/item/organ/internal/ears/cybernetic/xray = TRUE,
	)

/datum/bounty/item/medical/liver
	name = "Livers"
	description = "Multiple high-ranking CentCom diplomats have been hospitalized with liver failure after a recent meeting with Third Soviet Union ambassadors. Help us out, will you? We'll take cybernetic ones if need be, but only if they're upgraded."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(
		/obj/item/organ/internal/liver = TRUE,
		/obj/item/organ/internal/liver/synth = FALSE,
		/obj/item/organ/internal/liver/cybernetic = FALSE,
		/obj/item/organ/internal/liver/cybernetic/tier2 = TRUE,
		/obj/item/organ/internal/liver/cybernetic/tier3 = TRUE,
	)

/datum/bounty/item/medical/eye
	name = "Organic Eyes"
	description = "Station 5's Research Director Willem is requesting a few pairs of non-robotic eyes. Don't ask questions, just ship them."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(
		/obj/item/organ/internal/eyes = TRUE,
		/obj/item/organ/internal/eyes/robotic = FALSE,
		/obj/item/organ/internal/eyes/synth = FALSE,
	)

/datum/bounty/item/medical/tongue
	name = "Tongues"
	description = "A recent attack by Mime extremists has left staff at Station 23 speechless. Ship some spare tongues."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 3
	wanted_types = list(
		/obj/item/organ/internal/tongue = TRUE,
		/obj/item/organ/internal/tongue/synth = FALSE,
	)
